import Flutter
import UIKit
import DyScan

public class FlutterDyscanPlugin: NSObject, FlutterPlugin, DyScanViewControllerDelegate {
    
    private var result: FlutterResult? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "vvvirani/flutter_dyscan", binaryMessenger: registrar.messenger())
        let instance = FlutterDyscanPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        self.result = result
        
        if call.method == "init" {
            
            if let arguments = call.arguments as? Dictionary<String, Any>{
                if let apiKey = arguments["apiKey"] as? String, !apiKey.isEmpty {
                    DyScanApp.configure(apiKey: apiKey)
                    result(true)
                } else {
                    result(FlutterError(code: "not_initialized", message: "DyScan is not initialized", details: nil))
                }
                
            }
            result(false)
            
        } else if call.method == "startCardScan" {
            
            let viewController = DyScanViewController()
            viewController.paymentDelegate = self
            let navigationController = UINavigationController(rootViewController: viewController)
            
            if let arguments = call.arguments as? Dictionary<String, Any>{
                
                
                navigationController.modalPresentationStyle = getModalPresentationStyle(arguments["modalPresentationStyle"] as? String)
                
                if let showDynetiLogo = arguments["showDynetiLogo"] as? Bool {
                    viewController.showDynetiLogo = showDynetiLogo
                }
                
                if let defaultCardNumberText = arguments["defaultCardNumberText"] as? String {
                    viewController.defaultCardNumberText = defaultCardNumberText
                }
                
                if let defaultExpirationDate = arguments["defaultExpirationDate"] as? String {
                    viewController.defaultExpirationDate = defaultExpirationDate
                }
                
                if let language = arguments["language"] as? String {
                    viewController.language = language
                }
                
                if let bgColor = arguments["bgColor"] as? String {
                    viewController.bgColor = UIColor(hex: bgColor)
                }
                
                if let bgOpacity = arguments["bgOpacity"] as? String, let flotValue = Float(bgOpacity)  {
                    viewController.bgOpacity = CGFloat(flotValue)
                }
                
                if let showRotateButton = arguments["showRotateButton"] as? Bool {
                    viewController.showRotateButton = showRotateButton
                }
                
                if let showCorners = arguments["showCorners"] as? Bool {
                    viewController.showCorners = showCorners
                }
                
                if let cornerActiveColor = arguments["cornerActiveColor"] as? String {
                    viewController.cornerActiveColor = UIColor(hex: cornerActiveColor)
                }
                
                if let cornerCompletedColor = arguments["cornerCompletedColor"] as? String {
                    viewController.cornerCompletedColor = UIColor(hex: cornerCompletedColor)
                }
                
                if let cornerInactiveColor = arguments["cornerInactiveColor"] as? String {
                    viewController.cornerInactiveColor = UIColor(hex: cornerInactiveColor)
                }
                
                if let cornerThickness = arguments["cornerThickness"] as? Int {
                    viewController.cornerThickness = cornerThickness
                }
                
                if let showHelperText = arguments["showHelperText"] as? Bool {
                    viewController.showHelperText = showHelperText
                }
                
                if let helperTextString = arguments["helperTextString"] as? String {
                    viewController.helperTextString = helperTextString
                }
                
                if let helperTextColor = arguments["helperTextColor"] as? String {
                    viewController.helperTextColor = UIColor(hex: helperTextColor)
                }
                
                if let helperTextFont = arguments["helperTextFont"] as? String, let flotValue = Float(helperTextFont) {
                    if let helperTextFontFamily = arguments["helperTextFontFamily"] as? String {
                        viewController.helperTextFont = UIFont(descriptor: UIFontDescriptor(name: helperTextFontFamily,size: CGFloat(flotValue)), size: CGFloat(flotValue))
                    } else {
                        viewController.helperTextFont = UIFont.systemFont(ofSize: CGFloat(flotValue))
                    }
                    
                }
                
                if let helperTextPosition = arguments["helperTextPosition"] as? String {
                    viewController.helperTextPosition = getHelperTextPosition(helperTextPosition)
                }
                
                if let vibrateOnCompletion = arguments["vibrateOnCompletion"] as? Bool {
                    viewController.vibrateOnCompletion = vibrateOnCompletion
                }
                
                if let useFrontCamera = arguments["useFrontCamera"] as? Bool {
                    viewController.useFrontCamera = useFrontCamera
                }
                
                if let lightTorchWhenDark = arguments["lightTorchWhenDark"] as? Bool {
                    viewController.lightTorchWhenDark = lightTorchWhenDark
                }
            }
            
            
            if #available(iOS 13.0, *) {
                if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow })
                    keyWindow?.rootViewController?.present(navigationController, animated: true)
                }
            }
            
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    
    public func onSuccess(_ cardInfo: DyScan.DyScanCreditCardInfo!, in paymentViewController: DyScan.DyScanViewController!) {
        
        paymentViewController.dismiss(animated: true, completion: nil)
        
        if let result = self.result {
            var resultMap = [String : Any]()
            resultMap["cardNumber"] = cardInfo.cardNumber
            resultMap["expiryMonth"] = cardInfo.expiryMonth
            resultMap["expiryYear"] = cardInfo.expiryYear
            resultMap["isFraud"] = cardInfo.isFraud
            result(resultMap)
        }
    }
    
    public func onFailure(_ paymentViewController: DyScan.DyScanViewController!, reason: DyScan.DyScanExitReason) {
        paymentViewController.dismiss(animated: true, completion: nil)
        
        if let result = self.result {
            switch reason {
            case .AuthError:
                result(FlutterError(code: "auth_error", message: "Invalid api key", details: nil))
                break
            case .CameraError:
                result(FlutterError(code: "camera_error", message: "Camera not found", details: nil))
                break
            case .NoPermissions:
                result(FlutterError(code: "no_permissions", message: "Missing camera permission", details: nil))
                break
            case .UserCancelled:
                result(FlutterError(code: "user_cancelled", message: "Cancelled by user", details: nil))
                break
            default: break
            }
        }
    }
    
    func getModalPresentationStyle(_ style: String?) -> UIModalPresentationStyle {
        switch style {
        case "pageSheet":
            return .pageSheet
        case "fullScreen":
            return .fullScreen
        case "automatic":
            return .automatic
        default:
            return .automatic
        }
    }
    
    func getHelperTextPosition(_ position: String?) -> DyScan.DyScanHelperTextPosition {
        switch position {
        case "top":
            return .top
        case "center":
            return .center
        case "bottom":
            return .bottom
        default:
            return .bottom
        }
    }
}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


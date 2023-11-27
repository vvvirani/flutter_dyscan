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
                let apiKey = arguments["apiKey"] as? String
                DyScanApp.configure(apiKey: apiKey!)
                result(true)
            }
            result(false)
            
        } else if call.method == "startCardScan" {
            
            let viewController = DyScanViewController()
            viewController.paymentDelegate = self
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            
            if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                let keyWindow = windowScene.windows.first(where: { $0.isKeyWindow })
                keyWindow?.rootViewController?.present(navigationController, animated: true)
            }
            
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func onFailure(_ paymentViewController: DyScan.DyScanViewController!, reason: DyScan.DyScanExitReason) {
        paymentViewController.dismiss(animated: true, completion: nil)
        let error = FlutterError(code: "not_found", message: "Card scan result is not found", details: nil)
        if result != nil { result!(error) }
    }
    
    public func onSuccess(_ cardInfo: DyScan.DyScanCreditCardInfo!, in paymentViewController: DyScan.DyScanViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
        var resultMap = [String : Any]()
        resultMap["cardNumber"] = cardInfo.cardNumber
        resultMap["expiryMonth"] = cardInfo.expiryMonth
        resultMap["expiryYear"] = cardInfo.expiryYear
        resultMap["isFraud"] = cardInfo.isFraud
        if result != nil { result!(resultMap) }
    }
}

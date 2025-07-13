package com.vvvirani.flutter_dyscan

import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import androidx.core.app.ActivityCompat
import androidx.core.app.ActivityCompat.startActivityForResult
import androidx.core.content.ContextCompat
import com.dyneti.android.dyscan.CreditCard
import com.dyneti.android.dyscan.DyScan
import com.dyneti.android.dyscan.DyScanActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener


class FlutterDyscanPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    ActivityResultListener {

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var binding: ActivityPluginBinding
    private var scanRequestCode: Int = 1337
    private lateinit var result: Result

    private val permissionRequestCode = 100


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "vvvirani/flutter_dyscan")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        this.result = result
        when (call.method) {
            "init" -> {
                val apiKey = call.argument<String?>("apiKey")
                if (apiKey.isNullOrEmpty()) {
                    result.error("notInitialized", "DyScan is not initialized", null)
                } else {
                    DyScan.init(context, apiKey)
                }
            }
            "requestCameraPermission" -> {
                requestCameraPermission()
            }
            "checkCameraPermission" -> {
                result.success(checkCameraPermission())
            }
            "startCardScan" -> {
                if (DyScan.isDeviceSupported(context)) {
                    val intent = Intent(context, DyScanActivity::class.java)

                    val showHelperText = call.argument<Boolean?>("showHelperText")
                    if (showHelperText != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_SHOW_HELPER_TEXT,
                            showHelperText
                        )
                    }

                    val helperTextPosition = call.argument<String?>("helperTextPosition")
                    if (helperTextPosition != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_HELPER_TEXT_POSITION,
                            helperTextPosition
                        )
                    }

                    val helperTextFontSize = call.argument<String?>("helperTextFontSize")
                    if (helperTextFontSize != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_HELPER_TEXT_SIZE_SP,
                            helperTextFontSize.toFloat()
                        )
                    }

                    val helperTextString = call.argument<String?>("helperTextString")
                    if (helperTextString != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_HELPER_TEXT_STRING,
                            helperTextString
                        )
                    }

                    val helperTextFontFamily = call.argument<String?>("helperTextFontFamily")
                    if (helperTextFontFamily != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_HELPER_TEXT_FONT_FAMILY,
                            helperTextFontFamily
                        )
                    }

                    val helperTextColor = call.argument<String?>("helperTextColor")
                    if (helperTextColor != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_HELPER_TEXT_COLOR,
                            Color.parseColor(helperTextColor)
                        )
                    }

                    val showCorners = call.argument<Boolean?>("showCorners")
                    if (showCorners != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_SHOW_CORNERS,
                            showCorners
                        )
                    }

                    val cornerThickness = call.argument<Int?>("cornerThickness")
                    if (cornerThickness != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_CORNER_THICKNESS,
                            cornerThickness.toFloat()
                        )
                    }

                    val cornerInactiveColor = call.argument<String?>("cornerInactiveColor")
                    if (cornerInactiveColor != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_CORNER_INACTIVE_COLOR,
                            Color.parseColor(cornerInactiveColor)
                        )
                    }

                    val cornerActiveColor = call.argument<String?>("cornerActiveColor")
                    if (cornerActiveColor != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_CORNER_ACTIVE_COLOR,
                            Color.parseColor(cornerActiveColor)
                        )
                    }

                    val cornerCompletedColor = call.argument<String?>("cornerCompletedColor")
                    if (cornerCompletedColor != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_CORNER_COMPLETED_COLOR,
                            Color.parseColor(cornerCompletedColor)
                        )
                    }

                    val bgColor = call.argument<String?>("bgColor")
                    if (bgColor != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_BACKGROUND_COLOR,
                            Color.parseColor(bgColor)
                        )
                    }

                    val bgOpacity = call.argument<String?>("bgOpacity")
                    if (bgOpacity != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_BACKGROUND_OPACITY,
                            bgOpacity.toInt()
                        )
                    }

                    val showRotateButton = call.argument<Boolean?>("showRotateButton")
                    if (showRotateButton != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_SHOW_ROTATE_BUTTON,
                            showRotateButton
                        )
                    }

                    val showDynetiLogo = call.argument<Boolean?>("showDynetiLogo")
                    if (showDynetiLogo != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_SHOW_DYNETI_LOGO,
                            showDynetiLogo
                        )
                    }
                    val lightTorchWhenDark = call.argument<Boolean?>("lightTorchWhenDark")
                    if (lightTorchWhenDark != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_LIGHT_TORCH_WHEN_DARK,
                            lightTorchWhenDark
                        )
                    }

                    val vibrateOnCompletion = call.argument<Boolean?>("vibrateOnCompletion")
                    if (vibrateOnCompletion != null) {
                        intent.putExtra(
                            DyScanActivity.EXTRA_VIBRATE_ON_COMPLETION,
                            vibrateOnCompletion
                        )
                    }

                    startActivityForResult(binding.activity, intent, scanRequestCode, null)

                } else {
                    result.error("notSupported", "DyScan is not supported for this device", null)
                }
            }
            else -> {
                result.notImplemented()
            }
        }
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding
        binding.addActivityResultListener { requestCode, resultCode, data ->
            onActivityResult(requestCode, resultCode, data)
        }
        addRequestPermissionsResultListener()
    }

    override fun onDetachedFromActivityForConfigChanges() {
        binding.removeActivityResultListener { requestCode, resultCode, data ->
            onActivityResult(requestCode, resultCode, data)
        }
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.binding = binding
        binding.addActivityResultListener { requestCode, resultCode, data ->
            onActivityResult(requestCode, resultCode, data)
        }
        addRequestPermissionsResultListener()
    }

    override fun onDetachedFromActivity() {
        binding.removeActivityResultListener { requestCode, resultCode, data ->
            onActivityResult(requestCode, resultCode, data)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {

        if (requestCode == scanRequestCode) {
            if (resultCode == DyScanActivity.RESULT_OK) {
                if (data != null && data.hasExtra(DyScanActivity.EXTRA_SCAN_RESULT)) {
                    val scanResult: CreditCard? =
                        data.getParcelableExtra(DyScanActivity.EXTRA_SCAN_RESULT)
                    if (scanResult != null) {
                        val resultMap: MutableMap<String, Any?> = HashMap()
                        resultMap["cardNumber"] = scanResult.cardNumber
                        resultMap["expiryMonth"] = scanResult.expiryMonth
                        resultMap["expiryYear"] = scanResult.expiryYear
                        resultMap["isFraud"] = scanResult.isFraud
                        result.success(resultMap)
                        return true
                    }
                }
            } else if (resultCode == DyScanActivity.RESULT_AUTH_FAILURE) {
                result.error("authError", "Invalid api key & authentication", null)
            } else if (resultCode == DyScanActivity.RESULT_CAMERA_ERROR) {
                result.error("cameraError", "Camera not found", null)
            } else if (resultCode == DyScanActivity.RESULT_PERMISSIONS_NOT_GRANTED) {
                result.error("noPermissions", "Missing camera permission", null)
            } else if (resultCode == DyScanActivity.RESULT_CANCELED) {
                result.error("userCancelled", "Cancelled by user", null)
            }
        }
        return false
    }

    private fun checkCameraPermission(): Boolean {
        return ContextCompat.checkSelfPermission(
            context,
            Manifest.permission.CAMERA
        ) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestCameraPermission() {
        ActivityCompat.requestPermissions(
            binding.activity,
            arrayOf(Manifest.permission.CAMERA),
            permissionRequestCode
        )

    }

    private fun addRequestPermissionsResultListener() {
        this.binding.addRequestPermissionsResultListener { requestCode, _, grantResults ->
            if (requestCode == permissionRequestCode) {
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    result.success(true)
                } else {
                    result.success(false)
                }
            }
            true
        }
    }
}

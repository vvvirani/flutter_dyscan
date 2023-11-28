package com.vvvirani.flutter_dyscan

import android.content.Context
import android.content.Intent
import android.graphics.Color
import androidx.core.app.ActivityCompat.startActivityForResult
import com.dyneti.android.dyscan.CreditCard
import com.dyneti.android.dyscan.DyScan
import com.dyneti.android.dyscan.DyScanActivity
import com.dyneti.android.dyscan.DyScanHelperTextPosition
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


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "vvvirani/flutter_dyscan")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        this.result = result
        if (call.method == "init") {
            val apiKey = call.argument<String?>("apiKey")
            if (apiKey.isNullOrEmpty()) {
                result.error("not_initialized", "DyScan is not initialized", null)
            } else {
                DyScan.init(context, apiKey)
            }
        } else if (call.method == "startCardScan") {
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
                        helperTextFontSize
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

                val showCardOverlay = call.argument<Boolean?>("showCardOverlay")
                if (showCardOverlay != null) {
                    intent.putExtra(
                        DyScanActivity.EXTRA_SHOW_CARD_OVERLAY,
                        showCardOverlay
                    )
                }

                val showResultOverlay = call.argument<Boolean?>("showResultOverlay")
                if (showResultOverlay != null) {
                    intent.putExtra(
                        DyScanActivity.EXTRA_SHOW_RESULT_OVERLAY,
                        showResultOverlay
                    )
                }

                startActivityForResult(binding.activity, intent, scanRequestCode, null)

            } else {
                result.error("not_supported", "DyScan is not supported for this device", null)
            }
        } else {
            result.notImplemented()
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

    }

    override fun onDetachedFromActivity() {
        binding.removeActivityResultListener { requestCode, resultCode, data ->
            onActivityResult(requestCode, resultCode, data)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {

        if (requestCode == scanRequestCode) {
            if (data != null && data.hasExtra(DyScanActivity.EXTRA_SCAN_RESULT)) {
                val scanResult: CreditCard? =
                    data.getParcelableExtra(DyScanActivity.EXTRA_SCAN_RESULT)
                return if (scanResult != null) {
                    val resultMap: MutableMap<String, Any?> = HashMap()
                    resultMap["cardNumber"] = scanResult.cardNumber
                    resultMap["expiryMonth"] = scanResult.expiryMonth
                    resultMap["expiryYear"] = scanResult.expiryYear
                    resultMap["isFraud"] = scanResult.isFraud
                    result.success(resultMap)
                    true
                } else {
                    result.error("failed", "Card scan result is not found", null)
                    false
                }
            }
        }
        result.error("cancelled", "Cancelled by user", null)
        return false
    }
}

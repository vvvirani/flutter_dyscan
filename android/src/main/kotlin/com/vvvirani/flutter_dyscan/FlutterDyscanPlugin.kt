package com.vvvirani.flutter_dyscan

import android.content.Context
import android.content.Intent
import androidx.core.app.ActivityCompat.startActivityForResult
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
    private var scanRequestCode: Int = 1000
    private lateinit var result: Result


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "vvvirani/flutter_dyscan")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        this.result = result
        if (call.method == "init") {
            val apiKey = call.argument<String>("apiKey")
            if (apiKey != null) {
                DyScan.init(context, apiKey)
                result.success(true)
            }
            result.success(false)
        } else if (call.method == "startCardScan") {
            if (DyScan.isDeviceSupported(context)) {
                val intent = Intent(context, DyScanActivity::class.java)
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
                if (scanResult != null) {
                    val resultMap: MutableMap<String, Any?> = HashMap()
                    resultMap["cardNumber"] = scanResult.cardNumber
                    resultMap["expiryMonth"] = scanResult.expiryMonth
                    resultMap["expiryYear"] = scanResult.expiryYear
                    resultMap["isFraud"] = scanResult.isFraud
                    result.success(resultMap)
                    return true
                } else {
                    result.error("failed", "Card scan result is not found", null)
                }
            }
        }
        result.error("canceled", "Canceled by User", null)
        return false
    }
}

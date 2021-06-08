package com.example.flutter_hc_webview_example

import android.content.Intent;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel;
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
  private val CHANNEL = "ejemplo.hybrid.composition.webview"
  private val METHOD = "nativeWebView"
  private val REQUEST = 1

  lateinit var methodResult:MethodChannel.Result

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      methodResult = result
      if (call.method == METHOD) {
        val url:String = call.arguments()
        onLaunchWebView(url)
      } else {
        result.notImplemented()
      }
    }
  }

  private fun onLaunchWebView(url:String){
    val intent = Intent(this, WebViewActivity::class.java).apply {
      putExtra(WebViewActivity().EXTRA_WEBVIEW, url)
    }

    startActivityForResult(intent, REQUEST);
  }

  override fun onActivityResult(requestCode:Int, resultCode:Int, data:Intent){
    if (requestCode == REQUEST) {
      if (resultCode == RESULT_OK) {
        var recibido = data.getStringExtra(WebViewActivity().EXTRA_WEBVIEW)
        methodResult.success(recibido);
      } else {
        methodResult.error("ACTIVITY_FAILURE", "Failed while launching activity", null);
      }
    }
  }
}

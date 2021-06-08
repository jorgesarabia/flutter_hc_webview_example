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

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method == METHOD) {
        onLaunchWebView("")
      } else {
        result.notImplemented()
      }
    }
  }

  private fun onLaunchWebView(url:String){
    // val startForResult = registerForActivityResult(ActivityResultContracts.StartActivityForResult())
    // { result: ActivityResult ->
    //     if (result.resultCode == Activity.RESULT_OK) {
    //         //  you will get result here in result.data
    //         }

    //     }
    // }

    // Intent fullScreenIntent = Intent(this, MainActivity.class);
    // fullScreenIntent.putExtra(WebViewActivity.extraWebView, url);
    // startActivityForResult(fullScreenIntent, REQUEST);
    val intent = Intent(this, WebViewActivity::class.java).apply {
      putExtra("webviewExtra", url)
    }

    startActivity(intent)

    // startForResult.launch(Intent(activity, CameraCaptureActivity::class.java))
  }

  // @Override
  // protected fun onActivityResult(int requestCode, int resultCode, Intent data) {
  //   if (requestCode == REQUEST) {
  //     if (resultCode == RESULT_OK) {
  //       result.success(data.getIntExtra(CountActivity.extraWebView, 0));
  //     } else {
  //       result.error("ACTIVITY_FAILURE", "Failed while launching activity", null);
  //     }
  //   }
  // }
}

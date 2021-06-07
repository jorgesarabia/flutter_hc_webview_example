package com.example.flutter_hc_webview_example

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
  private val CHANNEL = 'ejemplo.hybrid.composition.webview';
  private val METHOD = 'nativeWebView';

  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
      if (call.method == METHOD) {
      } else {
        result.notImplemented()
      }
    }
  }

  private void onLaunchWebView(String url){
    Intent fullScreenIntent = new Intent(this, CountActivity.class);
    fullScreenIntent.putExtra(CountActivity.EXTRA_COUNTER, count);
    startActivityForResult(fullScreenIntent, COUNT_REQUEST);
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == COUNT_REQUEST) {
      if (resultCode == RESULT_OK) {
        result.success(data.getIntExtra(CountActivity.EXTRA_COUNTER, 0));
      } else {
        result.error("ACTIVITY_FAILURE", "Failed while launching activity", null);
      }
    }
  }
}

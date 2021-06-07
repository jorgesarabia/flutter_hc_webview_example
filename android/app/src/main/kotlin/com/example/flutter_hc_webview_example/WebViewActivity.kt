package com.example.flutter_hc_webview_example

  import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle

class MainActivity : AppCompatActivity() {
    public static final String EXTRA_COUNTER = "counter";
    private String lastUrl;

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.webview_activity)
    }
}
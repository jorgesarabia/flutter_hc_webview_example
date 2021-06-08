package com.example.flutter_hc_webview_example

import android.graphics.Bitmap
import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import android.webkit.*
import android.widget.SearchView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout


class WebViewActivity: FlutterActivity() {
    public val extraWebView = "webviewExtra";
    private var lastUrl = "";
    private val baseUrl = "https://www.google.com"
    private val searchPath = "/search?q="

    lateinit var webView:WebView
    lateinit var swipeRefresh:SwipeRefreshLayout
    lateinit var searchView:SearchView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        webView = findViewById<WebView>(R.id.webView)
        swipeRefresh = findViewById(R.id.swipeRefresh)
        searchView = findViewById(R.id.searchView)

        searchView.setOnQueryTextListener(object:SearchView.OnQueryTextListener{
            override fun onQueryTextChange(newText: String?): Boolean {
                return false
            }

            override fun onQueryTextSubmit(query: String?): Boolean {
                query?.let {
                    if(URLUtil.isValidUrl(it)){
                        webView.loadUrl(it)
                    }else{
                        webView.loadUrl("$baseUrl$searchPath$it")
                    }
                }
                return false
            }
        })

        swipeRefresh.setOnRefreshListener {
            webView.reload()
        }

        webView.webChromeClient = object: WebChromeClient() {

        }
        webView.webViewClient = object :WebViewClient(){
            override fun shouldOverrideUrlLoading(
                view: WebView?,
                request: WebResourceRequest?
            ): Boolean {
                return false
            }

            override fun onPageStarted(view: WebView?, url: String?, favicon: Bitmap?) {
                super.onPageStarted(view, url, favicon)
                searchView.setQuery(url,false)
                swipeRefresh.isRefreshing = true
            }

            override fun onPageFinished(view: WebView?, url: String?) {
                super.onPageFinished(view, url)
                swipeRefresh.isRefreshing = false
            }
        }

        val settings:WebSettings = webView.settings
        settings.javaScriptEnabled = true

        webView.loadUrl(baseUrl)

    }

    override fun onBackPressed() {
        if(webView.canGoBack()){
            webView.goBack()
        }else{
            super.onBackPressed()
        }
    }
}
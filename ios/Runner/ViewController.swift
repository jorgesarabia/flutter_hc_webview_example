//
//  ViewController.swift
//  Runner
//
//  Created by Jorge Sarabia on 17/06/2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var initialUrl:String = "https://www.google.com"
    var delegate:MyProtocol?
    var lastUrl:String = ""
    
    private var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config = WKWebViewConfiguration()
        
        if #available(iOS 14, *) {
            let webViewPrefs = WKWebpagePreferences()
            webViewPrefs.allowsContentJavaScript = true

            config.defaultWebpagePreferences = webViewPrefs
        } else {
            let webViewPrefs = WKPreferences()
            webViewPrefs.javaScriptEnabled = true
            webViewPrefs.javaScriptCanOpenWindowsAutomatically = true
            
            config.preferences = webViewPrefs
        }

        webView = WKWebView(frame: view.frame, configuration: config)
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(webView)
        webView.navigationDelegate = self
        
        
        load(url: URL(string: initialUrl)!)
    }
    
    private func load(url:URL){
        webView.load(URLRequest(url: url))
    }
}

extension ViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let thisUrl = webView.url?.absoluteString{
            lastUrl = thisUrl
        }
        
        if lastUrl.contains("exit"){
            delegate?.onInteractionFinish(type: lastUrl)
            self.dismiss(animated: true, completion: nil)
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
}

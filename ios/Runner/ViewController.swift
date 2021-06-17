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
    @IBOutlet weak var navBAr: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webViewPrefs = WKPreferences()
        webViewPrefs.javaScriptEnabled = true
        webViewPrefs.javaScriptCanOpenWindowsAutomatically = true

        let config = WKWebViewConfiguration()
        config.preferences = webViewPrefs

        webView = WKWebView(frame: view.frame, configuration: config)
        webView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        view.addSubview(webView)
        webView.navigationDelegate = self
        
        
        load(url: URL(string: initialUrl)!)
    }
    
    private func load(url:URL){
        webView.load(URLRequest(url: url))
    }

    @IBAction func backButton(_ sender: Any) {
        delegate?.onInteractionFinish(type: "Volvi desde el bar")
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //refreshControl.endRefreshing()
        //backButton.isEnabled = webView.canGoBack
        //forwardButton.isEnabled = webView.canGoForward
        if let thisUrl = webView.url?.absoluteString{
            lastUrl = thisUrl
        }
        
        if lastUrl.contains("exit"){
            delegate?.onInteractionFinish(type: lastUrl)
            self.dismiss(animated: true, completion: nil)
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //refreshControl.beginRefreshing()
    }
}

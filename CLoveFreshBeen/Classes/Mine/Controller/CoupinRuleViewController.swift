//
//  CoupinRuleViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/3.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit
import WebKit

class CoupinRuleViewController: UIViewController {

    private let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64))
    private let loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 3))
    var loadURLStr: String? {
        didSet {
            webView.load(URLRequest(url: URL(string: loadURLStr!)!))
        }
    }
    
    var navTitle: String? {
        didSet {
            navigationItem.title = navTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        buildWebView()
        webView.addSubview(loadProgressAnimationView)
    }
    
    private func buildWebView() {
        webView.navigationDelegate = self
        webView.backgroundColor = UIColor.white
        view.addSubview(webView)
    }
}

extension CoupinRuleViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }
}

//
//  WebViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/1.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    private lazy var webView = WKWebView(frame: ScreenBounds)
    private var urlStr: String?
    private lazy var loadProgressAnimationView: LoadProgressAnimationView = LoadProgressAnimationView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 3))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.addSubview(loadProgressAnimationView)
    }
    
    convenience init(navigationTitle: String, urlStr: String) {
        self.init(nibName: nil, bundle: nil)
        navigationItem.title = navigationTitle
        webView.load(URLRequest(url: URL(string: urlStr)!))
        self.urlStr = urlStr
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        buildRightItemBarButton()
    }
}

extension WebViewController{
    private func buildRightItemBarButton(){
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 44))
        rightButton.setImage(UIImage(named: "v2_refresh"), for: .normal)
        rightButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -53)
        rightButton.addTarget(self, action: #selector(refreshClick), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
    }
    
    @objc private func refreshClick(){
        if urlStr != nil && urlStr!.count > 1{
            webView.load(URLRequest(url: URL(string: urlStr!)!))
        }
    }
}

extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadProgressAnimationView.startLoadProgressAnimation()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadProgressAnimationView.endLoadProgressAnimation()
    }
}

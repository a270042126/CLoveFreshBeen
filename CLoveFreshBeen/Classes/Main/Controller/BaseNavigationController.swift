//
//  BaseNavigationController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    var isAnimation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    lazy var backBtn: UIButton = {[unowned self] in
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "v2_goback"), for: .normal)
        backBtn.titleLabel?.isHidden = true
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        backBtn.contentHorizontalAlignment = .left
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        let btnW: CGFloat = ScreenWidth > 375.0 ? 50 : 44
        backBtn.frame = CGRect(x: 0, y: 0, width: btnW, height: 40)
        return backBtn
    }()
  
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.hidesBackButton = true
        if children.count > 0{
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }

    @objc private func backBtnClick(){
        popViewController(animated: isAnimation)
    }
}

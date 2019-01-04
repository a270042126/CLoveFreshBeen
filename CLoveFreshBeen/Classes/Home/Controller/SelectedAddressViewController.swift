//
//  SelectedAdressViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class SelectedAddressViewController: AnimationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        buildNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserInfo.shareUserInfo.hasDefaultAddress(){
            let titleView = AddressTitleView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
            titleView.setTitle(text: UserInfo.shareUserInfo.defaultAddress()!.address!)
            titleView.frame = CGRect(x: 0, y: 0, width: titleView.addressWidth, height: 30)
            navigationItem.titleView = titleView
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleViewClick))
            navigationItem.titleView?.addGestureRecognizer(tap)
        }
    }
}

extension SelectedAddressViewController{
    
    private func buildNavigationItem(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(title: "扫一扫", titleColor: UIColor.black, image: UIImage(named: "icon_black_scancode")!, hightLightImage: nil, target: self, action: #selector(leftItemClick), type: .Left)
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "搜 索", titleColor: UIColor.black, image: UIImage(named: "icon_search")!, hightLightImage: nil, target: self, action: #selector(rightItemClick), type: .Right)
        
        let titleView = AddressTitleView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
        titleView.frame = CGRect(x: 0, y: 0, width: titleView.addressWidth, height: 30)
        navigationItem.titleView = titleView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(titleViewClick))
        navigationItem.titleView?.addGestureRecognizer(tap)
    }
    
    @objc private func titleViewClick(){
        let addressVC = MyAddressViewController {[weak self] (address) in
            let titleView = AddressTitleView(frame: CGRect(x: 0, y: 0, width: 0, height: 30))
            titleView.setTitle(text: address.address!)
            titleView.frame = CGRect(x: 0, y: 0, width: titleView.addressWidth, height: 30)
            self?.navigationItem.titleView = titleView
            UserInfo.shareUserInfo.setDefaultAddress(address: address)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self?.titleViewClick))
            self?.navigationItem.titleView?.addGestureRecognizer(tap)
        }
        addressVC.isSelectVC = true
        navigationController?.pushViewController(addressVC, animated: true)
    }
    
    @objc private func leftItemClick(){
        let qrVC = QRCodeViewController()
        navigationController?.pushViewController(qrVC, animated: true)
    }
    
    @objc private func rightItemClick(){
        let searchVC = SearchProductViewController()
        navigationController?.pushViewController(searchVC, animated: false)
    }
}

//
//  ADViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import Kingfisher

class ADViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.frame = ScreenBounds
        return backImageView
    }()
    
    var imageName: String? {
        didSet{
            backImageView.kf.setImage(with: URL(string: imageName!), placeholder: UIImage(named: "iphone6s")) { (image, error, _, _) in
                if error != nil{
                    //加载广告失败
                    print("加载广告失败")
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: ADImageLoadFail), object: nil)
                }else{
                    if image != nil {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                            NotificationCenter.default.post(name: NSNotification.Name(ADImageLoadSecussed), object: image)
                        })
                    }else{
                        print("加载广告失败")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: ADImageLoadFail), object: nil)
                    }
                }
            }
            
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backImageView)
        
    }
}

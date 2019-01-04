//
//  YellowShopCarView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class YellowShopCarView: UIView {

    private var shopViewClick:(() -> ())?
    private let yellowImageView = UIImageView()
    private let redDot = ShopCarRedDotView.sharedRedDotView

    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: 61, height: 61))
        clipsToBounds = false
        
        yellowImageView.image = UIImage(named: "v2_shopNoBorder")
        yellowImageView.frame = CGRect(x: 0, y: 0, width: 61, height: 61)
        addSubview(yellowImageView)
        
        let shopCarImageView = UIImageView(image: UIImage(named: "v2_whiteShopBig"))
        shopCarImageView.frame = CGRect(x: (61 - 45) * 0.5, y: (61 - 45) * 0.5, width: 45, height: 45)
        addSubview(shopCarImageView)
        redDot.frame = CGRect(x: frame.width - 20, y: 0, width: 20, height: 20)
        addSubview(redDot)
        isUserInteractionEnabled = true
    }
    
    convenience init(frame: CGRect, shopViewClick:@escaping (() -> ())) {
        self.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(shopViewShowShopCar))
        addGestureRecognizer(tap)
        self.shopViewClick = shopViewClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func shopViewShowShopCar(){
        shopViewClick?()
    }
}

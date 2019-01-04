//
//  BindingCouponView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/3.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class BindingCouponView: UIView {

    var bindingButtonClickBack:((_ couponTextFiled: UITextField) -> ())?
    private lazy var couponTextFiled: UITextField = {
        let couponTextFiled = UITextField()
        
        couponTextFiled.keyboardType = UIKeyboardType.numberPad
        couponTextFiled.borderStyle = UITextField.BorderStyle.roundedRect
        couponTextFiled.autocorrectionType = UITextAutocorrectionType.no
        couponTextFiled.font = UIFont.systemFont(ofSize: 14)
        let placeholder = NSAttributedString(string: "请输入优惠劵号码", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor(red: 50 / 255.0, green: 50 / 255.0, blue: 50 / 255.0, alpha: 0.8)])
        
        couponTextFiled.attributedPlaceholder = placeholder
        
        return couponTextFiled
    }()
    
    private lazy var bindingButton: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5
        btn.backgroundColor = LFBNavigationYellowColor
        btn.setTitle("绑定", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btn.addTarget(self, action: #selector(bindingButtonClick), for: UIControl.Event.touchUpInside)
        
        return btn
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.black
        lineView.alpha = 0.2
        
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(couponTextFiled)
        addSubview(bindingButton)
        addSubview(lineView)
    }
    
    convenience init(frame: CGRect, bindingButtonClickBack:@escaping ((_ couponTextFiled: UITextField) -> ())) {
        self.init(frame: frame)
        
        self.bindingButtonClickBack = bindingButtonClickBack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let topBottomMargin: CGFloat = 10
        let bingdingButtonWidth: CGFloat = 60
        couponTextFiled.frame = CGRect(x: CouponViewControllerMargin, y: topBottomMargin, width: frame.width - 2 * CouponViewControllerMargin - bingdingButtonWidth - 10, height: frame.height - 2 * topBottomMargin)
        bindingButton.frame = CGRect(x: frame.width - CouponViewControllerMargin - bingdingButtonWidth, y: topBottomMargin, width: bingdingButtonWidth, height: couponTextFiled.frame.height)
        lineView.frame = CGRect(x: 0, y: frame.height - 0.5, width: frame.width, height: 0.5)
    }
    
    // MARK: Action
    @objc func bindingButtonClick() {
        if bindingButtonClickBack != nil {
            bindingButtonClickBack!(couponTextFiled)
        }
    }
}

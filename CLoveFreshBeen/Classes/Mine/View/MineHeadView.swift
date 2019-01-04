//
//  MineHeadView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class MineHeadView: UIImageView {

    let setUpBtn: UIButton = UIButton(type: .custom)
    let iconView: IconView = IconView()
    var buttonClick:(() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        image = UIImage(named: "v2_my_avatar_bg")
        setUpBtn.setImage(UIImage(named: "v2_my_settings_icon"), for: .normal)
        setUpBtn.addTarget(self, action: #selector(setUpButtonClick), for: .touchUpInside)
        addSubview(setUpBtn)
        addSubview(iconView)
        self.isUserInteractionEnabled = true
    }
    
    convenience init(frame: CGRect, settingButtonClick:@escaping (() -> Void)) {
        self.init(frame: frame)
        buttonClick = settingButtonClick
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let iconViewWH: CGFloat = 150
        iconView.frame = CGRect(x: (frame.width - 150) * 0.5, y: 40, width: iconViewWH, height: iconViewWH)
        setUpBtn.frame = CGRect(x: frame.width - 50, y: 20, width: 50, height: 50)
    }
    
    @objc private func setUpButtonClick(){
        buttonClick?()
    }
}

class IconView: UIView{
    
    var iconImageView: UIImageView!
    var phoneNum: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconImageView = UIImageView(image: UIImage(named: "v2_my_avatar"))
        addSubview(iconImageView)
        
        phoneNum = UILabel()
        phoneNum.text = "18612348765"
        phoneNum.font = UIFont.boldSystemFont(ofSize: 18)
        phoneNum.textColor = UIColor.white
        phoneNum.textAlignment = .center
        addSubview(phoneNum)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.frame = CGRect(x: (frame.width - iconImageView.frame.size.width) * 0.5, y: 0, width: iconImageView.frame.size.width, height: iconImageView.frame.size.height)
        phoneNum.frame = CGRect(x: 0, y: iconImageView.frame.maxY + 5, width: frame.width, height: 30)
    }
}

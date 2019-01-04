//
//  AdressTitleView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class AddressTitleView: UIView {

    private lazy var playLabel: UILabel = {
        let playLabel = UILabel()
        playLabel.text = "配送至"
        playLabel.textColor = UIColor.black
        playLabel.backgroundColor = UIColor.clear
        playLabel.layer.borderWidth = 0.5
        playLabel.font = UIFont.systemFont(ofSize: 10)
        playLabel.sizeToFit()
        playLabel.textAlignment = .center
        return playLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.sizeToFit()
        return titleLabel
    }()
    private lazy var arrowImageView = UIImageView(image: UIImage(named: "allowBlack"))
    var addressWidth: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playLabel)
        addSubview(titleLabel)
        addSubview(arrowImageView)
        
        playLabel.frame = CGRect(x: 0, y: (frame.height - playLabel.frame.height - 2) / 2, width: playLabel.frame.width + 6, height: playLabel.frame.height + 2)
        if let address = UserInfo.shareUserInfo.defaultAddress(){
            if address.address != nil &&  address.address!.count > 0{
                let addressStr = address.address! as NSString
                if addressStr.components(separatedBy: " ").count > 1{
                    titleLabel.text = addressStr.components(separatedBy: " ")[0]
                }else{
                    titleLabel.text = addressStr as String
                }
            }else{
                titleLabel.text = "你在哪里呀"
            }
        }else{
            titleLabel.text = "你在哪里呀"
        }
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: playLabel.frame.maxX + 4, y: 0, width: titleLabel.frame.width, height: frame.height)
        
        arrowImageView.frame = CGRect(x: titleLabel.frame.maxX + 4, y: (frame.height - 6) / 2, width: 10, height: 6)
        addressWidth = arrowImageView.frame.maxX
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(text: String){
        let addressStr = text as NSString
        if addressStr.components(separatedBy: " ").count > 1{
            titleLabel.text = addressStr.components(separatedBy: " ")[0]
        }else{
            titleLabel.text = addressStr as String
        }
        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: playLabel.frame.maxX + 4, y: 0, width: titleLabel.frame.width, height: frame.height)
        arrowImageView.frame = CGRect(x: titleLabel.frame.maxX + 4, y: (frame.height - arrowImageView.frame.height) / 2, width: arrowImageView.frame.width, height: arrowImageView.frame.height)
        addressWidth = arrowImageView.frame.maxX
    }
}

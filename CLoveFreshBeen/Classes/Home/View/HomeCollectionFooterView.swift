//
//  HomeCollectionFooterView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class HomeCollectionFooterView: UICollectionReusableView {
    
    private let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "点击查看更多商品 >"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor(r: 150, g: 150, b: 150)
        titleLabel.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 60)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hideLabel(){
        self.titleLabel.isHidden = true
    }
    
    func showLabel(){
        self.titleLabel.isHidden = false
    }
    
    func setFooterTitle(text: String, textColor: UIColor){
        titleLabel.text = text
        titleLabel.textColor = textColor
    }
}

class HomeCollectionHeaderView: UICollectionReusableView{
    private let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel.text = "新鲜热卖"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.frame = CGRect(x: 10, y: 0, width: 200, height: 20)
        titleLabel.textColor = UIColor(r: 150, g: 150, b: 150)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

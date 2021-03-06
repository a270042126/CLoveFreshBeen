//
//  NotSearchProductsView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class NotSearchProductsView: UIView {

    private let topBackView = UIView()
    private let searchLabel = UILabel()
    private let markImageView = UIImageView()
    private let productLabel = UILabel()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        topBackView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 50)
        topBackView.backgroundColor = UIColor(r: 249, g: 242, b: 216)
        addSubview(topBackView)
        
        markImageView.contentMode = .scaleAspectFill
        markImageView.image = UIImage(named: "icon_exclamationmark")
        markImageView.frame = CGRect(x: 15, y: (50 - 27) * 0.5, width: 27, height: 27)
        addSubview(markImageView)
        
        productLabel.textColor = UIColor(r: 148, g: 107, b: 81)
        productLabel.font = UIFont.systemFont(ofSize: 14)
        productLabel.frame = CGRect(x: markImageView.frame.maxX + 10, y: 10, width: frame.width * 0.7, height: 15)
        productLabel.text = "暂时没搜到〝星巴克〞相关商品"
        addSubview(productLabel)
        
        searchLabel.textColor = UIColor(r: 252, g: 185, b: 47)
        searchLabel.font = UIFont.systemFont(ofSize: 12)
        searchLabel.text = "换其他关键词试试看,但是并没有什么卵用~"
        searchLabel.frame = CGRect(x: productLabel.frame.origin.x, y: productLabel.frame.maxY + 5, width: frame.width * 0.7, height: 15)
        addSubview(searchLabel)
        
        titleLabel.textColor = UIColor.gray
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.text = "大家都在买"
        titleLabel.frame = CGRect(x: 10, y: 60, width: 200, height: 15)
        addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSearchProductLabelText(text: String) {
        productLabel.text = "暂时没搜到" + "〝" + text + "〞" + "相关商品"
    }
}

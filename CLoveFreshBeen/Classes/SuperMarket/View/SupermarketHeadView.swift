//
//  SupermarketHeadView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/1.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class SupermarketHeadView: UITableViewHeaderFooterView {

    var titleLabel: UILabel!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor(r: 240, g: 240, b: 240, alpha: 0.8)
        buildTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: HotViewMargin, y: 0, width: frame.width - HotViewMargin, height: frame.height)
    }

    private func buildTitleLabel(){
        titleLabel = UILabel()
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.textColor = UIColor(r: 100, g: 100, b: 100)
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)
    }
}


//
//  LeftImageRightTextButton.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class LeftImageRightTextButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        imageView?.contentMode = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: 0, y: (frame.height - (imageView?.frame.height)!) * 0.5, width: (imageView?.frame.width)!, height: (imageView?.frame.height)!)
        titleLabel?.frame = CGRect(x: (imageView?.frame.width)! + 10, y: 0, width: frame.width - (imageView?.frame.width)! - 10, height: frame.height)
    }
}

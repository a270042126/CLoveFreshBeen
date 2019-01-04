//
//  UpImageDownTextButton.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class UpImageDownTextButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: 0, y: frame.height - 15, width: frame.width, height: titleLabel!.frame.height)
        titleLabel?.textAlignment = .center
        
        imageView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 15)
        imageView?.contentMode = .center
    }
    
}

class ItemLeftButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let Offset: CGFloat = 15
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: -Offset, y: frame.height - 15, width: frame.width - Offset, height: titleLabel!.frame.height)
        titleLabel?.textAlignment = .center
        
        imageView?.frame = CGRect(x: -Offset, y: 0, width: frame.width - Offset, height: frame.height - 15)
        imageView?.contentMode = .center
    }
}

class ItemRightButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let Offset: CGFloat = 15
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: Offset, y: frame.height - 15, width: frame.width + Offset, height: titleLabel!.frame.height)
        titleLabel?.textAlignment = .center
        imageView?.frame = CGRect(x: Offset, y: 0, width: frame.width + Offset, height: frame.height - 15)
        imageView?.contentMode = .center
    }
}

class ItemLeftImageButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = bounds
        imageView?.frame.origin.x = -15
    }
    
}

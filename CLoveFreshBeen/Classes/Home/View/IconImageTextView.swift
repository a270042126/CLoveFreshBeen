//
//  IconImageTextView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class IconImageTextView: UIView {

    private var imageView: UIImageView?
    private var textLabel: UILabel?
    private var placeholderImage: UIImage?
    
    var activitle: Activities? {
        didSet{
            textLabel?.text = activitle?.name
            imageView?.kf.setImage(with: URL(string: activitle!.img!), placeholder: placeholderImage)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView?.isUserInteractionEnabled = false
        imageView?.contentMode = .center
        addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel?.textAlignment = .center
        textLabel?.font = UIFont.systemFont(ofSize: 12)
        textLabel?.textColor = UIColor.black
        textLabel?.isUserInteractionEnabled = false
        addSubview(textLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, placeholderImage: UIImage) {
        self.init(frame: frame)
        self.placeholderImage = placeholderImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: 5, y: 5, width: frame.width - 15, height: frame.height - 30)
        textLabel?.frame = CGRect(x: 5, y: frame.height - 25, width: imageView!.frame.width, height: 20)
    }
}

//
//  LoadProgressAnimationView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/1.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class LoadProgressAnimationView: UIView {

    var viewWidth: CGFloat = 0
    override var frame: CGRect{
        willSet{
            if frame.size.width == viewWidth{
                self.isHidden = true
            }
            super.frame = frame
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewWidth = frame.size.width
        backgroundColor = LFBNavigationYellowColor
        self.frame.size.width = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoadProgressAnimation() {
        self.frame.size.width = 0
        isHidden = false
        UIView.animate(withDuration: 0.4, animations: {
            self.frame.size.width = self.viewWidth * 0.6
        }) { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    self.frame.size.width = self.viewWidth * 0.8
                })
            })
        }
    }
    
    func endLoadProgressAnimation(){
        UIView.animate(withDuration: 0.2, animations: {
            self.frame.size.width = self.viewWidth
        }) { (_) in
            self.isHidden = true
        }
    }
}

//
//  LFBCollectionView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class LFBCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        delaysContentTouches = false
        canCancelContentTouches = true
        let wrapView = subviews.first
        
        if wrapView != nil && NSStringFromClass(wrapView!.classForCoder).hasPrefix("WrapperView"){
            for gesture in wrapView!.gestureRecognizers! {
                if NSStringFromClass(gesture.classForCoder).contains("DelayedTouchesBegan"){
                    gesture.isEnabled = false
                    break
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        if view.isKind(of: UIControl.self){
            return true
        }
        return super.touchesShouldCancel(in: view)
    }
}

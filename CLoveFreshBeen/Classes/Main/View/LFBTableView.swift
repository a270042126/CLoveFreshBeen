//
//  LFBTableView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class LFBTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        //delaysContentTouches：默认值为YES。如果设置为NO，则会立即把事件传递给subView
        delaysContentTouches = false
        //canCancelContentTouches：默认为YES，如果设置为NO，这消息一旦传递给subView，这scroll事件不会再发生。
        canCancelContentTouches = true
        separatorStyle = .none
        
        let wrapView = subviews.first
        if wrapView != nil && NSStringFromClass((wrapView?.classForCoder)!).hasPrefix("WrapperView"){
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

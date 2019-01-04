//
//  LFBSegmentedControl.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/3.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class LFBSegmentedControl: UISegmentedControl {

    var segmentedClick:((_ index: Int) -> Void)?
    
    override init(items: [Any]?) {
        super.init(items: items)
        tintColor = LFBNavigationYellowColor
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: UIControl.State.selected)
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(r: 100, g: 100, b: 100)], for: UIControl.State.normal)
        addTarget(self, action: #selector(segmentedControlDidValuechange(sender:)), for: UIControl.Event.valueChanged)
        selectedSegmentIndex = 0
    }
    
    convenience init(items: [AnyObject]?, didSelectedIndex: @escaping (_ index: Int) -> ()) {
        self.init(items: items)
        
        segmentedClick = didSelectedIndex
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @objc func segmentedControlDidValuechange(sender: UISegmentedControl) {
        segmentedClick?(sender.selectedSegmentIndex)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

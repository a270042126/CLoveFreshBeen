//
//  HomeTableHeadView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
// - MARK: Delegate
@objc protocol HomeTableHeadViewDelegate: NSObjectProtocol {
    @objc optional func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int)
    @objc optional func tableHeadView(headView: HomeTableHeadView, iconClick index: Int)
}

class HomeTableHeadView: UIView {
    
    private var pageScrollView: PageScrollView?
    private var hotView: HotView?
    weak var delegate: HomeTableHeadViewDelegate?
    
    var tableHeadViewHeight: CGFloat = 0 {
        willSet{
            NotificationCenter.default.post(name: NSNotification.Name(HomeTableHeadViewHeightDidChange), object: newValue)
            frame = CGRect(x: 0, y: -newValue, width: ScreenWidth, height: newValue)
        }
    }
    
    // MARK: 模型的set方法
    var headData: HeadResources? {
        didSet {
            pageScrollView?.headData = headData
            hotView!.headData = headData?.data
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildPageScrollView()
        buildHotView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pageScrollView?.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenWidth * 0.31)
        hotView?.frame.origin = CGPoint(x: 0, y: pageScrollView!.frame.maxY)
        tableHeadViewHeight = hotView!.frame.maxY
    }
}

extension HomeTableHeadView{
    private func buildPageScrollView(){
        pageScrollView = PageScrollView(frame: .zero, placeholder: UIImage(named: "v2_placeholder_full_size")!, focusImageViewClick: {[weak self]  (index) in
            self?.delegate?.tableHeadView?(headView: self!, focusImageViewClick: index)
        })
        addSubview(pageScrollView!)
    }
    
    private func buildHotView(){
        hotView = HotView(frame: CGRect.zero, iconClick: {[weak self] (index) in
            self?.delegate?.tableHeadView?(headView: self!, iconClick: index)
        })
        hotView?.backgroundColor = UIColor.white
        addSubview(hotView!)
    }
}

//
//  SearchView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class SearchView: UIView {

    private let searchLabel = UILabel()
    private var lastX: CGFloat = 0
    private var lastY: CGFloat = 35
    private var searchButtonClickCallback:((_ sender: UIButton) -> ())?
    var searchHeight: CGFloat = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        searchLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width - 30, height: 35)
        searchLabel.font = UIFont.systemFont(ofSize: 15)
        searchLabel.textColor = UIColor(r: 140, g: 140, b: 140)
        addSubview(searchLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, searchTitleText: String, searchButtonTitleTexts: [String], searchButtonClickCallback:@escaping ((_ sender: UIButton) -> ())) {
        self.init(frame: frame)
        
        searchLabel.text = searchTitleText
        var btnW: CGFloat = 0
        let btnH: CGFloat = 30
        let addW: CGFloat = 30
        let marginX: CGFloat = 10
        let marginY: CGFloat = 10
        
        for i in 0..<searchButtonTitleTexts.count{
            let btn = UIButton()
            btn.setTitle(searchButtonTitleTexts[i], for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.titleLabel?.sizeToFit()
            btn.backgroundColor = UIColor.white
            btn.layer.masksToBounds = true
            btn.layer.borderWidth = 0.5
            btn.layer.borderColor = UIColor(r: 200, g: 200, b: 200).cgColor
            btn.addTarget(self, action: #selector(searchButtonClick(sender:)), for: .touchUpInside)
            btnW = btn.titleLabel!.frame.width + addW
            
            if frame.width - lastX > btnW {
                btn.frame = CGRect(x: lastX, y: lastY, width: btnW, height: btnH)
            }else{
                btn.frame = CGRect(x: 0, y: lastY + marginY + btnH, width: btnW, height: btnH)
            }
            
            lastX = btn.frame.maxX + marginX
            lastY = btn.frame.origin.y
            searchHeight = btn.frame.maxY
            addSubview(btn)
        }
        
        self.searchButtonClickCallback = searchButtonClickCallback
    }
    
    @objc private func searchButtonClick(sender: UIButton){
        searchButtonClickCallback?(sender)
    }
}

//
//  SystemMessageCell.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/4.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class SystemMessageCell: UITableViewCell {

    private var titleView: UIView?
    private var titleLabel: UILabel?
    private var showMoreButton: UIButton?
    private var subTitleView: UIView?
    private var subTitleLabel: UILabel?
    private var lineView: UIView?
    private var isSted = false
    private weak var tableView: UITableView?
    
    var message: UserMessage? {
        didSet {
            titleLabel?.text = message?.title
            subTitleLabel?.text = message?.content
            
            let attStr = NSMutableAttributedString(string: message!.content!)
            let attStyle = NSMutableParagraphStyle()
            attStyle.lineSpacing = 5.0
            var leng = (Int)(ScreenWidth - 40)
            if attStr.length < leng {
                leng = attStr.length
            }
            
            attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value:attStyle, range: NSMakeRange(0, leng))
            
            subTitleLabel?.numberOfLines = 0
            subTitleLabel?.attributedText = attStr
            subTitleLabel?.sizeToFit()
            
            if subTitleLabel!.frame.height >= 40 {
                subTitleLabel?.numberOfLines = 2
                showMoreButton?.isHidden = false
            } else {
                showMoreButton?.isHidden = true
                subTitleLabel?.numberOfLines = 1
                message?.subTitleViewHeightNomarl = 20 + (subTitleLabel!.frame.height)
                message?.cellHeight = 60 + message!.subTitleViewHeightNomarl + 20
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor.clear
        selectionStyle = UITableViewCell.SelectionStyle.none
        contentView.backgroundColor = UIColor.clear
        
        titleView = UIView()
        titleView!.backgroundColor = UIColor.white
        contentView.addSubview(titleView!)
        
        titleLabel = UILabel()
        titleLabel?.numberOfLines = 0
        titleLabel!.textAlignment = NSTextAlignment.left
        titleLabel!.font = UIFont.systemFont(ofSize: 15)
        titleView!.addSubview(titleLabel!)
        
        showMoreButton = UIButton(type: .custom)
        showMoreButton!.setTitle("显示全部", for: .normal)
        showMoreButton!.titleLabel!.font = UIFont.systemFont(ofSize: 13)
        showMoreButton?.setTitleColor(UIColor.black, for: UIControl.State.normal)
        showMoreButton?.setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        showMoreButton!.titleLabel?.textAlignment = NSTextAlignment.center
        showMoreButton!.addTarget(self, action: #selector(showMoreButtonClick), for: UIControl.Event.touchUpInside)
        showMoreButton?.isHidden = true
        titleView!.addSubview(showMoreButton!)
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor.lightGray
        lineView?.alpha = 0.2
        titleView?.addSubview(lineView!)
        
        subTitleView = UIView()
        subTitleView!.backgroundColor = UIColor.white
        contentView.addSubview(subTitleView!)
        
        subTitleLabel = UILabel()
        subTitleLabel?.numberOfLines = 0
        subTitleLabel!.textAlignment = NSTextAlignment.left
        subTitleLabel?.backgroundColor = UIColor.clear
        subTitleLabel!.textColor = UIColor.lightGray
        subTitleLabel!.font = UIFont.systemFont(ofSize: 12)
        subTitleView!.addSubview(subTitleLabel!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static private let identifier = "identifier"
    class func systemMessageCell(tableView: UITableView) -> SystemMessageCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SystemMessageCell
        if cell == nil {
            cell = SystemMessageCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        }
        cell?.tableView = tableView
        
        return cell!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: 60)
        titleLabel?.frame = CGRect(x: 20, y: 0, width: frame.width - 40, height: 60)
        showMoreButton?.frame = CGRect(x: frame.width - 80, y: 15, width: 60, height: 30)
        lineView?.frame = CGRect(x: 20, y: 59, width: frame.width - 20, height: 1)
        
        if !isSted {
            subTitleView?.frame = CGRect(x: 0, y: 60, width: frame.width, height: 60)
            subTitleLabel?.frame = CGRect(x: 20, y: 10, width: frame.width - 40, height: 60 - 20)
        } else {
            subTitleView?.frame = CGRect(x: 0, y: 60, width: frame.width, height: (message?.subTitleViewHeightSpread)!)
            subTitleLabel?.frame = CGRect(x: 20, y: 10, width: frame.width - 40, height: message!.subTitleViewHeightSpread)
            subTitleLabel?.numberOfLines = 0
            subTitleLabel?.sizeToFit()
        }
    }
    
    @objc private func showMoreButtonClick() {
        isSted = !isSted
        if isSted {
            subTitleLabel?.numberOfLines = 0
            subTitleLabel?.sizeToFit()
            message!.cellHeight = 60 + (subTitleLabel?.frame.height)! + 20 + 20
            message?.subTitleViewHeightSpread = (subTitleLabel?.frame.height)! + 20
        } else {
            subTitleLabel?.numberOfLines = 2
            message!.cellHeight = 60 + message!.subTitleViewHeightNomarl + 20
        }
        
        tableView?.reloadData()
    }
}

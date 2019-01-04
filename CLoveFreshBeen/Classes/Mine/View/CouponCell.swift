//
//  CouponCell.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/3.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class CouponCell: UITableViewCell {

    static private let cellIdentifier = "cuoponCell"
    
    let useColor = UIColor(r: 161, g: 120, b: 90)
    let unUseColor = UIColor(r: 158, g: 158, b: 158)
    
    var backImageView: UIImageView? //v2_coupon_gray  v2_coupon_yellow
    var outdateImageView: UIImageView? // v2_coupon_outdated 过期 // v2_coupon_used已使用
    var titleLabel: UILabel?
    var dateLabel: UILabel?
    var descLabel: UILabel?
    var line1View: UIView?
    var line2View: UIView?
    var priceLabel: UILabel?
    var statusLabel: UILabel?
    var circleImageView: UIImageView?
    
    private let circleWidth: CGFloat = ScreenWidth * 0.16
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCell.SelectionStyle.none
        contentView.backgroundColor = UIColor.clear
        
        backImageView = UIImageView()
        contentView.addSubview(backImageView!)
        
        dateLabel = UILabel()
        dateLabel?.font = UIFont.systemFont(ofSize: 12)
        dateLabel?.textAlignment = NSTextAlignment.center
        contentView.addSubview(dateLabel!)
        
        line1View = UIView()
        line1View?.alpha = 0.3
        contentView.addSubview(line1View!)
        
        line2View = UIView()
        line2View?.alpha = 0.3
        contentView.addSubview(line2View!)
        
        titleLabel = UILabel()
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        titleLabel?.textAlignment = NSTextAlignment.center
        contentView.addSubview(titleLabel!)
        
        circleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: circleWidth, height: circleWidth))
        contentView.addSubview(circleImageView!)
        
        statusLabel = UILabel(frame: CGRect(x: 0, y: 35, width: circleWidth, height: 20))
        statusLabel!.isHidden = true
        statusLabel?.textColor = UIColor(r: 105, g: 105, b: 105)
        statusLabel?.font = UIFont.systemFont(ofSize: 10)
        statusLabel?.textAlignment = NSTextAlignment.center
        circleImageView?.addSubview(statusLabel!)
        
        priceLabel = UILabel()
        priceLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceLabel?.frame = CGRect(x: 0, y: 10, width: circleWidth, height: 30)
        priceLabel?.textAlignment = NSTextAlignment.center
        priceLabel?.textColor = UIColor.white
        circleImageView!.addSubview(priceLabel!)
        
        descLabel = UILabel()
        descLabel?.font = UIFont.systemFont(ofSize: 9)
        descLabel?.numberOfLines = 0
        contentView.addSubview(descLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func cellWithTableView(tableView: UITableView) -> CouponCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CouponCell
        if cell == nil {
            cell = CouponCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellIdentifier)
        }
        
        return cell!
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let starRightL: CGFloat = (ScreenWidth - 2 * CouponViewControllerMargin) * 0.26 + CouponViewControllerMargin
        let rightWidth: CGFloat = (ScreenWidth - 2 * CouponViewControllerMargin) * 0.74
        
        backImageView?.frame = CGRect(x: CouponViewControllerMargin, y: 5, width: frame.width - 2 * CouponViewControllerMargin, height: frame.height - 10)
        
        let circleX = ((ScreenWidth - 2 * CouponViewControllerMargin) * 0.26 - circleWidth) * 0.65
        circleImageView?.frame = CGRect(x: CouponViewControllerMargin + circleX, y: 0, width: circleWidth, height: circleWidth)
        circleImageView?.center.y = backImageView!.center.y
        
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRect(x: (rightWidth - titleLabel!.frame.width) * 0.5 + starRightL, y: 15, width: titleLabel!.frame.width, height: titleLabel!.frame.height)
        
        line1View?.frame = CGRect(x: CouponViewControllerMargin + (ScreenWidth - 2 * CouponViewControllerMargin) * 0.26 + 10, y:  2, width: (ScreenWidth - 2 * CouponViewControllerMargin) * 0.74 - 20, height: 0.8)
        line1View?.center.y = (titleLabel?.center.y)!
        
        dateLabel?.sizeToFit()
        dateLabel?.frame = CGRect(x: (rightWidth - dateLabel!.frame.width) * 0.5 + starRightL, y: titleLabel!.frame.maxY + 10, width: dateLabel!.frame.width, height: dateLabel!.frame.height)
        
        line2View?.frame = CGRect(x: dateLabel!.frame.maxX, y: dateLabel!.frame.maxY + 15, width: dateLabel!.frame.width, height: 0.4)
        
        descLabel?.frame = CGRect(x: starRightL + CouponViewControllerMargin, y: line2View!.frame.minY + 5, width: rightWidth - CouponViewControllerMargin - 10, height: 40)
    }
    
    var coupon: Coupon? {
        didSet {
            switch coupon!.status {
            case 0:
                setCouponColor(isUse: true)
                break
            case 1:
                setCouponColor(isUse: false)
                statusLabel?.text = "已使用"
                break
            default:
                setCouponColor(isUse: false)
                statusLabel?.text = "已过期"
                break
            }
            priceLabel?.text = "$" + (coupon!.value?.cleanDecimalPointZear())!
            titleLabel?.text = " " + (coupon?.name)! + "  "
            dateLabel?.text = "有效期:  " + coupon!.start_time! + "至" + coupon!.end_time!
            descLabel?.text = coupon?.desc
        }
    }
    
    private func setCouponColor(isUse: Bool) {
        
        backImageView!.image = isUse ? UIImage(named: "v2_coupon_yellow") : UIImage(named: "v2_coupon_gray")
        titleLabel?.textColor = isUse ? useColor : unUseColor
        titleLabel?.backgroundColor = isUse ? UIColor(r: 255, g: 244, b: 224) : UIColor(r: 238, g: 238, b: 238)
        dateLabel?.textColor = titleLabel?.textColor
        statusLabel?.isHidden = isUse
        line1View?.backgroundColor = isUse ? useColor : unUseColor
        line2View?.backgroundColor = line1View?.backgroundColor
        descLabel?.textColor = titleLabel?.textColor
        
        let tmpView = UIView(frame: CGRect(x: 0, y: 0, width: circleWidth, height: circleWidth))
        tmpView.backgroundColor = isUse ? LFBNavigationYellowColor : UIColor(r: 210, g: 210, b: 210)
        let image = UIImage.createImageFromView(view: tmpView)
        circleImageView!.image = image?.imageClipOvalImage()
    }
}
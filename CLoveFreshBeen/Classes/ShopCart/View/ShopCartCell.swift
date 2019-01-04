//
//  ShopCartCell.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class ShopCartCell: UITableViewCell {

    static private let identifier = "ShopCarCell"
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let buyView    = BuyView()
    
    var goods: Goods? {
        didSet{
            if goods?.is_xf == 1 {
                titleLabel.text = "[精选]" + goods!.name!
            } else {
                titleLabel.text = goods?.name
            }
            
            priceLabel.text = "$" + goods!.price!.cleanDecimalPointZear()
            
            buyView.goods = goods
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        titleLabel.frame = CGRect(x: 15, y: 0, width: ScreenWidth * 0.5, height: ShopCartRowHeight)
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.black
        contentView.addSubview(titleLabel)
        
        buyView.frame = CGRect(x: ScreenWidth - 85, y: (ShopCartRowHeight - 25) * 0.55, width: 80, height: 25)
        contentView.addSubview(buyView)
        
        priceLabel.frame = CGRect(x: buyView.frame.minX - 100 - 5, y: 0, width: 100, height: ShopCartRowHeight)
        priceLabel.textAlignment = .right
        contentView.addSubview(priceLabel)
        
        let lineView = UIView(frame: CGRect(x: 10, y: ShopCartRowHeight - 0.5, width: ScreenWidth - 10, height: 0.5))
        lineView.backgroundColor = UIColor.black
        lineView.alpha = 0.1
        contentView.addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func shopCarCell(tableView: UITableView) -> ShopCartCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ShopCartCell
        if cell == nil{
            cell = ShopCartCell(style: .default, reuseIdentifier: identifier)
        }
        return cell!
    }
}

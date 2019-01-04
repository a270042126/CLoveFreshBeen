//
//  DiscountPriceView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class DiscountPriceView: UIView {

    private var marketPriceLabel: UILabel?
    private var priceLabel: UILabel?
    private var lineView: UIView?
    private var hasMarketPrice = false
    
    var priceColor: UIColor? {
        didSet{
            if priceLabel != nil {
                priceLabel?.textColor = priceColor
            }
        }
    }
    
    var marketPriceColor: UIColor? {
        didSet{
            if marketPriceLabel != nil {
                marketPriceLabel!.textColor = marketPriceColor
                
                if lineView != nil {
                    lineView?.backgroundColor = marketPriceColor
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        marketPriceLabel = UILabel()
        marketPriceLabel?.textColor = UIColor(r: 80, g: 80, b: 80)
        marketPriceLabel?.font = HomeCollectionTextFont
        addSubview(marketPriceLabel!)
        
        lineView = UIView()
        lineView?.backgroundColor = UIColor(r: 80, g: 80, b: 80)
        
        marketPriceLabel?.addSubview(lineView!)
        
        priceLabel = UILabel()
        priceLabel?.font = HomeCollectionTextFont
        priceLabel!.textColor = UIColor.red
        addSubview(priceLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(price: String?, marketPrice: String?) {
        self.init()
        if price != nil && price?.count != 0 {
            priceLabel!.text = "$" + price!.cleanDecimalPointZear()
            priceLabel!.sizeToFit()
        }
        
        if marketPrice != nil && marketPrice?.count  != 0 {
            marketPriceLabel?.text = "$" + marketPrice!.cleanDecimalPointZear()
            hasMarketPrice = true
            marketPriceLabel?.sizeToFit()
        } else {
            hasMarketPrice = false
        }
        
        if marketPrice == price {
            hasMarketPrice = false
        } else {
            hasMarketPrice = true
        }
        
        marketPriceLabel?.isHidden = !hasMarketPrice
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        priceLabel?.frame = CGRect(x: 0, y: 0, width: priceLabel!.frame.width, height: frame.height)
        if hasMarketPrice {
            marketPriceLabel?.frame = CGRect(x: priceLabel!.frame.maxX + 5, y: 0, width: marketPriceLabel!.frame.width, height: frame.height)
            lineView?.frame = CGRect(x: 0, y: marketPriceLabel!.frame.height * 0.5 - 0.5, width: marketPriceLabel!.frame.width, height: 1)
        }
    }
}

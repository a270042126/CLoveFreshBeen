//
//  ShopCartSupermarketTableFooterView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

protocol ShopCartSupermarketTableFooterViewDelegate: NSObjectProtocol {
    func supermarketTableFooterDetermineButtonClick();
}
class ShopCartSupermarketTableFooterView: UIView {

    private let titleLabel = UILabel()
    let priceLabel = UILabel()
    private let determineButton = UIButton()
    private let backView = UIView()
    weak var delegate: ShopCartSupermarketTableFooterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ShopCartRowHeight)
        backView.backgroundColor = UIColor.white
        addSubview(backView)
        
        titleLabel.text = "共$ "
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.red
        titleLabel.frame = CGRect(x: 15, y: 0, width: titleLabel.frame.width, height: ShopCartRowHeight)
        addSubview(titleLabel)
        
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = UIColor.red
        priceLabel.frame = CGRect(x: titleLabel.frame.maxX, y: 0, width: ScreenWidth * 0.5, height: ShopCartRowHeight)
        priceLabel.text = UserShopCarTool.sharedUserShopCar.getAllProductsPrice()
        addSubview(priceLabel)
        
        determineButton.frame = CGRect(x: ScreenWidth - 90, y: 0, width: 90, height: ShopCartRowHeight)
        determineButton.backgroundColor = LFBNavigationYellowColor
        determineButton.setTitle("选好了", for: .normal)
        determineButton.setTitleColor(UIColor.black, for: .normal)
        determineButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        determineButton.addTarget(self, action: #selector(determineButtonClick), for: .touchUpInside)
        addSubview(determineButton)
        
        addSubview(lineView(frame: CGRect(x: 0, y: ShopCartRowHeight - 0.5, width: ScreenWidth, height: 0.5)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShopCartSupermarketTableFooterView{
    
    func setPriceLabel(price: Double) {
        priceLabel.text = "\(price)".cleanDecimalPointZear()
    }
    
    private func lineView(frame: CGRect) -> UIView {
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = UIColor.black
        lineView.alpha = 0.1
        return lineView
    }
    
    @objc func determineButtonClick() {
        delegate?.supermarketTableFooterDetermineButtonClick()
    }
}

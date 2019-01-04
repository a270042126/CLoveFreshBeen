//
//  BuyView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class BuyView: UIView {

    var clickAddShopCar: (() -> ())?
    var zearIsShow = false
    
    /// 添加按钮
    private lazy var addGoodsButton: UIButton = {
        let addGoodsButton = UIButton(type: .custom)
        addGoodsButton.setImage(UIImage(named: "v2_increase"), for: .normal)
        addGoodsButton.addTarget(self, action: #selector(addGoodsButtonClick), for: .touchUpInside)
        return addGoodsButton
    }()
    
    /// 删除按钮
    private lazy var reduceGoodsButton: UIButton = {
        let reduceGoodsButton = UIButton(type: .custom)
        reduceGoodsButton.setImage(UIImage(named: "v2_reduce"), for: .normal)
        reduceGoodsButton.addTarget(self, action: #selector(reduceGoodsButtonClick), for: .touchUpInside)
        return reduceGoodsButton
    }()
    
    /// 购买数量
    private lazy var buyCountLabel: UILabel = {
        let buyCountLabel = UILabel()
        buyCountLabel.isHidden = false
        buyCountLabel.text = "0"
        buyCountLabel.textColor = UIColor.black
        buyCountLabel.textAlignment = .center
        buyCountLabel.font = HomeCollectionTextFont
        return buyCountLabel
    }()
    
    /// 补货中
    private lazy var supplementLabel: UILabel = {
        let supplementLabel = UILabel()
        supplementLabel.text = "补货中"
        supplementLabel.isHidden = true
        supplementLabel.textAlignment = .right
        supplementLabel.textColor = UIColor.red
        supplementLabel.font = HomeCollectionTextFont
        return supplementLabel
    }()
    
    private var buyNumber: Int = 0 {
        willSet {
            if newValue > 0 {
                reduceGoodsButton.isHidden = false
                buyCountLabel.text = "\(newValue)"
            } else {
                reduceGoodsButton.isHidden = true
                buyCountLabel.isHidden = false
                buyCountLabel.text = "\(newValue)"
            }
        }
    }
    
    var goods: Goods?{
        didSet{
            buyNumber = goods!.userBuyNumber
            if goods!.number <= 0{
                showSupplementLabel()
            }else{
                hideSupplementLabel()
            }
            
            if buyNumber == 0{
                reduceGoodsButton.isHidden = true && !zearIsShow
                buyCountLabel.isHidden = true && !zearIsShow
            } else {
                reduceGoodsButton.isHidden = false
                buyCountLabel.isHidden = false
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buyCountLabel)
        addSubview(supplementLabel)
        addSubview(reduceGoodsButton)
        addSubview(addGoodsButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let buyCountWidth: CGFloat = 25
        addGoodsButton.frame = CGRect(x: frame.width - frame.height - 2, y: 0, width: frame.height, height: frame.height)
        buyCountLabel.frame = CGRect(x: addGoodsButton.frame.minX - buyCountWidth, y: 0, width: buyCountWidth, height: frame.height)
        reduceGoodsButton.frame = CGRect(x: buyCountLabel.frame.minX - frame.height, y: 0, width: frame.height, height: frame.height)
        supplementLabel.frame = CGRect(x: reduceGoodsButton.frame.minX, y: 0, width: frame.height + buyCountWidth + frame.height, height: frame.height)
    }
}

extension BuyView {
    /// 显示补货中
    private func showSupplementLabel() {
        supplementLabel.isHidden = false
        addGoodsButton.isHidden = true
        reduceGoodsButton.isHidden = true
        buyCountLabel.isHidden = true
    }
    
    /// 隐藏补货中,显示添加按钮
    private func hideSupplementLabel() {
        supplementLabel.isHidden = true
        addGoodsButton.isHidden = false
        reduceGoodsButton.isHidden = false
        buyCountLabel.isHidden = false
    }
    
    // MARK: - Action
    @objc private func addGoodsButtonClick(){
        if buyNumber > goods!.number{
            NotificationCenter.default.post(name: NSNotification.Name(HomeGoodsInventoryProblem), object: goods?.name)
            return
        }
        
        reduceGoodsButton.isHidden = false
        buyNumber += 1
        goods?.userBuyNumber = buyNumber
        buyCountLabel.text = "\(buyNumber)"
        buyCountLabel.isHidden = false
        
        clickAddShopCar?()
        ShopCarRedDotView.sharedRedDotView.addProductToRedDotView(animation: true)
        UserShopCarTool.sharedUserShopCar.addSupermarkProductToShopCar(goods: goods!)
        NotificationCenter.default.post(name: NSNotification.Name(LFBShopCarBuyPriceDidChangeNotification), object: nil)
    }
    
    @objc private func reduceGoodsButtonClick(){
        if buyNumber <= 0{
            return
        }
        
        buyNumber -= 1
        goods?.userBuyNumber = buyNumber
        if buyNumber == 0{
            reduceGoodsButton.isHidden = true && !zearIsShow
            buyCountLabel.isHidden = true && !zearIsShow
            buyCountLabel.text = zearIsShow ? "0" : ""
            UserShopCarTool.sharedUserShopCar.removeSupermarketProduct(goods: goods!)
        }else{
            buyCountLabel.text = "\(buyNumber)"
        }
        
        ShopCarRedDotView.sharedRedDotView.reduceProductToRedDotView(animation: true)
        NotificationCenter.default.post(name: NSNotification.Name(LFBShopCarBuyPriceDidChangeNotification), object: nil)
    }
}

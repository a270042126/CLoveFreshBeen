
//
//  UserShopCarTool.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class UserShopCarTool: NSObject {

    private static let instance = UserShopCarTool()
    private var supermarketProducts = [Goods]()
    
    class var sharedUserShopCar: UserShopCarTool{
        return instance
    }
    
    func userShopCarProductsNumber() -> Int {
        return ShopCarRedDotView.sharedRedDotView.buyNumber
    }
    
    func isEmpty() -> Bool {
        return supermarketProducts.count == 0
    }
    
    func addSupermarkProductToShopCar(goods: Goods){
        for everyGoods in supermarketProducts{
            if everyGoods.id == goods.id {
                return
            }
        }
        supermarketProducts.append(goods)
    }
    
    func getShopCarProducts() -> [Goods] {
        return supermarketProducts
    }
    
    func getShopCarProductsClassifNumber() -> Int {
        return supermarketProducts.count
    }
    
    func removeSupermarketProduct(goods: Goods) {
        for i in 0..<supermarketProducts.count{
            let everyGoods = supermarketProducts[i]
            if everyGoods.id == goods.id{
                supermarketProducts.remove(at: i)
                NotificationCenter.default.post(name: NSNotification.Name(LFBShopCarDidRemoveProductNSNotification), object: nil)
                return
            }
        }
    }
    
    func getAllProductsPrice() -> String {
        var allPrice: Decimal = 0
        for goods in supermarketProducts {
            allPrice = allPrice + Decimal(string: goods.partner_price!)! * Decimal(goods.userBuyNumber)
        }
        return "\(allPrice)".cleanDecimalPointZear()
    }
}

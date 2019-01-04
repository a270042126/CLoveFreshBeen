//
//  Supermarket.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/1.
//  Copyright © 2019年 dd. All rights reserved.
//

import HandyJSON

struct Supermarket: HandyJSON {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: SupermarketResouce?
    
    static func searchCategoryMatchProducts(supermarketResouce: SupermarketResouce) -> [[Goods]]? {
        var arr = [[Goods]]()

        let products = supermarketResouce.products
        for cate in supermarketResouce.categories! {
            let goodsArr = products!.value(forKey: cate.id!) as? [Goods]
            arr.append(goodsArr ?? [])
        }
        return arr
    }
}

struct SupermarketResouce: HandyJSON {
    var categories: [Categorie]?
    var products: Products?
    var trackid: String?
}

struct Categorie: HandyJSON {
    var id: String?
    var name: String?
    var sort: String?
}


class Products: NSObject, HandyJSON {
    @objc var a82: [Goods]?
    @objc var a96: [Goods]?
    @objc var a99: [Goods]?
    @objc var a106: [Goods]?
    @objc var a134: [Goods]?
    @objc var a135: [Goods]?
    @objc var a136: [Goods]?
    @objc var a137: [Goods]?
    @objc var a141: [Goods]?
    @objc var a143: [Goods]?
    @objc var a147: [Goods]?
    @objc var a151: [Goods]?
    @objc var a152: [Goods]?
    @objc var a158: [Goods]?
    required override init() {}
}

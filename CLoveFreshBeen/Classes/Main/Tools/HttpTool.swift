//
//  HttpTool.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import SwiftyJSON

class HttpTool {
    private class func getData(file:String, type:String? = nil) -> Data?{
        let path = Bundle.main.path(forResource: file, ofType: type)
        let data = try? NSData(contentsOfFile: path!) as Data
        return data
    }
    
    class func loadADData(completion:(_ model: AdModel?) -> Void){
        guard let data = getData(file: "AD") else {return}
        if let json = try? JSON(data: data){
            completion(AdModel.deserialize(from: json.dictionaryObject))
        }
    }
    
    class func loadMyAdressData(completion:(_ model: AddressModel?) -> Void){
        guard let data = getData(file: "MyAdress") else {return}
        if let json = try? JSON(data: data){
            completion(AddressModel.deserialize(from: json.dictionaryObject))
        }
    }
    
    class func loadSearchData(completion:(_ model: SearchProductsModel?) -> Void){
        guard let data = getData(file: "促销") else {return}
        if let json = try? JSON(data: data){
            completion(SearchProductsModel.deserialize(from: json.dictionaryObject))
        }
    }
    
    class func loadHomeHeadData(completion:(_ model: HeadResources?) -> Void){
        guard let data = getData(file: "首页焦点按钮") else {return}
        if let json = try? JSON(data: data){
            completion(HeadResources.deserialize(from: json.dictionaryObject))
        }
    }
    
    class func loadFreshHotData(completion:(_ model: FreshHot?) -> Void){
        guard let data = getData(file: "首页新鲜热卖") else {return}
        if let json = try? JSON(data: data){
            completion(FreshHot.deserialize(from: json.dictionaryObject))
        }
    }
    
    class func loadSupermarketData(completion:(_ model: Supermarket?) -> Void){
        guard let data = getData(file: "supermarket") else{return}
        if let json = try? JSON(data: data) {
            completion(Supermarket.deserialize(from: json.dictionaryObject))
        }
    }
    
    class func loadMineData(completion:(_ model: MineModel?) -> Void){
        guard let data = getData(file: "Mine") else{return}
        if let json = try? JSON(data: data) {
            completion(MineModel.deserialize(from: json.dictionaryObject))
        }
    }
    
    class func loadOrderData(completion:(_ model: OrderModel?) -> Void){
        guard let data = getData(file: "MyOrders") else{return}
        if let json = try? JSON(data: data) {
            completion(OrderModel.deserialize(from: json.dictionaryObject))
        }
    }
    
    class func loadCouponData(completion:(_ model: CouponModel?) -> Void){
        guard let data = getData(file: "MyCoupon") else{return}
        if let json = try? JSON(data: data) {
            completion(CouponModel.deserialize(from: json.dictionaryObject))
        }
    }
    
    class func loadSystemMessage(completion:(_ models: [UserMessage]?) -> Void){
        guard let data = getData(file: "SystemMessage") else{return}
        if let json = try? JSON(data: data) {
            completion(json["data"].array?.compactMap({UserMessage.deserialize(from: $0.dictionaryObject)}))
        }
    }
    
    class func loadUserMessage(completion:(_ models: [UserMessage]?) -> Void){
        guard let data = getData(file: "UserMessage") else{return}
        if let json = try? JSON(data: data) {
            completion(json["data"].array?.compactMap({UserMessage.deserialize(from: $0.dictionaryObject)}))
        }
    }
    
    class func loadQuestions(completion:(_ models: [Question]?) -> Void){
        let path = Bundle.main.path(forResource: "HelpPlist", ofType: "plist")
        if let array = NSArray(contentsOfFile: path!) {
            completion(array.compactMap({Question.question(dict: $0 as! [String: Any])}))
        }
    }
}

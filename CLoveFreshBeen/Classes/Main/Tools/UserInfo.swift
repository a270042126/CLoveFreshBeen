//
//  UserInfo.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//  当前用户信息

import UIKit

class UserInfo: NSObject {
    private static let instance = UserInfo()
    
    private var allAddress: [Address]?
    class var shareUserInfo: UserInfo {
        return instance
    }
    
    func hasDefaultAddress() -> Bool{
        return allAddress != nil
    }
    
    func setAllAdress(addresses: [Address]) {
        allAddress = addresses
    }
    
    func cleanAllAddress() {
        allAddress = nil
    }
    
    func defaultAddress() -> Address? {
        if allAddress == nil {
            HttpTool.loadMyAdressData { (model) in
                self.allAddress = model?.data
            }
        }
        
        return allAddress?.first
    }
    
    func setDefaultAddress(address: Address){
        if allAddress != nil {
            allAddress?.insert(address, at: 0)
        } else {
            allAddress = [Address]()
            allAddress?.append(address)
        }
    }
}

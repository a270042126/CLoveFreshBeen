//
//  AddressModel.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import HandyJSON

class AddressModel: HandyJSON {
    var code: Int = -1
    var msg: String?
    var data: [Address]?
    required init() {
        
    }
}

class Address: HandyJSON {
    var accept_name: String?
    var telphone: String?
    var province_name: String?
    var city_name: String?
    var address: String?
    var lng: String?
    var lat: String?
    var gender: String?
    required init() {
        
    }
}

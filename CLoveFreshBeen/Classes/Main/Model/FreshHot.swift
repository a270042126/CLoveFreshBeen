//
//  FreshHot.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import HandyJSON

struct FreshHot: HandyJSON{
    var page: Int = -1
    var code: Int = -1
    var msg: String?
    var data: [Goods]?
}

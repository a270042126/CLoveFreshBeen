
//
//  MineModel.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import HandyJSON

struct MineModel: HandyJSON {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: MineData?
}

struct MineData: HandyJSON {
    var has_new: Int = -1
    var has_new_user: Int = -1
    var availble_coupon_num = 0
}

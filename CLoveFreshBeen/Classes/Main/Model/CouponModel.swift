//
//  CouponModel.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/3.
//  Copyright © 2019年 dd. All rights reserved.
//

import HandyJSON

struct CouponModel: HandyJSON {
    var code: Int = -1
    var msg: String?
    var reqid: String?
    var data: [Coupon]?
}

struct Coupon: HandyJSON {
    var id: String?
    var card_pwd: String?
    /// 开始时间
    var start_time: String?
    /// 结束时间
    var end_time: String?
    /// 金额
    var value: String?
    var tid: String?
    /// 是否被使用 0 使用 1 未使用
    var is_userd: String?
    /// 0 可使用 1 不可使用
    var status: Int = -1
    var true_end_time: String?
    /// 标题
    var name: String?
    var point: String?
    var type: String?
    var order_limit_money: String?
    var desc: String?
    var free_freight: String?
    var city: String?
    var ctime: String?
}

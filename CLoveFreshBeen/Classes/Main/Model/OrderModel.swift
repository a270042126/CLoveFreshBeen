//
//  OrderModel.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import HandyJSON

struct OrderModel: HandyJSON {
    var page: Int = -1
    var code: Int = -1
    var data: [Order]?
}

struct Order: HandyJSON {
    var star: Int = -1
    var comment: String?
    var id: String?
    var order_no: String?
    var accept_name: String?
    var user_id: String?
    var pay_code: String?
    var pay_type: String?
    var distribution: String?
    var status: String?
    var pay_status: String?
    var distribution_status: String?
    var postcode: String?
    var telphone: String?
    var country: String?
    var province: String?
    var city: String?
    var address: String?
    var longitude: String?
    var latitude: String?
    var mobile: String?
    var payable_amount: String?
    var real_amount: String?
    var pay_time: String?
    var send_time: String?
    var create_time: String?
    var completion_time: String?
    var order_amount: String?
    var accept_time: String?
    var lastUpdateTime: String?
    var preg_dealer_type: String?
    var user_pay_amount: String?
    var order_goods: [[OrderGoods]]?
    var enableComment: Int = -1
    var isCommented: Int = -1
    var newStatus: Int = -1
    var status_timeline: [OrderStatus]?
    var fee_list: [OrderFeeList]?
    var buy_num: Int = -1
    var showSendCouponBtn: Int = -1
    var dealer_name: String?
    var dealer_address: String?
    var dealer_lng: String?
    var dealer_lat: String?
    var buttons: [OrderButton]?
    var detail_buttons: [OrderButton]?
    var textStatus: String?
    var in_refund: Int = -1
    var checknum: String?
    var postscript: String?
}

struct OrderGoods: HandyJSON {
    var goods_id: String?
    var goods_price: String?
    var real_price: String?
    var isgift: Int = -1
    var name: String?
    var specifics: String?
    var brand_name: String?
    var img: String?
    var is_gift: Int = -1
    var goods_nums: String?
}

struct OrderStatus: HandyJSON {
    var status_title: String?
    var status_desc: String?
    var status_time: String?
}

struct OrderFeeList: HandyJSON {
    var text: String?
    var value: String?
}

struct OrderButton: HandyJSON {
    var type: Int = -1
    var text: String?
}

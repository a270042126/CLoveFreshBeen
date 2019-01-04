//
//  AdModel.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import HandyJSON

struct AdModel: HandyJSON {
    var code: Int = -1
    var msg: String?
    var data: AD?
}

struct AD: HandyJSON {
    var title: String?
    var img_name: String?
    var starttime: String?
    var endtime: String?
}

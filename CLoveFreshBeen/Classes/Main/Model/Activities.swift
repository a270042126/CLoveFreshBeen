//
//  Activities.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import HandyJSON

struct HeadResources: HandyJSON {
    var msg: String?
    var reqid: String?
    var data: HeadData?
}

struct HeadData: HandyJSON{
    var focus: [Activities]?
    var icons: [Activities]?
    var activities: [Activities]?
}

struct Activities: HandyJSON {
    var id: String?
    var name: String?
    var img: String?
    var topimg: String?
    var jptype: String?
    var trackid: String?
    var mimg: String?
    var customURL: String?
}

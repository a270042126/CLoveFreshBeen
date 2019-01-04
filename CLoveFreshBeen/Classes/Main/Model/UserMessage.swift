//
//  UserMessage.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/4.
//  Copyright © 2019年 dd. All rights reserved.
//

import HandyJSON

enum UserMessageType: Int {
    case System = 0
    case User = 1
}

class UserMessage: HandyJSON {
    var id: String?
    var type = -1
    var title: String?
    var content: String?
    var link: String?
    var city: String?
    var noticy: String?
    var send_time: String?
    
    // 辅助参数
    var subTitleViewHeightNomarl: CGFloat = 60
    var cellHeight: CGFloat = 60 + 60 + 20
    var subTitleViewHeightSpread: CGFloat = 0
    
    required init() {}
}

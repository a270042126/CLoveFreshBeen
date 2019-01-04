//
//  Question.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/4.
//  Copyright © 2019年 dd. All rights reserved.
//

import HandyJSON

struct Question {
    var title: String?
    var texts: [String]? {
        didSet {
            let maxSize = CGSize(width: ScreenWidth - 40, height: 100000)
            for i in 0..<texts!.count {
                let str = texts![i] as NSString
                let rowHeight: CGFloat = str.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil).size.height + 14
                cellHeight += rowHeight
                everyRowHeight.append(rowHeight)
            }
        }
    }
    
    static func question(dict: [String: Any]) -> Question {
        var question = Question()
        question.title = dict["title"] as? String
        question.texts = dict["texts"] as? [String]
        
        return question
    }
    
    var everyRowHeight: [CGFloat] = []
    var cellHeight: CGFloat = 0
}

//
//  String+Extension.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

extension String {

    /// 清除字符串小数点末尾的0
    func cleanDecimalPointZear() -> String {
        let newStr = self as NSString
        var s = NSString()
        
        var offset = newStr.length - 1
        while offset > 0 {
            s = newStr.substring(with: NSRange(location: offset, length: 1)) as NSString
            if s.isEqual(to: "0") || s.isEqual(to: "."){
                offset -= 1
            }else{
                break
            }
        }
        return newStr.substring(to: offset + 1)
    }

}

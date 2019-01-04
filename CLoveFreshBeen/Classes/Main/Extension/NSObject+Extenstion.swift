
//
//  NSObject+Extenstion.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/1.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

extension NSObject{
    func getValueOfProperty(property:String)-> AnyObject?{
        let allPropertys = self.getAllPropertys()
        if(allPropertys.contains(property)){
            return self.value(forKey: property) as AnyObject
        }else{
            return nil
        }
    }
    
    func getAllPropertys()->[String]{
        var result = [String]()
        let count = UnsafeMutablePointer<UInt32>.allocate(capacity: 0)
        let buff = class_copyPropertyList(object_getClass(self), count)
        let countInt = Int(count[0])
        for i in 0..<countInt{
            let temp = buff![i]
            let tempPro = property_getName(temp)
            let proper = NSString.init(utf8String: tempPro)
            result.append(proper! as String)
        }
        return result
    }
}


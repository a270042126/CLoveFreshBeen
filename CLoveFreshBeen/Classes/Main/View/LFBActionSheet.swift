//
//  LFBActionSheet.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

enum ShareType: Int {
    case WeiXinMyFriend = 1
    case WeiXinCircleOfFriends = 2
    case SinaWeiBo = 3
    case QQZone = 4
}

class LFBActionSheet: NSObject, UIActionSheetDelegate {
    private var selectedShaerType: ((_ shareType: ShareType) -> ())?
    private var alert: UIAlertController?
    
    func showActionSheetViewShowInView(parentVc: UIViewController, selectedShaerType: @escaping ((_ shareType: ShareType) -> ())) {
        alert = UIAlertController(title: "分享到", message: nil, preferredStyle: .actionSheet)
        let wechatAction = UIAlertAction(title: "微信好友", style: .default) { (action) in
            selectedShaerType(.WeiXinMyFriend)
        }
        
        let pyqAction = UIAlertAction(title: "微信朋友圈", style: .default) { (action) in
            selectedShaerType(.WeiXinCircleOfFriends)
        }
        
        let sinaAction = UIAlertAction(title: "新浪微博", style: .default) { (action) in
            selectedShaerType(.SinaWeiBo)
        }
        
        let qqAction = UIAlertAction(title: "QQ空间", style: .default) { (action) in
            selectedShaerType(.QQZone)
        }
        alert?.addAction(wechatAction)
        alert?.addAction(pyqAction)
        alert?.addAction(sinaAction)
        alert?.addAction(qqAction)
        parentVc.present(alert!, animated: true, completion: nil)
    }
}

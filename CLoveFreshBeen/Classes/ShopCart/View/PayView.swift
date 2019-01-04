//
//  PayView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit
enum PayWayType: Int {
    case WeChat   = 0
    case QQPurse  = 1
    case AliPay   = 2
    case Delivery = 3
}
class PayWayView: UIView{
    private var payType: PayWayType?
    private let payIconImageView = UIImageView(frame: CGRect(x: 20, y: 10, width: 20, height: 20))
    private let payTitleLabel: UILabel = UILabel(frame: CGRect(x: 55, y: 0, width: 150, height: 40))
    private var selectedCallback: ((_ type: PayWayType) -> Void)?
    let selectedButton = UIButton(frame: CGRect(x: ScreenWidth - 10 - 16, y: (40 - 16) * 0.5, width: 16, height: 16))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        payIconImageView.contentMode = .scaleAspectFill
        addSubview(payIconImageView)
        
        payTitleLabel.textColor = UIColor.black
        payTitleLabel.font = UIFont.systemFont(ofSize: 14)
        addSubview(payTitleLabel)
        
        selectedButton.setImage(UIImage(named: "v2_noselected"), for: .normal)
        selectedButton.setImage(UIImage(named: "v2_selected"), for: .selected)
        selectedButton.isUserInteractionEnabled = false
        addSubview(selectedButton)
        
        let lineView = UIView(frame: CGRect(x: 15, y: 0, width: ScreenWidth - 15, height: 0.5))
        lineView.backgroundColor = UIColor.black
        lineView.alpha = 0.1
        addSubview(lineView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(selectedPayView))
        addGestureRecognizer(tap)
    }
    
    convenience init(frame: CGRect, payType: PayWayType, selectedCallBack: @escaping ((_ type: PayWayType) -> ())) {
        self.init(frame: frame)
        self.payType = payType
        
        switch payType {
        case .WeChat:
            payIconImageView.image = UIImage(named: "v2_weixin")
            payTitleLabel.text = "微信支付"
            break
        case .QQPurse:
            payIconImageView.image = UIImage(named: "icon_qq")
            payTitleLabel.text = "QQ钱包"
            break
        case .AliPay:
            payIconImageView.image = UIImage(named: "zhifubaoA")
            payTitleLabel.text = "支付宝支付"
            break
        case .Delivery:
            payIconImageView.image = UIImage(named: "v2_dao")
            payTitleLabel.text = "货到付款"
            break
        }
        self.selectedCallback = selectedCallBack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func selectedPayView(){
        selectedButton.isSelected = true
        selectedCallback?(payType!)
    }
}

class PayView: UIView {

    private var weChatView: PayWayView?
    private var qqPurseView: PayWayView?
    private var alipayView: PayWayView?
    private var deliveryView: PayWayView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        weChatView = PayWayView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40), payType: .WeChat, selectedCallBack: {[weak self] (type) in
            self?.setSelectedPayView(type: type)
        })
        weChatView?.selectedButton.isSelected = true
        qqPurseView = PayWayView(frame: CGRect(x: 0, y: 40, width: ScreenWidth, height: 40), payType: .QQPurse, selectedCallBack: { [weak self](type) in
            self?.setSelectedPayView(type: type)
        })
        alipayView = PayWayView(frame: CGRect(x: 0, y: 80, width: ScreenWidth, height: 40), payType: .AliPay, selectedCallBack: {[weak self] (type) in
            self?.setSelectedPayView(type: type)
        })
        deliveryView = PayWayView(frame: CGRect(x: 0, y: 120, width: ScreenWidth, height: 40), payType: .Delivery, selectedCallBack: {[weak self] (type) in
            self?.setSelectedPayView(type: type)
        })
        
        addSubview(weChatView!)
        addSubview(qqPurseView!)
        addSubview(alipayView!)
        addSubview(deliveryView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSelectedPayView(type: PayWayType){
        weChatView?.selectedButton.isSelected = type.rawValue == PayWayType.WeChat.rawValue
        qqPurseView?.selectedButton.isSelected = type.rawValue == PayWayType.QQPurse.rawValue
        alipayView?.selectedButton.isSelected = type.rawValue == PayWayType.AliPay.rawValue
        deliveryView?.selectedButton.isSelected = type.rawValue == PayWayType.Delivery.rawValue
    }
}

//
//  ReceiptAddressView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class ReceiptAddressView: UIView {

    private let topImageView = UIImageView(image: UIImage(named: "v2_shoprail"))
    private let bottomImageView = UIImageView(image: UIImage(named: "v2_shoprail"))
    private let consigneeLabel = UILabel()
    private let phoneNumLabel = UILabel()
    private let receiptAdressLabel = UILabel()
    private let consigneeTextLabel = UILabel()
    private let phoneNumTextLabel = UILabel()
    private let receiptAdressTextLabel = UILabel()
    private let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
    private let modifyButton = UIButton()
    var modifyButtonClickCallBack: (() -> ())?
    var address: Address? {
        didSet{
            if address != nil{
                consigneeLabel.text = address!.accept_name! + (address!.gender! == "1" ? "先生" : " 女士")
                phoneNumLabel.text = address!.telphone
                receiptAdressLabel.text = address?.address
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(topImageView)
        addSubview(bottomImageView)
        addSubview(arrowImageView)
        
        modifyButton.setTitle("修改", for: .normal)
        modifyButton.setTitleColor(UIColor.red, for: .normal)
        modifyButton.addTarget(self, action: #selector(modifyButtonClick), for: .touchUpInside)
        modifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        addSubview(modifyButton)
        
        initLabel(consigneeLabel, text: "收  货  人  ")
        initLabel(phoneNumLabel, text:  "电       话  ")
        initLabel(receiptAdressLabel, text: "收货地址  ")
        initLabel(consigneeTextLabel, text: "")
        initLabel(phoneNumTextLabel, text: "")
        initLabel(receiptAdressTextLabel, text: "")
    }
    
    convenience init(frame: CGRect, modifyButtonClickCallBack:@escaping (() -> ())) {
        self.init(frame: frame)
        self.modifyButtonClickCallBack = modifyButtonClickCallBack
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let leftMargin: CGFloat = 15
        
        topImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 2)
        bottomImageView.frame = CGRect(x: 0, y: frame.height - 2, width: frame.width, height: 2)
        consigneeLabel.frame = CGRect(x: leftMargin, y: 10, width: consigneeLabel.frame.width, height: consigneeLabel.frame.height)
        consigneeTextLabel.frame = CGRect(x: consigneeLabel.frame.maxX + 5, y: consigneeLabel.frame.origin.y, width: 150, height: consigneeLabel.frame.height)
        phoneNumLabel.frame = CGRect(x: leftMargin, y: consigneeLabel.frame.maxX + 5, width: phoneNumLabel.frame.width, height: phoneNumLabel.frame.height)
        phoneNumTextLabel.frame = CGRect(x: consigneeTextLabel.frame.origin.x, y: phoneNumLabel.frame.origin.y, width: 150, height: phoneNumLabel.frame.height)
        receiptAdressLabel.frame = CGRect(x: leftMargin, y: phoneNumLabel.frame.maxY + 5, width: receiptAdressLabel.frame.width, height: receiptAdressLabel.frame.height)
        receiptAdressTextLabel.frame = CGRect(x: consigneeTextLabel.frame.origin.x, y: receiptAdressTextLabel.frame.origin.y, width: 150, height: receiptAdressTextLabel.frame.height)
        modifyButton.frame = CGRect(x: frame.width - 60, y: 0, width: 30, height: frame.height)
        arrowImageView.frame = CGRect(x: frame.width - 15, y: (frame.height - arrowImageView.frame.height) * 0.5, width: arrowImageView.frame.width, height: arrowImageView.frame.height)
    }
}

extension ReceiptAddressView {
    
    private func initLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black
        label.sizeToFit()
        addSubview(label)
    }
    
    @objc private func modifyButtonClick(){
        modifyButtonClickCallBack?()
    }
}

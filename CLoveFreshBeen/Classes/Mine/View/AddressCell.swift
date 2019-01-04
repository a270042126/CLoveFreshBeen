//
//  AdressCell.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {
    static private let identifier = "AdressCell"
    
    private lazy var nameLabel = UILabel()
    private lazy var phoneLabel = UILabel()
    private lazy var addressLabel = UILabel()
    private lazy var lineView = UIView()
    private lazy var modifyImageView = UIImageView()
    private lazy var bottomView = UIView()
    var modifyClickCallBack:((Int) -> Void)?
    
    var address: Address?{
        didSet{
            nameLabel.text = address?.accept_name
            phoneLabel.text = address?.telphone
            addressLabel.text = address?.address
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.white
    
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        nameLabel.textColor = LFBTextBlackColor
        contentView.addSubview(nameLabel)
        
        phoneLabel.font = UIFont.systemFont(ofSize: 14)
        phoneLabel.textColor = LFBTextBlackColor
        contentView.addSubview(phoneLabel)
        
        addressLabel.font = UIFont.systemFont(ofSize: 13)
        addressLabel.textColor = UIColor.lightGray
        contentView.addSubview(addressLabel)
        
        lineView.backgroundColor = UIColor.lightGray
        lineView.alpha = 0.2
        contentView.addSubview(lineView)
        
        modifyImageView.image = UIImage(named: "v2_address_edit_highlighted")
        modifyImageView.contentMode = .center
        contentView.addSubview(modifyImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(modifyImageViewClick(tap:)))
        modifyImageView.isUserInteractionEnabled = true
        modifyImageView.addGestureRecognizer(tap)
        
        bottomView.backgroundColor = UIColor.lightGray
        bottomView.alpha = 0.4
        contentView.addSubview(bottomView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame = CGRect(x: 10, y: 15, width: 80, height: 20)
        phoneLabel.frame = CGRect(x: nameLabel.frame.maxX + 10, y: 15, width: 150, height: 20)
        addressLabel.frame = CGRect(x: 10, y: phoneLabel.frame.maxY + 10, width: frame.width * 0.6, height: 20)
        lineView.frame = CGRect(x: frame.width * 0.8, y: 10, width: 1, height: frame.height - 20)
        modifyImageView.frame = CGRect(x: frame.width * 0.8 +  (frame.width * 0.2 - 40) * 0.5, y: (frame.height - 40) * 0.5, width: 40, height: 40)
        bottomView.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width - 1, height: 1)
    }

    
    // MARK: - Action
    @objc private func modifyImageViewClick(tap: UIGestureRecognizer) {
        modifyClickCallBack?(tap.view!.tag)
    }
    
    class func addressCell(tableView: UITableView, indexPath: IndexPath, modifyClickCallBack: @escaping ((Int) -> Void)) -> AddressCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AddressCell
        if cell == nil {
            cell = AddressCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.modifyClickCallBack = modifyClickCallBack
        cell?.modifyImageView.tag = indexPath.row
        return cell!
    }
}

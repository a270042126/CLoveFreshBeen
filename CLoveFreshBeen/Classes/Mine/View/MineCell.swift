//
//  MineCell.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class MineCell: UITableViewCell {
    static private let identifier = "CellID"
    let bottomLine = UIView()
    private lazy var iconImageView = UIImageView()
    private lazy var titleLabel = UILabel()
    private lazy var arrowView = UIImageView()
    
    var mineModel: MineCellModel? {
        didSet {
            titleLabel.text = mineModel!.title
            iconImageView.image = UIImage(named: mineModel!.iconName!)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconImageView)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.alpha = 0.8
        contentView.addSubview(titleLabel)
        
        bottomLine.backgroundColor = UIColor.gray
        bottomLine.alpha = 0.15
        contentView.addSubview(bottomLine)
        
        arrowView.image = UIImage(named: "icon_go")
        contentView.addSubview(arrowView)
        
        selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        arrowView.frame = CGRect(x: frame.width - 20, y: (frame.height - (arrowView.image?.size.height)!) * 0.5, width: (arrowView.image?.size.width)!, height: (arrowView.image?.size.height)!)
        
        let rightMargin: CGFloat = 10
        let iconWH: CGFloat = 20
        iconImageView.frame = CGRect(x: rightMargin, y: CGFloat(frame.height - iconWH) * 0.5, width: iconWH, height: iconWH)
        titleLabel.frame = CGRect(x: iconImageView.frame.maxX + rightMargin, y: 0, width: 200, height: frame.height)
        
        let leftMarge: CGFloat = 20
        bottomLine.frame = CGRect(x: leftMarge, y: frame.height - 0.5, width: frame.width - leftMarge, height: 0.5)
    }
    
    class func cellFor(tableView: UITableView) -> MineCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MineCell
        if cell == nil {
            cell = MineCell(style: .default, reuseIdentifier: identifier)
        }
        return cell!
    }

}

class MineCellModel: NSObject {
    
    var title: String?
    var iconName: String?
    
    class func loadMineCellModels() -> [MineCellModel] {
        
        var mines = [MineCellModel]()
        let path = Bundle.main.path(forResource: "MinePlist", ofType: "plist")
        let arr = NSArray(contentsOfFile: path!)
        
        for dic in arr! {
            mines.append(MineCellModel.mineModel(dic: dic as! NSDictionary))
        }
        
        return mines
    }
    
    class func mineModel(dic: NSDictionary) -> MineCellModel {
        
        let model = MineCellModel()
        model.title = dic["title"] as? String
        model.iconName = dic["iconName"] as? String
        
        return model
    }
    
}

//
//  CategoryCell.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/1.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    private static let identifier = "CategoryCell"
    // MARK: Lazy Property
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = LFBTextGreyColol
        nameLabel.highlightedTextColor = UIColor.black
        nameLabel.backgroundColor = UIColor.clear
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.font = UIFont.systemFont(ofSize: 14)
        return nameLabel
    }()
    
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.image = UIImage(named: "llll")
        backImageView.highlightedImage = UIImage(named: "kkkkkkk")
        return backImageView
    }()
    
    private lazy var yellowView: UIView = {
        let yellowView = UIView()
        yellowView.backgroundColor = LFBNavigationYellowColor
        
        return yellowView
    }()
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor(r: 225, g: 225, b: 225)
        return lineView
    }()
    // MARK: 模型setter方法
    var categorie: Categorie? {
        didSet {
            nameLabel.text = categorie?.name
        }
    }
    
    
    // MARK: Method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(backImageView)
        addSubview(lineView)
        addSubview(yellowView)
        addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    class func cellWithTableView(tableView: UITableView) -> CategoryCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryCell
        if cell == nil {
            cell = CategoryCell(style: .default, reuseIdentifier: identifier)
        }
        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        nameLabel.isHighlighted = selected
        backImageView.isHighlighted = selected
        yellowView.isHidden = !selected
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = bounds
        backImageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        yellowView.frame = CGRect(x: 0, y: frame.height * 0.1, width: 5, height: frame.height * 0.8)
        lineView.frame = CGRect(x: 0, y: frame.height - 1, width: frame.width, height: 1)
    }
}

//
//  AnswerCell.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/4.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {

    static private let identifier: String = "cellID"
    private let lineView = UIView()
    
    var question: Question? {
        didSet {
            for i in 0..<question!.texts!.count {
                
                var textY: CGFloat = 0
                for j in 0..<i {
                    textY += question!.everyRowHeight[j]
                }
                
                let textLabel = UILabel(frame: CGRect(x: 20, y: textY, width: ScreenWidth - 40, height: question!.everyRowHeight[i]))
                textLabel.text = question!.texts![i]
                textLabel.numberOfLines = 0
                textLabel.textColor = UIColor.gray
                textLabel.font = UIFont.systemFont(ofSize: 14)
                
                contentView.addSubview(textLabel)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = UITableViewCell.SelectionStyle.none
        lineView.alpha = 0.25
        lineView.backgroundColor = UIColor.gray
        contentView.addSubview(lineView)
    }
    
    class func answerCell(tableView: UITableView) -> AnswerCell {
        let cell = AnswerCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: identifier)
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        lineView.frame = CGRect(x: 20, y: 0, width: frame.width - 40, height: 0.5)
    }

}

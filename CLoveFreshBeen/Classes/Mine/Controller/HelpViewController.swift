//
//  HelpViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/4.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

enum HelpCellType: Int {
    case Phone = 0
    case Question = 1
}

class HelpViewController: UIViewController {

    let margin: CGFloat = 20
    let backView: UIView = UIView(frame: CGRect(x: 0, y: 10, width: ScreenWidth, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        
        navigationItem.title = "客服帮助"
        
        backView.backgroundColor = UIColor.white
        view.addSubview(backView)
        
        let phoneLabel = UILabel(frame: CGRect(x: 20, y: 0, width: ScreenWidth - margin, height: 50))
        creatLabel(label: phoneLabel, text: "客服电话: 400-8484-842", type: .Phone)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRect(x: ScreenWidth - 20, y: (50 - 10) * 0.5, width: 5, height: 10)
        backView.addSubview(arrowImageView)
        
        let lineView = UIView(frame: CGRect(x: margin, y: 49.5, width: ScreenWidth - margin, height: 1))
        lineView.backgroundColor = UIColor.gray
        lineView.alpha = 0.2
        backView.addSubview(lineView)
        
        let questionLabel = UILabel(frame: CGRect(x: margin, y: 50, width: ScreenWidth - margin, height: 50))
        creatLabel(label: questionLabel, text: "常见问题", type: .Question)
        
        let arrowImageView2 = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView2.frame = CGRect(x: ScreenWidth - 20, y: (50 - 10) * 0.5 + 50, width: 5, height: 10)
        backView.addSubview(arrowImageView2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK - Method
    private func creatLabel(label: UILabel, text: String, type: HelpCellType) {
        label.text = text
        label.isUserInteractionEnabled = true
        label.font = UIFont.systemFont(ofSize: 15)
        label.tag = type.hashValue
        backView.addSubview(label)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cellClick(tap:)))
        label.addGestureRecognizer(tap)
    }
    
    // MARK: - Action
    @objc func cellClick(tap: UITapGestureRecognizer) {
        
        switch tap.view!.tag {
        case HelpCellType.Phone.hashValue :
            let alertVC = UIAlertController(title: "", message: "400-8484-842", preferredStyle: UIAlertController.Style.alert)
            let action1 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let action2 = UIAlertAction(title: "拔打", style: .default) { (_) in
                
            }
            alertVC.addAction(action1)
            alertVC.addAction(action2)
            self.present(alertVC, animated: true, completion: nil)
            break
        case HelpCellType.Question.hashValue :
            let helpDetailVC = HelpDetailViewController()
            navigationController?.pushViewController(helpDetailVC, animated: true)
            break
        default : break
        }
        
    }
}

//
//  MessageViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    private var segment: LFBSegmentedControl!
    private var systemTableView: LFBTableView!
    private var systemMessage: [UserMessage]?
    private var userMessage: [UserMessage]?
    private var secondView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        bulidSystemTableView()
        bulidSecontView()
        bulidSegmentedControl()
        showSystemTableView()
        loadSystemMessage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
}

extension MessageViewController {
    private func bulidSystemTableView(){
        systemTableView = LFBTableView(frame: view.bounds, style: .plain)
        systemTableView.backgroundColor = LFBGlobalBackgroundColor
        systemTableView.showsHorizontalScrollIndicator = false
        systemTableView.showsVerticalScrollIndicator = false
        systemTableView.delegate = self
        systemTableView.dataSource = self
        systemTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        view.addSubview(systemTableView)
        
        loadSystemTableViewData()
    }
    
    private func bulidSecontView(){
        secondView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64))
        secondView?.backgroundColor = LFBGlobalBackgroundColor
        view.addSubview(secondView!)
        
        let normalImageView = UIImageView(image: UIImage(named: "v2_my_message_empty"))
        normalImageView.center = view.center
        normalImageView.center.y -= 150
        secondView?.addSubview(normalImageView)
        
        let normalLabel = UILabel()
        normalLabel.text = "~~~并没有消息~~~"
        normalLabel.textAlignment = NSTextAlignment.center
        normalLabel.frame = CGRect(x: 0, y: normalImageView.frame.maxY + 10, width: ScreenWidth, height: 50)
        secondView?.addSubview(normalLabel)
    }
    
    private func bulidSegmentedControl(){
        segment = LFBSegmentedControl(items: ["系统消息" as AnyObject, "用户消息" as AnyObject], didSelectedIndex: { [weak self](index) -> () in
            if 0 == index {
                self?.showSystemTableView()
            } else if 1 == index {
                self?.showUserTableView()
            }
        })
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRect(x: 0, y: 5, width: 180, height: 27)
    }
    
    private func showSystemTableView(){
        secondView?.isHidden = true
    }
    
    private func showUserTableView(){
        secondView?.isHidden = false
    }
    
    private func loadSystemMessage(){
        HttpTool.loadSystemMessage { (models) in
            self.systemMessage = models
            self.systemTableView.reloadData()
        }
    }
    
    private func loadSystemTableViewData(){
        HttpTool.loadSystemMessage { (models) in
            self.systemMessage = models
            self.systemTableView.reloadData()
        }
    }
}

extension MessageViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return systemMessage?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = systemMessage![indexPath.row]
        return message.cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SystemMessageCell.systemMessageCell(tableView: tableView)
        cell.message = systemMessage![indexPath.row]
        return cell
    }
}

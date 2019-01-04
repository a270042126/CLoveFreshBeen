//
//  OrderStatuslViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/3.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class OrderStatuslViewController: UIViewController {
    
    private var bottomView1: UIView?
    private var orderDetailTableView: LFBTableView?
    private var segment: LFBSegmentedControl!
    private var orderDetailVC: OrderDetailViewController?
    private var orderStatuses: [OrderStatus]? {
        didSet {
            orderDetailTableView?.reloadData()
        }
    }
    
    var order: Order? {
        didSet {
            orderStatuses = order?.status_timeline
            
            if order?.detail_buttons != nil && order!.detail_buttons!.count > 0 {
                let btnWidth: CGFloat = 80
                let btnHeight: CGFloat = 30
                for i in 0..<order!.detail_buttons!.count {
                    let btn = UIButton(frame: CGRect(x: view.frame.width - (10 + CGFloat(i + 1) * (btnWidth + 10)), y: (50 - btnHeight) * 0.5, width: btnWidth, height: btnHeight))
                    btn.setTitle(order!.detail_buttons![i].text, for: UIControl.State.normal)
                    btn.backgroundColor = LFBNavigationYellowColor
                    btn.setTitleColor(UIColor.black, for: .normal)
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                    btn.layer.cornerRadius = 5;
                    btn.tag = order!.detail_buttons![i].type
                    btn.addTarget(self, action: #selector(detailButtonClick(sender:)), for: UIControl.Event.touchUpInside)
                    bottomView1?.addSubview(btn)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        
        buildNavigationItem()
        buildOrderDetailTableView()
        buildDetailButtonsView()
    }
    
    private func buildNavigationItem(){
        let rightItem = UIBarButtonItem.barButton(title: "投诉", titleColor: LFBTextBlackColor, target: self, action: #selector(rightItemButtonClick))
        navigationItem.rightBarButtonItem = rightItem
     
        segment = LFBSegmentedControl(items: ["订单状态" as AnyObject, "订单详情" as AnyObject], didSelectedIndex: { [weak self](index) -> () in
            if index == 0 {
                self?.showOrderStatusView()
            } else if index == 1 {
                self?.showOrderDetailView()
            }
        })
        navigationItem.titleView = segment
        navigationItem.titleView?.frame = CGRect(x: 0, y: 5, width: 180, height: 27)
    }
    
    private func buildOrderDetailTableView(){
        orderDetailTableView = LFBTableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64), style: .plain)
        orderDetailTableView?.backgroundColor = UIColor.white
        orderDetailTableView?.delegate = self
        orderDetailTableView?.dataSource = self
        orderDetailTableView?.rowHeight = 80
        view.addSubview(orderDetailTableView!)
    }
    
    private func buildDetailButtonsView(){
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.gray
        bottomView.alpha = 0.1
        view.addSubview(bottomView)
        
        
        bottomView1 = UIView()
        bottomView1?.backgroundColor = UIColor.white
        view.addSubview(bottomView1!)
        bottomView1?.snp.makeConstraints { (make) in
            make.height.equalTo(49)
            make.left.bottom.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomView1!.snp.top)
        }
    }

    @objc func detailButtonClick(sender: UIButton) {
        print("点击了底部按钮 类型是" + "\(sender.tag)")
    }

    @objc func rightItemButtonClick(){
        
    }
    
    @objc func showOrderStatusView(){
        orderDetailVC?.view.isHidden = true
        orderDetailTableView?.isHidden = false
    }
    
    @objc func showOrderDetailView(){
        if orderDetailVC == nil{
            orderDetailVC = OrderDetailViewController()
            orderDetailVC?.view.isHidden = false
            orderDetailVC?.order = order
            addChild(orderDetailVC!)
            view.insertSubview(orderDetailVC!.view, at: 0)
        }else{
            orderDetailVC?.view.isHidden = false
        }
        orderDetailTableView?.isHidden = true
    }
}

extension OrderStatuslViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderStatuses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = OrderStatusCell.orderStatusCell(tableView: tableView)
        cell.orderStatus = orderStatuses![indexPath.row]
        
        if indexPath.row == 0 {
            cell.orderStateType = .Top
        } else if indexPath.row == orderStatuses!.count - 1 {
            cell.orderStateType = .Bottom
        } else {
            cell.orderStateType = .Middle
        }
        
        return cell
    }
}

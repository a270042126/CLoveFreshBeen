//
//  OrderViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    var orderTableView: LFBTableView!
    var orders: [Order]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        navigationItem.title = "我的订单"
        bulidOrderTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension OrderViewController{
    
    private func bulidOrderTableView(){
        orderTableView = LFBTableView(frame: view.bounds, style: UITableView.Style.plain)
        orderTableView.backgroundColor = view.backgroundColor
        orderTableView.delegate = self
        orderTableView.dataSource = self
        orderTableView.backgroundColor = UIColor.clear
        orderTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        view.addSubview(orderTableView)
        loadOderData()
    }
    
    private func loadOderData(){
        HttpTool.loadOrderData { (model) in
            self.orders = model?.data
            self.orderTableView.reloadData()
        }
    }
}

extension OrderViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyOrderCell.myOrderCell(tableView: tableView, indexPath: indexPath)
        cell.order = orders![indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailVC = OrderStatuslViewController()
        orderDetailVC.order = orders![indexPath.row]
        navigationController?.pushViewController(orderDetailVC, animated: true)
    }
}

extension OrderViewController: MyOrderCellDelegate{
    private func orderCellButtonDidClick(indexPath: IndexPath, buttonType: Int) {
        print(buttonType, indexPath.row)
    }
}

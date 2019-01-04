//
//  MineViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {
    
    private var headView: MineHeadView!
    private var tableView: LFBTableView!
    private var headViewHeight: CGFloat = 150
    private var tableHeadView: MineTabeHeadView!
    private var couponNum: Int = 0
    private let shareActionSheet: LFBActionSheet = LFBActionSheet()
    
    // MARK: Flag
    var iderVCSendIderSuccess = false
    
    // MARK: Lazy Property
    private lazy var mines: [MineCellModel] = {
        let mines = MineCellModel.loadMineCellModels()
        return mines
    }()
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        buildUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        
        HttpTool.loadMineData { (model) in
            if model?.data?.availble_coupon_num != nil && model!.data!.availble_coupon_num > 0{
                self.couponNum = model!.data!.availble_coupon_num
                self.tableHeadView.setCouponNumer(number: model!.data!.availble_coupon_num)
            }else{
                self.tableHeadView.setCouponNumer(number: 0)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if iderVCSendIderSuccess {
            ProgressHUDManager.showSuccessWithStatus(string: "已经收到你的意见了,我们会刚正面的,放心吧~~")
            iderVCSendIderSuccess = false
        }
    }
}

extension MineViewController {
    
    private func buildUI(){
        headView = MineHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: headViewHeight + 10), settingButtonClick: {
            let settingVC = SettingViewController()
            self.navigationController?.pushViewController(settingVC, animated: true)
        })
        view.addSubview(headView)
        buildTableView()
    }
    
    private func buildTableView(){
        tableView = LFBTableView(frame: CGRect(x: 0, y: headViewHeight, width: ScreenWidth, height: ScreenHeight - headViewHeight), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 46
        view.addSubview(tableView)
        
        tableHeadView = MineTabeHeadView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 70))
        // 点击headView回调
        tableHeadView.mineHeadViewClick = {[weak self] (type) -> () in
            switch type {
            case .Order:
                let orderVc = OrderViewController()
                self?.navigationController?.pushViewController(orderVc, animated: true)
                break
            case .Coupon:
                let couponVC = CouponViewController()
                self?.navigationController!.pushViewController(couponVC, animated: true)
                break
            case .Message:
                let message = MessageViewController()
                self?.navigationController?.pushViewController(message, animated: true)
                break
            }
        }
        
        tableView.tableHeaderView = tableHeadView
    }
}

extension MineViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 2
        } else if (1 == section) {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MineCell.cellFor(tableView: tableView)
        
        if 0 == indexPath.section {
            cell.mineModel = mines[indexPath.row]
        } else if 1 == indexPath.section {
            cell.mineModel = mines[2]
        } else {
            if indexPath.row == 0 {
                cell.mineModel = mines[3]
            } else {
                cell.mineModel = mines[4]
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                let adressVC = MyAddressViewController()
                navigationController?.pushViewController(adressVC, animated: true)
            } else {
                let myShopVC = MyShopViewController()
                navigationController?.pushViewController(myShopVC, animated: true)
            }
        } else if 1 == indexPath.section {
            shareActionSheet.showActionSheetViewShowInView(parentVc: self) { (shareType) -> () in
                ShareManager.shareToShareType(shareType: shareType, vc: self)
            }
        } else if 2 == indexPath.section {
            if 0 == indexPath.row {
                let helpVc = HelpViewController()
                navigationController?.pushViewController(helpVc, animated: true)
            } else if 1 == indexPath.row {
                let ideaVC = IdeaViewController()
                ideaVC.mineVC = self
                navigationController!.pushViewController(ideaVC, animated: true)
            }
        }
    }
}

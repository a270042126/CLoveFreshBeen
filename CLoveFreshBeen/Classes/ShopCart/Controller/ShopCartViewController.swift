//
//  ShopCartViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class ShopCartViewController: UIViewController {

    private let userShopCar = UserShopCarTool.sharedUserShopCar
    
    private let shopImageView = UIImageView()
    private let emptyLabel = UILabel()
    private let emptyButton = UIButton(type: .custom)
    private var receiptAdressView: ReceiptAddressView?
    private var tableHeadView = UIView()
    private let signTimeLabel = UILabel()
    private let reserveLabel = UILabel()
    private let signTimePickerView = UIPickerView()
    private let commentsView = ShopCartCommentsView()
    private let supermarketTableView = LFBTableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64 - 50), style: .plain)
    private let tableFooterView = ShopCartSupermarketTableFooterView()
    private var isFristLoadData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        
        addNSNotification()
        buildNavigationItem()
        buildEmptyUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if userShopCar.isEmpty(){
            showshopCarEmptyUI()
        }else{
            if !ProgressHUDManager.isVisible(){
                ProgressHUDManager.setBackgroundColor(color: UIColor(r: 230, g: 230, b: 230))
                ProgressHUDManager.showWithStatus(status: "正在加载商品信息")
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.showProductView()
                ProgressHUDManager.dismiss()
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ShopCartViewController{
    private func addNSNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(shopCarProductsDidRemove), name: NSNotification.Name(LFBShopCarDidRemoveProductNSNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shopCarBuyPriceDidChange), name: NSNotification.Name(LFBShopCarBuyPriceDidChangeNotification), object: nil)
    }
    
    private func buildNavigationItem(){
        navigationItem.title = "购物车"
        navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(image: UIImage(named: "v2_goback")!, target: self, action: #selector(leftNavigitonItemClick))
    }
    
    private func buildEmptyUI(){
        shopImageView.image = UIImage(named: "v2_shop_empty")
        shopImageView.contentMode = .center
        shopImageView.frame = CGRect(x: (view.frame.width - shopImageView.frame.width) * 0.5, y: view.frame.height * 0.5, width: shopImageView.frame.width, height: shopImageView.frame.height)
        shopImageView.isHidden = true
        view.addSubview(shopImageView)
        
        emptyLabel.text = "亲,购物车空空的耶~赶紧挑好吃的吧"
        emptyLabel.textColor = UIColor(r: 100, g: 100, b: 100)
        emptyLabel.textAlignment = .center
        emptyLabel.frame = CGRect(x: 0, y: shopImageView.frame.maxY + 55, width: view.frame.width, height: 50)
        emptyLabel.font = UIFont.systemFont(ofSize: 16)
        emptyLabel.isHidden = true
        view.addSubview(emptyLabel)
        
        emptyButton.frame = CGRect(x: (view.frame.width - 150) * 0.5, y: emptyLabel.frame.maxY + 15, width: 150, height: 30)
        emptyButton.setBackgroundImage(UIImage(named: "btn.png"), for: .normal)
        emptyButton.setTitle("去逛逛", for: .normal)
        emptyButton.setTitleColor(UIColor(r: 100, g: 100, b: 100), for: .normal)
        emptyButton.addTarget(self, action: #selector(leftNavigitonItemClick), for: .touchUpInside)
        emptyButton.isHidden = true
        view.addSubview(emptyButton)
    }
    
    private func showshopCarEmptyUI(){
        shopImageView.isHidden = false
        emptyButton.isHidden = false
        emptyLabel.isHidden = false
        supermarketTableView.isHidden = true
    }
    
    @objc private func shopCarProductsDidRemove(){
        if UserShopCarTool.sharedUserShopCar.isEmpty(){
            showshopCarEmptyUI()
        }
        self.supermarketTableView.reloadData()
    }
    
    @objc private func shopCarBuyPriceDidChange(){
        tableFooterView.priceLabel.text = UserShopCarTool.sharedUserShopCar.getAllProductsPrice()
    }
    
    @objc private func leftNavigitonItemClick(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: LFBShopCarBuyProductNumberDidChangeNotification), object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    private func showProductView(){
        if !isFristLoadData {
            buildTableHeadView()
            buildSupermarketTableView()
            isFristLoadData = true
        }
    }
    
    private func buildTableHeadView(){
        tableHeadView.backgroundColor = view.backgroundColor
        tableHeadView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 250)
        buildReceiptAddress()
        buildMarketView()
        buildSignTimeView()
        buildSignComments()
    }
    
    private func buildSupermarketTableView(){
        supermarketTableView.tableHeaderView = tableHeadView
        
        supermarketTableView.delegate = self
        supermarketTableView.dataSource = self
        supermarketTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        supermarketTableView.rowHeight = ShopCartRowHeight
        supermarketTableView.backgroundColor = view.backgroundColor
        view.addSubview(supermarketTableView)
        view.addSubview(tableFooterView)
        tableFooterView.delegate = self
        tableFooterView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    private func buildReceiptAddress(){
        receiptAdressView = ReceiptAddressView(frame: CGRect(x: 0, y: 10, width: view.frame.width, height: 70), modifyButtonClickCallBack: { () -> () in
            
        })
        tableHeadView.addSubview(receiptAdressView!)
        if UserInfo.shareUserInfo.hasDefaultAddress(){
            receiptAdressView?.address = UserInfo.shareUserInfo.defaultAddress()
        }else{
            HttpTool.loadMyAdressData { (model) in
                if model?.data != nil && model!.data!.count > 0 {
                    UserInfo.shareUserInfo.setAllAdress(addresses: model!.data!)
                    self.receiptAdressView?.address = UserInfo.shareUserInfo.defaultAddress()
                }
            }
        }
    }
    
    private func buildMarketView(){
        let marketView = ShopCartMarkerView(frame: CGRect(x: 0, y: 90, width: ScreenWidth, height: 60))
        tableHeadView.addSubview(marketView)
    }
    
    private func buildSignTimeView(){
        let signTimeView = UIView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: ShopCartRowHeight))
        signTimeView.backgroundColor = UIColor.white
        tableHeadView.addSubview(signTimeView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(modifySignTimeViewClick))
        tableHeadView.addGestureRecognizer(tap)
        
        let signTimeTitleLabel = UILabel()
        signTimeTitleLabel.text = "收货时间"
        signTimeTitleLabel.textColor = UIColor.black
        signTimeTitleLabel.font = UIFont.systemFont(ofSize: 15)
        signTimeTitleLabel.sizeToFit()
        signTimeTitleLabel.frame = CGRect(x: 10, y: 0, width: signTimeTitleLabel.frame.width, height: ShopCartRowHeight)
        signTimeView.addSubview(signTimeTitleLabel)
        
        signTimeLabel.frame = CGRect(x: signTimeTitleLabel.frame.maxX + 10, y: 0, width: view.frame.width * 0.5, height: ShopCartRowHeight)
        signTimeLabel.textColor = UIColor.red
        signTimeLabel.font = UIFont.systemFont(ofSize: 15)
        signTimeLabel.text = "闪电送,及时达"
        signTimeView.addSubview(signTimeLabel)
        
        reserveLabel.text = "可预定"
        reserveLabel.backgroundColor = UIColor.white
        reserveLabel.textColor = UIColor.red
        reserveLabel.font = UIFont.systemFont(ofSize: 15)
        reserveLabel.frame = CGRect(x: view.frame.width - 72, y: 0, width: 60, height: ShopCartRowHeight)
        signTimeView.addSubview(reserveLabel)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRect(x: view.frame.width - 15, y: (ShopCartRowHeight - arrowImageView.frame.height) * 0.5, width: arrowImageView.frame.width, height: arrowImageView.frame.height)
        signTimeView.addSubview(arrowImageView)
    }
    
    private func buildSignComments(){
        commentsView.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: ShopCartRowHeight)
        tableHeadView.addSubview(commentsView)
    }
    
    @objc private func modifySignTimeViewClick(){
        print("修改收货时间")
    }
}

extension ShopCartViewController: ShopCartSupermarketTableFooterViewDelegate{
    func supermarketTableFooterDetermineButtonClick() {
        let orderPlayVC = OrderPayWayViewController()
        navigationController?.pushViewController(orderPlayVC, animated: true)
    }
}

extension ShopCartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserShopCarTool.sharedUserShopCar.getShopCarProductsClassifNumber()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShopCartCell.shopCarCell(tableView: tableView)
        cell.goods = UserShopCarTool.sharedUserShopCar.getShopCarProducts()[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        commentsView.textField.endEditing(true)
    }
}

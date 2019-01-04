
//
//  SupermarketViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/1.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class SupermarketViewController: SelectedAddressViewController {

    private var supermarketData: Supermarket?
    private var categoryTableView: LFBTableView!
    private var productsVC: ProductsViewController!
    // flag
    private var categoryTableViewIsLoadFinish = false
    private var productTableViewIsLoadFinish  = false
   
    override func viewDidLoad() {
        super.viewDidLoad()

        addNotification()
        showProgressHUD()
        bulidCategoryTableView()
        bulidProductsViewController()
        loadSupermarketData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        productsVC.productsTableView?.reloadData()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LFBSearchViewControllerDeinit"), object: nil)
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SupermarketViewController{
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(shopCarBuyProductNumberDidChange), name: NSNotification.Name(rawValue: LFBShopCarBuyProductNumberDidChangeNotification), object: nil)
    }
    
    private func showProgressHUD(){
        ProgressHUDManager.setBackgroundColor(color: UIColor(r: 230, g: 230, b: 230))
        view.backgroundColor = UIColor.white
        if !ProgressHUDManager.isVisible(){
            ProgressHUDManager.showWithStatus(status: "正在加载中")
        }
    }
    
    private func bulidCategoryTableView(){
        categoryTableView = LFBTableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth * 0.25, height: ScreenHeight), style: .plain)
        categoryTableView.backgroundColor = LFBGlobalBackgroundColor
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.showsHorizontalScrollIndicator = false
        categoryTableView.showsVerticalScrollIndicator = false
        categoryTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        categoryTableView.isHidden = true
        view.addSubview(categoryTableView)
    }
    
    private func bulidProductsViewController(){
        productsVC = ProductsViewController()
        productsVC.delegate = self
        productsVC.view.isHidden = true
        addChild(productsVC)
        view.addSubview(productsVC.view)
        productsVC.view.frame = CGRect(x: categoryTableView.frame.maxX, y: 0, width: ScreenWidth * 0.75, height: ScreenHeight)
        productsVC.refreshUpPull = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
                HttpTool.loadSupermarketData(completion: { (model) in
                    self.supermarketData = model
                    self.productsVC.supermarketData = model
                    self.productsVC.productsTableView?.mj_header.endRefreshing()
                    self.categoryTableView.reloadData()
                    self.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
                })
            })
        }
    }
    
    private func loadSupermarketData(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            HttpTool.loadSupermarketData(completion: { (model) in
                self.supermarketData = model
                self.categoryTableView.reloadData()
                self.categoryTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .bottom)
                self.productsVC.supermarketData = model
                self.categoryTableViewIsLoadFinish = true
                self.productTableViewIsLoadFinish = true
                if self.categoryTableViewIsLoadFinish && self.productTableViewIsLoadFinish{
                    self.categoryTableView.isHidden = false
                    self.productsVC.productsTableView?.isHidden = false
                    self.productsVC.view.isHidden = false
                    self.categoryTableView.isHidden = false
                    ProgressHUDManager.dismiss()
                    self.view.backgroundColor = LFBGlobalBackgroundColor
                }
            })
        })
    }
    
    @objc private func shopCarBuyProductNumberDidChange(){
        productsVC.productsTableView?.reloadData()
    }
}

extension SupermarketViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoryCell.cellWithTableView(tableView: tableView)
        cell.categorie = supermarketData!.data!.categories![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if productsVC != nil {
            productsVC.categortsSelectedIndexPath = indexPath
            productsVC.isSelected = true
        }
    }
}

extension SupermarketViewController: ProductsViewControllerDelegate{
    func didEndDisplayingHeaderView(section: Int) {
        categoryTableView.selectRow(at: IndexPath(row: section + 1, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
    
    func willDisplayHeaderView(section: Int) {
        categoryTableView.selectRow(at: IndexPath(row: section, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.middle)
    }
}

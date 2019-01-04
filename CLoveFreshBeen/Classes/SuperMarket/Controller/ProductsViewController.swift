//
//  ProductsViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/1.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit
@objc protocol ProductsViewControllerDelegate: NSObjectProtocol {
    @objc optional func didEndDisplayingHeaderView(section: Int)
    @objc optional func willDisplayHeaderView(section: Int)
}

class ProductsViewController: AnimationViewController {

    private let headViewIdentifier = "supermarketHeadView"
    private var lastOffsetY: CGFloat = 0
    private var isScrollDown = false
    var isSelected = false
    var productsTableView: LFBTableView?
    weak var delegate: ProductsViewControllerDelegate?
    var refreshUpPull:(() -> ())?
    
    private var goodsArr: [[Goods]]? {
        didSet{
            productsTableView?.reloadData()
        }
    }
    
    var supermarketData: Supermarket?{
        didSet{
            self.goodsArr = Supermarket.searchCategoryMatchProducts(supermarketResouce: supermarketData!.data!)
        }
    }
    
    var categortsSelectedIndexPath: IndexPath? {
        didSet {
            productsTableView?.selectRow(at: IndexPath(row: 0, section: categortsSelectedIndexPath!.row), animated: true, scrollPosition: .top)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(shopCarBuyProductNumberDidChange), name: NSNotification.Name(LFBShopCarBuyProductNumberDidChangeNotification), object: nil)
        
        buildProductsTableView()
    }
}

extension ProductsViewController{
    
    private func buildProductsTableView(){
        productsTableView = LFBTableView(frame: view.bounds, style: .plain)
        productsTableView?.frame.size.width = ScreenWidth * 0.75
        productsTableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 49, right: 0)
        productsTableView?.backgroundColor = LFBGlobalBackgroundColor
        productsTableView?.delegate = self
        productsTableView?.dataSource = self
        productsTableView?.register(SupermarketHeadView.self, forHeaderFooterViewReuseIdentifier: headViewIdentifier)
        productsTableView?.tableFooterView = buildProductsTableViewTableFooterView()
       
        let headView = LFBRefreshHeader(refreshingTarget: self, refreshingAction: #selector(startRefreshUpPull))
        productsTableView?.mj_header = headView
        view.addSubview(productsTableView!)
    }
    
    @objc private func startRefreshUpPull(){
        refreshUpPull?()
    }
    
    private func buildProductsTableViewTableFooterView() -> UIView{
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: productsTableView!.frame.width, height: 70))
        imageView.contentMode = .center
        imageView.image = UIImage(named: "v2_common_footer")
        return imageView
    }
    
    @objc private func shopCarBuyProductNumberDidChange(){
        productsTableView?.reloadData()
    }
}

extension ProductsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return supermarketData?.data?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodsArr?[section].count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductCell.cellWithTableView(tableView: tableView)
        let goods = goodsArr![indexPath.section][indexPath.row]
        cell.goods = goods
        cell.addProductClick = {[weak self](imageView) -> () in
            self?.addProductsAnimation(imageView: imageView)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterView(withIdentifier: headViewIdentifier) as! SupermarketHeadView
        if supermarketData?.data?.categories != nil &&  supermarketData!.data!.categories!.count > 0 && supermarketData!.data!.categories![section].name != nil{
            headView.titleLabel.text = supermarketData!.data!.categories![section].name
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if isScrollDown && !isSelected {
            delegate?.didEndDisplayingHeaderView?(section: section)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if !isScrollDown && !isSelected{
            delegate?.willDisplayHeaderView?(section: section)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let goods = goodsArr![indexPath.section][indexPath.row]
        let productDetailVC = ProductDetailViewController(goods: goods)
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isSelected = false
    }
}

// MARK: - UIScrollViewDelegate
extension ProductsViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if animationLayers != nil && animationLayers!.count > 0{
            let transitionLayer = animationLayers![0]
            transitionLayer.isHidden = true
        }
        
        isScrollDown = lastOffsetY < scrollView.contentOffset.y
        lastOffsetY = scrollView.contentOffset.y
    }
}

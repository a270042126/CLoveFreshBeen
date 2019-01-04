//
//  HomeViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class HomeViewController: SelectedAddressViewController {
    
    private var flag: Int = -1
    private var headView: HomeTableHeadView?
    private var collectionView: LFBCollectionView!
    private var lastContentOffsetY: CGFloat = 0
    private var isAnimation: Bool = false
    private var headData: HeadResources?
    private var freshHot: FreshHot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        addHomeNotification()
        buildCollectionView()
        buildTableHeadView()
        buildProessHud()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = LFBNavigationYellowColor
        if collectionView != nil{
            collectionView.reloadData()
        }
        NotificationCenter.default.post(name: NSNotification.Name("LFBSearchViewControllerDeinit"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension HomeViewController{
    
    private func buildCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSize(width: 0, height: HomeCollectionViewCellMargin)
        
        collectionView = LFBCollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = LFBGlobalBackgroundColor
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: "\(HomeCell.self)")
        collectionView.register(HomeCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HomeCollectionHeaderView.self)")
        collectionView.register(HomeCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(HomeCollectionFooterView.self)")
        view.addSubview(collectionView)
    
        let refreshHeadView = LFBRefreshHeader(refreshingTarget: self, refreshingAction: #selector(headRefresh))
        refreshHeadView?.gifView.frame = CGRect(x: 0, y: 30, width: 100, height: 100)
        collectionView.mj_header = refreshHeadView
    }
    
    private func buildTableHeadView(){
        headView = HomeTableHeadView()
        headView?.delegate = self
        HttpTool.loadHomeHeadData { (model) in
            self.headView?.headData = model
            self.headData = model
            self.collectionView.reloadData()
        }
        
        collectionView.addSubview(headView!)
        HttpTool.loadFreshHotData { (model) in
            self.freshHot = model
            self.collectionView.reloadData()
            self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 64, right: 0)
        }
    }
    
    private func buildProessHud() {
        ProgressHUDManager.setBackgroundColor(color: UIColor(r: 240, g: 240, b: 240))
        ProgressHUDManager.setFont(font: UIFont.systemFont(ofSize: 16))
    }
    
    private func addHomeNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(homeTableHeadViewHeightDidChange(noti:)), name: NSNotification.Name(HomeTableHeadViewHeightDidChange), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goodsInventoryProblem(noti:)), name: NSNotification.Name(HomeGoodsInventoryProblem), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shopCarBuyProductNumberDidChange), name: NSNotification.Name(LFBShopCarBuyProductNumberDidChangeNotification), object: nil)
    }
    
    @objc private func headRefresh(){
        headView?.headData = nil
        headData = nil
        freshHot = nil
        var headDataLoadFinish = false
        var freshHotLoadFinish = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            HttpTool.loadHomeHeadData(completion: { (model) in
                headDataLoadFinish = true
                self.headView?.headData = model
                self.headData = model
                if headDataLoadFinish && freshHotLoadFinish{
                    self.collectionView.reloadData()
                    self.collectionView.mj_header.endRefreshing()
                }
            })
            
            HttpTool.loadFreshHotData(completion: { (model) in
                freshHotLoadFinish = true
                self.freshHot = model
                if headDataLoadFinish && freshHotLoadFinish{
                    self.collectionView.reloadData()
                    self.collectionView.mj_header.endRefreshing()
                }
            })
        })
    }
    
    @objc private func homeTableHeadViewHeightDidChange(noti: NSNotification) {
        collectionView.contentInset = UIEdgeInsets(top: noti.object as! CGFloat, left: 0, bottom: 64, right: 0)
        collectionView.setContentOffset(CGPoint(x: 0, y: -(collectionView!.contentInset.top)), animated: false)
        lastContentOffsetY = collectionView.contentOffset.y
    }
    
    @objc private func goodsInventoryProblem(noti: NSNotification) {
        if let goodsName = noti.object as? String{
            ProgressHUDManager.showImage(image: UIImage(named: "v2_orderSuccess")!, status: goodsName + "  库存不足了\n先买这么多, 过段时间再来看看吧~")
        }
    }
    
    @objc private func shopCarBuyProductNumberDidChange(){
        collectionView.reloadData()
    }
    
    private func startAnimation(view: UIView, offsetY: CGFloat, duration: TimeInterval) {
        view.transform = CGAffineTransform(translationX: 0, y: offsetY)
        UIView.animate(withDuration: duration) {
            view.transform = CGAffineTransform.identity
        }
    }
    
    // MARK: 查看更多商品被点击
    @objc func moreGoodsClick(tap: UITapGestureRecognizer) {
        if tap.view?.tag == 100 {
            let tabBarController = UIApplication.shared.keyWindow!.rootViewController as! MainTabBarController
            tabBarController.setSelectIndex(from: 0, to: 1)
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if headData?.data?.activities == nil || freshHot?.data == nil || headData!.data!.activities!.count <= 0 || freshHot!.data!.count <= 0{
            return 0
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if headData?.data?.activities == nil || freshHot?.data == nil || headData!.data!.activities!.count <= 0 || freshHot!.data!.count <= 0 {
            return 0
        }
        
        if section == 0{
            return headData?.data?.activities?.count ?? 0
        }else if section == 1{
            return freshHot?.data?.count ?? 0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeCell.self)", for: indexPath) as! HomeCell
        if headData?.data?.activities == nil || headData!.data!.activities!.count <= 0{
            return cell
        }
        
        if indexPath.section == 0{
            cell.activities = headData!.data?.activities![indexPath.row]
        }else if indexPath.section == 1{
            cell.goods = freshHot!.data![indexPath.row]
            cell.addButtonClick = ({[weak self] (imageView) -> () in
                self?.addProductsAnimation(imageView: imageView)
            })
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var itemSize = CGSize.zero
        if indexPath.section == 0{
            let width = ScreenWidth - HomeCollectionViewCellMargin * 2
            itemSize = CGSize(width: width, height: width / 5 * 2)
        } else if indexPath.section == 1{
            let width = (ScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4
            itemSize = CGSize(width: (ScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, height: width / 4 * 5)
        }
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: ScreenWidth, height: HomeCollectionViewCellMargin)
        }else if section == 1{
            return CGSize(width: ScreenWidth, height: HomeCollectionViewCellMargin * 2)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: ScreenWidth, height: HomeCollectionViewCellMargin)
        }else if section == 1{
            return CGSize(width: ScreenWidth, height: HomeCollectionViewCellMargin * 5)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1){
            return
        }
        
        if isAnimation{
            startAnimation(view: cell, offsetY: 80, duration: 1.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if indexPath.section == 1 && headData != nil && freshHot != nil && isAnimation {
            startAnimation(view: view, offsetY: 60, duration: 0.8)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 1 && kind == UICollectionView.elementKindSectionHeader{
            let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HomeCollectionHeaderView.self)", for: indexPath as IndexPath) as! HomeCollectionHeaderView
            return headView
        }else{
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(HomeCollectionFooterView.self)", for: indexPath) as! HomeCollectionFooterView
            if indexPath.section == 1 && kind == UICollectionView.elementKindSectionFooter{
                footerView.showLabel()
                footerView.tag = 100
            }else{
                footerView.hideLabel()
                footerView.tag = 1
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(moreGoodsClick(tap:)))
            footerView.addGestureRecognizer(tap)
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let webVC = WebViewController(navigationTitle: headData!.data!.activities![indexPath.row].name!, urlStr: headData!.data!.activities![indexPath.row].customURL!)
            navigationController?.pushViewController(webVC, animated: true)
        }else{
            let productVc = ProductDetailViewController(goods: freshHot!.data![indexPath.row])
            navigationController?.pushViewController(productVc, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if animationLayers != nil && animationLayers!.count > 0{
            let transitionLayer = animationLayers![0]
            transitionLayer.isHidden = true
        }
        
        if scrollView.contentOffset.y <= scrollView.contentSize.height{
            isAnimation = lastContentOffsetY < scrollView.contentOffset.y
            lastContentOffsetY = scrollView.contentOffset.y
        }
    }
    
}

extension HomeViewController: HomeTableHeadViewDelegate{
    func tableHeadView(headView: HomeTableHeadView, iconClick index: Int) {
        if headData?.data?.focus != nil && headData!.data!.focus!.count > 0{
            let path = Bundle.main.path(forResource: "FocusURL", ofType: "plist")
            let array = NSArray(contentsOfFile: path!)
            let webVC = WebViewController(navigationTitle: headData!.data!.focus![index].name!, urlStr: array![index] as! String)
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    func tableHeadView(headView: HomeTableHeadView, focusImageViewClick index: Int) {
        if headData?.data?.icons != nil && headData!.data!.icons!.count > 0 {
            let webVC = WebViewController(navigationTitle: headData!.data!.icons![index].name!, urlStr: headData!.data!.icons![index].customURL!)
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
}

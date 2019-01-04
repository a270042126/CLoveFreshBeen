//
//  SearchProductViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchProductViewController: AnimationViewController {

    private let contentScrollView = UIScrollView(frame: ScreenBounds)
    private let searchBar = UITextField()
    private let cleanHistoryButton: UIButton = UIButton()
    private var hotSearchView: SearchView?
    private var historySearchView: SearchView?
    private var searchCollectionView: LFBCollectionView?
    private var goodses: [Goods]?
    private var collectionHeadView: NotSearchProductsView?
    private var yellowShopCar: YellowShopCarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildContentScrollView()
        buildSearchBar()
        buildCleanHistorySearchButton()
        loadHotSearchButtonData()
        loadHistorySearchButtonData()
        buildsearchCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(textFiledTextDidChange(noti:)), name: UITextField.textDidChangeNotification, object: searchBar)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
        if searchCollectionView != nil && goodses != nil && goodses!.count > 0 {
            searchCollectionView!.reloadData()
        }
    }

}

extension SearchProductViewController{
    
    private func buildContentScrollView(){
        contentScrollView.backgroundColor = view.backgroundColor
        contentScrollView.alwaysBounceVertical = true
        contentScrollView.delegate = self
        view.addSubview(contentScrollView)
    }
    
    private func buildSearchBar(){
        (navigationController as! BaseNavigationController).backBtn.frame = CGRect(x: 0, y: 0, width: 10, height: 40)
        
        searchBar.frame = CGRect(x: 0, y: 0, width: ScreenWidth * 0.9, height: 30)
        searchBar.placeholder = "请输入商品名称"
        searchBar.backgroundColor = UIColor.white
        searchBar.keyboardType = .default
        searchBar.layer.masksToBounds = true
        searchBar.layer.cornerRadius = 6
        searchBar.layer.borderColor = UIColor(r: 100, g: 100, b: 100).cgColor
        searchBar.layer.borderWidth = 0.2
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        let navVC = navigationController as! BaseNavigationController
        let leftBtn = navigationItem.leftBarButtonItem?.customView as? UIButton
        leftBtn?.addTarget(self, action: #selector(leftButtonClcik), for: .touchUpInside)
        navVC.isAnimation = false
    }
    
    private func buildCleanHistorySearchButton(){
        cleanHistoryButton.setTitle("清 空 历 史", for: .normal)
        cleanHistoryButton.setTitleColor(UIColor(r: 163, g: 163, b: 163), for: .normal)
        cleanHistoryButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        cleanHistoryButton.backgroundColor = view.backgroundColor
        cleanHistoryButton.layer.cornerRadius = 5
        cleanHistoryButton.layer.borderColor = UIColor(r: 200, g: 200, b: 200).cgColor
        cleanHistoryButton.layer.borderWidth = 0.5
        cleanHistoryButton.isHidden = true
        cleanHistoryButton.addTarget(self, action: #selector(cleanSearchHistorySearch), for: .touchUpInside)
        contentScrollView.addSubview(cleanHistoryButton)
    }
    
    private func loadHotSearchButtonData(){
        var array: [String]?
        var historySearch = UserDefaults.standard.object(forKey: LFBSearchViewControllerHistorySearchArray) as? [String]
        if historySearch == nil {
            historySearch = [String]()
            UserDefaults.standard.set(historySearch!, forKey: LFBSearchViewControllerHistorySearchArray)
        }
        
        let pathStr = Bundle.main.path(forResource: "SearchProduct", ofType: nil)
        let data = NSData(contentsOfFile: pathStr!)
        if data != nil {
            let json = JSON(data!)
            array = json["data"]["hotquery"].arrayObject as? [String]
            if array!.count > 0 {
                hotSearchView = SearchView(frame: CGRect(x: 10, y: 20, width: ScreenWidth - 20, height: 100), searchTitleText: "热门搜索", searchButtonTitleTexts: array!, searchButtonClickCallback: {[weak self] (sender) in
                    let str = sender.title(for: .normal)
                    self?.writeHistorySearchToUserDefault(str: str!)
                    self?.searchBar.text = sender.title(for: .normal)
                    self?.loadProductsWithKeyword(keyWord: sender.title(for: .normal)!)
                })
                hotSearchView?.frame.size.height = hotSearchView!.searchHeight
                contentScrollView.addSubview(hotSearchView!)
            }
        }
    }
    
    private func loadHistorySearchButtonData(){
        if historySearchView != nil {
            historySearchView?.removeFromSuperview()
            historySearchView = nil
        }
        
        let array = UserDefaults.standard.object(forKey: LFBSearchViewControllerHistorySearchArray) as? [String]
        if array!.count > 0 {
            historySearchView = SearchView(frame: CGRect(x: 10, y: hotSearchView!.frame.maxY + 20, width: ScreenWidth - 20, height: 0), searchTitleText: "历史记录", searchButtonTitleTexts: array!, searchButtonClickCallback: {[weak self] (sender) in
                self?.searchBar.text = sender.title(for: .normal)
                self?.loadProductsWithKeyword(keyWord: sender.title(for: .normal))
            })
            historySearchView?.frame.size.height = historySearchView!.searchHeight
            contentScrollView.addSubview(historySearchView!)
            updateCleanHistoryButton(hidden: false)
        }
    }
    
    private func buildsearchCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: HomeCollectionViewCellMargin, bottom: 0, right: HomeCollectionViewCellMargin)
        layout.headerReferenceSize = CGSize(width: 0, height: HomeCollectionViewCellMargin)
        
        searchCollectionView = LFBCollectionView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64), collectionViewLayout: layout)
        searchCollectionView?.delegate = self
        searchCollectionView?.dataSource = self
        searchCollectionView?.backgroundColor = LFBGlobalBackgroundColor
        searchCollectionView?.register(HomeCell.self, forCellWithReuseIdentifier: "\(HomeCell.self)")
        searchCollectionView?.isHidden = true
        collectionHeadView = NotSearchProductsView(frame: CGRect(x: 0, y: -80, width: ScreenWidth, height: 80))
        searchCollectionView?.addSubview(collectionHeadView!)
        searchCollectionView?.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 30, right: 0)
        searchCollectionView?.register(HomeCollectionFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(HomeCollectionFooterView.self)")
        view.addSubview(searchCollectionView!)
    }
    
    private func buildYellowShopCar(){
        let navigationH: CGFloat = 64
        yellowShopCar = YellowShopCarView(frame: CGRect(x: ScreenWidth - 70, y: ScreenHeight - 70 - navigationH, width: 61, height: 61), shopViewClick: {[weak self] in
            let shopCarVc = ShopCartViewController()
            let nav = BaseNavigationController(rootViewController: shopCarVc)
            self?.present(nav, animated: true, completion: nil)
        })
        yellowShopCar?.isHidden = true
        view.addSubview(yellowShopCar!)
    }
    
    // MARK: - Private Method
    private func writeHistorySearchToUserDefault(str: String) {
        var historySearch = UserDefaults.standard.object(forKey: LFBSearchViewControllerHistorySearchArray) as? [String]
        for text in historySearch! {
            if text == str{
                return
            }
        }
        historySearch?.append(str)
        UserDefaults.standard.set(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
    }
    
    private func updateCleanHistoryButton(hidden: Bool) {
        if historySearchView != nil {
            cleanHistoryButton.frame = CGRect(x: 0.1 * ScreenWidth, y: historySearchView!.frame.maxY + 20, width: ScreenWidth * 0.8, height: 40)
        }
        cleanHistoryButton.isHidden = hidden
    }
    
    func loadProductsWithKeyword(keyWord: String?) {
        if keyWord == nil || keyWord?.count == 0{return}
        ProgressHUDManager.setBackgroundColor(color: UIColor.white)
        ProgressHUDManager.showWithStatus(status: "正在全力加载")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            HttpTool.loadSearchData(completion: { (model) in
                if model?.data != nil && model!.data!.count > 0 {
                    self.goodses = model!.data!
                    self.searchCollectionView?.isHidden = false
                    self.yellowShopCar?.isHidden = false
                    self.searchCollectionView?.reloadData()
                    self.collectionHeadView?.setSearchProductLabelText(text: keyWord!)
                    self.searchCollectionView?.setContentOffset(CGPoint(x: 0, y: -80), animated: false)
                    ProgressHUDManager.dismiss()
                }
            })
        })
    }
    
    @objc private func leftButtonClcik(){
        searchBar.endEditing(false)
    }
    
    @objc private func cleanSearchHistorySearch(){
        var historySearch = UserDefaults.standard.object(forKey: LFBSearchViewControllerHistorySearchArray) as? [String]
        historySearch?.removeAll()
        UserDefaults.standard.set(historySearch, forKey: LFBSearchViewControllerHistorySearchArray)
        loadHistorySearchButtonData()
        updateCleanHistoryButton(hidden: true)
    }
}

extension SearchProductViewController: UITextFieldDelegate, UIScrollViewDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil && searchBar.text!.count > 0{
            writeHistorySearchToUserDefault(str: searchBar.text!)
            loadProductsWithKeyword(keyWord: searchBar.text!)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBar.endEditing(false)
    }
    
    @objc private func textFiledTextDidChange(noti: Notification){
        guard let textField = noti.object as? UITextField,
            let text = textField.text else { return }
        if text.count == 0 {
            searchCollectionView?.isHidden = true
            yellowShopCar?.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return searchBar.resignFirstResponder()
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.count == 0 {
//            searchCollectionView?.isHidden = true
//            yellowShopCar?.isHidden = true
//        }
//    }
}


extension SearchProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goodses?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(HomeCell.self)", for: indexPath) as! HomeCell
        cell.goods = goodses?[indexPath.row]
        cell.addButtonClick = ({[weak self] (imageView) -> () in
            self?.addProductsToBigShopCarAnimation(imageView: imageView)
        }) as ((UIImageView) -> ())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = CGSize(width: (ScreenWidth - HomeCollectionViewCellMargin * 2) * 0.5 - 4, height: 250)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if goodses == nil || goodses!.count <= 0{
            return CGSize.zero
        }else{
            return CGSize(width: ScreenWidth, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter{
            let footView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(HomeCollectionFooterView.self)", for: indexPath) as! HomeCollectionFooterView
            footView.setFooterTitle(text: "无更多商品", textColor: UIColor(r: 50, g: 50, b: 50))
            return footView
        }else{
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "\(HomeCollectionFooterView.self)", for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productDetailVC = ProductDetailViewController(goods: goodses![indexPath.row])
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

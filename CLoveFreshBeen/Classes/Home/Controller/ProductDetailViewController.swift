//
//  ProductDetailViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    private let grayBackgroundColor = UIColor(r: 248, g: 248, b: 248)
    
    private var scrollView: UIScrollView?
    private var productImageView: UIImageView?
    private var titleNameLabel: UILabel?
    private var priceView: DiscountPriceView?
    private var presentView: UIView?
    private var detailView: UIView?
    private var brandTitleLabel: UILabel?
    private var detailTitleLabel: UILabel?
    private var promptView: UIView?
    private let nameView = UIView()
    private var detailImageView: UIImageView?
    private var bottomView: UIView?
    private var yellowShopCar: YellowShopCarView?
    private var goods: Goods?
    private var buyView: BuyView?
    private let shareActionSheet: LFBActionSheet = LFBActionSheet()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        let navigationH: CGFloat = 64
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView?.backgroundColor = UIColor.white
        scrollView?.bounces = false
        view.addSubview(scrollView!)
        
        productImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 400))
        productImageView?.contentMode = .scaleAspectFill
        scrollView?.addSubview(productImageView!)
        
        buildLineView(addView: productImageView!, lineFrame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 400))
        
        let leftMargin: CGFloat = 15
        
        nameView.frame = CGRect(x: 0, y: productImageView!.frame.maxY, width: ScreenWidth, height: 80)
        nameView.backgroundColor = UIColor.white
        scrollView?.addSubview(nameView)
        
        titleNameLabel = UILabel(frame: CGRect(x: leftMargin, y: 0, width: ScreenWidth, height: 60))
        titleNameLabel?.textColor = UIColor.black
        titleNameLabel?.font = UIFont.systemFont(ofSize: 16)
        nameView.addSubview(titleNameLabel!)
        
        buildLineView(addView: nameView, lineFrame: CGRect(x: 0, y: 80 - 1, width: ScreenWidth, height: 1))
        
        presentView = UIView(frame: CGRect(x: 0, y: nameView.frame.maxY, width: ScreenWidth, height: 50))
        presentView?.backgroundColor = grayBackgroundColor
        scrollView?.addSubview(presentView!)
        
        let presenButton = UIButton(frame: CGRect(x: leftMargin, y: 13, width: 55, height: 24))
        presenButton.setTitle("促销", for: .normal)
        presenButton.backgroundColor = UIColor(r: 252, g: 85, b: 88)
        presenButton.layer.cornerRadius = 8
        presenButton.setTitleColor(UIColor.white, for: .normal)
        presentView?.addSubview(presenButton)
        
        let presentLabel = UILabel(frame: CGRect(x: 100, y: 0, width: ScreenWidth * 0.7, height: 50))
        presentLabel.textColor = UIColor.black
        presentLabel.font = UIFont.systemFont(ofSize: 14)
        presentLabel.text = "买一赠一 (赠品有限,赠完为止)"
        presentView?.addSubview(presentLabel)
        
        buildLineView(addView: presentView!, lineFrame: CGRect(x: 0, y: 49, width: ScreenWidth, height: 1))
        
        detailView = UIView(frame: CGRect(x: 0, y: presentView!.frame.maxY, width: ScreenWidth, height: 150))
        detailView?.backgroundColor = grayBackgroundColor
        scrollView?.addSubview(detailView!)
        
        let brandLabel = UILabel(frame: CGRect(x: leftMargin, y: 0, width: 80, height: 50))
        brandLabel.textColor = UIColor(r: 150, g: 150, b: 150)
        brandLabel.text = "品       牌"
        brandLabel.font = UIFont.systemFont(ofSize: 14)
        detailView?.addSubview(brandLabel)
        
        brandTitleLabel = UILabel(frame: CGRect(x: 100, y: 0, width: ScreenWidth * 0.6, height: 50))
        brandTitleLabel?.textColor = UIColor.black
        brandTitleLabel?.font = UIFont.systemFont(ofSize: 14)
        detailView?.addSubview(brandTitleLabel!)
        
        buildLineView(addView: detailView!, lineFrame: CGRect(x: 0, y: 50 - 1, width: ScreenWidth, height: 1))
        
        let detailLabel = UILabel(frame: CGRect(x: leftMargin, y: 50, width: 80, height: 50))
        detailLabel.text = "产品规格"
        detailLabel.textColor = brandLabel.textColor
        detailLabel.font = brandTitleLabel?.font
        detailView?.addSubview(detailLabel)
        
        detailTitleLabel = UILabel(frame: CGRect(x: 100, y: 50, width: ScreenWidth * 0.6, height: 50))
        detailTitleLabel?.textColor = brandTitleLabel?.textColor
        detailTitleLabel?.font = brandTitleLabel?.font
        detailView?.addSubview(detailTitleLabel!)
        
        buildLineView(addView: detailView!, lineFrame: CGRect(x: 0, y: 100 - 1, width: ScreenWidth, height: 1))
        
        let textImageLabel = UILabel(frame: CGRect(x: leftMargin, y: 100, width: 80, height: 50))
        textImageLabel.textColor = brandLabel.textColor
        textImageLabel.font = brandLabel.font
        textImageLabel.text = "图文详情"
        detailView?.addSubview(textImageLabel)
        
        promptView = UIView(frame: CGRect(x: 0, y: detailView!.frame.maxY, width: ScreenWidth, height: 80))
        promptView?.backgroundColor = UIColor.white
        scrollView?.addSubview(promptView!)
        
        let promptLabel = UILabel(frame: CGRect(x: 15, y: 5, width: ScreenWidth, height: 20))
        promptLabel.text = "温馨提示:"
        promptLabel.textColor = UIColor.black
        promptView?.addSubview(promptLabel)
        
        let prompotDetailLabel = UILabel(frame: CGRect(x: 15, y: 20, width: ScreenWidth - 30, height: 60))
        prompotDetailLabel.textColor = presenButton.backgroundColor
        prompotDetailLabel.numberOfLines = 2
        prompotDetailLabel.text = "商品签收后, 如有问题请您在24小时内联系4008484842,并将商品及包装保留好,拍照发给客服"
        prompotDetailLabel.font = UIFont.systemFont(ofSize: 14)
        promptView?.addSubview(prompotDetailLabel)
        
        buildLineView(addView: view, lineFrame: CGRect(x: 0, y: ScreenHeight - 51 - navigationH, width: ScreenWidth, height: 1))
        
        bottomView = UIView()
        bottomView?.backgroundColor = grayBackgroundColor
        view.addSubview(bottomView!)
        bottomView?.snp.makeConstraints({ (make) in
            make.height.equalTo(50)
            make.left.bottom.right.equalToSuperview()
        })
        
        let addProductLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 70, height: 50))
        addProductLabel.text = "添加商品:"
        addProductLabel.textColor = UIColor.black
        addProductLabel.font = UIFont.systemFont(ofSize: 15)
        bottomView?.addSubview(addProductLabel)
    }
    
    convenience init(goods: Goods) {
        self.init()
        let navigationH: CGFloat = 64
        
        self.goods = goods
        productImageView?.kf.setImage(with: URL(string: goods.img!), placeholder: UIImage(named: "v2_placeholder_square"))
        titleNameLabel?.text = goods.name
        priceView = DiscountPriceView(price: goods.price, marketPrice: goods.market_price)
        priceView?.frame = CGRect(x: 15, y: 40, width: ScreenWidth * 0.6, height: 40)
        nameView.addSubview(priceView!)
        
        if goods.pm_desc == "买一赠一" {
            presentView?.frame.size.height = 50
            presentView?.isHidden = false
        }else{
            presentView?.frame.size.height = 0
            presentView?.isHidden = true
            detailView?.frame.origin.y -= 50
            promptView?.frame.origin.y -= 50
        }
        
        brandTitleLabel?.text = goods.brand_name
        detailTitleLabel?.text = goods.specifics
        
        detailImageView = UIImageView(image: UIImage(named: "aaaa"))
        let scale: CGFloat = 320 / ScreenWidth
        detailImageView?.frame = CGRect(x: 0, y: promptView!.frame.maxY, width: ScreenWidth, height: detailImageView!.frame.height / scale)
        scrollView?.addSubview(detailImageView!)
        scrollView?.contentSize = CGSize(width: ScreenWidth, height: detailImageView!.frame.maxY + navigationH)
    
        buildNavigationItem(titleText: goods.name!)
        
        buyView = BuyView(frame: CGRect(x: 85, y: 12, width: 80, height: 25))
        buyView?.zearIsShow = true
        buyView?.goods = goods
        bottomView?.addSubview(buyView!)
        
        yellowShopCar = YellowShopCarView(frame: CGRect(x: ScreenWidth - 70, y: 50 - 61 - 10, width: 61, height: 61), shopViewClick: { [weak self] in
            let shopCarVC = ShopCartViewController()
            let nav = BaseNavigationController(rootViewController: shopCarVC)
            self?.present(nav, animated: true, completion: nil)
        })
        
        bottomView?.addSubview(yellowShopCar!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
        if goods != nil {
            buyView?.goods = goods
        }
        
        (navigationController as! BaseNavigationController).isAnimation = true
    }
    
    deinit {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LFBSearchViewControllerDeinit"), object: nil)
    }
}

extension ProductDetailViewController{
    
    private func buildNavigationItem(titleText: String){
        self.navigationItem.title = titleText
        navigationItem.rightBarButtonItem = UIBarButtonItem.barButton(title: "分享", titleColor: UIColor(r: 100, g: 100, b: 100), target: self, action: #selector(rightItemClick))
    }
    
    @objc private func rightItemClick(){
        shareActionSheet.showActionSheetViewShowInView(parentVc: self) { (shareType) in
            
        }
    }
    
    private func buildLineView(addView: UIView, lineFrame: CGRect) {
        let lineView = UIView(frame: lineFrame)
        lineView.backgroundColor = UIColor.black
        lineView.alpha = 0.1
        addView.addSubview(lineView)
    }
}

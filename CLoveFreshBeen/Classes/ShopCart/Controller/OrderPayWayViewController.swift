//
//  OrderPayWayViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/2.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class OrderPayWayViewController: UIViewController {

    private var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight - 64 - 50))
    private var tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40 + 15 + 190 + 30))
    private let leftMargin: CGFloat = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        buildNavigationItem()
        buildScrollView()
    }
}

extension OrderPayWayViewController{
    private func buildNavigationItem(){
        navigationItem.title = "结算付款"
    }
    
    private func buildScrollView(){
        scrollView.contentSize = CGSize(width: ScreenWidth, height: 1000)
        scrollView.backgroundColor = UIColor.clear
        view.addSubview(scrollView)
        
        buildTableHeaderView()
        scrollView.addSubview(tableHeaderView)
    }
    
    private func buildTableHeaderView(){
        tableHeaderView.backgroundColor = UIColor.clear
        buildCouponView()
        buildPayView()
        buildCarefullyView()
    }
    
    private func buildCouponView(){
        let couponView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 40))
        couponView.backgroundColor = UIColor.white
        tableHeaderView.addSubview(couponView)
        
        let couponImageView = UIImageView(image: UIImage(named: "v2_submit_Icon"))
        couponImageView.frame = CGRect(x: leftMargin, y: 10, width: 20, height: 20)
        couponView.addSubview(couponImageView)
        
        let couponLabel = UILabel(frame: CGRect(x: couponImageView.frame.maxX + 10, y: 0, width: ScreenWidth * 0.4, height: 40))
        couponLabel.text = "1张优惠劵"
        couponLabel.textColor = UIColor.red
        couponLabel.font = UIFont.systemFont(ofSize: 14)
        couponView.addSubview(couponLabel)
        
        let arrowImageView = UIImageView(image: UIImage(named: "icon_go"))
        arrowImageView.frame = CGRect(x: ScreenWidth - 10 - 5, y: 15, width: 5, height: 10)
        couponView.addSubview(arrowImageView)
        
        let checkButton = UIButton(frame: CGRect(x: ScreenWidth - 60, y: 0, width: 40, height: 40))
        checkButton.setTitle("查看", for: .normal)
        checkButton.setTitleColor(UIColor.black, for: .normal)
        checkButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        couponView.addSubview(checkButton)
        
        buildLineView(couponView, lineFrame: CGRect(x: 0, y: 39, width: ScreenWidth, height: 1))
    }
    
    private func buildPayView(){
        let payView = UIView(frame: CGRect(x: 0, y: 55, width: ScreenWidth, height: 190))
        payView.backgroundColor = UIColor.white
        tableHeaderView.addSubview(payView)
        
        buildLabel(CGRect(x: leftMargin, y: 0, width: 150, height: 30), textColor: UIColor.lightGray, font: UIFont.systemFont(ofSize: 12), addView: payView, text: "选择支付方式")
        let payV = PayView(frame: CGRect(x: 0, y: 30, width: ScreenWidth, height: 160))
        payView.addSubview(payV)
        
        buildLineView(payView, lineFrame: CGRect(x: 0, y: 189, width: ScreenWidth, height: 1))
    }
    
    private func buildCarefullyView(){
        let carefullyView = UIView(frame: CGRect(x: 0, y: 40 + 15 + 190 + 15, width: ScreenWidth, height: 30))
        carefullyView.backgroundColor = UIColor.white
        tableHeaderView.addSubview(carefullyView)
        
        buildLabel(CGRect(x: leftMargin, y: 0, width: 150, height: 30), textColor: UIColor.lightGray, font: UIFont.systemFont(ofSize: 12), addView: carefullyView, text: "精选商品")
        
        let goodsView = ShopCartGoodsListView(frame: CGRect(x: 0, y: carefullyView.frame.maxY, width: ScreenWidth, height: 300))
        goodsView.frame.size.height = goodsView.goodsHeight
        scrollView.addSubview(goodsView)
        
        let costDetailView = CostDetailView(frame: CGRect(x: 0, y: goodsView.frame.maxY + 10, width: ScreenWidth, height: 135))
        scrollView.addSubview(costDetailView)
        
        scrollView.contentSize = CGSize(width: ScreenWidth, height: costDetailView.frame.maxY + 15)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        buildLineView(bottomView, lineFrame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 1))
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.bottom.right.equalToSuperview()
        }
        
        buildLabel(CGRect(x: leftMargin, y: 0, width: 80, height: 50), textColor: UIColor.black, font: UIFont.systemFont(ofSize: 14), addView: bottomView, text: "实付金额:")
        var priceText = costDetailView.coupon == "0" ? UserShopCarTool.sharedUserShopCar.getAllProductsPrice() : "\((UserShopCarTool.sharedUserShopCar.getAllProductsPrice() as NSString).floatValue - 5)"
        if (priceText as NSString).floatValue < 30 {
            priceText = "\((priceText as NSString).floatValue + 8)".cleanDecimalPointZear()
        }
        buildLabel(CGRect(x: 85, y: 0, width: 150, height: 50), textColor: UIColor.red, font: UIFont.systemFont(ofSize: 14), addView: bottomView, text: "$" + priceText)
        
        let payButton = UIButton(frame: CGRect(x: ScreenWidth - 100, y: 1, width: 100, height: 49))
        payButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        payButton.setTitle("确认付款", for: UIControl.State.normal)
        payButton.backgroundColor = LFBNavigationYellowColor
        payButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        bottomView.addSubview(payButton)
    }
    
    private func buildLineView(_ addView: UIView, lineFrame: CGRect) {
        let lineView = UIView(frame: lineFrame)
        lineView.backgroundColor = UIColor.black
        lineView.alpha = 0.1
        addView.addSubview(lineView)
    }
    
    private func buildLabel(_ labelFrame: CGRect, textColor: UIColor, font: UIFont, addView: UIView, text: String) {
        let label = UILabel(frame: labelFrame)
        label.textColor = textColor
        label.font = font
        label.text = text
        addView.addSubview(label)
    }
    
}

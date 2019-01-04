//
//  OrderDetailViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2019/1/3.
//  Copyright © 2019年 dd. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {
    private var scrollView: UIScrollView?
    private let orderDetailView = OrderDetailView()
    private let orderUserDetailView = OrderUserDetailView()
    private let orderGoodsListView = OrderGoodsListView()
    private let evaluateView = UIView()
    private let evaluateLabel = UILabel()
    
    private lazy var starImageViews: [UIImageView] = {
        var starImageViews: [UIImageView] = []
        for i in 0...4 {
            let starImageView = UIImageView(image: UIImage(named: "v2_star_no"))
            starImageViews.append(starImageView)
        }
        return starImageViews
    }()
    
    var order: Order? {
        didSet {
            orderDetailView.order = order
            orderUserDetailView.order = order
            orderGoodsListView.order = order
            if -1 != order?.star {
                for i in 0..<order!.star {
                    let imageView = starImageViews[i]
                    imageView.image = UIImage(named: "v2_star_on")
                }
            }
            
            evaluateLabel.text = order?.comment
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        buildScrollView()
        buildOrderDetailView()
        buildOrderUserDetailView()
        buildOrderGoodsListView()
        bulidEvaluateView()
    }

}

extension OrderDetailViewController {
    private func buildScrollView(){
        scrollView = UIScrollView(frame: view.bounds)
        scrollView?.alwaysBounceVertical = true
        scrollView?.backgroundColor = LFBGlobalBackgroundColor
        scrollView?.contentSize = CGSize(width: ScreenWidth, height: 1000)
        view.addSubview(scrollView!)
    }
    
    private func buildOrderDetailView(){
        orderDetailView.frame = CGRect(x: 0, y: 10, width: ScreenWidth, height: 185)
        scrollView?.addSubview(orderDetailView)
    }
    
    private func buildOrderUserDetailView(){
        orderUserDetailView.frame = CGRect(x: 0, y: orderDetailView.frame.maxY + 10, width: ScreenWidth, height: 110)
        scrollView?.addSubview(orderUserDetailView)
    }
    
    private func buildOrderGoodsListView(){
        orderGoodsListView.frame = CGRect(x: 0, y: orderUserDetailView.frame.maxY + 10, width: ScreenWidth, height: 350)
        orderGoodsListView.delegate = self
        scrollView?.addSubview(orderGoodsListView)
    }
    
    private func bulidEvaluateView(){
        evaluateView.frame = CGRect(x: 0, y: orderGoodsListView.frame.maxY + 10, width: ScreenWidth, height: 80)
        evaluateView.backgroundColor = UIColor.white
        scrollView?.addSubview(evaluateView)
        
        let myEvaluateLabel = UILabel()
        myEvaluateLabel.text = "我的评价"
        myEvaluateLabel.textColor = LFBTextBlackColor
        myEvaluateLabel.font = UIFont.systemFont(ofSize: 14)
        myEvaluateLabel.frame = CGRect(x: 10, y: 5, width: ScreenWidth, height: 25)
        evaluateView.addSubview(myEvaluateLabel)
        
        for i in 0...4 {
            let starImageView = starImageViews[i]
            starImageView.frame = CGRect(x: 10 + CGFloat(i) * 30, y: myEvaluateLabel.frame.maxY + 5, width: 25, height: 25)
            evaluateView.addSubview(starImageView)
        }
        
        evaluateLabel.font = UIFont.systemFont(ofSize: 14)
        evaluateLabel.frame = CGRect(x: 10, y: starImageViews[0].frame.maxY + 10, width: ScreenWidth - 20, height: 25)
        evaluateLabel.textColor = LFBTextBlackColor
        evaluateView.addSubview(evaluateLabel)
    }
}

extension OrderDetailViewController: OrderGoodsListViewDelegate{
    func orderGoodsListViewHeightDidChange(height: CGFloat) {
        orderGoodsListView.frame = CGRect(x: 0, y: orderUserDetailView.frame.maxY + 10, width: ScreenWidth, height: height)
        evaluateView.frame = CGRect(x: 0, y: orderGoodsListView.frame.maxY + 10, width: ScreenWidth, height: 100)
        scrollView?.contentSize = CGSize(width: ScreenWidth, height: evaluateView.frame.maxY + 10 + 50 + 64)
    }
}

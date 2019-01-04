//
//  Constant.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

public let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds: CGRect = UIScreen.main.bounds

public let ShopCarRedDotAnimationDuration: TimeInterval = 0.2

// MARK: - Home 属性
public let HotViewMargin: CGFloat = 10
public let HomeCollectionViewCellMargin: CGFloat = 10
public let HomeCollectionTextFont = UIFont.systemFont(ofSize: 14)
public let HomeCollectionCellAnimationDuration: TimeInterval = 1.0

// MARK: - 通知
/// 首页headView高度改变
public let HomeTableHeadViewHeightDidChange = "HomeTableHeadViewHeightDidChange"
/// 首页商品库存不足
public let HomeGoodsInventoryProblem = "HomeGoodsInventoryProblem"
// MARK: - 广告页通知
public let ADImageLoadSecussed = "ADImageLoadSecussed"
public let ADImageLoadFail = "ADImageLoadFail"


public let GuideViewControllerDidFinish = "GuideViewControllerDidFinish"

// MARK: - 常用颜色
public let LFBGlobalBackgroundColor = UIColor(r: 239, g: 239, b: 239)
public let LFBNavigationYellowColor = UIColor(r: 253, g: 212, b: 48)
public let LFBTextGreyColol = UIColor(r: 130, g: 130, b: 130)
public let LFBTextBlackColor = UIColor(r: 50, g: 50, b: 50)
public let LFBNavigationBarWhiteBackgroundColor = UIColor(r: 249, g: 249, b: 253)

// MARK: - 购物车管理工具通知
public let LFBShopCarDidRemoveProductNSNotification = "LFBShopCarDidRemoveProductNSNotification"
/// 购买商品数量发生改变
public let LFBShopCarBuyProductNumberDidChangeNotification = "LFBShopCarBuyProductNumberDidChangeNotification"
/// 购物车商品价格发送改变
public let LFBShopCarBuyPriceDidChangeNotification = "LFBShopCarBuyPriceDidChangeNotification"
// MARK: - 购物车ViewController
public let ShopCartRowHeight: CGFloat = 50
// MARK: - 搜索ViewController
public let LFBSearchViewControllerHistorySearchArray = "LFBSearchViewControllerHistorySearchArray"

// MARK: - Cache路径
public let LFBCachePath: String = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!

// MARK: - Mine属性
public let CouponViewControllerMargin: CGFloat = 20

///优惠劵使用规则
public let CouponUserRuleURLString = "http://m.beequick.cn/show/webview/p/coupon?zchtauth=e33f2ac7BD%252BaUBDzk6f5D9NDsFsoCcna6k%252BQCEmbmFkTbwnA&__v=ios4.7&__d=d14ryS0MFUAhfrQ6rPJ9Gziisg%2F9Cf8CxgkzZw5AkPMbPcbv%2BpM4HpLLlnwAZPd5UyoFAl1XqBjngiP6VNOEbRj226vMzr3D3x9iqPGujDGB5YW%2BZ1jOqs3ZqRF8x1keKl4%3D"

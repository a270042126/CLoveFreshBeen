//
//  MainTabController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MainTabBarController:AnimationTabBarController, UITabBarControllerDelegate {
    
    private var fristLoadMainTabBarController: Bool = true
    private var adImageView: UIImageView?
    
    var adImage: UIImage? {
        didSet{
            adImageView = UIImageView(frame: ScreenBounds)
            adImageView!.image = adImage
            self.view.addSubview(adImageView!)
            
            UIImageView.animate(withDuration: 2.0, animations: {
                self.adImageView!.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.adImageView!.alpha = 0
            }) { (_) in
                self.adImageView!.removeFromSuperview()
                self.adImageView = nil
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        buildMainTabBarChildViewController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if fristLoadMainTabBarController {
            let containers = createViewContainers()
            
            createCustomIcons(containers)
            fristLoadMainTabBarController = false
        }
    }
    
    private func buildMainTabBarChildViewController(){
        tabBarControllerAddChildViewController(HomeViewController(), title: "首页", imageName: "v2_home", selectedImageName: "v2_home_r", tag: 0)
        tabBarControllerAddChildViewController(SupermarketViewController(), title: "闪电超市", imageName: "v2_order", selectedImageName: "v2_order_r", tag: 1)
        tabBarControllerAddChildViewController(ShopCartViewController(), title: "购物车", imageName: "shopCart", selectedImageName: "shopCart", tag: 2)
        tabBarControllerAddChildViewController(MineViewController(), title: "我的", imageName: "v2_my", selectedImageName: "v2_my_r", tag: 3)
    }
    
    private func tabBarControllerAddChildViewController(_ childView: UIViewController, title: String, imageName: String, selectedImageName: String, tag: Int){
        let vcItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vcItem.tag = tag
        vcItem.animation = RAMBounceAnimation()
        childView.tabBarItem = vcItem
        
        let navigationVC = BaseNavigationController(rootViewController: childView)
        addChild(navigationVC)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let childArr = tabBarController.children as NSArray
        let index = childArr.index(of: viewController)
        
        if index == 2 {
            return false
        }
        
        return true
    }
}

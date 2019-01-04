//
//  AppDelegate.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setAppSubject()
        addNotification()
        buildKeyWindow()
        return true
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension AppDelegate{
    
    private func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(showMainTabbarControllerSucess(noti:)), name: NSNotification.Name(ADImageLoadSecussed), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showMainTabbarControllerFale), name: NSNotification.Name(ADImageLoadFail), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showMainTabBarController), name: NSNotification.Name(GuideViewControllerDidFinish), object: nil)
    }
    
    private func buildKeyWindow(){
        window = UIWindow(frame: ScreenBounds)
        window?.makeKeyAndVisible()
        
        let isFirtOpen = UserDefaults.standard.object(forKey: "isFristOpenApp")
        if isFirtOpen == nil {
            window?.rootViewController = GuideViewController()
            UserDefaults.standard.set("isFristOpenApp", forKey: "isFristOpenApp")
        }else{
            loadADRootViewController()
        }
    }
    
    private func loadADRootViewController(){
        let adViewController = ADViewController()
        HttpTool.loadADData {[weak self] (model) in
            if model?.data?.img_name != nil {
                adViewController.imageName = model?.data?.img_name
                self?.window?.rootViewController = adViewController
            }
        }
    }
    
    @objc private func showMainTabbarControllerSucess(noti: NSNotification){
        let adImage = noti.object as! UIImage
        let mainTabBar = MainTabBarController()
        mainTabBar.adImage = adImage
        window?.rootViewController = mainTabBar
    }
    
    @objc private func showMainTabBarController(){
        window!.rootViewController = MainTabBarController()
    }
    
    @objc private func showMainTabbarControllerFale(){
         window!.rootViewController = MainTabBarController()
    }
    
    // MARK:- privete Method
    // MARK:主题设置
    private func setAppSubject() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor.white
        //tabBarAppearance.backgroundColor = UIColor(r: 0, g: 0, b: 0)
        
        let navBar = UINavigationBar.appearance()
        navBar.isTranslucent = false
    }
}

//
//  AnimationViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var animationLayers: [CALayer]?
    var animationBigLayers: [CALayer]?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
    }
}

extension AnimationViewController{
    // MARK: 商品添加到购物车动画
    func addProductsAnimation(imageView: UIImageView){
        if self.animationLayers == nil{
            self.animationLayers = [CALayer]()
        }
        
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        self.view.layer.addSublayer(transitionLayer)
        self.animationLayers?.append(transitionLayer)
        
        let p1 = transitionLayer.position
        let p3 = CGPoint(x: view.frame.width - view.frame.width / 4 - view.frame.width / 8 - 6, y: view.layer.bounds.height - 40)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath()
        path.move(to: p1)
        path.addCurve(to: CGPoint(x: p1.x, y: p1.y - 30), control1: CGPoint(x: p3.x, y: p1.y - 30), control2: CGPoint(x: p3.x, y: p3.y))
        positionAnimation.path = path
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = .forwards
        opacityAnimation.isRemovedOnCompletion = true
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation]
        groupAnimation.duration = 0.8
        groupAnimation.delegate = self
        
        transitionLayer.add(groupAnimation, forKey: "cartParabola")
    }
    
     // MARK: - 添加商品到右下角购物车动画
    func addProductsToBigShopCarAnimation(imageView: UIImageView){
        if animationBigLayers == nil {
            animationBigLayers = [CALayer]()
        }
        
        let frame = imageView.convert(imageView.bounds, to: view)
        let transitionLayer = CALayer()
        transitionLayer.frame = frame
        transitionLayer.contents = imageView.layer.contents
        self.view.layer.addSublayer(transitionLayer)
        self.animationBigLayers?.append(transitionLayer)
        
        let p1 = transitionLayer.position
        let p3 = CGPoint(x: view.bounds.width - 40, y: view.layer.bounds.height - 40)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        let path = CGMutablePath()
        path.move(to: p1)
        path.addCurve(to: CGPoint(x: p1.x, y: p1.y - 30), control1: CGPoint(x: p3.x, y: p1.y - 30), control2: p3)
        positionAnimation.path = path
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1
        opacityAnimation.toValue = 0.9
        opacityAnimation.fillMode = .forwards
        opacityAnimation.isRemovedOnCompletion = true
        
        let transformAnimation = CABasicAnimation(keyPath: "transform")
        transformAnimation.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        transformAnimation.toValue = NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 1))
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation, transformAnimation, opacityAnimation]
        groupAnimation.duration = 0.8
        groupAnimation.delegate = self
        transitionLayer.add(groupAnimation, forKey: "BigShopCarAnimation")
    }
    
}

extension AnimationViewController: CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if animationLayers != nil && animationLayers!.count > 0 {
            let transitionLayer = animationLayers![0]
            transitionLayer.isHidden = true
            transitionLayer.removeFromSuperlayer()
            animationLayers?.removeFirst()
            view.layer.removeAnimation(forKey: "cartParabola")
        }
        
        if animationBigLayers != nil && animationBigLayers!.count > 0 {
            let transitionLayer = animationBigLayers![0]
            transitionLayer.isHidden = true
            transitionLayer.removeFromSuperlayer()
            animationBigLayers?.removeFirst()
            view.layer.removeAnimation(forKey: "BigShopCarAnimation")
        }
    }
}

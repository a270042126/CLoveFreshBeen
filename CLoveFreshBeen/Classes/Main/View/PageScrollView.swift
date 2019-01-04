//
//  PageScrollView.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/31.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class PageScrollView: UIView {
    private let imageViewMaxCount = 3
    private var imageScrollView: UIScrollView!
    private var pageControl: UIPageControl!
    private var timer: Timer?
    private var placeholderImage: UIImage?
    private var imageClick:((_ index: Int) -> ())?
    
    var headData: HeadResources?{
        didSet{
            if timer != nil{
                timer?.invalidate()
                timer = nil
            }
            
            if headData?.data?.focus != nil && headData!.data!.focus!.count >= 0{
                pageControl.numberOfPages = headData!.data!.focus!.count
                pageControl.currentPage = 0
                updatePageScrollView()
                startTimer()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildImageScrollView()
        buildPageControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, placeholder: UIImage, focusImageViewClick:@escaping ((_ index: Int) -> Void)) {
        self.init(frame: frame)
        placeholderImage = placeholder
        imageClick = focusImageViewClick
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageScrollView.frame = bounds
        imageScrollView.contentSize = CGSize(width: CGFloat(imageViewMaxCount) * frame.width, height: 0)
        for i in 0...imageViewMaxCount - 1{
            let imageView = imageScrollView.subviews[i] as! UIImageView
            imageView.isUserInteractionEnabled = true
            imageView.frame = CGRect(x: CGFloat(i) * imageScrollView.frame.width, y: 0, width: imageScrollView.frame.width, height: imageScrollView.frame.height)
        }
        
        let pageW: CGFloat = 80
        let pageH: CGFloat = 20
        let pageX: CGFloat = imageScrollView.frame.width - pageW
        let pageY: CGFloat = imageScrollView.frame.height - pageH
        pageControl.frame = CGRect(x: pageX, y: pageY, width: pageW, height: pageH)
        updatePageScrollView()
    }
}

extension PageScrollView{
    
    private func buildImageScrollView(){
        imageScrollView = UIScrollView()
        imageScrollView.bounces = false
        imageScrollView.showsHorizontalScrollIndicator = false
        imageScrollView.showsVerticalScrollIndicator = false
        imageScrollView.isPagingEnabled = true
        imageScrollView.delegate = self
        addSubview(imageScrollView)
        
        for _ in 0..<3{
            let imageView = UIImageView()
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewClick(tap:)))
            imageView.addGestureRecognizer(tap)
            imageScrollView.addSubview(imageView)
        }
    }
    
    private func buildPageControl(){
        pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_normal")!)
        pageControl.currentPageIndicatorTintColor = UIColor(patternImage: UIImage(named: "v2_home_cycle_dot_selected")!)
        addSubview(pageControl)
    }
    
    private func updatePageScrollView(){
        for i in 0..<imageScrollView.subviews.count{
            let imageView = imageScrollView.subviews[i] as! UIImageView
            var index = pageControl.currentPage
            
            if i == 0{
                index -= 1
            } else if 2 == i{
                index += 1
            }
            
            if index < 0 {
                index = self.pageControl.numberOfPages - 1
            }else if index >= pageControl.numberOfPages {
                index = 0
            }
            
            imageView.tag = index
            if headData?.data?.focus != nil && headData!.data!.focus!.count > 0 {
                imageView.kf.setImage(with: URL(string: headData!.data!.focus![index].img!), placeholder: placeholderImage)
            }
        }
        
        imageScrollView.contentOffset = CGPoint(x: imageScrollView.frame.width, y: 0)
    }
    
    private func startTimer(){
        timer = Timer(timeInterval: 3, target: self, selector: #selector(nextScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func imageViewClick(tap: UITapGestureRecognizer){
        imageClick?(tap.view!.tag)
    }
    
    @objc private func nextScroll(){
        imageScrollView.setContentOffset(CGPoint(x: 2 * imageScrollView.frame.width, y: 0), animated: true)
    }
}

extension PageScrollView: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var page: Int = 0
        var minDistance: CGFloat = CGFloat(MAXFLOAT)
        for i in 0..<imageScrollView.subviews.count{
            let imageView = imageScrollView.subviews[i] as! UIImageView
            let distance: CGFloat = abs(imageView.frame.origin.x - scrollView.contentOffset.x)
            
            if distance < minDistance{
                minDistance = distance
                page = imageView.tag
            }
        }
        pageControl.currentPage = page
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageScrollView()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updatePageScrollView()
    }
}

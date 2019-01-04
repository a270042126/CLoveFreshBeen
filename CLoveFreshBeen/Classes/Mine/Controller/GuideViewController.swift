//
//  GuideViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = ScreenBounds.size
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.bounces = true
        cv.register(GuideCell.self, forCellWithReuseIdentifier: "\(GuideCell.self)")
        return cv
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageController = UIPageControl(frame: .zero)
        pageController.numberOfPages = imageNames.count
        pageController.currentPage = 0
        return pageController
    }()
    
    private var imageNames = ["guide_40_1", "guide_40_2", "guide_40_3", "guide_40_4"]
    private var isHiddenNextButton = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { (make) in
            make.width.equalTo(ScreenWidth)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-50)
            make.left.right.equalToSuperview()
        }
    }
}

extension GuideViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(GuideCell.self)", for: indexPath) as! GuideCell
        cell.newImage = UIImage(named: imageNames[indexPath.row])
        if indexPath.row != imageNames.count - 1 {
            cell.setNextButtonHidden(isHidden: true)
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x == ScreenWidth * CGFloat(imageNames.count - 1){
            let cell = collectionView.cellForItem(at: IndexPath(item: imageNames.count - 1, section: 0)) as! GuideCell
            cell.setNextButtonHidden(isHidden: false)
            isHiddenNextButton = false
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x != ScreenWidth * CGFloat(imageNames.count - 1) && !isHiddenNextButton && scrollView.contentOffset.x > ScreenWidth * CGFloat(imageNames.count - 2){
            let cell = collectionView.cellForItem(at: IndexPath(item: imageNames.count - 1, section: 0)) as! GuideCell
            cell.setNextButtonHidden(isHidden: true)
            isHiddenNextButton = true
        }
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / ScreenWidth + 0.5)
    }
}

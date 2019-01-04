//
//  GuideCell.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/28.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import SnapKit

class GuideCell: UICollectionViewCell {

    private lazy var newImageView: UIImageView = {
        let nV = UIImageView()
        nV.contentMode = .scaleToFill
        return nV
    }()
    private lazy var nextButton: UIButton = {
        let nB = UIButton()
        nB.setBackgroundImage(UIImage(named: "icon_next"), for: .normal)
        nB.isHidden = true
        nB.addTarget(self, action: #selector(nextButtonClick), for: .touchUpInside)
        return nB
    }()
    
    var newImage: UIImage? {
        didSet{
            newImageView.image = newImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(newImageView)
        newImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        contentView.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.height.equalTo(33)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-110)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNextButtonHidden(isHidden: Bool){
        nextButton.isHidden = isHidden
    }
    
    @objc func nextButtonClick(){
        NotificationCenter.default.post(name: NSNotification.Name(GuideViewControllerDidFinish), object: nil)
    }
}

//
//  HomeCell.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

enum HomeCellType: Int {
    case Horizontal = 0
    case Vertical = 1
}

class HomeCell: UICollectionViewCell {
    //MARK: - 初始化子空间
    private lazy var backImageView: UIImageView = {
        let backImageView = UIImageView()
        return backImageView
    }()
    
    private lazy var goodsImageView: UIImageView = {
        let goodsImageView = UIImageView()
        goodsImageView.contentMode = .scaleAspectFit
        return goodsImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.font = HomeCollectionTextFont
        nameLabel.textColor = UIColor.black
        return nameLabel
    }()
    
    private lazy var fineImageView: UIImageView = {
        let fineImageView = UIImageView()
        fineImageView.image = UIImage(named: "jingxuan.png")
        return fineImageView
    }()
    
    private lazy var giveImageView: UIImageView = {
        let giveImageView = UIImageView()
        giveImageView.image = UIImage(named: "buyOne.png")
        return giveImageView
    }()
    
    private lazy var specificsLabel: UILabel = {
        let specificsLabel = UILabel()
        specificsLabel.textColor = UIColor(r: 100, g: 100, b: 100)
        specificsLabel.font = UIFont.systemFont(ofSize: 12)
        specificsLabel.textAlignment = .left
        return specificsLabel
    }()
    
    private var discountPriceView: DiscountPriceView?
    
    private lazy var buyView: BuyView = BuyView()
    
    private var type: HomeCellType? {
        didSet{
            backImageView.isHidden = !(type == HomeCellType.Horizontal)
            goodsImageView.isHidden = (type == HomeCellType.Horizontal)
            nameLabel.isHidden = (type == HomeCellType.Horizontal)
            fineImageView.isHidden = (type == HomeCellType.Horizontal)
            giveImageView.isHidden = (type == HomeCellType.Horizontal)
            specificsLabel.isHidden = (type == HomeCellType.Horizontal)
            discountPriceView?.isHidden = (type == HomeCellType.Horizontal)
            buyView.isHidden = (type == HomeCellType.Horizontal)
        }
    }
    
    var addButtonClick:((_ imageView: UIImageView) -> ())?
    
    // MARK: - 模型set方法
    var activities: Activities? {
        didSet{
            self.type = .Horizontal
            backImageView.kf.setImage(with: URL(string: activities!.img!), placeholder: UIImage(named: "v2_placeholder_full_size"))
        }
    }

    var goods: Goods? {
        didSet{
            self.type = .Vertical
            goodsImageView.kf.setImage(with: URL(string: goods!.img!), placeholder: UIImage(named: "v2_placeholder_square"))
            nameLabel.text = goods?.name
            if goods!.pm_desc == "买一赠一" {
                giveImageView.isHidden = false
            } else {
                giveImageView.isHidden = true
            }
            discountPriceView?.removeFromSuperview()
            discountPriceView = DiscountPriceView(price: goods?.price, marketPrice: goods?.market_price)
            addSubview(discountPriceView!)
            discountPriceView?.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().inset(5)
                make.bottom.equalToSuperview().inset(5)
                make.width.equalTo(60)
                make.height.equalTo(20)
            })
            specificsLabel.text = goods?.specifics
            buyView.goods = goods
        }
    }
    
    // MARK: - 便利构造方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(backImageView)
        addSubview(goodsImageView)
        addSubview(nameLabel)
        addSubview(fineImageView)
        addSubview(giveImageView)
        addSubview(specificsLabel)
        addSubview(buyView)
        
        
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        goodsImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
        
        specificsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.bottom.equalToSuperview().inset(23)
        }
        
        fineImageView.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(15)
            make.left.equalToSuperview().inset(5)
            make.bottom.equalTo(specificsLabel.snp.top).inset(-2)
        }
        
        giveImageView.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(15)
            make.left.equalTo(fineImageView.snp.right).inset(-5)
            make.centerY.equalTo(fineImageView.snp.centerY)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(5)
            make.bottom.equalTo(fineImageView.snp.top).inset(-2)
        }
        
        buyView.snp.makeConstraints { (make) in
            make.height.equalTo(35)
            make.width.equalTo(80)
            make.bottom.right.equalToSuperview()
        }
        
        buyView.clickAddShopCar = {[weak self] in
            self?.addButtonClick?(self!.goodsImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

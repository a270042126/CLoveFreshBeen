//
//  MyAdressViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

class MyAddressViewController: UIViewController {

    private var addAddressButton: UIButton?
    private lazy var nullImageView = UIView()
    
    var selectedAddressCallBack: ((_ address: Address) -> Void)?
    var isSelectVC = false
    var addressTableView: LFBTableView?
    var isNavShow = false
    var addresses: [Address]? {
        didSet{
            if addresses?.count == 0 {
                nullImageView.isHidden = false
                addressTableView?.isHidden = true
            }else{
                nullImageView.isHidden = true
                addressTableView?.isHidden = false
            }
        }
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        isNavShow = true
    }
    
    
    init(selectedAdress: ((_ adress:Address) -> Void)?){
        super.init(nibName: nil, bundle: nil)
        selectedAddressCallBack = selectedAdress
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        buildNavigationItem()
        buildAddressTableView()
        buildNullImageView()
        loadAdressData()
        buildBottomAddAdressButtom()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNavShow{
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

extension MyAddressViewController {
    private func buildNavigationItem(){
        navigationItem.title = "我的收获地址"
    }
    
    private func buildAddressTableView(){
        addressTableView = LFBTableView(frame: view.bounds, style: .plain)
        addressTableView?.frame.origin.y += 10
        addressTableView?.backgroundColor = UIColor.clear
        addressTableView?.rowHeight = 80
        addressTableView?.delegate = self
        addressTableView?.dataSource = self
        view.addSubview(addressTableView!)
    }
    
    private func buildNullImageView(){
        nullImageView.backgroundColor = UIColor.clear
        nullImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        nullImageView.center = view.center
        nullImageView.center.y -= 100
        view.addSubview(nullImageView)
        
        let imageView = UIImageView(image: UIImage(named: "v2_address_empty"))
        imageView.center.x = 100
        imageView.center.y = 100
        nullImageView.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxX + 10, width: 200, height: 200))
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "你还没有地址哦~"
        nullImageView.addSubview(label)
    }
    
    private func loadAdressData() {
        HttpTool.loadMyAdressData { (model) in
            if model?.data != nil && model!.data!.count > 0 {
                addresses = model?.data
                addressTableView?.isHidden = false
                addressTableView?.reloadData()
                nullImageView.isHidden = true
                UserInfo.shareUserInfo.setAllAdress(addresses: model!.data!)
            }else{
                addressTableView?.isHidden = true
                nullImageView.isHidden = false
                UserInfo.shareUserInfo.cleanAllAddress()
            }
        }
    }
    
    private func buildBottomAddAdressButtom(){
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(60)
            make.left.right.bottom.equalToSuperview()
        }
        addAddressButton = UIButton()
        addAddressButton?.backgroundColor = LFBNavigationYellowColor
        addAddressButton?.setTitle("+ 新增地址", for: .normal)
        addAddressButton?.setTitleColor(UIColor.black, for: .normal)
        addAddressButton?.layer.masksToBounds = true
        addAddressButton?.layer.cornerRadius = 8
        addAddressButton?.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addAddressButton?.addTarget(self, action: #selector(addAdressButtonClick), for: .touchUpInside)
        bottomView.addSubview(addAddressButton!)
        addAddressButton?.snp.makeConstraints({ (make) in
            make.height.equalTo(46)
            make.width.equalTo(ScreenWidth * 0.7)
            make.center.equalToSuperview()
        })
    }
    
    @objc private func addAdressButtonClick(){
        let editVc = EditAdressViewController()
        editVc.topVC = self
        editVc.vcType = EditAdressViewControllerType.Add
        navigationController?.pushViewController(editVc, animated: true)
    }
}

extension MyAddressViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = AddressCell.addressCell(tableView: tableView, indexPath: indexPath) {[weak self] (cellIndexPathRow) in
            let editVC = EditAdressViewController()
            editVC.topVC = self
            editVC.vcType = EditAdressViewControllerType.Edit
            editVC.currentAddressRow = indexPath.row
            self?.navigationController?.pushViewController(editVC, animated: true)
        }
        cell.address = addresses![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSelectVC{
            if selectedAddressCallBack != nil{
                selectedAddressCallBack!(addresses![indexPath.row])
                navigationController?.popViewController(animated: true)
            }
        }
    }
}

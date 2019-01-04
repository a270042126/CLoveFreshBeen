//
//  EditAdressViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/29.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit

enum EditAdressViewControllerType: Int {
    case Add
    case Edit
}

class EditAdressViewController: UIViewController {
    private let deleteView = UIView()
    private let scrollView = UIScrollView()
    private let adressView = UIView()
    private var contactsTextField: UITextField?
    private var phoneNumberTextField: UITextField?
    private var cityTextField: UITextField?
    private var areaTextField: UITextField?
    private var adressTextField: UITextField?
    private var manButton: LeftImageRightTextButton?
    private var womenButton: LeftImageRightTextButton?
    private var selectCityPickView: UIPickerView?
    private var toolBar: UIToolbar!
    private var currentSelectedCityIndex = -1
    weak var topVC: MyAddressViewController?
    var vcType: EditAdressViewControllerType?
    var currentAddressRow: Int = -1
    
    private lazy var cityArray: [String]? = {
        let array = ["北京市", "上海市", "天津市", "广州市", "佛山市", "深圳市", "廊坊市", "武汉市", "苏州市", "无锡市"]
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        buildNavigationItem()
        buildScrollView()
        buildAdressView()
        buildDeleteAdressView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
        
        if currentAddressRow != -1 && vcType == .Edit{
            let address = topVC!.addresses![currentAddressRow]
            contactsTextField?.text = address.accept_name
            if address.telphone?.count == 11{
                let telphone = address.telphone! as NSString
                phoneNumberTextField?.text = telphone.substring(with: NSRange(location: 0, length: 3)) + " " + telphone.substring(with: NSRange(location: 3, length: 4)) + " " + telphone.substring(with: NSRange(location: 7, length: 4))
            }
            
            if address.telphone?.count == 13 {
                phoneNumberTextField?.text = address.telphone
            }
            
            if address.gender == "1" {
                manButton?.isSelected = true
            }else{
                womenButton?.isSelected = true
            }
            cityTextField?.text = address.city_name
            let range = (address.address! as NSString).range(of: " ")
            areaTextField?.text = (address.address! as NSString).substring(to: range.location)
            adressTextField?.text = (address.address! as NSString).substring(from: range.location + 1)
            deleteView.isHidden = false
        }
    }
    
    private func buildScrollView(){
        scrollView.frame = view.bounds
        scrollView.backgroundColor = UIColor.clear
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
    }
    
    private func buildAdressView(){
        adressView.frame = CGRect(x: 0, y: 10, width: view.frame.width, height: 300)
        adressView.backgroundColor = UIColor.white
        scrollView.addSubview(adressView)
        
        let viewHeight: CGFloat = 50
        let leftMargin: CGFloat = 15
        let labelWidth: CGFloat = 70
        buildUnchangedLabel(frame: CGRect(x: leftMargin, y: 0, width: labelWidth, height: viewHeight), text: "联系人")
        buildUnchangedLabel(frame: CGRect(x: leftMargin, y: 2 * viewHeight, width: labelWidth, height: viewHeight), text: "手机号码")
        buildUnchangedLabel(frame: CGRect(x: leftMargin, y: 3 * viewHeight, width: labelWidth, height: viewHeight), text: "所在城市")
        buildUnchangedLabel(frame: CGRect(x: leftMargin, y: 4 * viewHeight, width: labelWidth, height: viewHeight), text: "所在地区")
        buildUnchangedLabel(frame: CGRect(x: leftMargin, y: 5 * viewHeight, width: labelWidth, height: viewHeight), text: "详细地址")
        
        let lineView = UIView(frame: CGRect(x: leftMargin, y: 49, width: view.frame.width - 10, height: 1))
        lineView.alpha = 0.45
        lineView.backgroundColor = UIColor.lightGray
        adressView.addSubview(lineView)
        
        let textFieldWidth = view.frame.width * 0.6
        let x = leftMargin + labelWidth + 10
        contactsTextField = UITextField()
        buildTextField(textField: contactsTextField!, frame: CGRect(x: x, y: 0, width: textFieldWidth, height: viewHeight), placeholder: "收货人姓名", tag: 1)
        
        phoneNumberTextField = UITextField()
        buildTextField(textField: phoneNumberTextField!, frame: CGRect(x: x, y: 2 * viewHeight, width: textFieldWidth, height: viewHeight), placeholder: "鲜蜂侠联系你的电话", tag: 2)
        
        cityTextField = UITextField()
        buildTextField(textField: cityTextField!, frame: CGRect(x: x, y: 3 * viewHeight, width: textFieldWidth, height: viewHeight), placeholder: "选择城市", tag: 3)
        
        areaTextField = UITextField()
        buildTextField(textField: areaTextField!, frame: CGRect(x: x, y: 4 * viewHeight, width: textFieldWidth, height: viewHeight), placeholder: "请选择你的住宅,大厦或学校", tag: 4)
        
        adressTextField = UITextField()
        buildTextField(textField: adressTextField!, frame: CGRect(x: x, y: 5 * viewHeight, width: textFieldWidth, height: viewHeight), placeholder: "请输入楼号门牌号等详细信息", tag: 5)
        
        manButton = LeftImageRightTextButton()
        buildGenderButton(button: manButton!, frame: CGRect(x: phoneNumberTextField!.frame.minX, y: 50, width: 100, height: 50), title: "先生", tag: 101)
        
        womenButton = LeftImageRightTextButton()
        buildGenderButton(button: womenButton!, frame: CGRect(x: manButton!.frame.maxX + 10, y: 50, width: 100, height: 50), title: "女士", tag: 102)
        
    }
    
    private func buildNavigationItem(){
        navigationItem.title = "修改地址"
        let rightItemButton = UIBarButtonItem.barButton(title: "保存", titleColor: UIColor.lightGray, target: self, action: #selector(saveButtonClick))
        navigationItem.rightBarButtonItem = rightItemButton
    }
    
    private func buildTextField(textField: UITextField, frame: CGRect, placeholder: String, tag: Int) {
        textField.frame = frame
        if tag == 2{
            textField.keyboardType = .numberPad
        }else if tag == 3{
            selectCityPickView = UIPickerView()
            selectCityPickView?.delegate = self
            selectCityPickView?.dataSource = self
            textField.inputView = selectCityPickView
            textField.inputAccessoryView = buildInputView()
        }
        
        textField.tag = tag
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.delegate = self
        textField.textColor = LFBTextBlackColor
        adressView.addSubview(textField)
    }
    
    private func buildInputView() -> UIView{
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 40))
        toolBar.backgroundColor = UIColor.white
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1))
        lineView.backgroundColor = UIColor.black
        lineView.alpha = 0.1
        toolBar.addSubview(lineView)
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.lightGray
        titleLabel.alpha = 0.8
        titleLabel.text = "选择城市"
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: toolBar.bounds.height)
        toolBar.addSubview(titleLabel)
        
//        let cancleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: toolBar.bounds.height))
//        cancleButton.tag = 10
//        cancleButton.addTarget(self, action: #selector(selectedCityTextFieldDidChange(sender:)), for: .touchUpInside)
//        cancleButton.setTitle("取消", for: .normal)
//        cancleButton.setTitleColor(UIColor(r: 82, g: 188, b: 248), for: .normal)
//        toolBar.addSubview(cancleButton)
//        let determineButton = UIButton(frame: CGRect(x: view.bounds.width - 80, y: 0, width: 80, height: toolBar.bounds.height))
//        determineButton.tag = 11
//        determineButton.addTarget(self, action: #selector(selectedCityTextFieldDidChange(sender:)), for: .touchUpInside)
//        determineButton.setTitleColor(UIColor(r: 82, g: 188, b: 248), for: .normal)
//        determineButton.setTitle("确定", for: .normal)
//        toolBar.addSubview(determineButton)
        
        let cancleButton = UIBarButtonItem(title: "取消", style: .done, target: self, action: #selector(selectedCityTextFieldDidChange(sender:)))
        cancleButton.tag = 10
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let determinButton = UIBarButtonItem(title: "确定", style: .done, target: self, action: #selector(selectedCityTextFieldDidChange(sender:)))
        determinButton.tag = 11
        toolBar.items = [cancleButton,flexSpace, determinButton]
        
        return toolBar
    }
    
    private func buildGenderButton(button: LeftImageRightTextButton, frame: CGRect, title: String, tag: Int){
        button.tag = tag
        button.setImage(UIImage(named: "v2_noselected"), for: .normal)
        button.setImage(UIImage(named: "v2_selected"), for: .selected)
        button.addTarget(title, action: #selector(genderButtonClick(sender:)), for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.frame = frame
        button.setTitleColor(LFBTextBlackColor, for: .normal)
        adressView.addSubview(button)
    }
    
    private func buildDeleteAdressView(){
        deleteView.frame = CGRect(x: 0, y: adressView.frame.maxX + 10, width: view.bounds.width, height: 50)
        deleteView.backgroundColor = UIColor.white
        scrollView.addSubview(deleteView)
        
        let deleteLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 50))
        deleteLabel.text = "删除当前地址"
        deleteLabel.textAlignment = .center
        deleteLabel.font = UIFont.systemFont(ofSize: 15)
        deleteView.addSubview(deleteLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(deleteViewClick))
        deleteView.addGestureRecognizer(tap)
        deleteView.isHidden = true
    }
    
    private func buildUnchangedLabel(frame: CGRect, text: String){
        let label = UILabel(frame: frame)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = LFBTextBlackColor
        adressView.addSubview(label)
        
        let lineView = UIView(frame: CGRect(x: 15, y: frame.origin.y - 1, width: view.frame.width - 10 , height: 1))
        lineView.alpha = 0.15
        lineView.backgroundColor = UIColor.lightGray
        adressView.addSubview(lineView)
    }
    
    @objc private func saveButtonClick(){
        if contactsTextField!.text!.count <= 1{
            ProgressHUDManager.showImage(image: UIImage(named: "v2_orderSuccess")!, status: "我们需要你的大名~")
        }
        
        if !manButton!.isSelected && !womenButton!.isSelected {
            ProgressHUDManager.showImage(image: UIImage(named: "v2_orderSuccess")!, status: "人妖么,不男不女的~")
            return
        }
        
        if phoneNumberTextField!.text!.count != 13 {
            ProgressHUDManager.showImage(image: UIImage(named: "v2_orderSuccess")!, status: "没电话,特么怎么联系你~")
            return
        }
        
        if areaTextField!.text!.count <= 2 {
            ProgressHUDManager.showImage(image: UIImage(named: "v2_orderSuccess")!, status: "你的位置啊~")
            return
        }
        
        if adressTextField!.text!.count <= 2 {
            ProgressHUDManager.showImage(image: UIImage(named: "v2_orderSuccess")!, status: "在哪里呢啊~上哪找你去啊~")
            return
        }
        
        if vcType == .Add{
            let address = Address()
            setAdressModel(address: address)
            if topVC?.addresses?.count == 0 || topVC?.addresses == nil {
                topVC?.addresses = []
            }
            topVC!.addresses!.insert(address, at: 0)
        }
        
        if vcType == .Edit{
            let address = topVC!.addresses![currentAddressRow]
            setAdressModel(address: address)
        }
        navigationController?.popViewController(animated: true)
        topVC?.addressTableView?.reloadData()
    }
    
    private func setAdressModel(address: Address){
        address.accept_name = contactsTextField!.text
        address.telphone = phoneNumberTextField!.text
        address.gender = manButton!.isSelected ? "1" : "2"
        address.city_name = cityTextField!.text
        address.address = areaTextField!.text! + " " + adressTextField!.text!
    }
    
    @objc private func selectedCityTextFieldDidChange(sender: UIBarButtonItem) {
        //print("selectedCityTextFieldDidChange")
        if sender.tag == 11{
            if currentSelectedCityIndex != -1 {
                cityTextField?.text = cityArray![currentSelectedCityIndex]
            }
        }
        cityTextField?.endEditing(true)
    }
    
    @objc private func genderButtonClick(sender: UIButton){
        switch sender.tag {
        case 101:
            manButton?.isSelected = true
            womenButton?.isSelected = false
            break
        case 102:
            manButton?.isSelected = false
            womenButton?.isSelected = true
        default:
            break
        }
    }
    
    @objc private func deleteViewClick(){
        topVC?.addresses?.remove(at: currentAddressRow)
        navigationController?.popViewController(animated: true)
        topVC?.addressTableView?.reloadData()
    }
}

extension EditAdressViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 2{
            if textField.text?.count == 13{
                return false
            }else{
                if textField.text?.count == 3 || textField.text?.count == 8 {
                    textField.text = textField.text! + " "
                }
                return true
            }
        }
        return true
    }
}

extension EditAdressViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityArray?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityArray![row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelectedCityIndex = row
    }
    
}



//
//  QRCodeViewController.swift
//  CLoveFreshBeen
//
//  Created by dd on 2018/12/30.
//  Copyright © 2018年 dd. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{

    private lazy var titleLabel = UILabel()
    private lazy var animationLineView = UIImageView()
    private var captureSession: AVCaptureSession?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = LFBGlobalBackgroundColor
        buildNavigationItem()
        buildInputAVCaptureDevice()
        buildFrameImageView()
        buildTitleLabel()
        buildAnimationLineView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
}

extension QRCodeViewController {
    
    private func buildTitleLabel(){
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.frame = CGRect(x: 0, y: 340, width: ScreenWidth, height: 30)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }
    
    private func buildNavigationItem(){
        navigationItem.title = "店铺二维码"
        navigationController?.navigationBar.barTintColor = LFBNavigationBarWhiteBackgroundColor
    }
    
    private func buildInputAVCaptureDevice(){
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else{return}
        titleLabel.text = "将店铺二维码对准方块内既可收藏店铺"
        let input = try? AVCaptureDeviceInput(device: captureDevice)
        if input == nil {
            titleLabel.text = "没有摄像头你描个蛋啊~换真机试试"
            return
        }
        
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession = AVCaptureSession()
        captureSession?.addInput(input!)
        captureSession?.addOutput(captureMetadataOutput)
        let dispatchQueue = DispatchQueue(label: "myQueue")
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.aztec]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.frame
        view.layer.addSublayer(videoPreviewLayer!)
        captureMetadataOutput.rectOfInterest = CGRect(x: 0, y: 0, width: 1, height: 1)
        captureSession?.startRunning()
    }
    
    private func buildFrameImageView(){
        let lineT = [CGRect(x: 0, y: 0, width: ScreenWidth, height: 100),
                     CGRect(x: 0, y: 100, width: ScreenWidth * 0.2, height: ScreenWidth * 0.6),
                     CGRect(x: 0, y: 100 + ScreenWidth * 0.6, width: ScreenWidth, height: ScreenHeight - 100 - ScreenWidth * 0.6),
                     CGRect(x: ScreenWidth * 0.8, y: 100, width: ScreenWidth * 0.2, height: ScreenWidth * 0.6)]
        for lineTFrame in lineT{
            buildTransparentView(frame: lineTFrame)
        }
        
        let lineR = [CGRect(x: ScreenWidth * 0.2, y: 100, width: ScreenWidth * 0.6, height: 2),
                     CGRect(x: ScreenWidth * 0.2, y: 100, width: 2, height: ScreenWidth * 0.6),
                     CGRect(x: ScreenWidth * 0.8 - 2, y: 100, width: 2, height: ScreenWidth * 0.6),
                     CGRect(x: ScreenWidth * 0.2, y: 100 + ScreenWidth * 0.6, width: ScreenWidth * 0.6, height: 2)]
        for lineFrame in lineR{
            buildLineView(frame: lineFrame)
        }
        
        let yellowHeight: CGFloat = 4
        let yellowWidth: CGFloat = 30
        let yellowX: CGFloat = ScreenWidth * 0.2
        let bottomY: CGFloat = 100 + ScreenWidth * 0.6
        let lineY = [CGRect(x: yellowX, y: 100, width: yellowWidth, height: yellowHeight),
                     CGRect(x: yellowX, y: 100, width: yellowHeight, height: yellowWidth),
                     CGRect(x: ScreenWidth * 0.8 - yellowHeight, y: 100, width: yellowHeight, height: yellowWidth),
                     CGRect(x: ScreenWidth * 0.8 - yellowWidth, y: 100, width: yellowWidth, height: yellowHeight),
                     CGRect(x: yellowX, y: bottomY - yellowHeight + 2, width: yellowWidth, height: yellowHeight),
                     CGRect(x: ScreenWidth * 0.8 - yellowWidth, y: bottomY - yellowHeight + 2, width: yellowWidth, height: yellowHeight),
                     CGRect(x: yellowX, y: bottomY - yellowWidth, width: yellowHeight, height: yellowWidth),
                     CGRect(x: ScreenWidth * 0.8 - yellowHeight, y: bottomY - yellowWidth, width: yellowHeight, height: yellowWidth)]
        for yellowRect in lineY {
            buildYellowLineView(frame: yellowRect)
        }
    }
    
    private func buildTransparentView(frame: CGRect){
        let tView = UIView(frame: frame)
        tView.backgroundColor = UIColor.black
        tView.alpha = 0.5
        view.addSubview(tView)
    }

    private func buildLineView(frame: CGRect){
        let view1 = UIView(frame: frame)
        view1.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        view.addSubview(view1)
    }
    
    private func buildYellowLineView(frame: CGRect){
        let yellowView = UIView(frame: frame)
        yellowView.backgroundColor = LFBNavigationYellowColor
        view.addSubview(yellowView)
    }
    
    private func buildAnimationLineView(){
        animationLineView.image = UIImage(named: "yellowlight")
        view.addSubview(animationLineView)
        timer = Timer(timeInterval: 2.5, target: self, selector: #selector(startYellowViewAnimation), userInfo: nil, repeats: true)
        let runloop = RunLoop.current
        runloop.add(timer!, forMode: RunLoop.Mode.common)
        timer?.fire()
    }
    
    @objc private func startYellowViewAnimation(){
        animationLineView.frame = CGRect(x: ScreenWidth * 0.2 + ScreenWidth * 0.1 * 0.5, y: 100, width: ScreenWidth * 0.5, height: 20)
        UIView.animate(withDuration: 2.5) {
            self.animationLineView.frame.origin.y += ScreenWidth * 0.55
        }
    }
}

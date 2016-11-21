//
//  QRCodeViewController.swift
//  WeiboTT
//
//  Created by 小浩 on 2016/11/19.
//  Copyright © 2016年 小浩. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController,UITabBarDelegate {

    @IBAction func closeBtnClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var CustomTabbar: UITabBar!
    
    @IBOutlet weak var scanView: UIView!
    //冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    //保存扫描结果
    @IBOutlet weak var resultLabel: UILabel!
    //扫描容器高度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    //冲击波视图顶部约束
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    @IBAction func myCodeClick(_ sender: Any) {
        
        let vc = QRMyCodeViewController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置底部视图默认选中第0个
        CustomTabbar.selectedItem = CustomTabbar.items![0]
        CustomTabbar.delegate = self
        
        scanView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //开始冲击波动画
        startAnimation()
        //开始扫描二维码
        startScan()
    }
    
    /**
     扫描二维码
     **/
    private func startScan(){
        //1、判断是否能够将输入添加到绘画中
        if !session.canAddInput(deviceInput) {
            return
        }
        //2、判断是否能够将输出添加到绘画中
        if !session.canAddOutput(output) {
            return
        }
        //3、将输入和输出都添加到设备中
        session.addInput(deviceInput)
        print(output.metadataObjectTypes)
        session.addOutput(output)
        print(output.metadataObjectTypes)
        //4、设置输出能够解析的数据类型,一定要在输出对象添加到会话后才能设置，否则报错
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        //5、设置输出对象的代理，只要解析成功就会通知代理
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        output.rectOfInterest = CGRect(x:0.5,y:0.5,w:0.5,h:0.5)
        //添加预览视图
        view.layer.insertSublayer(previewLayer, at: 0)
//        view.layer.addSublayer(previewLayer)
        // 添加绘制图层到预览图层上
        previewLayer.addSublayer(drawLayer)
        
        //6、告诉session开始扫描
        session.startRunning()
    }
    
    /**
     执行动画
     */
    private func startAnimation()
    {
        // 让约束从顶部开始
        self.scanLineCons.constant = -self.containerHeightCons.constant
        self.scanView.layoutIfNeeded()
        
        // 执行冲击波动画
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
            // 1.修改约束
            self.scanLineCons.constant = self.containerHeightCons.constant
            UIView.setAnimationDuration(2.0);
            // 设置动画指定的次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
//            // 2.强制更新界面
            self.scanView.layoutIfNeeded()
            
        }, completion: { (BOOL) -> Void in
            
        })
        
    }
    
    
    // MARK: - UITabBarDelegate
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // 1.修改容器的高度
        if item.tag == 1{
            //            print("二维码")
            self.containerHeightCons.constant = 300
        }else{
            print("条形码")
            self.containerHeightCons.constant = 150
        }
        
        // 2.停止动画
        self.scanLineView.layer.removeAllAnimations()
        
        // 3.重新开始动画
        startAnimation()
    }
    
    //MARK: - 懒加载
    private lazy var session:AVCaptureSession = AVCaptureSession()
    //拿到输入设备
    private lazy var deviceInput : AVCaptureDeviceInput? = {
        //获取摄像头
        let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        //创建输入对象
        do{
           let input = try AVCaptureDeviceInput(device:device)
            return input
        }catch {
            print(error)
            return nil
        }
    }()
    
    //拿到输出对象
    private lazy var output:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    //创建预览图层
    public lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session:self.session)
        layer?.frame = UIScreen.main.bounds
        return layer!
    }()
    
    // 创建用于绘制边线的图层
    public lazy var drawLayer: CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.main.bounds
        return layer
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QRCodeViewController:AVCaptureMetadataOutputObjectsDelegate
{
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // 0.清空图层
        clearCorners()
        
        print(metadataObjects)
        //获取扫描到的数据
        //主要要使用stringValue
        resultLabel.text = (metadataObjects.last as AnyObject).stringValue
        resultLabel.sizeToFit()
        
        //获取扫描到的二维码的位置
        print(metadataObjects.last)
        //2.1转化坐标
        for object in metadataObjects
        {
            //2.1.1判断当前获取到的数据,是否是机器可识别的类型
            if object is AVMetadataMachineReadableCodeObject
            {
                // 2.1.2将坐标转换界面可识别的坐标
                let codeObject = previewLayer.transformedMetadataObject(for: object as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                // 2.1.3绘制图形
                drawCorners(codeObject: codeObject)
            }
        }
    }
    
    /**
     绘制图形
     :param: codeObject 保存了坐标的对象
     */
    private func drawCorners(codeObject: AVMetadataMachineReadableCodeObject)
    {
        if codeObject.corners.isEmpty {
            return
        }
        //创建一个图层
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeColor = UIColor.red.cgColor
//        layer.fillColor = UIColor.clear.cgColor
        //创建路径
//        layer.path = UIBezierPath()
        let path = UIBezierPath()
        var point = CGPoint.zero
        var index:Int = 0
        //2.1移动到第一个点
//        CGPointMakeWithDictionaryRepresentation((codeObject.corners[index] as! CFDictionary), &point)
        let pointRep = CGPoint.init(dictionaryRepresentation: codeObject.corners[index] as! CFDictionary)
        point = pointRep!
        index = index+1
        path.move(to: point)
        //2.2移动到其他的点
        while  index < codeObject.corners.count {
            let pointRep = CGPoint.init(dictionaryRepresentation: codeObject.corners[index] as! CFDictionary)
            point = pointRep!
            index = index+1
            path.move(to: point)
        }
        //2.3关闭路径
        path.close()
        //2.4回执路径
        layer.path = path.cgPath
        
        //绘制好的图层添加到drawlayer上
        drawLayer.addSublayer(layer)
    }
    
    /**
     清空边线
     **/
    private func clearCorners() {
        //1、判断drawLayer上是否有其他图层
        if drawLayer.sublayers == nil || drawLayer.sublayers?.count == 0{
            return
        }
        //2、移除所有图层
        for subLayer in drawLayer.sublayers! {
            subLayer.removeFromSuperlayer()
        }
    }
}



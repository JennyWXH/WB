//
//  HomeViewController.swift
//  WeiboTT
//
//  Created by 小浩 on 2016/11/14.
//  Copyright © 2016年 小浩. All rights reserved.
//

import UIKit
import AFNetworking

class HomeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1、如果没有登录，就设置未登录的信息
        if !userLogin
        {
            vistorView?.setUpLoginView(isHome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
        }
        
        //2、初始化导航条
        setupNav()
        
        //3、注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(poverWillShow), name: NSNotification.Name(rawValue: PopoverAnimatorWillShow), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(poverWillDismiss), name: NSNotification.Name(rawValue: PopoverAnimatorWillDismiss), object: nil)
    }
    
    func poverWillShow() {
        titleBtn.isSelected = true
    }
    
    func poverWillDismiss() {
        titleBtn.isSelected = false
    }
    
    private func setupNav() {
        //1、左边按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButtonItem(imageName: "navigationbar_friendattention",target:
            self, action:#selector(leftItemClick))
        
        //2、右边按钮
        //command + control + e
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonItem(imageName: "navigationbar_pop",target:
            self, action:#selector(rightItemClick))
        
        //3、初始化标题
        navigationItem.titleView = titleBtn
    }
    
    func titleBtnClick(btn:TitleButton) {
        //修改箭头方向
//        btn.isSelected = !btn.isSelected
        
        //弹出菜单
        let sb = UIStoryboard(name:"PopoverViewController",bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: "222")
        //2.1设置转场代理
        vc.transitioningDelegate = popover
//        self.transition(from: self.tabBarController as! MainViewController, to: vc, duration: 0.5, options: UIViewAnimationOptions.allowAnimatedContent, animations: nil, completion: nil)
        //2.2设置转场的样式
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        present(vc, animated: true, completion: nil)
    }
    
    func leftItemClick() {
        print(#function)
    }
    
    func rightItemClick() {
        let sb = UIStoryboard(name:"QRCodeViewController", bundle:nil)
        let vc = sb.instantiateViewController(withIdentifier: "333")
        present(vc, animated: true, completion: nil)
    }
    
    private lazy var titleBtn:UIButton = {
        let btn = TitleButton()
        btn.setTitle("小浩快跑 ", for: UIControlState())
        btn.addTarget(self, action: #selector(titleBtnClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    //一定要自定义一个属性来作为转场代理，否则会报错
    private lazy var popover:PopoverAnimater = {
        let pop = PopoverAnimater()
        pop.presentFrame = CGRect(x:100,y:56,width:200,height:200)
        return pop
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//extension HomeViewController : 

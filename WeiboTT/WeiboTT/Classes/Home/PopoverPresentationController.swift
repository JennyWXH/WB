//
//  PopoverPresentationController.swift
//  WeiboTT
//
//  Created by 小浩 on 2016/11/18.
//  Copyright © 2016年 小浩. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    //定义属性,保存菜单的大小
    var presentFrame = CGRect.zero
    
    /**
    初始化方法，用于创建负责转场动画的对象
     
     presentedViewController：被展现的控制器
     presenting:发起的控制器
 
     **/
    
    override init(presentedViewController:UIViewController, presenting:UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presenting)
        
    }
    
    //即将布局子视图时调用
    override func containerViewWillLayoutSubviews() {
        //修改弹出视图的大小
//        containerView;//容器视图
//        presentedView;//被展现的视图
        presentedView?.backgroundColor = UIColor.clear
        if presentFrame == CGRect.zero {
            presentedView?.frame = CGRect(x:100,y:56,width:200,height:200)
        }else {
            presentedView?.frame = presentFrame
        }
        presentedView?.clipsToBounds = true
        //在容器里面添加一个蒙版，加入到展现视图的下面
        //因为展现实体和蒙板都在一个视图上，而后添加的会盖住前面的
        containerView?.insertSubview(coverView, at: 0)
    }
    
    //MARK: -懒加载
    private lazy var coverView:UIView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.2)
        view.frame = UIScreen.main.bounds
        
        //添加监听
        let tap = UITapGestureRecognizer(target:self,action:#selector(tapClick))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    func tapClick() {
        //presentedViewController拿到当前弹出的控制器
        presentedViewController.dismiss(animated: true, completion: nil)
    }

}

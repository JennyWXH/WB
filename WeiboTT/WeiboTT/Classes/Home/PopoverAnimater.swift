//
//  PopoverAnimater.swift
//  WeiboTT
//
//  Created by 小浩 on 2016/11/19.
//  Copyright © 2016年 小浩. All rights reserved.
//

import UIKit

//protocol PopoverAnimatorDelegate:NSObjectProtocol {
//    func willPressented();
//    func willDismissed();
//}

let PopoverAnimatorWillShow = "PopoverAnimatorWillShow"
let PopoverAnimatorWillDismiss = "PopoverAnimatorWillDismiss"
class PopoverAnimater: NSObject,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    
    /// 记录当前是否是展开
    var isPresent: Bool = false
    //定义属性,保存菜单的大小
    var presentFrame = CGRect.zero
    //实现代理方法，告诉谁来负责转场动画
    //presentationController ios8推出的专门负责管理转场动画的
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let pc = PopoverPresentationController(presentedViewController:presented, presenting:presenting)
        pc.presentFrame = presentFrame
        return pc
        
    }
    
    //    /**
    //     告诉系统谁来负责modal的展现动画
    //
    //     presente 被展现视图
    //     presenting 发起的视图
    //     returns 谁来负责
    //     **/
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        //发送通知，控制器展开
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PopoverAnimatorWillShow), object: nil)
        return self
    }
    
    /**
     告诉系统谁来负责Modal的消失动画
     
     :param: dismissed 被关闭的视图
     
     :returns: 谁来负责
     */
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        //发送通知，控制器消失
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: PopoverAnimatorWillDismiss), object: nil)
        return self
    }
    
    
    // MARK: - UIViewControllerAnimatedTransitioning
    /**
     返回动画时长
     
     :param: transitionContext 上下文, 里面保存了动画需要的所有参数
     
     :returns: 动画时长
     */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.5
    }
    
    /**
     告诉系统如何动画, 无论是展现还是消失都会调用这个方法
     
     :param: transitionContext 上下文, 里面保存了动画需要的所有参数
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        // 1.拿到展现视图
        /*
         let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
         let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
         // 通过打印发现需要修改的就是toVC上面的View
         print(toVC)
         print(fromVC)
         */
        if isPresent
        {
            // 展开
            print("展开")
            let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            toView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0);
            
            // 注意: 一定要将视图添加到容器上
            transitionContext.containerView.addSubview(toView)
            
            // 设置锚点
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            
            // 2.执行动画
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
                // 2.1清空transform
                toView.transform = CGAffineTransform.identity
            }, completion: { (_) -> Void in
                // 2.2动画执行完毕, 一定要告诉系统
                // 如果不写, 可能导致一些未知错误
                transitionContext.completeTransition(true)
            })
        }else
        {
            // 关闭
            print("关闭")
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { () -> Void in
                // 注意:由于CGFloat是不准确的, 所以如果写0.0会没有动画
                // 压扁
                fromView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.000001)
            }, completion: { (_) -> Void in
                // 如果不写, 可能导致一些未知错误
                transitionContext.completeTransition(true)
            })
        }
    }
}

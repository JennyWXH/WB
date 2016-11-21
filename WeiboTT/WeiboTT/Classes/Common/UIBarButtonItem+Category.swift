//
//  UIBarButtonItem+Category.swift
//  WeiboTT
//
//  Created by 小浩 on 2016/11/18.
//  Copyright © 2016年 小浩. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    //如果在func前面加上class,就相当于oc中的+
    class func createBarButtonItem(imageName:String,target: Any?, action: Selector) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: UIControlState())
        btn.setImage(UIImage(named:imageName + "_highlighted"), for: UIControlState.highlighted)
        btn.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView:btn)
    }
}

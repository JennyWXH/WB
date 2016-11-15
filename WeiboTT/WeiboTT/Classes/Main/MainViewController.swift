//
//  MainViewController.swift
//  WeiboTT
//
//  Created by 小浩 on 2016/11/15.
//  Copyright © 2016年 小浩. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置当前控制器对应的颜色
        //在iOS7之前设置了tintColor只有字体会变
        tabBar.tintColor = UIColor.orange;

        //1、添加首页       
        createViewController(VC: HomeViewController(), titleString: "首页", imageName: "tabbar_home")
        //2、消息
        createViewController(VC: HomeViewController(), titleString: "消息", imageName: "tabbar_message_center")
        //3、发现
        createViewController(VC: HomeViewController(), titleString: "广场", imageName: "tabbar_discover")
        //4、个人
        createViewController(VC: HomeViewController(), titleString: "我", imageName: "tabbar_profile")
        
        
        
    }
    
    private func createViewController(VC:UIViewController,titleString:String,imageName:String) {
        let home = VC
        //1.1设置首页tabbar对应的数据
        home.tabBarItem.image = UIImage(named:imageName)
        home.tabBarItem.selectedImage = UIImage(named:imageName + "highlighted")
        home.title = titleString
        
        //2、添加导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(VC)
        
        //3、将导航控制器添加到当前控制器上
        addChildViewController(nav);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

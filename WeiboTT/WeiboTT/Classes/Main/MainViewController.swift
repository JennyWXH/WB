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
        
//        //获取json文件
//        let dpath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil)
//        //通过文件路径获取NSData
//        if let jsonPath = dpath{
////            let jsonData = NSData(contentsOfFile: dpath!)
//            let jsonData = Data()
//            
////            jsonData.write(to: jsonPath)
//            
//            do{
//                //有可能发生异常的代码放到这里
//                //序列化json数据->array
//                //try:发生异常会调到catch中继续执行
//                //try！：发生异常直接崩溃
//                let dicArr = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers)
//                //遍历数组，动态创建控制器和设置数据
//                //在swift中，如果需要遍历一个数组，必须明确数据的类型,但是字典的返回值是可选类型
//                for dict in dicArr as! [[String:String]]
//                {
//                    //
//                    createViewController(VC: dict["vcName"]!, titleString: dict["title"]!, imageName: dict["imageName"]!)
//                }
//            }catch
//            {
//                //发生异常之后执行的代码
//                print(error)
//            }
//        }
        
        //序列化json数据->NSArray
        //便利数组，动态创建控制器
        
        //添加自控制器
        
//MARK:--  7.0后不建议在viewDidload中加载frame
        
        addChildViewControllers()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //添加加号按钮
        setupCompostBtn()
        
    }
    
    private func setupCompostBtn() {
        //1.添加加号按钮
        tabBar.addSubview(composeBtn)
        //2.调整加号按钮的位置
        let width = UIScreen.main.bounds.size.width / CGFloat(viewControllers!.count)
        let rect = CGRect(x:0,y:0,width:width,height:49)
//        composeBtn.frame = rect;
        composeBtn.frame = rect.offsetBy(dx: 2*width,dy: 0)
        
        
    }
    
    private func addChildViewControllers() {
        //1、添加首页
        createViewController(VC: "HomeViewController", titleString: "首页", imageName: "tabbar_home")
        //2、消息
        createViewController(VC: "MessageViewController", titleString: "消息", imageName: "tabbar_message_center")
        //加号按钮
        createViewController(VC: "NullViewController", titleString: "", imageName: "")
        //3、发现
        createViewController(VC: "DiscoverViewController", titleString: "广场", imageName: "tabbar_discover")
        //4、个人
        createViewController(VC: "ProfileViewController", titleString: "我", imageName: "tabbar_profile")
    }
    
    private func createViewController(VC:String,titleString:String,imageName:String) {
        
        //1、动态获取命名空间
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        print(ns)
        
        //将字符串转换为类
        let cls:AnyClass? = NSClassFromString(ns + "." + VC)
        //通过类转换对象
        //.1 将Anyclass转换为指定的类型
        let vcCls = cls as! UIViewController.Type
        //.2 通过class穿件对象
        let indexVC = vcCls.init()
        
        //1.1设置首页tabbar对应的数据
        indexVC.tabBarItem.image = UIImage(named:imageName)
        indexVC.tabBarItem.selectedImage = UIImage(named:imageName + "highlighted")
        indexVC.title = titleString
        
        //2、添加导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(indexVC)
        
        //3、将导航控制器添加到当前控制器上
        addChildViewController(nav);
    }
    
    func btnClick(button:UIButton)->() {
        print("哈哈");
    }
    
    //MARK: - 懒加载
    private lazy var composeBtn:UIButton = { () -> UIButton in
        let btn = UIButton()
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), for: UIControlState())
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), for: UIControlState.highlighted)
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: UIControlState())
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), for: UIControlState.highlighted)
        btn.addTarget(self, action: #selector(btnClick), for: UIControlEvents.touchUpInside)
        
        return btn
    }()

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

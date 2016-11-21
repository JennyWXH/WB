//
//  BaseTableViewController.swift
//  WeiboTT
//
//  Created by 小浩 on 2016/11/17.
//  Copyright © 2016年 小浩. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController,VistorViewDelegate{
    
    //定义一个变量保存用户是否登录
    var userLogin = false
    //定义属性保存未登录界面
    var vistorView:VistorView?
    override func loadView() {
        
        userLogin ? super.loadView() : setupVistorView()
        
        
    }
    
    func loginBtnWillClick() {
        print(#function)
    }
    func registerBtnWillClick() {
        print(#function)
    }
    
    /*
     创建未登录界面
    */
    private func setupVistorView(){
        //初始哈未登录界面
        let customView = VistorView()
//        customView.backgroundColor = UIColor.red
        customView.delegate = self;
        view = vistorView
        vistorView = customView
        //设置导航条未登录按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"注册", style:UIBarButtonItemStyle.plain,target:self, action:#selector(registerBtnWillClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:"登录", style:UIBarButtonItemStyle.plain,target:self, action:#selector(loginBtnWillClick))
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

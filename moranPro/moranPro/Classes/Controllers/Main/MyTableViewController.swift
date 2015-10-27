//
//  MyTableViewController.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/17.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit
import Alamofire

class MyTableViewController: UITableViewController {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var userNameLab: UILabel!
    @IBOutlet weak var userEmailLab: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headImage.layer.cornerRadius = CGRectGetHeight(self.headImage.bounds) / 2
        headImage.layer.masksToBounds = true;

        
        self.userNameLab.text = UserInfo.UserName!
        self.userEmailLab.text = UserInfo.UserEmail!
        //获取头像
        self.GetNewHeadImage()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "UserNameUpDatting:", name: "updateUserName", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "UserImageUpDatting:", name: "updateUserImage", object: nil)
    }
    
    /**
    初始化获取头像
    */
    func GetNewHeadImage()
    {
        
        let parameters = [
            "user_id":UserInfo.UserID!
        ]
        Alamofire.request(.GET, "http://moran.chinacloudapp.cn/moran/web/user/show", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            if error == nil{
                self.headImage.image = UIImage(data: data!)
            }
        }
        
    }
    
    /**
    通知修改用户名
    
    - parameter val: 监听参数
    */
    func UserNameUpDatting(val:NSNotification)
    {
        let str = val.object as! String
        self.userNameLab.text = str
    }
    
    func UserImageUpDatting(_: NSNotification)
    {
        GetNewHeadImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 3
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 3
//    }
    

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0{
            return 13
        }
        else{
            return 10
        }
    }
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0)
        {
            if(indexPath.row == 2)
            {
                let alert = UIAlertController(title: nil, message: "你确定要注销当前用户么?", preferredStyle:UIAlertControllerStyle.ActionSheet)
                alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil))
                
                alert.addAction(UIAlertAction(title: "注销", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
                    //注销代码
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("user_ID")
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("user_Name")
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("user_Email")
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("user_Token")
                    let mainStoryBoard = UIStoryboard(name: "Login", bundle: nil)
            let main:LoginViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = main
                }))
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        //点击后回复原来的颜色
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
   
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

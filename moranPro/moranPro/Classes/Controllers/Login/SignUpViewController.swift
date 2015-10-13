//
//  SignUpViewController.swift
//  moran
//
//  Created by 李建澎 on 15/10/12.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPwd: UITextField!
    
    @IBOutlet weak var rpPwd: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SignUpUserAction(sender: AnyObject) {

        if(userEmail.text!.isEmpty)
        {
            AlertEx("警告", messageStr: "邮箱没有填写", actionTitle: "好的")
            return
        }
        if(userPwd.text!.isEmpty)
        {
            AlertEx("警告", messageStr: "密码没有填写", actionTitle: "好的")
            return
        }
        
        if(userPwd.text?.characters.count<6 || userPwd.text?.characters.count>20)
        {
            AlertEx("警告", messageStr: "密码密码长度在6-20位之间", actionTitle: "好的")
            return
        }
        if(rpPwd.text!.isEmpty)
        {
            AlertEx("警告", messageStr: "重复密码没有填写", actionTitle: "好的")
            return
        }
        if(userPwd.text != rpPwd.text)
        {
            AlertEx("警告", messageStr: "两次密码不一致", actionTitle: "好的")
            userPwd.text = ""
            rpPwd.text = ""
            return
        }
        
        RequestURL.request("post", url: "http://moran.chinacloudapp.cn/moran/web/user/register",params:"username=\(userEmail.text)&password=\(userPwd.text)&email=\(userEmail.text)&gbid=G2015020201") { (data, response, error) -> Void in
            if(error != nil)
            {
                print(error)
            }
            print(NSString(data: data, encoding: NSUTF8StringEncoding))
            
            //let message = JSON(data: data)
        }
    }

    @IBAction func returnLoginView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AlertEx(titleStr:String,messageStr:String,actionTitle:String)
    {
        let alertView = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: actionTitle, style: .Default, handler: nil)
        alertView.addAction(okAction)
        self.presentViewController(alertView, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

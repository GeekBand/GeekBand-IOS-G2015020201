//
//  LoginViewController.swift
//  moran
//
//  Created by 李建澎 on 15/10/12.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var loginEmail: UITextField!
    
    @IBOutlet weak var loginPwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginEmail.delegate = self
        loginPwd.delegate = self
    }

    @IBAction func LoginAction(sender: AnyObject) {

        if(loginEmail.text!.isEmpty)
        {
            self.noticeError("邮箱没有填写!")
            return
        }
        if(loginPwd.text!.isEmpty)
        {
            self.noticeError("密码不能为空!")
            return
        }
        
        let parameters = [
            "email":"\(loginEmail.text!)",
            "password":"\(loginPwd.text!)"
        ]
        self.pleaseWait()
        
        Alamofire.request(.POST, "http://moran.chinacloudapp.cn/moran/web/user/login", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            if error == nil{
                let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                let message: String = json.objectForKey("message") as! String
                self.clearAllNotice()
                switch message
                {
                case "Login success":
                    let userid:String = json.objectForKey("data")!.objectForKey("user_id") as! String
                    let username:String = json.objectForKey("data")!.objectForKey("user_name") as! String
                    let token:String = json.objectForKey("data")!.objectForKey("token") as! String
                    
                    let useremail = self.loginEmail.text
                    if(userid != "")
                    {
                        UserInfo.UserID = userid
                        NSUserDefaults.standardUserDefaults().setObject(userid, forKey: "user_ID")
                    }
                    if(username != "")
                    {
                        UserInfo.UserName = username
                        NSUserDefaults.standardUserDefaults().setObject(username, forKey: "user_Name")
                    }
                    if(token != "" )
                    {
                        UserInfo.UserToken = token
                        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "user_Token")
                    }
                    if(useremail != "" )
                    {
                        UserInfo.UserEmail = useremail
                        NSUserDefaults.standardUserDefaults().setObject(useremail, forKey: "user_Email")
                    }
                    
                    dispatch_async(dispatch_get_main_queue(),{
                        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                        let main:PlazaViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("PlazaViewController") as! PlazaViewController
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.window?.rootViewController = main
                    })
                case "No such user":
                    self.noticeError("账户不存在!")
                case "Wrong password":
                    self.noticeError("密码不正确!")
                default:self.noticeError("异常!")
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - 键盘遮挡事件
    
    func textFieldDidBeginEditing(textField: UITextField) {
        let frame:CGRect = textField.frame;
        let offset = frame.origin.y + 92 - (self.view.frame.size.height - 216.0);//键盘高度216
        
        let animationDuration:NSTimeInterval = 0.3
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(animationDuration)
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0)
        {
            self.view.frame = CGRectMake(0.0, -offset, self.view.frame.size.width, self.view.frame.size.height)
        }
        UIView.commitAnimations()
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        let animationDuration:NSTimeInterval = 0.3
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(animationDuration)
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        UIView.commitAnimations()
        
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

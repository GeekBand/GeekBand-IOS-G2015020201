//
//  LoginViewController.swift
//  moran
//
//  Created by 李建澎 on 15/10/12.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit

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
            MBProgressHUD.showError("邮箱不能为空")
            return
        }
        if(loginPwd.text!.isEmpty)
        {
            MBProgressHUD.showError("密码不能为空")
            return
        }
        MBProgressHUD.showMessage("登录中...")
        RequestURL.request("post", type: requestType.login,params:"email=\(loginEmail.text!)&password=\(loginPwd.text!)") { (data, response, error) -> Void in
            if(error != nil)
            {
                print(error)
                MBProgressHUD.showError("登录失败")
                return
            }
            print(NSString(data: data, encoding: NSUTF8StringEncoding))
            let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            let message: String = json.objectForKey("message") as! String
            let token:String = json.objectForKey("data")!.objectForKey("token") as! String
            
            if(message == "Login success")
            {
                MBProgressHUD.hideHUD()
                if(token != "" )
                {
                    NSUserDefaults.standardUserDefaults().setObject(token, forKey: "user_info")
                }
                dispatch_async(dispatch_get_main_queue(),{
                    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                    
                    let main:PlazaViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("PlazaViewController") as! PlazaViewController
                    
                    //let maintab = UITabBarController()
                    //maintab.viewControllers = [main]
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    
                    appDelegate.window?.rootViewController = main
                })
            }
            else{
                MBProgressHUD.hideHUD()
                MBProgressHUD.showError("登录失败")
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
        let offset = frame.origin.y + 82 - (self.view.frame.size.height - 216.0);//键盘高度216
        
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

//
//  SignUpViewController.swift
//  moran
//
//  Created by 李建澎 on 15/10/12.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var userEmail: UITextField!
    
    @IBOutlet weak var userPwd: UITextField!
    
    @IBOutlet weak var rpPwd: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userEmail.delegate = self
        userPwd.delegate = self
        rpPwd.delegate = self
    }

    @IBAction func SignUpUserAction(sender: AnyObject) {

        if(userEmail.text!.isEmpty)
        {
            self.noticeError("邮箱没有填写!")
            return
        }
        if(userPwd.text!.isEmpty)
        {
            self.noticeError("密码没有填写!")
            return
        }
        
        if(userPwd.text?.characters.count<6 || userPwd.text?.characters.count>20)
        {
            self.noticeError("密码密码长度在6-20位之间!")
            return
        }
        if(rpPwd.text!.isEmpty)
        {
            self.noticeError("重复密码没有填写!")
            return
        }
        if(userPwd.text != rpPwd.text)
        {
            self.noticeError("两次密码不一致!")
            userPwd.text = ""
            rpPwd.text = ""
            return
        }
        
//        RequestURL.request("post", type: requestType.register,params:"username=\(userEmail.text!)&password=\(userPwd.text!)&email=\(userEmail.text!)&gbid=G2015020201") 
//            if(error != nil)
//            {
//                print(error)
//                return
//            }
//            print(NSString(data: data, encoding: NSUTF8StringEncoding))
//            let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
//            let message: String = json.objectForKey("message") as! String
//            if(message == "Register success")
//            {
//                
//                dispatch_async(dispatch_get_main_queue(),{
//                    self.dismissViewControllerAnimated(true, completion: nil)
//                    MBProgressHUD.showError("注册成功")
//                })
//                
//            }
//            else
//            {
//                dispatch_async(dispatch_get_main_queue(),{
//                MBProgressHUD.showError("注册失败")
//                })
//            }
//            
//        }
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

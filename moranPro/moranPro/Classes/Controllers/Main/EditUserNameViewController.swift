//
//  EditUserNameViewController.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/19.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit
import Alamofire

class EditUserNameViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func EditUserNamaAction(sender: AnyObject) {
        let parameters = [
            "user_id":UserInfo.UserID!,
            "token":UserInfo.UserToken!,
            "new_name":txtUserName.text!
        ]
        self.pleaseWait()
        Alamofire.request(.POST, "http://moran.chinacloudapp.cn/moran/web/user/rename", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            if error == nil{
                let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                let message: String = json.objectForKey("message") as! String
                self.clearAllNotice()
                print(message)
                if message == "Update success"{
                    NSUserDefaults.standardUserDefaults().setObject(self.txtUserName.text, forKey: "user_Name")
                    self.navigationController?.popToRootViewControllerAnimated(true)
                    self.noticeSuccess("修改成功!")
                    NSNotificationCenter.defaultCenter().postNotificationName("updateUserName", object: self.txtUserName.text!)
                    
                }
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

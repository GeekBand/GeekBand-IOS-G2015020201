//
//  HeadViewController.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/17.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit
import Alamofire

class HeadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var selectedHeadImage: UIButton!
    @IBOutlet weak var genghuanImage: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        headImage.layer.cornerRadius = CGRectGetHeight(self.headImage.bounds) / 2
        headImage.layer.masksToBounds = true;

        selectedHeadImage.layer.cornerRadius = 16;
        genghuanImage.layer.cornerRadius = 16

    }
    
    
    //MARK: - 事件
    
    //选择照片
    @IBAction func SelectHeadImageAction(sender: AnyObject) {
        let picker = UIImagePickerController()
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle:UIAlertControllerStyle.ActionSheet)
        alert.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler:nil))
        
        alert.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(picker, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "相册", style: UIAlertActionStyle.Default, handler: {
            (UIAlertAction) -> Void in
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(picker, animated: true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //将图片赋值给头像图片
        headImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //关闭照片选取器
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func genghuanHeadAction(sender: AnyObject) {
        self.pleaseWait() //HUD
        let dataImage:NSData = UIImageJPEGRepresentation(headImage.image!,0.00001)!
        let request = NSMutableURLRequest(URL: NSURL(string: "http://moran.chinacloudapp.cn/moran/web/user/avatar")!)
        request.HTTPMethod = "POST"
        request.timeoutInterval = 10
        let form:BLMultipartForm = BLMultipartForm()
        form.addValue(UserInfo.UserID!, forField: "user_id")
        form.addValue(UserInfo.UserToken!, forField: "token")
        form.addValue(dataImage, forField: "data")
        request.addValue(form.contentType(), forHTTPHeaderField: "Content-Type")
        request.HTTPBody = form.httpBody()
        let session = NSURLSession.sharedSession()
        let task:NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error == nil{
               
                let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                let message: String = json.objectForKey("message") as! String
                self.clearAllNotice() //HUD
                if message == "Update success"{
                    dispatch_async(dispatch_get_main_queue(),{
                    NSNotificationCenter.defaultCenter().postNotificationName("updateUserImage", object: nil)
                    self.dismissViewControllerAnimated(true, completion: nil)
                    self.noticeSuccess("上传成功!")
                    })
                }
                else{
                    dispatch_async(dispatch_get_main_queue(),{
                       self.noticeError("上传失败!")
                    })
                }
            }
        }
        task.resume()
    }

    //取消按钮事件
    @IBAction func CancelAction(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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

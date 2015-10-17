//
//  HeadViewController.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/17.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit

class HeadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var selectedHeadImage: UIButton!
    @IBOutlet weak var genghuanImage: UIButton!
    override func viewDidLoad() {
       
        super.viewDidLoad()
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
        print("获取图片")
        //关闭照片选取器
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    @IBAction func genghuanHeadAction(sender: AnyObject) {
        let userID:String = NSUserDefaults.standardUserDefaults().stringForKey("user_ID")!
        let userToken:String = NSUserDefaults.standardUserDefaults().stringForKey("user_Token")!
        let dataImage:NSData = UIImageJPEGRepresentation(headImage.image!, 0.1)!

        print("userID:\(userID)")
        print("token:\(userToken)")
        RequestURL.requestImage("post", type: requestType.upHeadImage, params:"user_id=\(userID)&token=\(userToken)&data=\(dataImage)") { (data, response, error) -> Void in
            print(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        
        
        
//        let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
//        print(json)

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

//
//  PlazaViewController.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/14.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit

class PlazaViewController: UITabBarController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.tintColor = UIColor(red:233.0/255.0,green:106.0/255.0,blue:52.0/255.0,alpha:1)
        
        let tabitem:[UITabBarItem] = self.tabBar.items!
        tabitem[0].title = "广场"
        tabitem[0].image = UIImage(named: "square")?.imageWithRenderingMode( UIImageRenderingMode.AlwaysOriginal)
        tabitem[0].selectedImage = UIImage(named: "square_selected")?.imageWithRenderingMode( UIImageRenderingMode.AlwaysOriginal)
        
        tabitem[1].title = "我的"
        tabitem[1].image = UIImage(named: "my")?.imageWithRenderingMode( UIImageRenderingMode.AlwaysOriginal)

        tabitem[1].selectedImage = UIImage(named: "my_selected")?.imageWithRenderingMode( UIImageRenderingMode.AlwaysOriginal)

        
                
        
        let width:CGFloat = self.view.frame.size.width;
        let height:CGFloat = self.view.frame.size.height;
        let radius:CGFloat = 22.5;
        let photoButton:UIButton = UIButton(frame: CGRectMake((width/2-radius), height-49-radius, radius*2, radius*2))
        photoButton.layer.cornerRadius = radius;
        photoButton.clipsToBounds = true;
        photoButton.setImage(UIImage(named: "publish"), forState: UIControlState.Normal)
        photoButton.setImage(UIImage(named: "publish_hover"), forState: UIControlState.Highlighted)
        photoButton.addTarget( self, action: Selector("addOrderView"), forControlEvents:UIControlEvents.TouchUpInside )
        
        self.view.addSubview(photoButton)
        
    }
    
    func addOrderView()
    {
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
        //UserImg.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        print("获取图片")
        print(info[UIImagePickerControllerOriginalImage] as? UIImage)
        //关闭照片选取器
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

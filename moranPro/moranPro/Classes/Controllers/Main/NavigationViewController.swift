//
//  NavigationViewController.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/19.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置字体颜色
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        //设置背景颜色
        self.navigationBar.barTintColor = UIColor(red:233.0/255.0,green:106.0/255.0,blue:52.0/255.0,alpha:1)
       // let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.navigationBar.bounds.width, height: self.navigationBar.bounds.height))
        
        
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

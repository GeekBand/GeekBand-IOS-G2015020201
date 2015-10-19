//
//  AppDelegate.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/13.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        UserInfo.UserID = NSUserDefaults.standardUserDefaults().stringForKey("user_ID")
        UserInfo.UserName = NSUserDefaults.standardUserDefaults().stringForKey("user_Name")
        UserInfo.UserEmail = NSUserDefaults.standardUserDefaults().stringForKey("user_Email")
        
        
        
        if(UserInfo.UserID != nil)
        {
            
            Alamofire.request(.GET, "http://moran.chinacloudapp.cn/moran/web/users/\(UserInfo.UserID!)", parameters: nil).response { (request, urlresquest, data, error) -> Void in
                if error == nil{
                    let json : AnyObject! = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    UserInfo.UserToken = json.objectForKey("token") as? String
                    UserInfo.UserName = json.objectForKey("name") as? String
                }
            }
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let main:PlazaViewController = mainStoryBoard.instantiateViewControllerWithIdentifier("PlazaViewController") as! PlazaViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = main
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


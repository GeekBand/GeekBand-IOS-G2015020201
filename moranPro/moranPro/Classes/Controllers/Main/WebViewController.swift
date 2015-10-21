//
//  WebViewController.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/21.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {

        super.viewDidLoad()

        self.webview.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        let url:NSURL = NSURL(string: "http://www.hao123.com")!
        let request:NSURLRequest = NSURLRequest(URL: url)
        self.webview.loadRequest(request)
    }

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

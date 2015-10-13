//
//  RequestURL.swift
//  moran
//
//  Created by 李建澎 on 15/10/12.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit

class RequestURL: NSObject {
    static func request(method: String, url: String, params:String, callback: (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void) {
        let session = NSURLSession.sharedSession()

        var newURL = url
        if method == "get" {
            newURL += "?" + params
        }
        
        let request = NSMutableURLRequest(URL: NSURL(string: newURL)!)
        request.HTTPMethod = method
        
        if method == "post" {
            //request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 5
            request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            callback(data: data, response: response , error: error)
        })
        task.resume()
    }
   }

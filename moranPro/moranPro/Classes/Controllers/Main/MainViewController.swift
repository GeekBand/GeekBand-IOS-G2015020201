//
//  MainViewController.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/13.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UITableViewController {

    var dian:Dictionary<String,JSON>?
    var storarray:Array<Store> = []
    override func viewDidLoad() {
        super.viewDidLoad()

        let parameters = [
            "user_id":UserInfo.UserID!,
            "token":UserInfo.UserToken!,
            "longitude":"121.47794",
            "latitude":"31.22516"
        ]
        Alamofire.request(.GET, "http://moran.chinacloudapp.cn/moran/web/node/list", parameters: parameters).response { (request, urlresquest, data, error) -> Void in
            if error == nil{
                let json = JSON(data: data!)
                let model = json["data"].dictionary
                for value in model!.values{
                    //print(value)
                    let store = Store()
                    store.addr = value["node"]["addr"].string
                    for index in 0..<value["pic"].count{
                        let picarr = PictoreModel()
                        picarr.pic_link = value["pic"][index]["pic_link"].string
                        picarr.node_id = value["pic"][index]["node_id"].string
                        picarr.pic_id = value["pic"][index]["pic_id"].string
                        picarr.user_id = value["pic"][index]["user_id"].string
                        picarr.title = value["pic"][index]["title"].string
                        store.pics.append(picarr)
                    }
                    self.storarray.append(store)
                }
                
            }
            self.tableView.reloadData()
        }
       
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.storarray.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tablecell", forIndexPath: indexPath) as! SquareTableViewCell
        
        
        cell.addreslab.text = self.storarray[indexPath.row].addr
        print(self.storarray[indexPath.row].pics)
        cell.pigarray = self.storarray[indexPath.row].pics
        
        return cell
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

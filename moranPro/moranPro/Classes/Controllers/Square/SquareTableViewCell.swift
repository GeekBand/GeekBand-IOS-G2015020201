//
//  SquareTableViewCell.swift
//  moranPro
//
//  Created by 李建澎 on 15/10/26.
//  Copyright © 2015年 Fish. All rights reserved.
//

import UIKit

class SquareTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    
    @IBOutlet weak var addreslab: UILabel!
    
    @IBOutlet weak var collcell: UICollectionView!
    
    var squareVC:MainViewController = MainViewController()
    
    var pigarray:Array<PictoreModel> = []
  
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! SquareCollectionCell
        
        cell.titlelab.text = self.pigarray[indexPath.row].title
        cell.picimage.sd_setImageWithURL(NSURL(string: self.pigarray[indexPath.row].pic_link!))
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return pigarray.count
    }
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

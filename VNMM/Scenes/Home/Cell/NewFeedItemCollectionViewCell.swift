//
//  NewFeedItemCollectionViewCell.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/23/21.
//

import UIKit

class NewFeedItemCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var view_item: UIView!
    @IBOutlet weak var img_product: UIImageView!
    
    @IBOutlet weak var lbl_time: UILabel!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_price: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    var pos = 0
    var delegate : DetailNewfeedDelegate?
    
    
   
    @IBAction func Action_showDetailPost(_ sender: Any) {
        
        delegate?.showDetailPost(pos: pos)
    }
    
}

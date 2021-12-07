//
//  ProductCategoryTableViewCell.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/22/21.
//

import UIKit

class ProductCategoryTableViewCell: UITableViewCell {
    
    var delegate : DetailNewfeedDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    @IBAction func Action_showListCar(_ sender: Any) {
        
        delegate?.showListCar()
    }
    
    
    @IBAction func Action_showListTech(_ sender: Any) {
    }
    
}

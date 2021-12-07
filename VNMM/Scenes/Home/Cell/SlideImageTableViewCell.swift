//
//  SlideImageTableViewCell.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/22/21.
//

import UIKit
import ImageSlideshow

class SlideImageTableViewCell: UITableViewCell {

    @IBOutlet weak var image_slideShow: ImageSlideshow!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  MyMessageImageTableViewCell.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/09/21.
//

import UIKit

class MyMessageImageTableViewCell: UITableViewCell {

    @IBOutlet weak var img_image1: UIImageView!
    
    @IBOutlet weak var widthImage: NSLayoutConstraint!
    @IBOutlet weak var heightImgage: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

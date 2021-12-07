//
//  MyMessageTextTableViewCell.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/09/21.
//

import UIKit

class MyMessageTextTableViewCell: UITableViewCell {

    @IBOutlet weak var view_my_message: UIView!
    
    @IBOutlet weak var lbl_content_message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

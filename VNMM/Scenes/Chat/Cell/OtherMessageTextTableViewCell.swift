//
//  OtherMessageTextTableViewCell.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/09/21.
//

import UIKit

class OtherMessageTextTableViewCell: UITableViewCell {

    @IBOutlet weak var view_other_message: UIView!
    
    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var lbl_content_message: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}

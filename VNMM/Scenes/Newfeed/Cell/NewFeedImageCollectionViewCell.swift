//
//  NewFeedImageCollectionViewCell.swift
//  Techres-Customer
//
//  Created by lephuhao on 9/4/20.
//  Copyright © 2020 aloapp. All rights reserved.
//

import UIKit
import GSPlayer

protocol NewFeedImageCollectionViewCellDelegate {
    func showImageFullScreen(_ pos: IndexPath)
}
class NewFeedImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var view_more: UIView!
    @IBOutlet weak var lbl_num_more: UILabel!
    
    @IBOutlet weak var lbl_fliter_video: UILabel!
    @IBOutlet weak var image_play_button: UIImageView!
    @IBOutlet weak var videoView: VideoPlayerView!
    
    var delegate: NewFeedImageCollectionViewCellDelegate?
    var pos: IndexPath?
    var isMore = false
    var numMore = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        if isMore {
            view_more.isHidden = false
            lbl_num_more.text = "+\(numMore)"
        } else {
            view_more.isHidden = true
        }
    }

    @IBAction func action_cell(_ sender: Any) {
        delegate?.showImageFullScreen(pos!)
    }
}

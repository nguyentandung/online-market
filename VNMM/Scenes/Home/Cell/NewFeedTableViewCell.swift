//
//  NewFeedTableViewCell.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/23/21.
//

import UIKit
 

class NewFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var col_newFeed: UICollectionView!
    
    var listNewfeed = [NewFeed]()
    
    var delegate : DetailNewfeedDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        col_newFeed.register(UINib(nibName: "NewFeedItemTableViewCell", bundle: nil), forCellWithReuseIdentifier: "NewFeedItemCollectionViewCell")
        col_newFeed.isScrollEnabled = false
        col_newFeed.delegate = self
        col_newFeed.dataSource = self
        
    }


}

extension NewFeedTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listNewfeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewFeedItemCollectionViewCell", for: indexPath) as!
            NewFeedItemCollectionViewCell
        
        let item = listNewfeed[indexPath.row]
        
        cell.delegate = self.delegate
        cell.pos = indexPath.row
        
        if item.images.count > 0 {
            if item.images[0].count == 0 {
                cell.img_product.image = UIImage(named: "")
            }else{
//                cell.img_product.loadImage(urlString: item.images[0])
                cell.img_product.kf.setImage(with: URL(string: item.images[0]))
            }
        }
        
        cell.lbl_title.text = item.title
        
        cell.lbl_price.text = Utils.stringVietnameseMoneyFormatWithNumberInt(amount: item.price)
        cell.lbl_address.text = item.address
        cell.lbl_time.text = item.dateUpload
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (col_newFeed.bounds.width - 4)/2, height: 300)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

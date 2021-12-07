//
//  ListCarViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/04/21.
//

import UIKit
import ObjectMapper

class ListCarViewController: UIViewController, NavigationControllerCustomDelegate {

    @IBOutlet weak var collectionview_ListCar: UICollectionView!
    
    var listNewfeed = [NewFeed]()
    var page = 1
    var limit = 100
    var typeCar = POST_TYPE.CAR.rawValue
    
    var prioritize_type = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionview_ListCar.register(UINib(nibName: "NewFeedItemTableViewCell", bundle: nil), forCellWithReuseIdentifier: "NewFeedItemCollectionViewCell")
        
        collectionview_ListCar.delegate = self
        collectionview_ListCar.dataSource = self
        
        getNewfeed()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        navigationController?.navigationBar.backgroundColor = ColorUtils.backgroundAppColor()
        
    }

    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func getNewfeed(){
        
        ResAPI.sharedInstance.getNewFeed(page: self.page, limit: self.limit,type:self.typeCar,prioritize_type:self.prioritize_type,{ (data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<NewFeedResponse>().map(JSONObject: response.data) {
                            self.listNewfeed = DataResponse.list
                            self.collectionview_ListCar.reloadData()
                        }
                       
                    } else {
                        let alert = UIAlertController(title:LOAD_FAIL , message: response.message, preferredStyle:.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    JHProgressHUD.sharedHUD.hide()
                }
                else {
                    Toast.show(message: "Thử lại", controller: self)
                    
                }
    
            })
        }
    
    
    
    
}

extension ListCarViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listNewfeed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewFeedItemCollectionViewCell", for: indexPath) as!
            NewFeedItemCollectionViewCell
        
        let item = listNewfeed[indexPath.row]
        
        cell.delegate = self
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
        
        
//        cell.view_item.layer.shadowOpacity = 0.9
//        cell.view_item.layer.masksToBounds = false
//        cell.view_item.layer.shadowRadius = 2
//        cell.view_item.layer.shadowColor = UIColor.lightGray.cgColor
//        cell.view_item.layer.shadowOffset = .zero
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionview_ListCar.bounds.width, height: 400)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension ListCarViewController : DetailNewfeedDelegate {
    func showDetailPost(pos: Int) {
        let vc : DetailTransportViewController?
        vc = UIStoryboard.detailTransportViewController()
        vc!.newfeed = self.listNewfeed[pos]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func showListCar() {
        
    }
    
    func showListTech() {
        
    }
    
}

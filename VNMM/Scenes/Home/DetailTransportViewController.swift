//
//  DetailTransportViewController.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/24/21.
//

import UIKit
import ObjectMapper
import MediaPlayer
import SKPhotoBrowser

import Alamofire
import Kingfisher
import AVKit



class DetailTransportViewController: UIViewController, NavigationControllerCustomDelegate {
    
    @IBOutlet weak var collectionImageDetailPost: UICollectionView!
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    
    @IBOutlet weak var img_avatar: UIImageView!
    
    @IBOutlet weak var labelUserName: UILabel!
    
    @IBOutlet weak var labelPostCount: UILabel!
    
    @IBOutlet weak var labelContent: UILabel!
    
    @IBOutlet weak var lbl_propety1: UILabel!
    @IBOutlet weak var lbl_propety2: UILabel!
    @IBOutlet weak var lbl_propety3: UILabel!
    @IBOutlet weak var lbl_propety4: UILabel!
    @IBOutlet weak var lbl_propety5: UILabel!
    @IBOutlet weak var lbl_propety6: UILabel!
    @IBOutlet weak var lbl_propety7: UILabel!
   
    
    @IBOutlet weak var lbl_detail_propety1: UILabel!
    @IBOutlet weak var lbl_detail_propety2: UILabel!
    @IBOutlet weak var lbl_detail_propety3: UILabel!
    @IBOutlet weak var lbl_detail_propety4: UILabel!
    @IBOutlet weak var lbl_detail_propety5: UILabel!
    @IBOutlet weak var lbl_detail_propety6: UILabel!
    @IBOutlet weak var lbl_detail_propety7: UILabel!
   
    
    @IBOutlet weak var btn_chat: UIButton!
    
    @IBOutlet weak var labelPhone: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    
    @IBOutlet weak var btn_changestatus: UIButton!
    @IBOutlet weak var labelStatus: UILabel!
    var listImage = [String]()
    var type : POST_TYPE = POST_TYPE.CAR
    
    var alertController: UIAlertController?
    
    var newfeed = NewFeed()
    
//    var photos = [MediaGitHub]()
//    var thumbs = [MediaGitHub]()
    
    var photos = [MediaGitHub]()
    var avatarPhotos = MediaGitHub()
    var thumbs = [MediaGitHub]()
    
    
    @IBOutlet weak var scollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        checkDataWithType()
        collectionImageDetailPost.isScrollEnabled = true
        
        if self.newfeed.user_id == ManageCacheObject.getCurrentAccount()._id {
            self.btn_chat.isHidden = true
            self.btn_changestatus.isHidden = false
        }else{
            self.btn_chat.isHidden = false
            self.btn_changestatus.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        
    }

    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getData() {
        self.labelTitle.text = self.newfeed.title
        self.labelPrice.text = Utils.stringVietnameseMoneyFormatWithNumberInt(amount: self.newfeed.price) + "đ"
       
        self.labelTime.text = self.newfeed.dateUpload
        self.labelUserName.text = self.newfeed.first_name + " " + self.newfeed.last_name
        self.labelContent.text = self.newfeed.content
        self.labelPhone.text = self.newfeed.phone
        self.labelAddress.text = self.newfeed.address
        
        if self.newfeed.statusbought == 0 {
            self.labelStatus.text = "Chưa bán"
            self.btn_changestatus.isUserInteractionEnabled = true
        }else {
            self.labelStatus.text = "Đã bán"
            self.btn_changestatus.isUserInteractionEnabled = false
        }
        
        self.collectionImageDetailPost.reloadData()
    }
    
    func checkDataWithType() {
        
        switch self.newfeed.type {
        case POST_TYPE.CAR.rawValue:
            
            
            self.lbl_propety1.text = "Hãng:"
            self.lbl_propety2.text = "Tên xe:"
            self.lbl_propety3.text = "Nơi sản xuất:"
            self.lbl_propety4.text = "Số Km đã đi:"
            self.lbl_propety5.text = "Tình trạng:"
            self.lbl_propety6.text = "Nhiên liệu:"
            self.lbl_propety7.text = "Sức chứa:"
            
            self.lbl_detail_propety1.text = self.newfeed.details.brand
            self.lbl_detail_propety2.text = self.newfeed.details.model
            self.lbl_detail_propety3.text = self.newfeed.details.production_location
            self.lbl_detail_propety4.text =  String(format: "%d", self.newfeed.details.km_used)
            self.lbl_detail_propety5.text = self.newfeed.details.status
            self.lbl_detail_propety6.text = self.newfeed.details.fuel
            self.lbl_detail_propety7.text = self.newfeed.details.capacity
            
            
        case POST_TYPE.MOTOCYCLE.rawValue:
            
            self.lbl_propety1.text = "Hãng:"
            self.lbl_propety2.text = "Tên xe:"
            self.lbl_propety3.text = "Nơi sản xuất:"
            self.lbl_propety4.text = "Số Km đã đi:"
            self.lbl_propety5.text = "Tình trạng:"
            self.lbl_propety6.text = "Nhiên liệu:"
            self.lbl_propety7.text = "Dung tích xe:"
            
            self.lbl_detail_propety1.text = self.newfeed.details.brand
            self.lbl_detail_propety2.text = self.newfeed.details.model
            self.lbl_detail_propety3.text = self.newfeed.details.production_location
            self.lbl_detail_propety4.text =  String(format: "%d", self.newfeed.details.km_used)
            self.lbl_detail_propety5.text = self.newfeed.details.status
            self.lbl_detail_propety6.text = self.newfeed.details.fuel
            self.lbl_detail_propety7.text = self.newfeed.details.capacity
            
        case POST_TYPE.LAPTOP.rawValue:
            self.lbl_propety1.text = "Hãng:"
            self.lbl_propety2.text = "Dòng máy:"
            self.lbl_propety3.text = "Nơi sản xuất:"
            self.lbl_propety4.text = "Màn hình:"
            self.lbl_propety5.text = "Tình trạng:"
            self.lbl_propety6.text = "Màu sắc:"
            self.lbl_propety7.text = "RAM:"
            
            self.lbl_detail_propety1.text = self.newfeed.details.brand
            self.lbl_detail_propety2.text = self.newfeed.details.model
            self.lbl_detail_propety3.text = self.newfeed.details.production_location
            self.lbl_detail_propety4.text = self.newfeed.details.fuel
            self.lbl_detail_propety5.text = self.newfeed.details.status
            self.lbl_detail_propety6.text = self.newfeed.details.color
            self.lbl_detail_propety7.text = self.newfeed.details.capacity
            
            
        case POST_TYPE.PHONE.rawValue:
            self.lbl_propety1.text = "Hãng:"
            self.lbl_propety2.text = "Dòng máy:"
            self.lbl_propety3.text = "Nơi sản xuất:"
            self.lbl_propety4.text = "Màn hình:"
            self.lbl_propety5.text = "Tình trạng:"
            self.lbl_propety6.text = "Màu sắc:"
            self.lbl_propety7.text = "Dung lượng:"
            
            self.lbl_detail_propety1.text = self.newfeed.details.brand
            self.lbl_detail_propety2.text = self.newfeed.details.model
            self.lbl_detail_propety3.text = self.newfeed.details.production_location
            self.lbl_detail_propety4.text = self.newfeed.details.fuel
            self.lbl_detail_propety5.text = self.newfeed.details.status
            self.lbl_detail_propety6.text = self.newfeed.details.color
            self.lbl_detail_propety7.text = self.newfeed.details.capacity
            
        default:
            break
        }
        
    }
    
    func confirmbought(){
        
        ResAPI.sharedInstance.confirmbought(_id:self.newfeed._id, { (data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        self.labelStatus.text = "Đã bán"
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
    
    
    
    @IBAction func btn_changestatus(_ sender: Any) {
        
        alertController = UIAlertController()
        
        let saveAction = UIAlertAction(title: "Xác nhận đã bán", style: .default) { [self](action) in

            self.confirmbought()
        }
        let cancelAction = UIAlertAction(title: "Huỷ", style: .cancel) {(action) in
            dLog("cancel")
        }

        alertController?.addAction(saveAction)

        alertController?.addAction(cancelAction)
        self.present(alertController!, animated: true)

    }
    
    @IBAction func Action_showProfile(_ sender: Any) {
        
        let vc : AccountViewController?
        vc = UIStoryboard.accountViewController()
        vc!._idUser = self.newfeed.user_id
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    @IBAction func btn_gotoChat(_ sender: Any) {
        
        let vc : ChatTwoUserViewController?
        vc = UIStoryboard.chatTwoUserViewController()
        vc!.OtherMemberId = self.newfeed.user_id
        vc!.OtherMemberName = self.newfeed.first_name +  self.newfeed.last_name 
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func displayimageFullScreen(){
        photos.removeAll()
        for item in self.newfeed.images {
            
            photos.removeAll()
            
            let photo = MediaGitHub(url: URL(string:item)!)
           
            photos.append(photo)
            thumbs.append(photo)
            print("Dungadadad")
            print("\(item)")
        }
        
        
        
        let displayActionButton = false
        let displaySelectionButtons = false
        let displayMediaNavigationArrows = false
        let enableGrid = true
        let startOnGrid = false
        let autoPlayOnAppear = true
        
        let browser = MediaBrowser(delegate: self)
        browser.displayActionButton = displayActionButton
        browser.displayMediaNavigationArrows = displayMediaNavigationArrows
        browser.displaySelectionButtons = displaySelectionButtons
        browser.alwaysShowControls = displaySelectionButtons
        browser.zoomPhotosToFill = true
        browser.enableGrid = enableGrid
        browser.startOnGrid = startOnGrid
        browser.enableSwipeToDismiss = true
        browser.autoPlayOnAppear = autoPlayOnAppear
        browser.cachingImageCount = 2
       
        
        let nc = UINavigationController.init(rootViewController: browser)
        nc.modalTransitionStyle = .crossDissolve
        nc.modalPresentationStyle = .overFullScreen
        self.present(nc, animated: true, completion: nil)
        
    }
    
}

extension DetailTransportViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newfeed.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.img_post.loadImage(urlString: self.newfeed.images[indexPath.row])
        cell.img_post.kf.setImage(with: URL(string: self.newfeed.images[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.displayimageFullScreen()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    
}

extension DetailTransportViewController: MediaBrowserDelegate {
    func thumbnail(for mediaBrowser: MediaBrowser, at index: Int) -> MediaGitHub {
        return thumbs[index]
    }
    
    func media(for mediaBrowser: MediaBrowser, at index: Int) -> MediaGitHub {
        return photos[index]
    }
    
    func numberOfMedia(in mediaBrowser: MediaBrowser) -> Int {
        return photos.count
    }
    
    func isMediaSelected(at index: Int, in mediaBrowser: MediaBrowser) -> Bool {
        return false
    }
    
    func didDisplayMedia(at index: Int, in mediaBrowser: MediaBrowser) {
        dLog("Did start viewing photo at index \(index)")
      

    }
    
    func mediaDid(selected: Bool, at index: Int, in mediaBrowser: MediaBrowser) {

    }


}


class ImageCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet weak var img_post: UIImageView!
}

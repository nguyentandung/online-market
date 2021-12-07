//
//  CreateTransportViewController.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/24/21.
//



import UIKit
import Alamofire

import ObjectMapper
import SKPhotoBrowser
import Kingfisher
import DKImagePickerController
import DropDown
import Loaf

import YPImagePicker
import AVKit
import VIMediaCache
import Photos
import GSPlayer

//post bai cong nghe

class CreateTransportViewController: UIViewController, NavigationControllerCustomDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var col_image: UICollectionView!
    
    @IBOutlet weak var col_video: UICollectionView!
    @IBOutlet weak var txt_content: UITextView!
    
    @IBOutlet weak var txt_title: UITextView!
    
    @IBOutlet weak var constraint_height_collection_view_image: NSLayoutConstraint!
    @IBOutlet weak var constraint_height_collection_view_video: NSLayoutConstraint!
    
    
    @IBOutlet weak var height_view_information: NSLayoutConstraint!
    
    @IBOutlet weak var view_infomation: UIView!
    
    @IBOutlet weak var tf_phone: UITextField!
    
    @IBOutlet weak var tf_price: UITextField!
    @IBOutlet weak var tf_address: UITextField!
    
    @IBOutlet weak var lbl_propety1: UILabel!
    @IBOutlet weak var lbl_propety2: UILabel!
    @IBOutlet weak var lbl_propety3: UILabel!
    @IBOutlet weak var lbl_propety4: UILabel!
    @IBOutlet weak var lbl_propety5: UILabel!
    @IBOutlet weak var lbl_propety6: UILabel!
    @IBOutlet weak var lbl_propety7: UILabel!
    @IBOutlet weak var lbl_propety8: UILabel!
    
    @IBOutlet weak var view_camera: UIView!
    
    @IBOutlet weak var view_video: UIView!
    
    @IBOutlet weak var tf_brand: UITextField!
    
    @IBOutlet weak var tf_model: UITextField!
    
    @IBOutlet weak var tf_product_location: UITextField!
    
    
    @IBOutlet weak var tf_km_used: UITextField!
    
    @IBOutlet weak var tf_status_product: UITextField!
    
    @IBOutlet weak var tf_fuel: UITextField!
    
    @IBOutlet weak var tf_color: UITextField!
    @IBOutlet weak var tf_capacity: UITextField!
    var selectedAssets = [UIImage]()
    
    var videoUploadCount = 0
    var imageUploadCount = 0
    var image_urls = [String]()
    
    var thumbVideos = [UIImage]()
    var videoUrls = [URL]()
    var videoAbsoluteUrls = [String]()
    var hasAlreadyCreated = false
    
    let resourceLoaderManager = VIResourceLoaderManager()
    let player = AVPlayer()
    
    var typePost = 0
    var fileName = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        txt_content.placeholder = "Nhập nội dung "
        txt_content.delegate = self
        
        txt_title.placeholder = "Nhập tiêu đề "
        txt_title.delegate = self
        
        tf_phone.delegate = self
        tf_address.delegate = self
        tf_price.delegate = self

        self.constraint_height_collection_view_video.constant = 0
        self.constraint_height_collection_view_image.constant = 0

        col_image.register(UINib(nibName: "NewFeedImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewFeedImageCollectionViewCell")
        
//        view_infomation.isHidden = true
//        height_view_information.constant = 0
        
        customViewGalerry()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Đăng tin công nghệ")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        navigationController?.navigationBar.backgroundColor = ColorUtils.backgroundAppColor()
        
    }

    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func customViewGalerry() {
        
        self.view_camera.layer.shadowOpacity = 0.9
        self.view_camera.layer.masksToBounds = false
        self.view_camera.layer.shadowRadius = 2
        self.view_camera.layer.shadowColor = UIColor.lightGray.cgColor
        self.view_camera.layer.shadowOffset = .zero
        
        self.view_video.layer.shadowOpacity = 0.9
        self.view_video.layer.masksToBounds = false
        self.view_video.layer.shadowRadius = 2
        self.view_video.layer.shadowColor = UIColor.lightGray.cgColor
        self.view_video.layer.shadowOffset = .zero
        
        self.txt_title.layer.shadowOpacity = 0.9
        self.txt_title.layer.masksToBounds = false
        self.txt_title.layer.shadowRadius = 2
        self.txt_title.layer.shadowColor = UIColor.lightGray.cgColor
        self.txt_title.layer.shadowOffset = .zero
        
        self.txt_content.layer.shadowOpacity = 0.9
        self.txt_content.layer.masksToBounds = false
        self.txt_content.layer.shadowRadius = 2
        self.txt_content.layer.shadowColor = UIColor.lightGray.cgColor
        self.txt_content.layer.shadowOffset = .zero
        
        
    }
    
    
    @IBAction func Action_post(_ sender: Any) {
        
        if txt_content.text.trimmingCharacters(in: .whitespaces).isEmpty
          {
          Loaf("Bạn chưa nhập nội dung", state: .warning, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
          return
      }
      
      if(!selectedAssets.isEmpty) {
          for item in self.selectedAssets {
              let parameters = [String:AnyObject]()
              let imageData: Data = item.jpegData(compressionQuality: 0.5)!
              let result = Utils.randomString(length: 15)
              let file_name = String(format: "%@.%@", result,"jpg")
             
            self.uploadPhotoToServer(parameters: parameters, filename: file_name, imageData: imageData)
           
          }
      }
      
      if selectedAssets.count == 0 {
          createPost()
      }

  }
    
    @IBAction func Action_setInformation(_ sender: Any) {
        
    }
    
    @IBAction func Action_chooseimage(_ sender: Any) {
        let pickerController = DKImagePickerController()
        pickerController.maxSelectableCount = 30
        pickerController.allowMultipleTypes = false
        pickerController.assetType = .allPhotos

        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            var images: [UIImage] = []
            let group = DispatchGroup()
            for item in assets {
                group.enter()
                item.fetchOriginalImage(completeBlock: {image, _ in
                    images.append(image!)
                    group.leave()
  
                })
            }
            group.notify(queue: .main) {
                self.selectedAssets = images
                switch self.selectedAssets.count {
                case 0:
                    self.constraint_height_collection_view_image.constant = 0
                    break
                default:
                    self.constraint_height_collection_view_image.constant = 380
                }
                DispatchQueue.main.async { [weak self] in
                    self!.col_image.reloadData()
                }
            }
        }
        
        self.present(pickerController, animated: true) {}
    }
    
    
    @IBAction func Action_chooseType(_ sender: Any) {
       

    }
    
    
    @IBAction func Action_chooseVideo(_ sender: Any) {
        
        if videoUrls.count > 0 {
            Loaf("Vui lòng chỉ chọn 1 video", state: .warning, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
        }
        else {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .savedPhotosAlbum
            imagePickerController.mediaTypes = ["public.movie"]
            imagePickerController.allowsEditing = false
            print(imagePickerController.mediaTypes)
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    
    func createPost() {
        let newfeedToPost: CarPostNewfeed = CarPostNewfeed()
        newfeedToPost.title = txt_title.text
        newfeedToPost.content = txt_content.text
        newfeedToPost.price = Int(self.tf_price.text!) ?? 100000
        newfeedToPost.phone_number = self.tf_phone.text!
        newfeedToPost.address = self.tf_address.text!
        newfeedToPost.type = self.typePost
        
        
        newfeedToPost.details.brand = self.tf_brand.text!
        newfeedToPost.details.model = self.tf_model.text!
        newfeedToPost.details.production_location = self.tf_product_location.text!
        newfeedToPost.details.km_used = Int(self.tf_km_used.text!) ?? 100
        newfeedToPost.details.status = self.tf_status_product.text!
        newfeedToPost.details.fuel = self.tf_fuel.text!
        newfeedToPost.details.capacity = self.tf_capacity.text!
        newfeedToPost.details.color = self.tf_color.text!
       
        
        for item in image_urls {
            newfeedToPost.images.append(item)
        }
        
        ResAPI.sharedInstance.postNewfeed(postObject: newfeedToPost, { (data, Message) -> Void in
            if(data != nil) {
                let response:ResResponse = data as! ResResponse
                if response.code == 200 {
                   
                    debugPrint("Post Successs")
                    
                    self.hasAlreadyCreated = true
                    self.dismiss(animated: true, completion: nil)
                    JHProgressHUD.sharedHUD.hide()
                    
                    let vc : MainViewController?
                    vc = UIStoryboard.mainViewController()
                    self.navigationController?.pushViewController(vc!, animated: true)
                    
                 

                }
                else {
                    let alert = UIAlertController(title:LOAD_FAIL , message: response.message! + "\(response.data!)", preferredStyle:.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                JHProgressHUD.sharedHUD.hide()
            }
            else {
                Toast.show(message: "Thử lại", controller: self)
            }
            JHProgressHUD.sharedHUD.hide()
        })
        
    }
    
    
    func getLink(fileName: String) {
        
        ResAPI.sharedInstance.getLinkImage(file_name: fileName, ({ (data, Message) -> Void in
            if(data != nil) {
                let response:ResResponse = data as! ResResponse
                if response.code == 200 {
                    let linkurl = DEFAULT_MAIN_DOMAIN + "/" + (response.data as! String)
                    self.image_urls.append(linkurl)
                    self.createPost()

                }
                else {
                    let alert = UIAlertController(title:LOAD_FAIL , message: response.message, preferredStyle:.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                JHProgressHUD.sharedHUD.hide()
            }
            else {
                Toast.show(message: "Thử lại", controller: self)
            }
            JHProgressHUD.sharedHUD.hide()
        }))
    }
    
    
    
    func uploadPhotoToServer( parameters: Dictionary<String, AnyObject>, filename:String, imageData: Data?) {
        
        var url = ""
        url = DEFAULT_MAIN_DOMAIN + String(format: API_UPLOAD_LINKIMAGE)

        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data",
            "Authorization":"\(ManageCacheObject.getCurrentAccount().accessToken)"
        ]
        
        let successHandler: ((DataResponse<Any>) -> Void)? = {res in
            

            debugPrint("Upload thanh cong")
            self.getLink(fileName: filename)
        }
        
        let errorHandler: ((Error) -> Void)? = {err in
            print("\(err)")
        }
        
        let progressHandler: ((Double) -> Void)? = {err in
            
        }
        
        VideoUploadClient.uploadWithData(serverUrl: URL(string: url)!, headers: headers, fileData: imageData!, filename: filename, withName: "send_file", progressing: progressHandler, success: successHandler, failure: errorHandler)
    }
    

    
}

extension CreateTransportViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return selectedAssets.count > 5 ? 5 : selectedAssets.count
        case 2:
            return thumbVideos.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView.tag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewFeedImageCollectionViewCell", for: indexPath) as! NewFeedImageCollectionViewCell
            cell.img.image = selectedAssets[indexPath.row]
            
            cell.pos = indexPath
            cell.delegate = self
            
            cell.lbl_fliter_video.isHidden = true
            cell.videoView.isHidden = true
            cell.image_play_button.isHidden = true
            
            if indexPath.row == 4 && selectedAssets.count > 5 {
                cell.isMore = true
                cell.numMore = selectedAssets.count - 4
            } else {
                cell.isMore = false
            }
            
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCollectionViewCell", for: indexPath) as! VideoCollectionViewCell
            
            cell.image_thumb.image = thumbVideos[indexPath.row]
//
//            cell.lbl_filterBlack.clipsToBounds = true
//            cell.lbl_filterBlack.layer.cornerRadius = 15
            cell.pos = indexPath.row
            cell.url = videoUrls[indexPath.row]
            cell.delegate = self
            
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView.tag {
        case 1:
            let collectionViewSize = collectionView.frame
            switch selectedAssets.count {
            case 0:
                return CGSize(width: 0, height: 0)
            case 1:
                return CGSize(width: collectionViewSize.width, height: collectionViewSize.height)
                
            case 2:
                return CGSize(width: (collectionViewSize.width - 1)/2, height: collectionViewSize.height)
            
            case 3:
                switch indexPath.row {
                case 0:
                    return CGSize(width: collectionViewSize.width, height: (collectionViewSize.height - 1)/2)
                default:
                    return CGSize(width: (collectionViewSize.width - 1)/2, height: (collectionViewSize.height - 1)/2)
                }
                
            case 4:
                return CGSize(width: (collectionViewSize.width - 1)/2, height: (collectionViewSize.height - 1)/2)
                 
            case 5:
                switch indexPath.row {
                case 0, 1:
                    return CGSize(width: (collectionViewSize.width - 1)/2, height: (collectionViewSize.height - 1)/2)
                default:
                    return CGSize(width: (collectionViewSize.width - 3)/3, height: (collectionViewSize.height - 1)/2)
                }
                
            default:
                switch indexPath.row {
                case 0, 1:
                    return CGSize(width: (collectionViewSize.width - 1)/2, height: (collectionViewSize.height - 1)/2)
                default:
                    return CGSize(width: (collectionViewSize.width - 3)/3, height: (collectionViewSize.height - 1)/2)
                }
            }
        case 2:
            return CGSize(width: col_video.frame.width, height: 300)
        default:
            return CGSize(width: 100, height: 100)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 1:
            return 1
        case 2:
            return 5
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView.tag {
        case 1:
            return 1
        case 2:
            return 5
        default:
            return 0
        }
    }
}


extension CreateTransportViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if(txt_content.text != "") {
            txt_content.placeholder = ""
        }
        else {
            txt_content.placeholder = "Nhập nội dung bài đăng"
        }
        if(txt_title.text != ""){
            txt_title.placeholder = ""
        }else{
            txt_title.placeholder = "Nhập tiêu đề bài viết"
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

    }
}

extension CreateTransportViewController: NewFeedImageCollectionViewCellDelegate {
    func showImageFullScreen(_ pos: IndexPath) {
        // 1. create URL Array
        let images: [SKPhoto] = selectedAssets.map(){item -> SKPhoto in
            let photo: SKPhoto = SKPhoto.photoWithImage(item)
            photo.shouldCachePhotoURLImage = false
            return photo
        }

        // 2. create PhotoBrowser Instance, and present.
        let browser = SKPhotoBrowser(photos: images)
        browser.initializePageIndex(pos.row)
        present(browser, animated: true, completion: {})
    }
    
}



extension CreateTransportViewController : VideoCollectionViewCellDelegate {
    func showVideoFullScreen(videoLink:URL) {
        
        resourceLoaderManager.cleanCache()
        let player = AVPlayer(url: videoLink)


        player.pause()
        
        let controller = AVPlayerViewController()
        controller.player = player //AVPlayer object
        controller.showsPlaybackControls = true
        
        controller.view.frame = self.view.frame
        
        NotificationCenter.default.addObserver(self, selector: #selector(avPlayerClosed), name: Notification.Name("avPlayerDidDismiss"), object: nil)
        view.window?.rootViewController?.present(controller, animated: true) {
            DispatchQueue.main.async {
                player.play()
            }
        }
    }
    
    func removeVideo(pos: Int) {
        
        self.thumbVideos.remove(at: pos)
        self.videoUrls.remove(at: pos)

        if thumbVideos.count > 0 {
            self.constraint_height_collection_view_video.constant = 150
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
        else {
            self.constraint_height_collection_view_video.constant = 0
        }
        self.col_video.reloadData()
    }
    
    @objc func avPlayerClosed(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.player.pause()
        }
    }
}

extension CreateTransportViewController : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print("videoURL:\(String(describing: info[UIImagePickerController.InfoKey.mediaURL] as? URL))")
        self.dismiss(animated: true, completion: nil)
        
        let url = info[UIImagePickerController.InfoKey.mediaURL] as! URL
        self.thumbVideos.append(Helper.generateThumbnail(path: url)!)
        self.videoUrls.append(url)
        if thumbVideos.count > 0 {
            self.constraint_height_collection_view_video.constant = 150
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
        else {
            self.constraint_height_collection_view_video.constant = 0
        }
        self.col_video.reloadData()
    }
    
    
}


extension CreateTransportViewController : UITextFieldDelegate {
    
}


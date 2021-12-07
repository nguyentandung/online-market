//
//  ChangeAvatarViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/18/21.
//

import UIKit
import CropViewController
import YPImagePicker
import Loaf
import Alamofire

class ChangeAvatarViewController: UIViewController, NavigationControllerCustomDelegate {
    
    
    
    @IBOutlet weak var img_avatar: UIImageView!
    
    var image = UIImage()
    
    var delegate : AccountDelegaete?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Đổi ảnh đại diện")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        
    }

    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }

 
    @IBAction func Action_chooseImage(_ sender: Any) {
        
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.options = nil
        config.library.onlySquare = true
        config.library.isSquareByDefault = true
        config.library.minWidthForItem = nil
        config.library.mediaType = YPlibraryMediaType.photo
        config.library.defaultMultipleSelection = false
        config.library.maxNumberOfItems = 1
        config.library.minNumberOfItems = 1
        config.library.numberOfItemsInRow = 4
        config.library.spacingBetweenItems = 1.0
        config.library.skipSelectionsGallery = true
        config.library.preselectedItems = nil
        config.showsPhotoFilters = false
        config.showsVideoTrimmer = false
        config.startOnScreen = YPPickerScreen.library

         let picker = YPImagePicker(configuration: config)
         picker.didFinishPicking { [unowned picker] items, _ in
             for item in items {
                 switch item {
                 case .photo(let photo):
                     let image = photo.originalImage.fixedOrientation()!.resizeImage(500, opaque: true)
                    
                     let cropViewController = CropViewController(image: image)
                     cropViewController.delegate = self
 //                    self.flag = 0
                     self.navigationController?.pushViewController(cropViewController, animated: true)
                 case .video( _):
                     break
                 }
             }
            picker.dismiss(animated: true, completion: nil)
        }
        self.present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func Action_done(_ sender: Any) {
        
            let item = self.image
            let parameters = [String:AnyObject]()
            let imageData: Data = item.jpegData(compressionQuality: 0.5)!
            let result = Utils.randomString(length: 15)
            let file_name = String(format: "%@.%@", result,"jpg")
           
          self.uploadPhotoToServer(parameters: parameters, filename: file_name, imageData: imageData)
         
        
    }
    
    func updateAvatar(url:String){
        ResAPI.sharedInstance.updateAvatar(avatar_image: url, callBack: { (data, Message) -> Void in
        if(data != nil) {
            let response:ResResponse = data as! ResResponse
            if response.code == 200 {
               
                debugPrint("Post Successs")
                
                self.delegate?.reload()
                self.navigationController?.popViewController(animated: true)

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
    
    func uploadPhotoToServer( parameters: Dictionary<String, AnyObject>, filename:String, imageData: Data?) {
        
        var url = ""
        url = DEFAULT_MAIN_DOMAIN + String(format: API_UPLOAD_LINKIMAGE)

        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data",
            "Authorization":"\(ManageCacheObject.getCurrentAccount().accessToken)"
        ]
        
        let successHandler: ((DataResponse<Any>) -> Void)? = {res in
            

//            debugPrint("Upload thanh cong")
            self.getLink(fileName: filename)
            dLog("upload success " + res.description)
            
           

        }
        
        let errorHandler: ((Error) -> Void)? = {err in
            print("\(err)")
        }
        
        let progressHandler: ((Double) -> Void)? = {err in
            
        }
        
        VideoUploadClient.uploadWithData(serverUrl: URL(string: url)!, headers: headers, fileData: imageData!, filename: filename, withName: "send_file", progressing: progressHandler, success: successHandler, failure: errorHandler)
    }
    
    func getLink(fileName: String) {
        
        ResAPI.sharedInstance.getLinkImage(file_name: fileName, ({ (data, Message) -> Void in
            if(data != nil) {
                let response:ResResponse = data as! ResResponse
                if response.code == 200 {
                    let image_url = DEFAULT_MAIN_DOMAIN + "/" + (response.data as! String)
                    self.updateAvatar(url: image_url)
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
    
}

extension ChangeAvatarViewController : CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
       
            self.image = image
            self.img_avatar.image = image
            
            self.navigationController?.popViewController(animated: true)

        
    
    }
    
    func cropViewController1(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
    }

}

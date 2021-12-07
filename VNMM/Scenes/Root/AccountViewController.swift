//
//  AccountViewController.swift
//  TechresSupplier
//
//  Created by Nguyễn văn Phú on 4/12/21.
//

import UIKit
import ObjectMapper
import CropViewController
import YPImagePicker
import Loaf

protocol AccountDelegaete {
    func reload()
}

class AccountViewController: UIViewController,NavigationControllerCustomDelegate {
    
    
    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var lbl_postCount: UILabel!
    @IBOutlet weak var lbl_nameUser: UILabel!
    
    @IBOutlet weak var viewProfileUser: UIView!
    
    @IBOutlet weak var viewInformationUser: UIView!
    @IBOutlet weak var lbl_email: UILabel!
    
    @IBOutlet weak var lbl_gender: UILabel!
    
    @IBOutlet weak var lbl_address: UILabel!
    
    var Userdata = UserAccount()
    var _idUser = ManageCacheObject.getCurrentAccount()._id
    
    var image = UIImage()
    
    var alertController: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInforUser()
        
        
        self.viewProfileUser.layer.shadowOpacity = 3
        self.viewProfileUser.layer.masksToBounds = false
        self.viewProfileUser.layer.shadowRadius = 3
        self.viewProfileUser.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewProfileUser.layer.shadowOffset = .zero
        
        self.viewInformationUser.layer.shadowOpacity = 0.5
        self.viewInformationUser.layer.masksToBounds = false
        self.viewInformationUser.layer.shadowRadius = 2
        self.viewInformationUser.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewInformationUser.layer.shadowOffset = .zero
        
       
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if self._idUser == ManageCacheObject.getCurrentAccount()._id {
            super.viewWillAppear(animated)
             self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }else{
            super.viewWillAppear(animated)
            //custom navigation bar
            self.navigationController?.setNavigationBarHidden(false, animated: animated)
            let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
            navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "")
            navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        }
       
    }
    
    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func go_to_profile_vc(_ sender: Any) {
        var profileUserViewController: ProfileUserViewController?
        profileUserViewController = UIStoryboard.profileUserViewController()
        profileUserViewController!._idUser = self._idUser
        self.navigationController!.pushViewController(profileUserViewController!, animated: true)
        
}
    
    
    @IBAction func Action_logOut(_ sender: Any) {
        alertController = UIAlertController()
        
        let saveAction = UIAlertAction(title: "Đăng xuất", style: .default) { [self](action) in

            ManageCacheObject.setToken("")
            ManageCacheObject.clearUser()
            var vc: LoginViewController?
            vc = UIStoryboard.loginViewController()
            self.navigationController!.pushViewController(vc!, animated: false)

            
        }
        let cancelAction = UIAlertAction(title: "Huỷ", style: .cancel) {(action) in
            dLog("cancel")
        }

        alertController?.addAction(saveAction)

        alertController?.addAction(cancelAction)
        self.present(alertController!, animated: true)

    }
    
    
    
    @IBAction func Action_updateAvatar(_ sender: Any){
        let vc : ChangeAvatarViewController?
        vc = UIStoryboard.changeAvatarViewController()
        vc!.delegate = self
        self.navigationController?.pushViewController(vc!, animated: true)
   
 }
    
    func getInforUser(){
        
        ResAPI.sharedInstance.getInforUser(_id: _idUser,{ (data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<UserAccount>().map(JSONObject: response.data) {
                            self.Userdata = DataResponse
                            
                            self.lbl_nameUser.text = self.Userdata.first_name + " " +  self.Userdata.last_name
                            self.lbl_postCount.text = String(format: "%d", self.Userdata.count_post) + " bài viết đã đăng"
                            self.lbl_email.text = self.Userdata.email
                            self.lbl_address.text = self.Userdata.address
                            
                            if self.Userdata.gender == 0 {
                                self.lbl_gender.text = "Nữ"
                            }else {
                                self.lbl_gender.text = "Nam"
                            }
                            
                            self.img_avatar.kf.setImage(with: URL(string: self.Userdata.avatar))
                           
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

extension AccountViewController : CropViewControllerDelegate {
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
            self.image = image
            self.img_avatar.image = image
            self.navigationController?.popViewController(animated: true)
    }
    
    func cropViewController1(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        
    }

}

extension AccountViewController : AccountDelegaete {
    func reload() {
        self.getInforUser()
    }
}

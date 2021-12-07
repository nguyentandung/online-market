//
//  RegisterInformationViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/26/21.
//

import UIKit
import Loaf

class RegisterInformationViewController: UIViewController, NavigationControllerCustomDelegate {
    
    @IBOutlet weak var tf_gender: UITextField!
    @IBOutlet weak var tf_firstname: UITextField!
    
    @IBOutlet weak var tf_address: UITextField!
    @IBOutlet weak var tf_lastname: UITextField!
    
    var email = ""
    var password = ""
    var genderSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
////
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Thông tin cá nhân")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        navigationController?.navigationBar.backgroundColor = ColorUtils.backgroundAppColor()
        
    }

    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
    
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue  {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height - 100
                    
                }
    
                
            }
    
        }
    
        @objc func keyboardWillHide(notification: NSNotification) {
            if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    
    }
    
    
    @IBAction func Action_done(_ sender: Any) {
        if self.tf_firstname.text == ""{
            Loaf("Vui lòng nhập họ của bạn", state: .success, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
        }else if self.tf_lastname.text == ""{
            Loaf("Vui lòng nhập tên của bạn", state: .success, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
        }else if self.tf_gender.text == ""{
            Loaf("Vui lòng chọn giới tính của bạn", state: .success, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
        }else if self.tf_address.text == "" {
            Loaf("Vui lòng nhập địa chỉ hiện tại của bạn", state: .success, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
        }else{
            self.registerAccount()
        }
    }
    
    
    
    
    func registerAccount(){
        JHProgressHUD.sharedHUD.showInView(view)
        ResAPI.sharedInstance.registerAccount(email: self.email, first_name: self.tf_firstname.text!, last_name: self.tf_lastname.text!, gender: self.genderSelected, address: self.tf_address.text!, password: self.password, { (data, Message) -> Void in
            if(data != nil) {
                let response:ResResponse = data as! ResResponse
                if response.code == 200 {
                    
                    Loaf("Đăng ký thành công", state: .success, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
                    
                    let delay = 1
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {

//                        var mainViewController: MainViewController?
//                        mainViewController = UIStoryboard.mainViewController()
//                        self.navigationController!.pushViewController(mainViewController!, animated: false)
                        
                        var vc: OnBoardViewController?
                        vc = UIStoryboard.onBoardViewController()
                        self.navigationController!.pushViewController(vc!, animated: false)
                    }
                
                }
                else {
                    Loaf(response.message!, state: .error, location: .top, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
                    
                }
                JHProgressHUD.sharedHUD.hide()
            }
            else {
                Loaf("Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", state: .error, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
            }
            JHProgressHUD.sharedHUD.hide()
        })
    }
    
    
}

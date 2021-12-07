//
//  RegisterViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/26/21.
//

import UIKit
import Loaf

class RegisterViewController: UIViewController, NavigationControllerCustomDelegate {
    
    @IBOutlet weak var tf_email: UITextField!
    
    @IBOutlet weak var tf_password: UITextField!
    
    @IBOutlet weak var tf_confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Đăng ký tài khoản")
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
    
    
    @IBAction func Action_next(_ sender: Any) {
        if tf_email.text == ""{
            Loaf("Bạn chưa nhập email", state: .warning, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
        }else if tf_password.text == ""{
            Loaf("Bạn chưa nhập mật khẩu", state: .warning, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
        }else if tf_confirmPassword.text == "" {
            Loaf("Bạn chưa xác nhận mật khẩu", state: .warning, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()
        }else {
            if tf_password.text != tf_confirmPassword.text {
                Loaf("Mật khẩu bạn xác nhận chưa đúng.Vui lòng nhập lại", state: .warning, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: self).show()

            }else{
                let vc : RegisterInformationViewController?
                vc = UIStoryboard.registerInformationViewController()
                vc!.email = self.tf_email.text!
                vc!.password = self.tf_password.text!
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
    }
    

}

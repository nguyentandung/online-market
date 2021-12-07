//
//  LoginViewController.swift
//  VNMarket
//
//  Created by Nguyen Tan Dung on 04/07/21.
//

import UIKit
import ObjectMapper

class LoginViewController: UIViewController, NavigationControllerCustomDelegate {
    
    
    @IBOutlet weak var img_background_login: UIImageView!

    @IBOutlet weak var view_bottom_login: UIView!
    @IBOutlet weak var tf_user_name: UITextField!

    @IBOutlet weak var tf_password: UITextField!
    
    @IBOutlet weak var btn_login: UIButton!
    
    var gradientLayer: CAGradientLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
//        createGradientLayer()
        tf_user_name.delegate = self
        tf_password.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }


    
    func setupLayout(){
        self.btn_login.backgroundColor = ColorUtils.buttonLoginColor()
//        self.view_bottom_login.roundCorners(corners: [.topLeft], radius: 75)
        
    }
    

    
    @IBAction func btn_login(_ sender: Any) {
        print("Dung")
        login()
    }
    
    
    @IBAction func Action_registerAccount(_ sender: Any) {
                let vc : RegisterViewController?
                vc = UIStoryboard.registerViewController()
                self.navigationController?.pushViewController(vc!, animated: true)
    }
    

    
    
    func login() {

        ResAPI.sharedInstance.phoneLogin(email: tf_user_name.text!, password: tf_password.text!,{ (data, Message) -> Void in
            if(data != nil) {
                let response:ResResponse = data as! ResResponse
                if response.code == 200 {
                    let account : Account = Mapper<Account>().map(JSONObject: response.data)!
                    ManageCacheObject.saveCurrentAccount(account)
                    ManageCacheObject.setToken(account.accessToken)
                    
//                    ManageCacheObject.isLogin(islogin:true)
                    var mainViewController: MainViewController?
                    mainViewController = UIStoryboard.mainViewController()
                    self.navigationController!.pushViewController(mainViewController!, animated: false)
                    
                }
                else {
                    let alert = UIAlertController(title:LOAD_FAIL , message: response.message, preferredStyle:.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }

            }
            else {
                Toast.show(message: "Thử lại", controller: self)

            }

        })
    }
    
   
    
}

extension LoginViewController : UITextFieldDelegate{
    
}

//
//  ForgotResetPasswordViewController.swift
//  TechresSupplier
//
//  Created by Nguyễn văn Phú on 4/13/21.
//

import UIKit

class ForgotResetPasswordViewController: UIViewController ,NavigationControllerCustomDelegate{

    @IBOutlet weak var txt_password1: UITextField!
    
    @IBOutlet weak var txt_password2: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Đặt lại mật khẩu")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.main_color()
        self.navigationItem.hidesBackButton = true
    }
    
    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }

   
    @IBAction func hide_password1(_ sender: Any) {
        if(txt_password1.isSecureTextEntry){
            txt_password1.isSecureTextEntry = false
        }
        else{
            txt_password1.isSecureTextEntry = true
        }
        
    }
    
    @IBAction func hide_password2(_ sender: Any) {
        if(txt_password2.isSecureTextEntry){
            txt_password2.isSecureTextEntry = false
        }
        else{
            txt_password2.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func btn_confirm(_ sender: Any) {
        var mainViewController: MainViewController?
        mainViewController = UIStoryboard.mainViewController()
        self.navigationController!.pushViewController(mainViewController!, animated: false)
    }
    
}

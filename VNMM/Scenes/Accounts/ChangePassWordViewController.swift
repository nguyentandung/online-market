//
//  ChangePassWordViewController.swift
//  TechresSupplier
//
//  Created by Ace_Phu on 4/19/21.
//

import UIKit

class ChangePassWordViewController: UIViewController,NavigationControllerCustomDelegate {

    @IBOutlet weak var txt_password1: UITextField!
    
    @IBOutlet weak var txt_password2: UITextField!
    
    @IBOutlet weak var txt_password3: UITextField!
    
    @IBOutlet weak var btn_confirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        btn_confirm.addTarget(self, action: #selector(showAlertXacNhan), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Đổi mật khẩu")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.main_color()
        self.navigationItem.hidesBackButton = true
    }
    
    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }

   

    @IBAction func btn_cofirm(_ sender: Any) {
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
    
    @IBAction func hide_password3(_ sender: Any) {
        if(txt_password3.isSecureTextEntry){
            txt_password3.isSecureTextEntry = false
        }
        else{
            txt_password3.isSecureTextEntry = true
        }
    }
    
    @objc func showAlertXacNhan(){
        let alertView = UIAlertController(title: "", message: "Đổi mật khẩu thành công", preferredStyle: .alert)
        
        let pop = UIAlertAction(title: "OK", style: .default){[self](action) in
            self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(pop)
        
        self.present(alertView, animated: true , completion: nil)
        
        
    }
    
}

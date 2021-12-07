
//
//  ForgotPasswordViewController.swift
//  TechresSupplier
//
//  Created by Nguyễn văn Phú on 4/13/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController ,NavigationControllerCustomDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Quên mật khẩu")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.main_color()
        self.navigationItem.hidesBackButton = true
    }
    
    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func go_to_otp_vc(_ sender: Any) {
        
       

    }
    
}

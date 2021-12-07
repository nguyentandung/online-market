//
//  SettingViewController.swift
//  TechresSupplier
//
//  Created by Ace_Phu on 4/12/21.
//

import UIKit

class SettingViewController: UIViewController,NavigationControllerCustomDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // self.navigationController.setUpNavigationBar
        // Do any additional setup after loading the view.
    
   }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Cài đặt")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.main_color()
        self.navigationItem.hidesBackButton = true
    }
    
    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }

    
    
    @IBAction func log_out(_ sender: Any) {
        
    }
    
    @IBAction func go_to_nation_vc(_ sender: Any) {
        
    }
    
    @IBAction func go_to_change_language_vc(_ sender: Any) {
        var languageViewController: LanguageViewController?
        languageViewController = UIStoryboard.languageViewController()
        self.navigationController!.pushViewController(languageViewController!, animated: false)

    }
    
    @IBAction func go_to_setting_notification_vc(_ sender: Any) {
    }
    
    
    @IBAction func go_to_changepassword_vc(_ sender: Any) {
        
        
        var changePassWordViewController: ChangePassWordViewController?
        changePassWordViewController = UIStoryboard.changePassWordViewController()
        self.navigationController!.pushViewController(changePassWordViewController!, animated: false)
    }
}

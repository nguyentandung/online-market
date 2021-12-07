//
//  LanguageViewController.swift
//  TechresSupplier
//
//  Created by Ace_Phu on 4/20/21.
//

import UIKit

class LanguageViewController: UIViewController,NavigationControllerCustomDelegate {

    @IBOutlet weak var btn_confirm: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_confirm.addTarget(self, action: #selector(showAlertXacNhan), for: .touchUpInside)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Ngôn ngữ")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.main_color()
        self.navigationItem.hidesBackButton = true
    }
    
    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func showAlertXacNhan(){
        let alertView = UIAlertController(title: "", message: "Thay đổi ngôn ngữ thành công", preferredStyle: .alert)
        
        let pop = UIAlertAction(title: "OK", style: .default){[self](action) in
            self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(pop)
        
        self.present(alertView, animated: true , completion: nil)
        
        
    }

    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

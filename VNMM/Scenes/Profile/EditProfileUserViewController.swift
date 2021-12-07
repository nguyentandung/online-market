//
//  EditProfileUserViewController.swift
//  TechresSupplier
//
//  Created by Ace_Phu on 4/20/21.
//

import UIKit

class EditProfileUserViewController: UIViewController , NavigationControllerCustomDelegate{

    @IBOutlet weak var txt_view_firstname: UITextView!
    
    @IBOutlet weak var txt_view_lastname: UITextView!
    
    @IBOutlet weak var txt_view_email: UITextView!
    
    @IBOutlet weak var txt_view_phone: UITextView!
    
    @IBOutlet weak var txt_view_address: UITextView!
    
    @IBOutlet weak var btn_done: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_done.addTarget(self, action: #selector(showAlertXacNhan), for: .touchUpInside)
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, editButton: true, title: "Chỉnh sửa thông tin")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.main_color()
        self.navigationItem.hidesBackButton = true
    }
    
    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btn_done(_ sender: Any) {
    }
    @objc func showAlertXacNhan(){
        let alertView = UIAlertController(title: "", message: "Chỉnh sửa thông tin thành công", preferredStyle: .alert)
        
        let pop = UIAlertAction(title: "OK", style: .default){[self](action) in
            self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(pop)
        
        self.present(alertView, animated: true , completion: nil)
        
        
    }
}

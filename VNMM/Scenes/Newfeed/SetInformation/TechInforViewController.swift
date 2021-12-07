//
//  TechInforViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/26/21.
//

import UIKit
import DropDown

class TechInforViewController: UIViewController, NavigationControllerCustomDelegate {
    
    var typePost = 0
    
    let dropDown = DropDown()
    
    var ModelTech : [CreateTech] = [CreateTech(id: 1, name: "Macbook"),
                                    CreateTech(id: 2, name: "Dell"),
                                    CreateTech(id: 3, name: "Lenovo"),
                                    CreateTech(id: 4, name: "ASUS"),
                                    CreateTech(id: 5, name: "HP"),
                                    CreateTech(id: 6, name: "MSI"),
                                    CreateTech(id: 7, name: "Delete"),
                                    CreateTech(id: 8, name: "Acer")]

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        
    }

    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    
}

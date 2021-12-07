//
//  CreateNewFeedViewController.swift
//  TechresSupplier
//
//  Created by Nguyen Tan Dung on 04/24/21.
//

import UIKit

class CreateNewFeedViewController: UIViewController, NavigationControllerCustomDelegate {
    
    
    @IBOutlet weak var viewCreateCarPost: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        self.viewCreateCarPost.layer.shadowOpacity = 1
//        self.viewCreateCarPost.layer.masksToBounds = false
//        self.viewCreateCarPost.layer.shadowRadius = 3
//        self.viewCreateCarPost.layer.shadowColor = UIColor.black.cgColor
//        self.viewCreateCarPost.layer.shouldRasterize = true
//        self.viewCreateCarPost.layer.shadowPath = UIBezierPath(rect: self.viewCreateCarPost.bounds).cgPath
//        self.viewCreateCarPost.layer.shadowOffset = CGSize(width: 5, height: 2)
//        self.viewCreateCarPost.layer.rasterizationScale = true ? UIScreen.main.scale : 1
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: true, searchButton: true, title: "Chọn loại danh mục")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        
    }
    
    
   
    
    
    
    @IBAction func Action_createTechnologyPost(_ sender: Any) {
        
        let vc : ChooseTypeTranSportViewController?
        vc = UIStoryboard.chooseTypeTranSportViewController()
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func Action_createFuniturePost(_ sender: Any) {
        
    }
    
    
    @IBAction func Action_createTransportPost(_ sender: Any) {
        
        let vc : ChooseTypeTechViewController?
        vc = UIStoryboard.chooseTypeTechViewController()
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func Action_createRealityPost(_ sender: Any) {
        
    }
    
    
    @IBAction func Action_createFruitPost(_ sender: Any) {
        
    }
    

}

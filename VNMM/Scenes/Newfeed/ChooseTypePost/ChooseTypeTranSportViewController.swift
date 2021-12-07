//
//  ChooseTypeTranSportViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/27/21.
//

import UIKit

class ChooseTypeTranSportViewController: UIViewController, NavigationControllerCustomDelegate {
    
    
    @IBOutlet weak var view_car: UIView!
    
    @IBOutlet weak var view_bike: UIView!
    @IBOutlet weak var view_moto: UIView!
    
    var gradientLayer: CAGradientLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
       

       
        self.view_car.layer.shadowOpacity = 1
        self.view_car.layer.masksToBounds = false
        self.view_car.layer.shadowRadius = 2
        self.view_car.layer.shadowColor = UIColor.lightGray.cgColor
        self.view_car.layer.shadowOffset = .zero
        
//        self.view_car.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#F8BBD0")
        
        self.view_bike.layer.shadowOpacity = 1
        self.view_bike.layer.masksToBounds = false
        self.view_bike.layer.shadowRadius = 2
        self.view_bike.layer.shadowColor = UIColor.lightGray.cgColor
        self.view_bike.layer.shadowOffset = .zero
//        self.view_bike.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#E0F7FA")
        
        self.view_moto.layer.shadowOpacity = 1
        self.view_moto.layer.masksToBounds = false
        self.view_moto.layer.shadowRadius = 2
        self.view_moto.layer.shadowColor = UIColor.lightGray.cgColor
        self.view_moto.layer.shadowOffset = .zero
//        self.view_moto.backgroundColor = ColorUtils.hexStringToUIColor(hex: "#80DEEA")
        

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Chọn loại phương tiện")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        navigationController?.navigationBar.backgroundColor = ColorUtils.backgroundAppColor()
        
    }

    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func Action_setInforByCar(_ sender: Any) {
//        let vc : TransportInforViewController?
//        vc = UIStoryboard.transportInforViewController()
//        vc!.typePost = POST_TYPE.CAR.rawValue
//        self.navigationController?.pushViewController(vc!, animated: true)
        
        let vc : CreateMotoCycleViewController?
        vc = UIStoryboard.createMotoCycleViewController()
        vc!.typePost = POST_TYPE.CAR.rawValue
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func Action_setInforByMotoCycle(_ sender: Any) {
        let vc : CreateMotoCycleViewController?
        vc = UIStoryboard.createMotoCycleViewController()
        vc!.typePost = POST_TYPE.MOTOCYCLE.rawValue
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    @IBAction func Action_setInforByBikeCycle(_ sender: Any) {
        let vc : CreateMotoCycleViewController?
        vc = UIStoryboard.createMotoCycleViewController()
        vc!.typePost = POST_TYPE.BYCYCLE.rawValue
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
}

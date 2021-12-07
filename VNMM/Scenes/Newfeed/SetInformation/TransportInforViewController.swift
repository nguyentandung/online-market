//
//  TransportInforViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 04/27/21.
//

import UIKit
import DropDown

class TransportInforViewController: UIViewController, NavigationControllerCustomDelegate {
    
    
    @IBOutlet weak var lbl_propety1: UILabel!
    @IBOutlet weak var lbl_propety2: UILabel!
    @IBOutlet weak var lbl_propety3: UILabel!
    @IBOutlet weak var lbl_propety4: UILabel!
    @IBOutlet weak var lbl_propety5: UILabel!
    @IBOutlet weak var lbl_propety6: UILabel!
    @IBOutlet weak var lbl_propety7: UILabel!
    
    @IBOutlet weak var lbl_propety8: UILabel!
    
   
    var typePost = 0
    
    let dropDown = DropDown()
    
    var delegate : GetDataAfterChooseDelegate?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        checkTypePost()
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
    
    
    @IBAction func Action_done(_ sender: Any) {
        
        self.delegate?.setData(Brand: self.lbl_propety1.text!, Model: self.lbl_propety2.text!, ProductionLocation: self.lbl_propety3.text!, kmUsed: Int(self.lbl_propety4.text!)!, Status: self.lbl_propety5.text!, Fuel: self.lbl_propety6.text!, Capacity: self.lbl_propety7.text!, Color: self.lbl_propety8.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func checkTypePost(){
        if (self.typePost == POST_TYPE.CAR.rawValue) {
            
            self.lbl_propety1.text = "Hãng"
            self.lbl_propety2.text = "Tên xe"
            self.lbl_propety3.text = "Nơi sản xuất"
            self.lbl_propety4.text = "Số Km đã đi"
            self.lbl_propety5.text = "Tình trạng"
            self.lbl_propety6.text = "Nhiên liệu"
            self.lbl_propety7.text = "Sức chứa"
            self.lbl_propety8.text = "Màu sắc"
            
        }else if (self.typePost == POST_TYPE.MOTOCYCLE.rawValue){
            
            self.lbl_propety1.text = "Hãng"
            self.lbl_propety2.text = "Tên xe"
            self.lbl_propety3.text = "Nơi sản xuất"
            self.lbl_propety4.text = "Số Km đã đi"
            self.lbl_propety5.text = "Tình trạng"
            self.lbl_propety6.text = "Nhiên liệu"
            self.lbl_propety7.text = "Sức chứa"
            self.lbl_propety8.text = "Màu sắc"
            
        }else{
            
            self.lbl_propety1.text = "Hãng"
            self.lbl_propety2.text = "Tên xe"
            self.lbl_propety3.text = "Nơi sản xuất"
            self.lbl_propety4.text = "Số Km đã đi"
            self.lbl_propety5.text = "Tình trạng"
            self.lbl_propety6.text = "Nhiên liệu"
            self.lbl_propety7.text = "Sức chứa"
            self.lbl_propety8.text = "Màu sắc"
            
        }
    }
    
    @IBAction func Action_choose_propety1(_ sender: Any) {
        let vc : BrandViewController
        vc = UIStoryboard.brandViewController()!
        vc.delegate = self
        vc.data = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Action_choose_propety2(_ sender: Any) {
        let vc : BrandViewController
        vc = UIStoryboard.brandViewController()!
        vc.delegate = self
        vc.data = 1
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func Action_choose_propety3(_ sender: Any) {
        let vc : BrandViewController
        vc = UIStoryboard.brandViewController()!
        vc.delegate = self
        vc.data = 2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Action_choose_propety4(_ sender: Any) {
        let vc : BrandViewController
        vc = UIStoryboard.brandViewController()!
        vc.delegate = self
        vc.data = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Action_choose_propety5(_ sender: Any) {
        let vc : BrandViewController
        vc = UIStoryboard.brandViewController()!
        vc.delegate = self
        vc.data = 4
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Action_choose_propety6(_ sender: Any) {
        let vc : BrandViewController
        vc = UIStoryboard.brandViewController()!
        vc.delegate = self
        vc.data = 5
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Action_choose_propety7(_ sender: Any) {
        let vc : BrandViewController
        vc = UIStoryboard.brandViewController()!
        vc.delegate = self
        vc.data = 6
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func Action_choose_propety8(_ sender: Any) {
        let vc : BrandViewController
        vc = UIStoryboard.brandViewController()!
        vc.delegate = self
        vc.data = 7
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TransportInforViewController : GetDataPostDelegate {
    func setBrandData(text: String) {
        self.lbl_propety1.text = text
    }
    
    func setModelData(text: String) {
        self.lbl_propety2.text = text
    }
    
    func setProductionData(text: String) {
        self.lbl_propety3.text = text
    }
    
    func setkmUsedData(text: Int) {
        self.lbl_propety4.text = "\(text)"
    }
    
    func setStatuslData(text: String) {
        self.lbl_propety5.text = text
    }
    
    func setFuellData(text: String) {
        self.lbl_propety6.text = text
    }
    
    func setCapacityData(text: String) {
        self.lbl_propety7.text = text
    }
    
    func setColorData(text: String) {
        self.lbl_propety8.text = text
    }
    
}



//
//  DialogConfirmUpdateVersionViewController.swift
//  Bán hàng
//
//  Created by kelvin on 6/21/19.
//  Copyright © 2019 vn.printstudio.res.employee. All rights reserved.
//

import UIKit


class DialogConfirmUpdateVersionViewController: UIViewController {
    
   
    @IBOutlet weak var lbl_content: UILabel!
    
    var is_require_update = 0
    var content:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbl_content.text = content
    }
    @IBAction func actionAccept(_ sender: Any) {

    }
    @IBAction func actionCancel(_ sender: Any) {
        
        if(is_require_update == 1){
             exit(0);
        }else{
             ManageCacheObject.setFistRun(false)
             self.dismiss(animated: true, completion: nil)
        }
        
    
    }
    


}

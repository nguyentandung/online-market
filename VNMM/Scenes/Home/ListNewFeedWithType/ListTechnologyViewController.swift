//
//  ListTechnologyViewController.swift
//  VNMM
//
//  Created by Nguyen Tan Dung on 05/03/21.
//

import UIKit
import ObjectMapper

class ListTechnologyViewController: UIViewController, NavigationControllerCustomDelegate {
    
    var listNewfeed = [NewFeed]()
    var limit = 100
    var page = 1
    var total_record = 0
    var typeAll = -1
    
    var prioritize_type = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //custom navigation bar
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        let navigationControllerCustom : NavigationControllerCustom = self.navigationController as! NavigationControllerCustom
        navigationControllerCustom.setUpNavigationBar(self, backButton: false, searchButton: true, title: "Đăng tin công nghệ")
        navigationControllerCustom.navigationBar.barTintColor = ColorUtils.backgroundAppColor()
        navigationController?.navigationBar.backgroundColor = ColorUtils.backgroundAppColor()
        
    }

    func backTap() {
        self.navigationController?.popViewController(animated: true)
    }

    func getNewfeed(){
        
        ResAPI.sharedInstance.getNewFeed(page: self.page, limit: self.limit,type:typeAll,prioritize_type:self.prioritize_type,{ (data, Message) -> Void in
                if(data != nil) {
                    let response:ResResponse = data as! ResResponse
                    if response.code == 200 {
                        if let DataResponse  = Mapper<NewFeedResponse>().map(JSONObject: response.data) {
                            
                            self.listNewfeed = DataResponse.list
//                            self.tbl_home.reloadData()
                        }
                       
                    } else {
                        let alert = UIAlertController(title:LOAD_FAIL , message: response.message, preferredStyle:.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    JHProgressHUD.sharedHUD.hide()
                }
                else {
                    Toast.show(message: "Thử lại", controller: self)
                    
                }
    
            })
        }
    
}

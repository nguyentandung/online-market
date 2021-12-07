//
//  SplashTableViewController.swift
//
//  Created by kelvin on 11/26/18.
//  Copyright © 2018 vn.techres.tm. All rights reserved.
//

import UIKit
import ObjectMapper

class SplashViewController: UIViewController ,NavigationControllerCustomDelegate{
 var window: UIWindow?
  
    override func viewDidLoad() {
        super.viewDidLoad()

        ManageCacheObject.setFistRun(true)
        if(!ManageCacheObject.isLogin() ){

            

        }else{

            loadMainScreen()
        }
        if ManageCacheObject.getFistRun() {
            ManageCacheObject.setFistRun(true)
        }
//        loadMainScreen()
        
    }

   
    
    func loadMainScreen(){
        self.view.removeFromSuperview()
        let frame = UIScreen.main.bounds
        self.window = UIWindow(frame: frame)
        self.window!.rootViewController = RootViewController()
        self.window!.makeKeyAndVisible()
    }
    
}

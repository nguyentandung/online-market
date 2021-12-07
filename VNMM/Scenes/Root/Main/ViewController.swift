//
//  ViewController.swift
//  TechresSupplier
//
//  Created by KELVIN on 11/04/2021.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(ManageCacheObject.isLogin() ){

            

            var mainViewController: MainViewController?
            mainViewController = UIStoryboard.mainViewController()
            self.navigationController!.pushViewController(mainViewController!, animated: false)
        }else{
            if( ManageCacheObject.getFistRun()){
                ManageCacheObject.setFistRun(false)
                

                let onBoardViewController: OnBoardViewController?
                onBoardViewController = UIStoryboard.onBoardViewController()
                self.navigationController!.pushViewController(onBoardViewController!, animated: false)
            }else{
                let loginViewController: LoginViewController?
                loginViewController = UIStoryboard.loginViewController()
                self.navigationController!.pushViewController(loginViewController!, animated: false)
            }
           
        }
    }


}


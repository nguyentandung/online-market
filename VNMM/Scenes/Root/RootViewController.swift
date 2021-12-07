//
//  RootViewController.swift
//  Print Studio
//
//  Created by KELVIN on 11/04/2021.
//

import UIKit


class RootViewController: BaseViewController, NavigationControllerCustomDelegate {

    var baseNavigationController: NavigationControllerCustom!
    let centerPanelExpandedOffset: CGFloat = UIScreen.main.bounds.width - 80
    var mainViewController:ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mainViewController = UIStoryboard.viewController()
        baseNavigationController = NavigationControllerCustom(rootViewController: mainViewController)
        view.addSubview(baseNavigationController.view)
        baseNavigationController.didMove(toParent: self)
        baseNavigationController.touchTarget = self
        

        
        NotificationCenter.default.addObserver(self, selector: #selector(RootViewController.rotation), name: NSNotification.Name(rawValue: "AddNotificationRotation"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(RootViewController.removeRotation), name: NSNotification.Name(rawValue: "RemoveNotificationRotation"), object: nil)
        

        
    }
   

    @objc func rotation(){
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    @objc func removeRotation(){
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
}

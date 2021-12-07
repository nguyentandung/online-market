//
//  MainViewController.swift
//  Customer
//
//  Created by kelvin on 11/04/2021.
//  Copyright © 2018 vn.eteacher. All rights reserved.
//

import UIKit
import ObjectMapper
import CTShowcase
class MainViewController: UITabBarController, NavigationControllerCustomDelegate {
    private var popGesture: UIGestureRecognizer?

   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveNotification(_:)), name: NSNotification.Name(rawValue: "NotificationPush"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveUnAuthorized(_:)), name: NSNotification.Name(rawValue: "ERROR_UNAUTHORIZED"), object: nil)
        
//        checkVersion()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
   
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
    }
    
    @objc func onDidReceiveUnAuthorized(_ notification: Notification)
    {
        ManageCacheObject.saveCurrentAccount(Account())
        ManageCacheObject.setToken("")
    }
    
    @objc func onDidReceiveNotification(_ notification: Notification)
    {
           let receiveData =  notification.object as? NSMutableDictionary
           let type = receiveData?.value(forKey: "type") as! String
            
//
//           switch Int(type) {
//           case PUSH_ADD_FRIEND_REQUEST:
//                // HANDLE CODE HERE
//               break
//            case PUSH_ACCEPT_CONTACT:
//                // HANDLE CODE HERE
//
//                break
//           case PUSH_CHAT:
//               // HANDLE CODE HERE
//                    debugPrint("HANDLE CODE HERE PUSH_CHAT")
//
//
//               break
//           default:
//             // HANDLE CODE HERE
//                break
//           }
     }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        if navigationController!.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
//            self.popGesture = navigationController!.interactivePopGestureRecognizer
//            self.navigationController!.view.removeGestureRecognizer(navigationController!.interactivePopGestureRecognizer!)
//            
//        }
//        
       
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
     
    }
    
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {

        
    }
    
    func incrementBadgeNumberBy(badgeNumberIncrement: Int) {
        let currentBadgeNumber = UIApplication.shared.applicationIconBadgeNumber
            let updatedBadgeNumber = currentBadgeNumber + badgeNumberIncrement
            if (updatedBadgeNumber > -1) {
                UIApplication.shared.applicationIconBadgeNumber = updatedBadgeNumber
            }
        }
    
    
}
extension MainViewController : UITabBarControllerDelegate{
    // UITabBarControllerDelegate
    private func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        print("Selected view controller")
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            //do your stuff
            debugPrint(tabBarIndex)
            
        }
        
    }
    
  
}

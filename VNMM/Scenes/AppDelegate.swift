//
//  AppDelegate.swift
//  TechresSupplier
//
//  Created by KELVIN on 11/04/2021.
//

import UIKit

@UIApplicationMain
//@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var	 window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let splashScreen = SplashViewController(nibName: "SplashViewController", bundle: nil)
              let frame = UIScreen.main.bounds
              window = UIWindow(frame: frame)
              window!.rootViewController = splashScreen
              window!.makeKeyAndVisible()
        
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}


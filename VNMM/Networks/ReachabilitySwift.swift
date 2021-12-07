//
//  ReachabilitySwift.swift
//  Techres-Supplier (iOS)
//
//  Created by KELVIN on 10/03/2021.
//

import UIKit
import ReachabilitySwift // 1. Importing the Library

class ReachabilityManager: NSObject {
    // 2. Shared instance
    static  let shared = ReachabilityManager()
    
    // 3. Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    
    // 4. Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
    // 5. Reachability instance for Network status monitoring
    let reachability = Reachability()!
    
    /// Called whenever there is a change in NetworkReachibility Status
    ///
    /// — parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.currentReachabilityStatus {
        case .notReachable:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: UNREACHABLE_NETWORK), object: nil)
        case .reachableViaWiFi:
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: REACHABLE_NETWORK), object: nil)
        case .reachableViaWWAN:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: REACHABLE_NETWORK), object: nil)
        }
    }
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
}

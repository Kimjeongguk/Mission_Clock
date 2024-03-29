//
//  AppDelegate.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/18.
//

import UIKit
import AudioToolbox
import AVFoundation
import NotificationCenter

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var alarms: AlarmSchedulerDelegate = Scheduler()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        alarms.authorization()
//        NotificationCenter.default.addObserver(self, selector: #selector(self.testselector), name: .created, object: nil)
        return true
    }
    @objc func testselector(notification: Notification){
        alarms.centerAdd(notification: notification)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        
    }
}



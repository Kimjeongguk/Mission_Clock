//
//  Scheduler.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/02/05.
//
//
//import UIKit
//import  UserNotifications
//
//class Scheduler: AlarmSchedulerDelegate {
//    
//    var clockModel: ClockModel = ClockModel()
//    func setupNotificationSettings() -> UNNotificationSettings {
////        // 알람의 유형지정
////        let notificationTypes: UNAuthorizationOptions = [UNAuthorizationOptions.alert, UNAuthorizationOptions.sound]
////
////        // 알람의 실행방식 지정?
////        let stopAction = UNNotificationAction.init(identifier: "Alarm-ios-swift-stop", title: "OK", options: UNNotificationActionOptions.foreground)
////        let actionsArray = [UNNotificationAction](arrayLiteral: stopAction)
////        let actionsArrayMinimal = [UNNotificationAction](arrayLiteral: stopAction)
////        let alarmCatefory = UNNotificationCategory()
////
//        
//        let center = UNUserNotificationCenter.current()
//        let options: UNAuthorizationOptions = [.alert, .sound]
//        
//        center.requestAuthorization(options: options) { (granted, error) in
//            if !granted{
//                print("someting went wrong")
//            }
//        }
//        // 알람 울리면 나오는 메시지
//        let content = UNMutableNotificationContent()
//        content.title = "알람"
//        content.body = "인나야"
//        content.sound = UNNotificationSound.default
//        
//    }
//    
//    func setNotificationWithDate(_ date: Date, onWeekdaysForNotify: [Int], soundName: String, index: Int) {
//        <#code#>
//    }
//    
//
//}

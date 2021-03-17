//
//  Scheduler.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/02/05.
//

import UIKit
import UserNotifications

class Scheduler: AlarmSchedulerDelegate {
    
    let center = UNUserNotificationCenter.current()
    
    func authorization() {
        // Specify the notification types.
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (granted, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            guard granted else{
                return
            }
        }
    }
    
    func centerAdd(notification: Notification){
        let content = UNMutableNotificationContent()
        content.title = "알람"
        content.body = ""
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

        let request = UNNotificationRequest(identifier: notification.name.rawValue, content: content, trigger: trigger)
        print(notification.name.rawValue)
        center.add(request)
        
    }
    
    func scheduleNotification(_ date: Date, onWeekdaysForNotify weekdays: [Bool], soundName: String) {
        let content = UNMutableNotificationContent()//이부분을 controllview로 변경하고 밑에 넣어줘야함 
        content.title = "알람"
        content.body = ""
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("\(soundName).mp3"))
        
        content.userInfo = ["customData": "fizzbuzz"]
//        content.sound.
        
        let calendar = Calendar.current // or e.g. Calendar(identifier: .persian)
        
        var weeks = [Int]()
        for index in 0..<weekdays.count{
            if weekdays[index]{
                weeks.append(index+1)
            }
        }
        if weeks.isEmpty{
//            var dateComponents = DateComponents()
//            dateComponents.hour = calendar.component(.hour, from: date)
//            dateComponents.minute = calendar.component(.minute, from: date)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            center.add(request)
        }else{
            for index in weeks{
                var dateComponents = DateComponents()
                dateComponents.weekday = index
                dateComponents.hour = calendar.component(.hour, from: date)
                dateComponents.minute = calendar.component(.minute, from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                

                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                center.add(request)
            }
        }
        
        
    }
    
    func saveNotifications(clockList: [ClockModel]){
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
        for index in clockList{
            if index.enable{
                scheduleNotification(index.date, onWeekdaysForNotify: index.week, soundName: index.sound.name)
            }
        }
    }
    
}




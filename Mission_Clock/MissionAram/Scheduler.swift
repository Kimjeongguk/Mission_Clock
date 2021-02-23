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
        let options: UNAuthorizationOptions = [.alert, .sound]
        center.requestAuthorization(options: options) { (granted, error) in
            if let error = error{
                print(error.localizedDescription)
            }
            guard granted else{
                return
            }
        }
    }
    
    func scheduleNotification(_ date: Date, onWeekdaysForNotify weekdays: [Bool], soundName: String) {
        let content = UNMutableNotificationContent()
        content.title = "title alarm"
        content.body = "body alarm"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound(named: UNNotificationSoundName(soundName))

        let calendar = Calendar.current // or e.g. Calendar(identifier: .persian)
        
        var weeks = [Int]()
        for index in 0..<weekdays.count{
            if weekdays[index]{
                weeks.append(index+1)
            }
        }
        if weeks.isEmpty{
            var dateComponents = DateComponents()
            dateComponents.hour = calendar.component(.hour, from: date)
            dateComponents.minute = calendar.component(.minute, from: date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

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
        for index in clockList{
            if index.enable{
                scheduleNotification(index.date, onWeekdaysForNotify: index.week, soundName: index.sound.name)
            }
        }
    }
    

}


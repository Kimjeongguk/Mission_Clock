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
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: soundName))

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
    

}


//
//    private func correctDate(_ date: Date, onWeekdaysForNotify weekdays:[Bool]) -> [Date] {
//        var correctedDate: [Date] = [Date]()
//        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
//        let now = Date()
//        let flags: NSCalendar.Unit = [NSCalendar.Unit.weekday, NSCalendar.Unit.weekdayOrdinal, NSCalendar.Unit.day]
//        let dateComponents = (calendar as NSCalendar).components(flags, from: date)
//        let weekday:Int = dateComponents.weekday!
//
//        var weeks: [Int] = [Int]()
//        for day in 0..<weekdays.count{
//            if weekdays[day]{
//                weeks.append(day)
//            }
//        }
//        //no repeat
//        if weeks.isEmpty{
//            //scheduling date is eariler than current date
//            if date < now {
//                //plus one day, otherwise the notification will be fired righton
//                correctedDate.append((calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: 1, to: date, options:.matchStrictly)!)
//            }
//            else { //later
//                correctedDate.append(date)
//            }
//            return correctedDate
//        }
//        //repeat
//        else {
//            let daysInWeek = 7
//            correctedDate.removeAll(keepingCapacity: true)
//            for wd in weeks {
//
//                var wdDate: Date!
//                //schedule on next week
//                if compare(weekday: wd, with: weekday) == .before {
//                    wdDate =  (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: wd+daysInWeek-weekday, to: date, options:.matchStrictly)!
//                }
//                //schedule on today or next week
//                else if compare(weekday: wd, with: weekday) == .same {
//                    //scheduling date is eariler than current date, then schedule on next week
//                    if date.compare(now) == ComparisonResult.orderedAscending {
//                        wdDate = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: daysInWeek, to: date, options:.matchStrictly)!
//                    }
//                    else { //later
//                        wdDate = date
//                    }
//                }
//                //schedule on next days of this week
//                else { //after
//                    wdDate =  (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: wd-weekday, to: date, options:.matchStrictly)!
//                }
//
//                //fix second component to 0
//                wdDate = Scheduler.correctSecondComponent(date: wdDate, calendar: calendar)
//                correctedDate.append(wdDate)
//            }
//            return correctedDate
//        }
//    }
//
//    private func syncAlarmModel() {
//        alarmModel = Alarms()
//    }
//
//    private enum weekdaysComparisonResult {
//        case before
//        case same
//        case after
//    }
//
//    private func compare(weekday w1: Int, with w2: Int) -> weekdaysComparisonResult {
//        if w1 != 1 && w2 == 1 {return .before}
//        else if w1 == w2 {return .same}
//        else {return .after}
//    }
//
//    public static func correctSecondComponent(date: Date, calendar: Calendar = Calendar(identifier: Calendar.Identifier.gregorian))->Date {
//        let second = calendar.component(.second, from: date)
//        let d = (calendar as NSCalendar).date(byAdding: NSCalendar.Unit.second, value: -second, to: date, options:.matchStrictly)!
//        return d
//    }
//
//    internal func sendNotification(_ date: Date, onWeekdaysForNotify weekdays:[Bool], soundName: String, index: Int) {
//        let notiContent = UNMutableNotificationContent()
//
//        notiContent.title = "title"
//        notiContent.body = "body"
//
//        let datesForNotification = correctDate(date, onWeekdaysForNotify:weekdays)
//        syncAlarmModel()
//        for d in datesForNotification {
//            alarmModel.alarms[index].date = d
//            let dateComponents = Calendar.current.dateComponents([.weekday, .hour, .minute], from: d)
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//            let request = UNNotificationRequest(identifier: "LocalNoti", content: notiContent, trigger: trigger)
//
//            center.add(request) { error in
//                if let error = error {
//                    print(error)
//                }
//            }
//        }
//    }
//
//    func checkNotification() {
//        alarmModel = Alarms()
//        center.getPendingNotificationRequests { (requests) in
//            if requests.isEmpty{
//                for i in 0..<self.alarmModel.count {
//                    self.alarmModel.alarms[i].enable = false
//                }
//            }
//            else {
//                for (i, alarm) in self.alarmModel.alarms.enumerated() {
//                    var isOutDated = true
//                    for n in requests {
//                        if alarm.date >= n.trigger.co {
//                            isOutDated = false
//                        }
//                    }
//                    if isOutDated {
//                        self.alarmModel.alarms[i].enable = false
//                    }
//                }
//            }
//        }

//
//  AlarmSchedulerDelegate.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/02/05.
//

import UIKit

protocol AlarmSchedulerDelegate{
    func authorization()
    func scheduleNotification(_ date: Date, onWeekdaysForNotify weekdays: [Bool], soundName: String)
    func saveNotifications(clockList: [ClockModel])
    func centerAdd(notification: Notification)
}

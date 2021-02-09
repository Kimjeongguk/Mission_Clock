//
//  AlarmSchedulerDelegate.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/02/05.
//

import UIKit

protocol AlarmSchedulerDelegate{
    func setNotificationWithDate(_ date: Date, onWeekdaysForNotify:[Int], soundName: String, index: Int)
    func setupNotificationSettings() -> UNNotificationSettings
}

//
//  ClockModel.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/19.
//

import UIKit

class ClockModel: NSObject {

    var title: String
    var ampm: String
    var time: String
    var week: Int
    
    init(title: String, ampm: String, time: String, week: Int) {
        self.title = title
        self.ampm = ampm
        self.time = time
        self.week = week
    }
}

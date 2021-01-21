//
//  ClockModel.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/19.
//

import UIKit

struct ClockModel {

    var title: String
    var ampm: String
    var time: String
    var week: WeekView
    
    init(){
        self.title = ""
        self.ampm = ""
        self.time = "0 : 0"
        self.week = WeekView()
    }
    
    init(title: String, ampm: String, time: String, week: WeekView) {
        self.title = title
        self.ampm = ampm
        self.time = time
        self.week = week
    }
}

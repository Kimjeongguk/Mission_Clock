//
//  ClockModel.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/19.
//

import UIKit

struct ClockModel {

    
    var ampm: String
    var time: String
    var week: WeekView
    
    init(){
        
        self.ampm = ""
        self.time = ""
        self.week = WeekView()
    }
    
    init(ampm: String, time: String, week: WeekView) {
        
        self.ampm = ampm
        self.time = time
        self.week = week
    }
}

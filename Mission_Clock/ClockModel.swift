//
//  ClockModel.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/19.
//

import UIKit

class ClockModel: NSObject, NSCoding, NSSecureCoding {
    static var supportsSecureCoding: Bool{
        return true
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(ampm, forKey: "ampm")
        coder.encode(time, forKey: "time")
        coder.encode(week, forKey: "week")
        
        
    }
    
    required convenience init?(coder: NSCoder) {
        let ampm = coder.decodeObject(forKey: "ampm") as! String
        let time = coder.decodeObject(forKey: "time") as! String
        let week = coder.decodeObject(forKey: "week") as! [Bool]
        
        self.init(ampm: ampm, time: time, week: week)
    }
    

    
    var ampm: String
    var time: String
    var week: [Bool]
    
    override init(){
        
        self.ampm = ""
        self.time = ""
        self.week = [false, false, false, false, false, false, false]
    }
    
    init(ampm: String, time: String, week: [Bool]) {
        
        self.ampm = ampm
        self.time = time
        self.week = week
    }
}

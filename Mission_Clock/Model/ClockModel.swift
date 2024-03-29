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
        coder.encode(date, forKey: "date")
        coder.encode(week, forKey: "week")
        coder.encode(sound, forKey: "sound")
        coder.encode(enable, forKey: "enable")
    }
    
    required convenience init?(coder: NSCoder) {
        let date = coder.decodeObject(forKey: "date") as! Date
        let week = coder.decodeObject(forKey: "week") as! [Bool]
        let sound = coder.decodeObject(forKey: "sound") as! SoundModel
        let enable = coder.decodeBool(forKey: "enable")
        self.init(date: date, week: week, sound: sound, enable: enable)
    }
    
    var date: Date
    var week: [Bool]
    var sound: SoundModel
    var enable: Bool
    
    
    override init(){
        
        self.date = Date()
        self.sound = SoundModel(id: 1, name: I.Sound.s1, duration: 2.06)
        self.week = [false, false, false, false, false, false, false]
        self.enable = true
    }
    
    init(date: Date, week: [Bool], sound: SoundModel, enable: Bool) {
        
        self.date = date
        self.week = week
        self.sound = sound
        self.enable = enable
    }
    
}

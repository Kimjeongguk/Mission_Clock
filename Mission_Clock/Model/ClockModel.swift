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
//        coder.encode(ampm, forKey: "ampm")
//        coder.encode(time, forKey: "time")
        coder.encode(date, forKey: "date")
        coder.encode(week, forKey: "week")
        coder.encode(sound, forKey: "sound")
        coder.encode(enable, forKey: "enable")
    }
    
    required convenience init?(coder: NSCoder) {
//        let ampm = coder.decodeObject(forKey: "ampm") as! String
//        let time = coder.decodeObject(forKey: "time") as! String
        let date = coder.decodeObject(forKey: "date") as! Date
        let week = coder.decodeObject(forKey: "week") as! [Bool]
        let sound = coder.decodeObject(forKey: "sound") as! SoundModel
        let enable = coder.decodeBool(forKey: "enable")
        self.init(date: date, week: week, sound: sound, enable: enable)
    }
    

//    var ampm: String
//    var time: String
    var date: Date
    var week: [Bool]
    var sound: SoundModel
    var enable: Bool
    
    
    override init(){
        
//        self.ampm = ""
//        self.time = ""
        self.date = Date()
        self.sound = SoundModel(id: 1, name: I.Sound.s1, duration: 2.06)
        self.week = [false, false, false, false, false, false, false]
        self.enable = true
    }
    
    init(date: Date, week: [Bool], sound: SoundModel, enable: Bool) {
        
//        self.ampm = ampm
//        self.time = time
        self.date = date
        self.week = week
        self.sound = sound
        self.enable = enable
    }
    
    
//    required init(_ r: RepresentationType) {
//        date = r["date"] as! Date
//        week = r["week"] as! [Bool]
//        sound = r["sound"] as! SoundModel
//        enable = r["enable"] as! Bool
//    }
}


//class Alarms: Persistable {
//    let ud: UserDefaults = UserDefaults.standard
//    let persistKey: String = "myAlarmKey"
//    var alarms: [ClockModel] = [] {
//        //observer, sync with UserDefaults
//        didSet{
//            persist()
//        }
//    }
//
//    private func getAlarmsDictRepresentation()->[PropertyReflectable.RepresentationType] {
//        return alarms.map {$0.propertyDictRepresentation}
//    }
//
//    init() {
//        alarms = getAlarms()
//    }
//
//    func persist() {
//        ud.set(getAlarmsDictRepresentation(), forKey: persistKey)
//        ud.synchronize()
//    }
//
//    func unpersist() {
//        for key in ud.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
//    }
//
//    var count: Int {
//        return alarms.count
//    }
//
//    //helper, get all alarms from Userdefaults
//    private func getAlarms() -> [ClockModel] {
//        let array = UserDefaults.standard.array(forKey: persistKey)
//        guard let alarmArray = array else{
//            return [ClockModel]()
//        }
//        if let dicts = alarmArray as? [PropertyReflectable.RepresentationType]{
//            if dicts.first?.count == ClockModel.propertyCount {
//                return dicts.map{ClockModel($0)}
//            }
//        }
//        unpersist()
//        return [ClockModel]()
//    }
//}

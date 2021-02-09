//
//  SoundModel.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/02/08.
//

import Foundation

class SoundModel: NSObject, NSCoding, NSSecureCoding{
    static var supportsSecureCoding: Bool{
        return true
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(duration, forKey: "duration")
    }
    
    required convenience init?(coder: NSCoder) {
        let id = coder.decodeInteger(forKey: "id")
        let name = coder.decodeObject(forKey: "name") as! String
        let duration = coder.decodeDouble(forKey: "duration")
        self.init(id: id, name: name, duration: duration)
    }
    
    static func == (lhs: SoundModel, rhs: SoundModel) -> Bool {
        return lhs.id == rhs.id
    }
//    override init(){
//        self.id = 1
//        self.name = "복싱벨"
//        self.duration = 2.06
//    }
//    
    var id: Int
    var name: String
    var duration: Double
    
    init(id: Int, name: String, duration: Double) {
        self.id = id
        self.name = name
        self.duration = duration
    }
}

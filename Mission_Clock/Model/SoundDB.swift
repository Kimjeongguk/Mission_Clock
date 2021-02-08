//
//  SoundDB.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/02/08.
//

import Foundation

struct SoundDB {
    var sounds = [SoundModel]()
    var count: Int{
        get{
            return sounds.count
        }
    }
    
    init(){
        sounds = [
            SoundModel(id: 1, name: I.Sound.s1, duration: 2.06),
            SoundModel(id: 2, name: I.Sound.s2, duration: 48.20),
            SoundModel(id: 3, name: I.Sound.s3, duration: 2.27),
            SoundModel(id: 4, name: I.Sound.s4, duration: 11.18),
            SoundModel(id: 5, name: I.Sound.s5, duration: 15.86)
        ]
    }
    
    func getSound(at position: Int) -> SoundModel?{
        guard 0...(sounds.count - 1) ~= position else{
            return nil
        }
        
        return sounds[position]
    }
    
    func getPosition(_ sound: SoundModel) -> Int?{
        return sounds.firstIndex{ $0 == sound }
    }
}

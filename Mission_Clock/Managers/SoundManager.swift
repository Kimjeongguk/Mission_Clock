//
//  SoundManager.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/02/08.
//

import Foundation
import AVFoundation

struct SoundManager{
    var player: AVAudioPlayer?
    var sound: SoundModel?
    
    func currentlyPlay() -> SoundModel?{
        return sound
    }
    
    mutating func play(this sound: SoundModel){
        stop()
        do{
            guard let url = Bundle.main.url(forResource: sound.name, withExtension: ".mp3") else{
                return
            }
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            self.sound = sound
            
        }catch let error{
            print(error.localizedDescription)
        }
        
    }
    mutating func stop(){
        player?.stop()
        self.sound = nil
    }
}

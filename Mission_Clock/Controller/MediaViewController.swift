//
//  MediaViewController.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/29.
//

import UIKit
import AVFoundation

class MediaViewController: UIViewController {
    
    let bellList: [String] = ["복싱벨", "성당종", "소방벨", "응급실", "x-ray"]
    var sound: String = String()
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("\(sound)")
        self.performSegue(withIdentifier: "toSound", sender: self)
       
    }
    
}

extension MediaViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        player?.stop()
        if let player = player, player.isPlaying{
//            player.stop()
        }else{
            sound = bellList[indexPath.row]
            let urlString = Bundle.main.path(forResource: "mp3/\(bellList[indexPath.row])", ofType: "mp3")
            do{
                
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else{
                    return
                }
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else{
                    return
                }
                player.play()
            }catch{
                 print("somthing went wrong ")
            }
        }
        
    }
}

extension MediaViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "soundCell")
        if(cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default, reuseIdentifier: "soundCell")
        }
        
        cell!.textLabel!.text = bellList[indexPath.row]
        
        return cell!
    }
    
    
}

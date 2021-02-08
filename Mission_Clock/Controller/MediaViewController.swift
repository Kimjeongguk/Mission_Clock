//
//  MediaViewController.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/29.
//

import UIKit
import AVFoundation

class MediaViewController: UIViewController {
    
    
    @IBOutlet var soundTableView: UITableView!
    
    var sound = SoundDB()
    var soundManager = SoundManager()
    var clockModel = ClockModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.performSegue(withIdentifier: I.SegueFrom.sound, sender: self)
        soundManager.stop()
    }
    
}

extension MediaViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        soundManager.play(this: sound.sounds[indexPath.row])
        clockModel.sound = sound.sounds[indexPath.row]
    }
}

extension MediaViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sound.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: I.Cell.soundCell)
        if(cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default, reuseIdentifier: I.Cell.soundCell)
        }
        
        cell!.textLabel!.text = sound.sounds[indexPath.row].name
        
        return cell!
    }
    
    
}

//
//  MediaViewController.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/29.
//

import UIKit

class MediaViewController: UIViewController {
    
    let bellList: [String] = ["복싱벨", "성당종", "소방벨", "응급실", "So Young lkoliks", "x-ray"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension MediaViewController: UITableViewDelegate{
    
}

extension MediaViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bellList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let soundCell = tableView.dequeueReusableCell(withIdentifier: "soundCell", for: indexPath)
        
        soundCell.detailTextLabel?.text = bellList[indexPath.row]
        
        return soundCell
    }
    
    
}

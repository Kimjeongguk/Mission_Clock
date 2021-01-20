//
//  ViewController.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/18.
//

import UIKit

class ViewController: UIViewController {

    var clockList: [ClockModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dummy = ClockModel.init(title: "test", ampm: "AM", time: "10:10", week: 0)
        clockList.append(dummy)
    }


}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clockList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let clockCell = tableView.dequeueReusableCell(withIdentifier: "clockCell", for: indexPath) as! ClockCell
        clockCell.titleLabel.text = clockList[indexPath.row].title
        clockCell.apmLabel.text = clockList[indexPath.row].ampm
        clockCell.clockLabel.text = clockList[indexPath.row].time
        clockCell.weekView.num = clockList[indexPath.row].week
        clockCell.weekView.isUserInteractionEnabled = false
        
        return clockCell
    }
    
    
}

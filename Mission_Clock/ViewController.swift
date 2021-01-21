//
//  ViewController.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var clockTableView: UITableView!
    var clockList: [ClockModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dummy = ClockModel.init(title: "test", ampm: "오전", time: "10:10", week: WeekView())
        clockList.append(dummy)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editshowDetail"{
            let detailVC = segue.destination as! ClockDetailViewController
            let selectedCell = sender as! ClockCell
            if let seletedIndexPath = clockTableView.indexPath(for: selectedCell){
                detailVC.clockModel = clockList[seletedIndexPath.row]
            }
        }else if segue.identifier == "addshowDetail"{
            
        }
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
        
        clockCell.weekView.isUserInteractionEnabled = false
        clockCell.weekView = clockList[indexPath.row].week
        
        return clockCell
    }
    
    
}

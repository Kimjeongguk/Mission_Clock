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
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)

//        let notificationCenter = NotificationCenter.default
//            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)

        
        if let loadClocks = loadClocks(){
            self.clockList = loadClocks
        }
//        let dummy = ClockModel.init(ampm: "오후", time: "3:33", week: [true,true,true,true,true,true,true])
//        clockList.append(dummy)
        
    }
    @objc func appMovedToBackground() {
        print("App moved to Background!")
    }
    override func viewWillAppear(_ animated: Bool) {
        if let selectedIndexRow = self.clockTableView.indexPathForSelectedRow{
            self.clockTableView.deselectRow(at: selectedIndexRow, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dist = segue.destination as! UINavigationController
        let controller = dist.topViewController as! ClockDetailViewController
        if segue.identifier == "editshowDetail"{
//            let detailVC = segue.destination as! ClockDetailViewController
            let selectedCell = sender as! ClockCell
            if let selectedIndexPath = clockTableView.indexPath(for: selectedCell){
                controller.clockModel = clockList[selectedIndexPath.row]
            }
        }else if segue.identifier == "addshowDetail"{
            
        }
    }
    
    var isEditMode = false
    @IBAction func doEdit(_ sender: Any) {
        isEditMode = !isEditMode
        clockTableView.setEditing(isEditMode, animated: true) //테이블뷰 편집기능
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            clockList.remove(at: indexPath.row)
            clockTableView.deleteRows(at: [indexPath], with: .automatic)
            saveClocks()
        }
    }
    @IBAction func unwindToClockList(sender: UIStoryboardSegue){ //toclocklist로 반환받았을때 실행됨
        guard let detailVC = sender.source as? ClockDetailViewController else{
            return
        }
        if let selectedIndexPath = self.clockTableView.indexPathForSelectedRow{
            clockList[selectedIndexPath.row] = detailVC.clockModel
            self.clockTableView.reloadRows(at: [selectedIndexPath], with: .none) // 테이블뷰에서 선택한 항목만 갱신
//            self.clockTableView.deselectRow(at: selectedIndexPath, animated: true) //선택한 항목의 표시를 제거하는것 근데 reload하면 자동으로 사라져서 여기선 불필요
            
        }else{
            clockList.append(detailVC.clockModel)
            self.clockTableView.reloadData()
            
        }
        
        saveClocks()
    }
    
    func saveClocks(){ //archive 방식
        
        DispatchQueue.global().async {
        
            let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
            
            guard let archiveURL = documentDirectory?.appendingPathComponent("clocks") else{
                return
            }
            
            do{
                let archiveDate = try NSKeyedArchiver.archivedData(withRootObject: self.clockList, requiringSecureCoding: true)
                try archiveDate.write(to: archiveURL)
            }catch{
                print("애러 ===>> \(error)")
            }
        }
    }

    func loadClocks() -> [ClockModel]? {
        let documentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
        
        guard let archiveURL = documentDirectory?.appendingPathComponent("clocks") else{
            return nil
        }
        guard let codeedData = try? Data(contentsOf: archiveURL) else{
            return nil
        }
        guard let unarchiveData = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codeedData) else{
            return nil
        }
        return unarchiveData as? [ClockModel]
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
        clockCell.apmLabel.text = clockList[indexPath.row].ampm
        clockCell.clockLabel.text = clockList[indexPath.row].time
        
        clockCell.weekView.isUserInteractionEnabled = false
        clockCell.weekView.weekDate = clockList[indexPath.row].week

        
        return clockCell
    }
}




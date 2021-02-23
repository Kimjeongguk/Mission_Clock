//
//  ViewController.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var clockTableView: UITableView!
    var alarm: AlarmSchedulerDelegate = Scheduler()
    var alarmScheduler: AlarmSchedulerDelegate = Scheduler()
    var clockList: [ClockModel] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        if let loadClocks = loadClocks(){
            self.clockList = loadClocks
        }
//        let dummy = ClockModel.init(ampm: "오후", time: "3:33", week: [true,true,true,true,true,true,true])
//        clockList.append(dummy)
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
                self.alarm.saveNotifications(clockList: self.clockList)
                
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        
        clockCell.apmLabel.text = dateFormatter.string(from: clockList[indexPath.row].date) == "AM" ? "오전" : "오후"
        dateFormatter.dateFormat = "h:mm"
        clockCell.clockLabel.text = dateFormatter.string(from: clockList[indexPath.row].date)
        
        clockCell.weekView.isUserInteractionEnabled = false
        clockCell.weekView.weekDate = clockList[indexPath.row].week
        
        clockCell.switchButton.tag = indexPath.row
        clockCell.switchButton.isOn = clockList[indexPath.row].enable
        clockCell.switchButton.addTarget(self, action: #selector(switchTap), for: UIControl.Event.valueChanged)
        
        return clockCell
    }
    
    @objc func switchTap(_ sender: UISwitch){
        clockList[sender.tag].enable = !clockList[sender.tag].enable
        saveClocks()
    }
    
}


extension ViewController: UNUserNotificationCenterDelegate {
    
//    앱이 foreground에서 실행될 때 로컬 알림이 사용자에게 표시되도록하려면 UNUserNotificationCenterDelegate 의 함수 중 하나를 구현해야합니다. 바로 밑에 함수
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        completionHandler( [.badge, .sound])
        for index in 0..<clockList.count{
            if notification.date == clockList[index].date{
                if clockList[index].week.filter({ $0 == true }).isEmpty{
                    clockList[index].enable = false
                    clockTableView.reloadData()
                    saveClocks()
                    print("test")
                    break
                }
            }
        }
    }
    
    // 사용자가 응용 프로그램을 열거나 알림을 해제하거나 UN Notification Action을 선택하여 알림에 응답하면 메소드가 대리인에게 호출됩니다
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        if let additionalData = userInfo["additionalData"] as? String {
            print("Additional data: \(additionalData)")
        }
        
        
        
        for index in 0..<clockList.count{
            if response.notification.date == clockList[index].date{
                print("sibal")
                if clockList[index].week.filter({ $0 == true }).isEmpty{
                    clockList[index].enable = false
                    clockTableView.reloadData()
                    saveClocks()
                    print("testback")
                    break
                }
            }
        }
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier:
            print("User tapped on message itself rather than on an Action button") // 알람을 클릭하면 실행됨
            
        default:
            break
        }
        
        completionHandler()
    }
 
}



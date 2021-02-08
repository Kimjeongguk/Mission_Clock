//
//  ClockDetailViewController.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/20.
//

import UIKit

class ClockDetailViewController: UIViewController {

    @IBOutlet var weekView: WeekView!
    @IBOutlet var pickerView: UIDatePicker!
    @IBOutlet var selectTableView: UITableView!
    
    var clockModel = ClockModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekView.weekDate = clockModel.week

        var ampm = ""
        if clockModel.ampm == "오전"{
            ampm = "AM"
        }else if clockModel.ampm == "오후"{
            ampm = "PM"
        }
        
        let dateString = "\(ampm) \(clockModel.time)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:mm"
        if let date = dateFormatter.date(from: dateString){
            pickerView.setDate(date, animated: false)
        }
        
        
        
    }
    @IBAction func unwindToSound(sender: UIStoryboardSegue){
        if let soundVC = sender.source as? MediaViewController{
            clockModel.sound = soundVC.clockModel.sound
            selectTableView.reloadData()
        }
    }

    @IBAction func dismissView(_ sender: Any) { //취소후 뒤로가기
//        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: Any) { // 데이터 저장해서 리스트에 추가
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        clockModel.ampm = formatter.string(from: pickerView.date) == "AM" ? "오전" : "오후"

        formatter.dateFormat = "h:mm"
        clockModel.time = formatter.string(from: pickerView.date)
        
        clockModel.week = weekView.weekDate
        
        self.performSegue(withIdentifier: "toClockList", sender: self)
    }
    
    @IBAction func dataPicker(_ sender: Any) { //datepickerview에 값저장
        let datePickerView = sender
        
        pickerView = datePickerView as! UIDatePicker
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "soundSegue"{
            if let controller = segue.destination as? MediaViewController{
                controller.clockModel = clockModel
            }
            //일단 대기
        }else if segue.identifier == "missionSegue"{
            
        }
    }
    
}

extension ClockDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //셀을 클릭했을 때 넘어가게 만드는함수??
        let cell = tableView.cellForRow(at: indexPath)
        switch indexPath.row{
        case 0:
            performSegue(withIdentifier: "soundSegue", sender: self)
            cell?.setSelected(true, animated: false)
            cell?.setSelected(false, animated: false)
        case 1:
            performSegue(withIdentifier: "missionSegue", sender: self)
            cell?.setSelected(true, animated: false)
            cell?.setSelected(false, animated: false)
        default:
            break
        }
    }
    
}
extension ClockDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {//tableview에 각각의 cell 의 정보를 추가해주는 함수
        var cell = tableView.dequeueReusableCell(withIdentifier: "setting")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "setting")
        }
       
        if indexPath.row == 0 {
            cell!.textLabel!.text = "Sound"
            cell!.detailTextLabel!.text = clockModel.sound.name
            cell!.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
//        else if indexPath.row == 1{
//            cell?.textLabel?.text = "Mission"
////            Cell?.detailTextLabel?.text = clockModel.mission
//            cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
//        }
           
        
        return cell!
    }
    
    
}

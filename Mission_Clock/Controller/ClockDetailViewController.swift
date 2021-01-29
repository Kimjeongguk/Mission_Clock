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
    
    var clockModel = ClockModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        weekView.delegate = self
        
        weekView.weekDate = clockModel.week

        var ampm = ""
        if clockModel.ampm == "오전"{
            ampm = "AM"
        }else if clockModel.ampm == "오후"{
            ampm = "PM"
        }
        
        let dateString = "\(ampm) \(clockModel.time)"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a h:m"
        if let date = dateFormatter.date(from: dateString){
            pickerView.setDate(date, animated: false)
        }
        
    }
    

    @IBAction func dismissView(_ sender: Any) { //취소후 뒤로가기
//        self.performSegue(withIdentifier: "toClockList", sender: self)   //cell 클릭해서들어와서 취소누르면 이걸로
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func saveButton(_ sender: Any) { // 데이터 저장해서 리스트에 추가
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        clockModel.ampm = formatter.string(from: pickerView.date) == "AM" ? "오전" : "오후"

        formatter.dateFormat = "h:m"
        clockModel.time = formatter.string(from: pickerView.date)
        
        clockModel.week = weekView.weekDate
        
        self.performSegue(withIdentifier: "toClockList", sender: self)
    }
    
    @IBAction func dataPicker(_ sender: Any) { //datepickerview에 값저장
        let datePickerView = sender
        
        pickerView = datePickerView as! UIDatePicker
        
    }
    
}

extension ClockDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
extension ClockDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var soundCell = tableView.dequeueReusableCell(withIdentifier: "setting")
        if soundCell == nil {
            soundCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "setting")
        }
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                soundCell!.textLabel!.text = "Sound"
                soundCell!.detailTextLabel!.text = clockModel.sound
                soundCell!.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }
           
        }
        return soundCell!
    }
}

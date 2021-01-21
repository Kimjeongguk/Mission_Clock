//
//  ClockDetailViewController.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/20.
//

import UIKit

class ClockDetailViewController: UIViewController {

    
    @IBOutlet var titlrField: UITextField!
    @IBOutlet var weekView: WeekView!
    @IBOutlet var pickerView: UIDatePicker!
    
    var clockModel = ClockModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titlrField.text = clockModel.title
        weekView = clockModel.week
        var date = Date.init()
        let formatter = DateFormatter()
        formatter.dateFormat = "h:m"
        let someDateTime = formatter.date(from: "10:10")
        
        pickerView.setDate(<#T##date: Date##Date#>, animated: false)
        let formatterPeriod = DateFormatter()
        formatterPeriod.dateStyle = .none
        let formatterHour = DateFormatter()
        formatterHour.dateStyle = .short
        
    }
    

    @IBAction func dismissView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dataPicker(_ sender: Any) {
        let datePickerView = sender
        
        pickerView = datePickerView as! UIDatePicker
        
    }
    
}

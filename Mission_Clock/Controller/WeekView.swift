//
//  WeekView.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/19.
//

import UIKit
//
//protocol weekViewDelegate {
//    func weekStatusChanged()
//}

class WeekView: UIStackView {

//    var delegate: weekViewDelegate?
    
    private var weekButtons: [UIButton] = []
    
    public var weekDate = [false, false, false, false, false, false, false]{
        didSet{
//            delegate?.weekStatusChanged()
            setUpWeekDate()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton(){
        
        self.spacing = (self.bounds.size.width - (self.bounds.size.height * 7)) / 8
        
        for index in 0..<7{
            
            let button = UIButton()
            
            button.widthAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
            button.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
            
            button.tag = index
            button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
            
            button.setImage(UIImage(named: "\(index)"), for: .normal)
            button.setImage(UIImage(named: "g\(index)"), for: .selected)
            
            self.addArrangedSubview(button)
            weekButtons.append(button)
        }
    }
    
    @objc func clickButton(sender: UIButton){
        weekDate[sender.tag] = !weekDate[sender.tag]
        
    }
    func setUpWeekDate(){
        for i in 0..<7{
            weekButtons[i].isSelected = weekDate[i]
        }
    }
}

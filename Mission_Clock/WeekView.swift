//
//  WeekView.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/19.
//

import UIKit

class WeekView: UIStackView {

    private var weekButtons: [UIButton] = []
    
//    public var check = [false, false, false, false, false, false, false]
    public var num = 0{
        didSet{
            updateButtonState()
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
        
        
        for index in 0..<7{
            
            let button = UIButton()
            
            button.widthAnchor.constraint(equalToConstant: 25).isActive = true
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.setImage(UIImage(named: "\(index)"), for: .normal)
            button.setImage(UIImage(named: "g\(index)"), for: .selected)
            
            self.addArrangedSubview(button)
            weekButtons.append(button)
        }
    }

    func updateButtonState(){
        weekButtons[num].isSelected = !weekButtons[num].isSelected
    }
}

//
//  ClockCell.swift
//  Mission_Clock
//
//  Created by Jeongguk Kim on 2021/01/20.
//

import UIKit

class ClockCell: UITableViewCell {

    @IBOutlet var weekView: WeekView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var apmLabel: UILabel!
    @IBOutlet var clockLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

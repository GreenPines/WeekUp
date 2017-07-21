//
//  checklistTableViewCell.swift
//  WeekUp2
//
//  Created by Jerry on 17/7/17.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit

class checklistTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityDetail: UIImageView!
    @IBOutlet weak var more: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

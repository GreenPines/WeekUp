//
//  AddedUserCell.swift
//  WeekUp2
//
//  Created by zuhui on 2017/7/19.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit

class AddedUserCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var teamerNameLabel: UILabel!
    @IBOutlet weak var teamerRoleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

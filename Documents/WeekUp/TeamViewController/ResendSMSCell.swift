//
//  ResendSMSCell.swift
//  WeekUp2
//
//  Created by zuhui on 2017/7/18.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit

class ResendSMSCell: UITableViewCell {
    @IBOutlet weak var phoneNumber: UILabel!

    @IBAction func ResendSMS(_ sender: UIButton) {
        print("Resend SMS")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

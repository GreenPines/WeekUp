//
//  UpTableHead.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/13.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class UpTableHead: UITableViewCell {

    @IBOutlet weak var monYear: UILabel!
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

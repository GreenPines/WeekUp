//
//  weekCell.swift
//  WKTabBarController-Example
//
//  Created by Jerry on 17/7/13.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class weekCell: UITableViewCell {
    
    @IBOutlet weak var weekNo: UILabel!
    @IBOutlet weak var allAct: UILabel!
    @IBOutlet weak var logOut: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

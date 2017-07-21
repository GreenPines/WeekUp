//
//  WeekRankTableCell.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/13.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class WeekRankTableCell: UITableViewCell {

    @IBOutlet weak var rankNum: UILabel!
    @IBOutlet weak var rankBgImage: UIImageView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var assessmentNum: UILabel!
    @IBOutlet weak var postNum: UILabel!
    @IBOutlet weak var checklistNum: UILabel!
    @IBOutlet weak var upNum: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var circleProgressView: CircleProgressView!
    
    var userPhoneNum: String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

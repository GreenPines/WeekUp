//
//  activityCell.swift
//  WKTabBarController-Example
//
//  Created by Jerry on 17/7/13.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class activityCell: UITableViewCell {

    
    @IBOutlet weak var actImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var activitityNum: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        actImage.layer.cornerRadius = actImage.bounds.size.width / 2
        actImage.clipsToBounds = true
        separatorInset = UIEdgeInsets(top: 0, left: 82, bottom: 0, right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

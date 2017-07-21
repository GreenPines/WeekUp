//
//  messagesCell.swift
//  WKTabBarController-Example
//
//  Created by Jerry on 17/7/12.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class messagesCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var atLabel: UILabel!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var inform: UILabel!
    @IBOutlet weak var time: UILabel!
    var type: String!
    
    lazy var badge: PPBadgeLabel = {
        return PPBadgeLabel.defaultBadgeLabel()
    }()
    
    
    override func awakeFromNib() {
        //self.setupBadge()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupBadge(text: String) {

        // 2. 给cell添加badge
        self.badge.backgroundColor = UIColor.red
        //self.badge.text = "\(arc4random()%300)"
        self.badge.text = text
        
        //self.badge.p_right = inform.frame.origin.x + inform.frame.size.width + 1

        self.badge.p_right = UIScreen.main.bounds.size.width - 25
        
        self.badge.p_centerY = self.p_height * 0.5

        self.contentView.addSubview(self.badge)

    }
    
}

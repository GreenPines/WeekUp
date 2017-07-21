//
//  TeamMemberCell.swift
//  WeekUp2
//
//  Created by zuhui on 2017/7/18.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit

class TeamMemberCell: UITableViewCell {
    
    @IBOutlet weak var teamerNameLabel: UILabel!
    @IBOutlet weak var teamerRoleLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var isVote: UIButton!
    
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        let selectedView = UIView(frame: CGRect.zero)
//        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255,
//                                               blue: 160/255, alpha: 0.5)
//        selectedBackgroundView = selectedView
//        avatar?.layer.cornerRadius = 50
//        avatar?.clipsToBounds = true
//        avatar?.contentMode = .scaleAspectFit
//        avatar?.backgroundColor = UIColor.lightGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatar?.image = nil
    }
    
}

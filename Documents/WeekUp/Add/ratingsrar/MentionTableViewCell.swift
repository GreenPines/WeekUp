//
//  MentionTableViewCell.swift
//  ratingsrar
//
//  Created by lion on 2017/7/19.
//  Copyright © 2017年 menglili. All rights reserved.
//

import UIKit

class MentionTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTeam: UILabel!
    @IBOutlet weak var userImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

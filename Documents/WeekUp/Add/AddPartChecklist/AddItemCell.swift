//
//  AddItemCell.swift
//  AddPartChecklist
//
//  Created by 黄豪杰 on 2017/7/12.
//  Copyright © 2017年 黄豪杰. All rights reserved.
//

import UIKit

class AddItemCell: UITableViewCell {
    
    
    var reminderButton: UIButton!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)!

    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.backgroundColor = UIColor.red
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

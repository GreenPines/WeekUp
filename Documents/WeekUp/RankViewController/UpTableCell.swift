//
//  UpTableCell.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/12.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class UpTableCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userChecklist: UILabel!
    @IBOutlet weak var userPost: UILabel!
    @IBOutlet weak var userAssessment: UILabel!
    @IBOutlet weak var userUp: UIButton!
    @IBOutlet weak var circleProgressView: CircleProgressView!
    
    var upTableView: UITableView!
    var upViewController: UpViewController!
    var userPhoneNum: String!

    @IBAction func doUp(_ sender: UIButton) {
        upViewController.rightBtn.isEnabled = true
        for index in 0...upTableView.numberOfRows(inSection: 0)-1 {
            let cell = upTableView.cellForRow(at: [0, index]) as! UpTableCell
            cell.isUp = false
            cell.userUp.setImage(#imageLiteral(resourceName: "updisable"), for: .normal)
        }
        
        if !isUp {
            userUp.setImage(#imageLiteral(resourceName: "upenable"), for: .normal)
            isUp = true
        } else {
            userUp.setImage(#imageLiteral(resourceName: "updisable"), for: .normal)
            isUp = false
        }
    }
    
    var isUp = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImage.layer.cornerRadius = userImage.bounds.size.width / 2
        userImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}

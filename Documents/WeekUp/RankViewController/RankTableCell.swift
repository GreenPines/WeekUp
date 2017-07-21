//
//  RankTableCell.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/11.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class RankTableCell: UITableViewCell {
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var user1Image: UIImageView!
    @IBOutlet weak var user1Name: UILabel!
    @IBOutlet weak var user1UpNum: UILabel!
    @IBOutlet weak var user2Image: UIImageView!
    @IBOutlet weak var user2Name: UILabel!
    @IBOutlet weak var user2UpNum: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        user1Image.layer.cornerRadius = user1Image.bounds.size.width / 2
        user1Image.clipsToBounds = true
        
        user2Image.layer.cornerRadius = user2Image.bounds.size.width / 2
        user2Image.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getUserName(userPhoneNum: String) -> String {
        if userPhoneNum == "11111111" {
            return "1111 1111"
        } else if userPhoneNum == "22222222" {
            return "2222 2222"
        } else if userPhoneNum == "33333333" {
            return "3333 3333"
        } else if userPhoneNum == "44444444" {
            return "4444 4444"
        } else {
            return "hello hhhh"
        }
    }
    
    func getUserImg(userPhoneNum: String) -> String {
        return "user"
    }
    
    func getUserUp(userPhoneNum: String, selectedTeam: String, monYear: String, week: Int) -> Int {
        //如果week == -1 返回这个monYear的总赞数
        if week == -1 {
            return 20
        } else {
            return 10
        }
    }
    
    func configure(user1: String, user2: String, monYear: String, week: Int, selectedTeam: String) {
        if week == -1 {
            weekLabel.text = ""
        } else {
            weekLabel.text = String(format: "Week %d", week+1)
        }
        
        user1Name.text = getUserName(userPhoneNum: user1)
        user1Image.image = UIImage(named: getUserImg(userPhoneNum: user1))
        user1UpNum.text = "\(getUserUp(userPhoneNum: user1, selectedTeam: selectedTeam, monYear: monYear, week: week))"
        
        user2Name.text = getUserName(userPhoneNum: user2)
        user2Image.image = UIImage(named: getUserImg(userPhoneNum: user2))
        user2UpNum.text = "\(getUserUp(userPhoneNum: user2, selectedTeam: selectedTeam, monYear: monYear, week: week))"
        
    }

}

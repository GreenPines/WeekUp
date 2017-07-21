//
//  message.swift
//  WeekUp2
//
//  Created by Jerry on 17/7/20.
//  Copyright © 2017年 android. All rights reserved.
//

import Foundation
import UIKit

class message{
    
    var type: String
    var userImg: UIImage
    var userName: String
    var userTeam: String
    var date: String
    var informMeg: String
    var badge: Int
    
    init(type:String, userImg:UIImage, userName:String, userTeam:String, date:String, informMeg:String, badge: Int){
        self.type = type
        self.userImg = userImg
        self.userName = userName
        self.userTeam = userTeam
        self.date = date
        self.informMeg = informMeg
        self.badge = badge
    }
}

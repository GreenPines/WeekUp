//
//  ChecklistItem.swift
//  AddPartChecklist
//
//  Created by 黄豪杰 on 2017/7/13.
//  Copyright © 2017年 黄豪杰. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, NSCoding {
    
    struct Constants {
        let beforeRemind : Date  //提前开始提醒的时间
    }
    
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false    //默认不推送
    var itemID: Int
    
    /** 初始化 
     **/
    override init() {
        
        //生成itemID
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        //解码
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        itemID = aDecoder.decodeInteger(forKey: "ItemID")

        super.init()
    }
    

    
    deinit {
        removeNotification()
    }
    
    
    func toggleChecked() {
        checked = !checked
    }
    
    /** 编码
     **/
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
        aCoder.encode(dueDate, forKey: "DueDate")
        aCoder.encode(shouldRemind,forKey: "ShouldRemind")
        aCoder.encode(itemID, forKey: "ItemID")
    }
    
    /** 通知推送 
     **/
    func scheduleNotification() {
        
        removeNotification()
        
        /** 提醒为true 且 定时到达时 
            可以设置提前多少时间开始提醒
         **/
        if shouldRemind && dueDate > Date() {
            print("We should schedule a notigication")
            
            // 1
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default()
            
            // 2
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(
                [.month, .day, .hour, .minute], from: dueDate)   // 有修改，可是weekOfMonth
            // 3
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components, repeats: false)
            
            // 4   identifier 是 itemID
            let request = UNNotificationRequest(identifier: "\(itemID)",
                                                content: content,trigger: trigger)
            // 5
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            print("Scheduled notification \(request) for itemID \(itemID)")
            
        }
    }
    
    /** 移除通知 
     **/
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
}

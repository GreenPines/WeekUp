//
//  Checklist.swift
//  AddPartChecklist
//
//  Created by 黄豪杰 on 2017/7/16.
//  Copyright © 2017年 黄豪杰. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    
    var name = ""
    var items = [ChecklistItem]()
    var weekID : Int
    var monthID : Int
    var yearID : Int
    var stTime = ""
    var edTime = ""
    
    /** 便携初始化 
     **/
    convenience init(name: String) {
        self.init(name: name, weekID: 1, monthID: 7, yearID: 2017,
                  stTime: "2017-7-17", edTime: "2017-7-23")
    }
    
    init(name: String, weekID: Int, monthID: Int, yearID: Int,
         stTime: String, edTime: String) {
        self.name = name
        self.weekID = weekID
        self.monthID = monthID
        self.yearID = yearID
        self.stTime = stTime
        self.edTime = edTime
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        // 解码
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        weekID = aDecoder.decodeInteger(forKey: "WeekID")
        monthID = aDecoder.decodeInteger(forKey: "MonthID")
        yearID = aDecoder.decodeInteger(forKey: "YearID")
        stTime = aDecoder.decodeObject(forKey: "StTime") as! String
        edTime = aDecoder.decodeObject(forKey: "EdTime") as! String
        super.init()
    }
    
    /** 编码 
     **/
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(weekID, forKey:"WeekID")
        aCoder.encode(monthID, forKey: "MonthID")
        aCoder.encode(yearID, forKey: "YearID")
        aCoder.encode(stTime, forKey: "StTime")
        aCoder.encode(edTime, forKey: "EdTime")
    }
    
    /** 计算未勾选items数 
     **/
    func countUncheckedItems() -> Int {
        var count = 0
        for item in  items where !item.checked {
            count += 1
        }
        return count
    }
    

}

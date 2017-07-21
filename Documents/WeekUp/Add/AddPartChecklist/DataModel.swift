//
//  DataModel.swift
//  AddPartChecklist
//
//  Created by 黄豪杰 on 2017/7/18.
//  Copyright © 2017年 黄豪杰. All rights reserved.
//

import Foundation
import CVCalendar

class DataModel {

    var lists = [Checklist]()
    
    /** 初始化数据
     **/
    var currentCalendar = Calendar.init(identifier: .gregorian)
    struct Variables {
        
        // 真实世界的本周list(空表)
        static var thisweeklist = Checklist(
            name: "Week \(AddViewController.Variables.weekID_this)",
            weekID: AddViewController.Variables.weekID_this,
            monthID: AddViewController.Variables.monthID_this,
            yearID: AddViewController.Variables.yearID_this,
            stTime: AddViewController.Variables.stTime_this,
            edTime: AddViewController.Variables.edTime_this)
        
        // 真实世界的下周list(空表)
        static var nextweeklist = Checklist(
            name: "Week \(AddViewController.Variables.weekID_next)",
            weekID: AddViewController.Variables.weekID_next,
            monthID: AddViewController.Variables.monthID_next,
            yearID: AddViewController.Variables.yearID_next,
            stTime: AddViewController.Variables.stTime_next,
            edTime: AddViewController.Variables.edTime_next)
        
    }
    

    /** 时间变更判断策略 
        用户下一次进入时
        根据现实世界的时间变化
        推算出list是否需要更新
     **/
    func judgeTime() {
        let jweek = (lists[0].weekID == AddViewController.Variables.weekID_this) //判断周相同
        let jnext = (lists[1].weekID == AddViewController.Variables.weekID_this) //判断是否恰好隔了一周
        let jmonth = (lists[0].monthID == AddViewController.Variables.monthID_this) //判断月相同
        let jyear = (lists[0].yearID == AddViewController.Variables.yearID_this) //判断年相同
        

        //策略A： 下周变这周，下周清空
        if jnext && jmonth && jyear {
            
            lists[0] = lists[1] //copy 可变集合中的对象是浅拷贝，集合本身是深拷贝
            lists[1] = Variables.nextweeklist // lists[1]改变指针，不影响lists[0]
        }
        
        //策略B： 两周都清空
        if (!jweek && !jnext) || !jmonth || !jyear {
//            lists.removeAll()
            // 值拷贝，深拷贝
            lists[0] = Variables.thisweeklist
            lists[1] = Variables.nextweeklist
        }
        
    }
    
    /** 初始化 
     **/
    init() {
        print("初始化")
        print("初始化时lists = \(lists.count)")
        
        loadChecklists()
        print("load时lists = \(lists.count)")
        
        // 用户曾经使用过App，存在2张表，才进行变更判断
        if lists.count==2 {
            judgeTime()
        }
        
        
        registerDefaults()
        datanum()
        handleFirstTime()
        print("初始化结束")
        print("WeekUp_Documents folder is\(self.documentsDirectory())")
        print("WeekUp_Data file path is\(self.dataFilePath())")
        
    }
    func datanum(){
        var weeknum = CVDate(date: Date(), calendar: currentCalendar).week
        var monthnum = CVDate(date: Date(), calendar: currentCalendar).month
        var yearnum = CVDate(date: Date(), calendar: currentCalendar).year
        
        
        AddViewController.Variables.yearID_this = yearnum
        AddViewController.Variables.monthID_this = monthnum
        switch weeknum{
        case 1:
            AddViewController.Variables.weekID_this = 5
            AddViewController.Variables.weekID_next = 1
            
        case 2,3,4,5,6:
            AddViewController.Variables.weekID_this = weeknum-1
            if weeknum == 6{
                AddViewController.Variables.weekID_next = 1
                if monthnum == 12{
                    AddViewController.Variables.yearID_next = yearnum + 1
                    AddViewController.Variables.monthID_next = 1
                    
                }
                AddViewController.Variables.monthID_next = monthnum + 1
            }
            else{
                AddViewController.Variables.weekID_next = weeknum
                AddViewController.Variables.yearID_next = yearnum
                AddViewController.Variables.monthID_next = monthnum
            }
        default:
            break
        }

    }
    
    /** 文档目录 
     **/
    func documentsDirectory() -> URL {
        
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    
    /** plist数据文件地址。
     **/
    func dataFilePath() -> URL {
        
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    /** save 
     **/
    func saveChecklists() {
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    /** load 
     **/
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            print("decodeObject")
            lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
            unarchiver.finishDecoding()
            print("finishDecoding")
        }
        
    }
    
    func registerDefaults() {
        let dictionary: [String: Any] = ["ChecklistIndex": -1,
                                         "FirstTime": true,
                                         "ChecklistItemID": 0 ]
        UserDefaults.standard.register(defaults: dictionary)
    }
    
    /** 首次处理 
     **/
    func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
     
        print("firstTime = \(firstTime)")
        print("lists = \(lists.count)")
        
        if firstTime || lists.count == 0 {
            print("firstTime ...")
            
            // 使用初始化数据
//            let checklist1 = DataModel.Variables.thisweeklist
//            let checklist2 = DataModel.Variables.nextweeklist
            let checklist1 = Checklist(
                name: "Week \(AddViewController.Variables.weekID_this)",
                weekID: AddViewController.Variables.weekID_this,
                monthID: AddViewController.Variables.monthID_this,
                yearID: AddViewController.Variables.yearID_this,
                stTime: AddViewController.Variables.stTime_this,
                edTime: AddViewController.Variables.edTime_this)
            let checklist2 = Checklist(
            name: "Week \(AddViewController.Variables.weekID_next)",
            weekID: AddViewController.Variables.weekID_next,
            monthID: AddViewController.Variables.monthID_next,
            yearID: AddViewController.Variables.yearID_next,
            stTime: AddViewController.Variables.stTime_next,
            edTime: AddViewController.Variables.edTime_next)
            lists.append(checklist1)
            lists.append(checklist2)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
            userDefaults.synchronize()
        }
        
    }
    
    var indexOfSelectedChecklist: Int {
        
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
            UserDefaults.standard.synchronize()
        }
    }
    
    /** 获取下一个ID 
     **/
    class func nextChecklistItemID() -> Int {
        
        let userDefaults = UserDefaults.standard
        let itemID = userDefaults.integer(forKey: "ChecklistItemID")
        userDefaults.set(itemID+1, forKey: "ChecklistItemID")
        userDefaults.synchronize()
        return itemID
    }
    
    
    
}

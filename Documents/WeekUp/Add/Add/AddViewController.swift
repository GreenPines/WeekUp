//
//  AddViewController.swift
//  Add
//
//  Created by Apple on 2017/7/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

import UIKit
import CVCalendar
import CoreLocation
import Foundation
//import SwiftyJSON

class AddViewController: UIViewController {
    @IBOutlet weak var checklistButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var summaryButton: UIButton!
    @IBOutlet weak var mentionButton: UIButton!
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var attachmentButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var Month: UILabel!
    @IBOutlet weak var weeknumber: UILabel!
    
    @IBOutlet weak var firstweeek: UIView!
    @IBOutlet weak var firstweekrank: UILabel!
    @IBOutlet weak var firstweekup: UILabel!
    
    @IBOutlet weak var secondweeek: UIView!
    @IBOutlet weak var secondweekrank: UILabel!
    @IBOutlet weak var secondweekup: UILabel!
    
    @IBOutlet weak var thirdweeek: UIView!
    @IBOutlet weak var thirdweekrank: UILabel!
    @IBOutlet weak var thirdweekup: UILabel!
    
    @IBOutlet weak var forthweeek: UIView!
    @IBOutlet weak var forthweekrank: UILabel!
    @IBOutlet weak var forthweekup: UILabel!
    
    @IBOutlet weak var fifthweeek: UIView!
    @IBOutlet weak var fifthweekrank: UILabel!
    @IBOutlet weak var fifthweekup: UILabel!
    
    @IBOutlet weak var sixthweeek: UIView!
    @IBOutlet weak var sixthweekrank: UILabel!
    @IBOutlet weak var sixthweekup: UILabel!
    
    @IBOutlet weak var weather: UIImageView!
    
    // 静态导航控制器（修改）
    struct Constants {
        
        static let navigationViewController = UINavigationController(rootViewController: AppDelegate.Constants.thisweek)
        
    }
    
    struct Variables {
        // THIS WEEK
        static var weekID_this = 3
        static var monthID_this = 7
        static var yearID_this = 2017
        static var stTime_this = "2017-7-16"
        static var edTime_this = "2017-7-23"
        // NEXT WEEK
        static var weekID_next = 4
        static var monthID_next = 7
        static var yearID_next = 2017
        static var stTime_next = "2017-7-23"
        static var edTime_next = "2017-7-30"
    }
    
    @IBAction func back(_ sender: AnyObject){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func checklist(_ sender: AnyObject){
        
        let c = AddViewController.Constants.navigationViewController
        
        self.present(c,animated:true, completion:nil)
        
        print("This Week info:")
        print("name = \(DataModel.Variables.thisweeklist.name)")
        print("count = \(DataModel.Variables.thisweeklist.items.count)")
        print("week = \(DataModel.Variables.thisweeklist.weekID)")
        print("month = \(DataModel.Variables.thisweeklist.monthID)")
        print("year = \(DataModel.Variables.thisweeklist.yearID)")
        
        
        
        
    }
    @IBAction func post(_ sender: AnyObject){
//        let controller = AddPostViewController(nibName: "AddPostViewController", bundle: nil)
        let controller = UINavigationController(rootViewController: AddPostViewController())
        controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(controller, animated: true, completion: nil)
    }
    @IBAction func summary(_ sender: AnyObject){
        let VC = AddSummaryViewController()
        self.present(VC, animated: true, completion: nil)
    }
    @IBAction func mention(_ sender: AnyObject){
        let VC = AddMentionViewController()
        self.present(VC, animated: true, completion: nil)
    }
    @IBAction func link(_ sender: AnyObject){
        let controller = UINavigationController(rootViewController: AddLinkViewController(nibName: "AddLinkViewController", bundle: nil))
        self.present(controller,animated: true,completion: nil)
    }
    @IBAction func attachment(_ sender: AnyObject){
        let controller = UINavigationController(rootViewController: AddAttachmentViewController())
        self.present(controller, animated: true, completion: nil)
    }
    
    var locationManager : CLLocationManager!
    var currLocation : CLLocation!
    private var menuView: CVCalendarMenuView!
    private var calendarView: CVCalendarView!
    
    var currentCalendar: Calendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentCalendar = Calendar.init(identifier: .gregorian)
        self.Month.text = CVDate(date: Date(), calendar: currentCalendar).globalDescription//show the date
        
        self.menuView = CVCalendarMenuView(frame: CGRect(x:107, y:116, width:235, height:15))
        self.calendarView = CVCalendarView(frame: CGRect(x:107, y:135, width:235, height:240))
        
        self.menuView.menuViewDelegate = self
        self.calendarView.calendarDelegate = self

        self.view.addSubview(calendarView)
        self.view.addSubview(menuView)
        
        
        //self.gradehide(viewer: firstweeek)
        //self.gradehide(viewer: secondweeek)
        //self.gradehide(viewer: thirdweeek)
        self.gradehide(viewer: forthweeek)
        self.gradehide(viewer: fifthweeek)
        self.gradehide(viewer: sixthweeek)
        
        var weeknum = CVDate(date: Date(), calendar: currentCalendar).week
//        var daynum = CVDate(date: Date(), calendar: currentCalendar).
//        print(daynum)x
        
        getCurrentWeatherData()
        weeknumchange()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.menuView.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func weeknumchange() {
        var weeknum = CVDate(date: Date(), calendar: currentCalendar).week
        var monthnum = CVDate(date: Date(), calendar: currentCalendar).month
        switch weeknum{
        case 1:
            if monthnum > 1{
                self.weeknumber.text = "Week5 of \(monthnum-1)"
                AddViewController.Variables.weekID_this = 5
                AddViewController.Variables.weekID_next = 1
            }
            else{
                self.weeknumber.text = "Week5 of 12"
            }
        case 2,3,4,5,6:
            self.weeknumber.text = "Week\(weeknum-1) of \(monthnum)"
            AddViewController.Variables.weekID_this = weeknum-1
            if weeknum == 6{
                AddViewController.Variables.weekID_next = 1
            }
            else{
                AddViewController.Variables.weekID_next = weeknum
            }
        default:
            break
        }
    }
    func gradehide(viewer: UIView!){
        viewer.isHidden = true
    }
    
    func getCurrentWeatherData(){
        let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=beijing&units=metric&appid=6b867e62ccfc8b5f4e49a8f12d98e0cd"
        let url = NSURL(string: urlStr)!
        guard let weatherData = NSData(contentsOf: url as URL) else { return }
        
        //将获取到的数据转为json对象
        do{
            let jsonData = try JSON(data: weatherData as Data)

            let weather = jsonData["weather"][0]["main"].string!
            let weathericon = jsonData["weather"][0]["icon"].string!
            self.weather.image = UIImage(named: weathericon)
        }catch{
            print(error)
        }
    }
}

extension AddViewController: CVCalendarViewDelegate,CVCalendarMenuViewDelegate {
    func presentationMode() -> CalendarMode {
        //使用月视图
        return .monthView
    }
    //每周的第一天
    func firstWeekday() -> Weekday {
        //从星期天开始
        return .sunday
    }
    func presentedDateUpdated(_ date: CVDate) {
        //导航栏显示当前日历的年月
        self.title = date.globalDescription
    }
    //每个日期上面是否添加横线(连在一起就形成每行的分隔线)
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    //切换月的时候日历是否自动选择某一天（本月为今天，其它月为第一天）
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }
}

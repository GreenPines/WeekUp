//
//  ThisWeekController.swift
//  AddPartChecklist
//
//  Created by 黄豪杰 on 2017/7/12.
//  Copyright © 2017年 黄豪杰. All rights reserved.
//

import UIKit
import UserNotifications

/** 
   本周list Controller
 **/
 
class ThisWeekController: UIViewController,
                          UITableViewDataSource,
                          UITableViewDelegate,
                          UITextFieldDelegate{
    
    
    let cellID = "CellH"          // cell 信息
    let cellName = "AddItemCell"
    var dataModel: DataModel!     // 数据模型
    var dueDate = Date()          // 定时
    var thisweeklist: Checklist!  // 本周list对象
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem! //完成按钮
    @IBOutlet weak var textField: UITextField! // 文本输入框
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var AddState: UIButton!     // 文字输入状态
    @IBOutlet weak var CalState: UIButton!     // 日历输入状态
    @IBOutlet var datePicker: UIDatePicker!    // datePicker
   
    // 日历导航栏
    @IBOutlet weak var dueDateNavigationBar: UINavigationBar!
    @IBOutlet weak var dueDateNavigationItem: UINavigationItem!

    
    /** 初始化
     **/
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibNameOrNil as? Bundle)

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    /** viewDidLoad
     **/
    override func viewDidLoad() {
        thisweeklist = dataModel.lists[0]   //从数据模型获取list


        // 解决 textField 输入文字下移问题， 自动滚动调整 false
        // 原因是： 导航栏+状态栏的存在，高度64，向下偏移64px
        self.automaticallyAdjustsScrollViewInsets = false
        
        //去除毛玻璃效果
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "RealRed"), for: .default)
        
        //设置导航栏标题字体、颜色白色
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName:
            UIFont(name:"Avenir-Heavy", size: 20)!]
       
        let backImg = UIImage(named: "closeIcon")
        let NextImg = UIImage(named: "Next Week")
 
        let leftitem = UIBarButtonItem(image: backImg, style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancel(_:)))
        let rightitem = UIBarButtonItem(image: NextImg, style: UIBarButtonItemStyle.plain, target: self, action: #selector(nextWeek(_:)))
        
        //设置itemButton颜色
        leftitem.tintColor = UIColor.white
        rightitem.tintColor = UIColor.white

        self.navigationItem.leftBarButtonItem = leftitem
        self.navigationItem.rightBarButtonItem = rightitem
        
        
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        textField.delegate = self           // 文本输入框绑定delegate
        
        isAddOrEdit() // 判断Add Edit
        
        tableView!.dataSource = self  // 表视图数据源与协议
        tableView!.delegate = self
        tableView.register(UINib.init(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellID)  // 注册cell

//        tableView.register(AddItemCell.self, forCellReuseIdentifier: cellID)    // 注册类
        
        self.view.addSubview(tableView!) // 添加子视图
        
        
        AddModel() // 进入即为Add模式
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()  //成为焦点
        // 视图出现前，判断 Add 或 Edit
        isAddOrEdit()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /** 判断 Add or Edit 
        根据：列表中的item数量是否为0
    **/
    func isAddOrEdit() {
        
        if thisweeklist.items.count == 0 {
            self.navigationItem.title = "Add Week\(thisweeklist.weekID) Checklist"
        } else {
            self.navigationItem.title = "Edit Week\(thisweeklist.weekID) Checklist"
        }
        
    }
    
    /** 设置提醒
     **/
    func shouldRemindToggled(_ reminder: Bool) {
        if reminder {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) {
                granted, error in
            }
        }
    }
    
    /** cancel 返回主界面
     **/
    func cancel(_ sender: Any) {
          self.dismiss(animated: true, completion: nil)
    }
    
    /** 下一周
     **/
    func nextWeek(_ sender: Any) {
        let controller = AppDelegate.Constants.nextweek
        //        controller.dataModel = AppDelegate.Constants.nextweek.dataModel
        self.navigationController?.pushViewController(controller, animated: true)
        
        print("Next Week info:")
        print("name = \(DataModel.Variables.nextweeklist.name)")
        print("count = \(DataModel.Variables.nextweeklist.items.count)")
        print("week = \(DataModel.Variables.nextweeklist.weekID)")
        print("month = \(DataModel.Variables.nextweeklist.monthID)")
        print("year = \(DataModel.Variables.nextweeklist.yearID)")
        
    }
    
    
    
    /** done 完成 Add Item
     **/
    @IBAction func done() {
       
        // 创建 item
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
//        item.shouldRemind = true
        item.dueDate = dueDate
        item.scheduleNotification()   //推送通知
        
        // 插入 item
        let newRowIndex = thisweeklist.items.count
        thisweeklist.items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        

        // 排序 并 重载数据
        sortItems()
        tableView.reloadData()
        
        // tableView的底端 滚动到指定位置 (刚刚添加的item处)

        var itemRowIndex = 0
 
        for i in 0 ... thisweeklist.items.count-1 {
            if item.itemID == thisweeklist.items[i].itemID {
                itemRowIndex = i
                print("find: \(itemRowIndex)")
            }
        }

        
        let itemIndexPath = IndexPath(row: itemRowIndex, section: 0)
        tableView.scrollToRow(at: itemIndexPath, at: UITableViewScrollPosition.bottom, animated: true)
        
        // 返回 文字模式
        AddModel()
        textField.text = ""
        
        
        print("Contents of the text field: \(textField.text!)" )
    }
    
    
    /** 2种输入模式的状态
     **/
    
    func AddStateOn() {
        AddState.setImage(UIImage(named:"add_highlighted"),for: UIControlState.highlighted)
        AddState.setImage(UIImage(named:"add_highlighted"),for: UIControlState.normal)
    }
    func AddStateOff() {
        AddState.setImage(UIImage(named:"add_normal"),for: UIControlState.highlighted)
        AddState.setImage(UIImage(named:"add_normal"),for: UIControlState.normal)
    }
    func CalStateOn() {
        CalState.setImage(UIImage(named:"deadline_highlighted"),for: UIControlState.highlighted)
        CalState.setImage(UIImage(named:"deadline_highlighted"),for: UIControlState.normal)
        
    }
    func CalStateOff() {
        CalState.setImage(UIImage(named:"deadline_normal"),for: UIControlState.normal)
        CalState.setImage(UIImage(named:"deadline_normal"),for: UIControlState.highlighted)
    }
    
    /** 文字模式 
     **/
    @IBAction func AddModel() {
      
        AddStateOn()
        CalStateOff()
        
        textField.becomeFirstResponder()  //成为焦点
        
        dueDateNavigationBar.isHidden = true  //隐藏日历
        datePicker.isHidden = true

    }
    
    /** 日期范围限制
     **/
    func DateLimit() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let minDate = dateformatter.date(from: thisweeklist.stTime)
        let maxDate = dateformatter.date(from: thisweeklist.edTime)
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        
    }
    
    /** 日历模式
     **/
    @IBAction func CalModel() {
       
        CalStateOn()  //开灯
        AddStateOff() //灭灯
        
        textField.resignFirstResponder()  //撤销键盘
        
        dueDateNavigationBar.isHidden = false   //唤出日历Bar
        dueDateNavigationBar.frame =  CGRect(x:0, y:411, width:375, height:40)

        self.view.addSubview(dueDateNavigationBar)  //修改
        datePicker.isHidden = false;  //唤出日历
        DateLimit() //日期范围控制
        
        self.view.addSubview(datePicker)
        datePicker.frame = CGRect(x:0, y:451, width:375, height:216)
        
        datePicker.setDate(dueDate, animated: false)
        updateDueDate() //更新bar上的date
    }
    
    
    /** 实现键盘上的 next 
        进入日历模式
     **/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        CalModel() //显示日历模式
        return true
    }
    
    /** 更新DueDate 
     **/
    func updateDueDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E HH:mm"   //时间格式
        let s = formatter.string(from: dueDate)
        let t = s.uppercased()

        let week = "Week \(thisweeklist.weekID) "
        let day = t.substring(to: t.characters.index(t.startIndex, offsetBy: 2))
        let time = t.substring(from: t.characters.index(t.startIndex, offsetBy: 3))

        let result = week + " " + day + " " + time
        dueDateNavigationItem.title = result  //时间格式为 Week 5  TH 15:00
    }
    
    /** 点击文本框立刻进入Add模式
     **/
    @IBAction func clickTextField() {
        AddModel()
    }

    
    

    
    /** dateChanged
     **/
    @IBAction func dateChanged(_ datePicker: UIDatePicker) {
        
        dueDate = datePicker.date
        updateDueDate()

    }
    

    /** 点击文本框清空文字 
     **/
    func textFieldDidBeginEditing(_ textField: UITextField){
        textField.text = ""  //清空文字
        AddModel()
    }
    
    
    /** 文字替换， 激活done 
     **/
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
                                                  as NSString
        
        if newText.length > 0 {
            doneBarButton.isEnabled = true
        } else {
            doneBarButton.isEnabled = false
        }
        return true
    }


    
    
    /** 实现 datasource 协议  numberOfRowsInSection 
     **/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return thisweeklist.items.count
    
    }
    
    /** 实现 datasource 协议 cellForRowAt 
     **/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let item = thisweeklist.items[indexPath.row]
        
        let button = cell.viewWithTag(2000) as! UIButton

       // 通过关联函数来“扩展”button的属性
//       objc_setAssociatedObject(button, "firstObject", item, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        let item = objc_getAssociatedObject(button, "firstObject")
//        print(sender.title(for: UIControlState.highlighted))

        
        // 给button添加点击事件 click
        button.addTarget(self, action: #selector(click(_:)), for: UIControlEvents.touchUpInside)
    
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        configureDeadline(for: cell, with: item)
        configureButton(for: cell, with: item)
        
        return cell
    }
    
    /** Cell上 button 点击事件
     **/
    func click(_ sender: Any) {

        // 获取button的cell和indexPath, 从而找到正确的item
        let btn = sender as! UIButton
        let cell = btn.superView(of: UITableViewCell.self)!
        let indexPath = tableView.indexPath(for: cell)
        let row = indexPath?.row
        let item = thisweeklist.items[row!]
        
        // 提醒改变
        item.shouldRemind = !item.shouldRemind

        if item.shouldRemind {
            btn.setImage(UIImage(named: "reminder_on"), for: UIControlState.normal)
            btn.setImage(UIImage(named: "reminder_on"), for: UIControlState.highlighted)
            btn.setTitleColor(UIColor.red, for: UIControlState.normal)
            btn.setTitleColor(UIColor.red, for: UIControlState.highlighted)
            
        } else {
            btn.setImage(UIImage(named: "reminder_off"), for: UIControlState.normal)
            btn.setImage(UIImage(named: "reminder_off"), for: UIControlState.highlighted)
            btn.setTitleColor(UIColor.black, for: UIControlState.normal)
            btn.setTitleColor(UIColor.black, for: UIControlState.highlighted)
        }
        
        shouldRemindToggled(item.shouldRemind) //设置提醒
        item.scheduleNotification()   //推送
        
    }
    
    /** 返回button所在的UITableViewCell 
     **/
    func superUITableViewCell(of: UIButton) -> UITableViewCell? {
        for view in sequence(first: of.superview, next: { $0?.superview }) {
            if let cell = view as? UITableViewCell {
                return cell
            }
        }
        return nil
    }

    
    /** 实现 delegate 协议 
     **/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        AddStateOff()
        CalStateOff()
        dueDateNavigationBar.isHidden = true
        datePicker.isHidden = true
        textField.resignFirstResponder()
        
        if let cell = tableView.cellForRow(at: indexPath) {
           let item = thisweeklist.items[indexPath.row]
            item.toggleChecked()
//            print("点击：\(indexPath.row)")
            configureCheckmark(for: cell, with: item)
        }
//        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    /**   编辑style
     本应该override   但是超类不是tableViewController
     **/
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        thisweeklist.items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
    //    不需要实现
    //    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

    //    }
    
    /** 
     校正Checkmark、Text、Button、Deadline
     **/
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        
        let checkState = cell.viewWithTag(1001) as! UIImageView
        
        print(item.checked)
        if item.checked {
            checkState.image = UIImage(named: "check_true")
        } else {
            checkState.image = UIImage(named: "check_false")
        }

    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
//        label.text = "\(item.itemID)\(item.text)"  //测试ID 
        label.text = "\(item.text)"
        
    }
    
    func configureButton(for cell: UITableViewCell, with item: ChecklistItem) {
        let button = cell.viewWithTag(2000) as! UIButton
        var state = ""
        var color : UIColor
        if item.shouldRemind {
            state = "reminder_on"
            color = UIColor.red
        } else {
            state = "reminder_off"
            color = UIColor.black
        }
        button.setImage(UIImage(named: state), for: UIControlState.highlighted)
        button.setImage(UIImage(named: state), for: UIControlState.normal)
        button.setTitleColor(color, for: UIControlState.normal)
        button.setTitleColor(color, for: UIControlState.highlighted)
      
    }
    
    func configureDeadline(for cell: UITableViewCell, with item: ChecklistItem) {
        
        let button = cell.viewWithTag(2000) as! UIButton
        let formatter = DateFormatter()
        formatter.dateFormat = "E HH:mm"   //时间格式
        let t = formatter.string(from: item.dueDate).uppercased()
        let day = t.substring(to: t.characters.index(t.startIndex, offsetBy: 2))
        let time = t.substring(from: t.characters.index(t.startIndex, offsetBy: 3))
        
        let result = " " + day + time
        button.setTitle(result, for: UIControlState.normal)
        button.setTitle(result, for: UIControlState.highlighted)
        
    }
    
    
    
    /**
     sortItems  按照 DueDate 对 item 进行升序排列，上层为较早时间
     **/
    func sortItems() {
        thisweeklist.items.sort(by: { item1, item2 in
            return item1.dueDate.compare(item2.dueDate) == .orderedAscending })
    }
    
//    
//    // sortChecklists
//    func sortChecklists() {
//        lists.sort(by: { checklist1, checklist2 in
//            return checklist1.name.localizedStandardCompare(checklist2.name) == .orderedAscending })
//    }
}

/** 
     将navigation bar向上扩展，覆盖状态栏
 **/
//extension ThisWeekController: UINavigationBarDelegate {
//    func position(for bar: UIBarPositioning) -> UIBarPosition {
//        return .topAttached
//    }
//}


/** 
   实现Button点击事件传参
   参考文献：《在单元格里的按钮点击事件中获取对应的cell以及indexPath》
    http://www.hangge.com/blog/cache/detail_1500.html
 **/
extension UIView {
    //返回该view所在的父view
    func superView<T: UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
}

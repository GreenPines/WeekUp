//
//  NextWeekController.swift
//  AddPartChecklist
//
//  Created by 黄豪杰 on 2017/7/12.
//  Copyright © 2017年 黄豪杰. All rights reserved.
//

import UIKit
import UserNotifications

/** 
   下周list Controller
 **/
class NextWeekController:  UIViewController,
    UITableViewDataSource,
    UITableViewDelegate,
UITextFieldDelegate{
    
    let cellID = "CellH"          // cell 信息
    let cellName = "AddItemCell"

    var dataModel: DataModel! //数据模型
    var dueDate = Date()
    
    var nextweeklist: Checklist! // 下周list对象
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var AddState: UIButton!
    @IBOutlet weak var CalState: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    // 日历导航栏
    @IBOutlet weak var dueDateNavigationBar: UINavigationBar!
    @IBOutlet weak var dueDateNavigationItem: UINavigationItem!

    
    /** 初始化 
     **/
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibNameOrNil as? Bundle)
//        print("WeekUp_Documents folder is\(self.documentsDirectory())")
//        print("WeekUp_Data file path is\(self.dataFilePath())")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    /** 判断 Add or Edit 
     **/
    func isAddOrEdit() {
        
        if nextweeklist.items.count == 0 {
            self.navigationItem.title = "Add Week\(nextweeklist.weekID) Checklist"
        } else {
            self.navigationItem.title = "Edit Week\(nextweeklist.weekID) Checklist"
        }
        
    }
    
    /**  cancel 返回本周checklist
     **/
    @IBAction func lastweek(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        //        self.dismiss(animated: true, completion: nil)
    }

    
    /** viewDidLoad
     **/
    override func viewDidLoad() {
        
        nextweeklist = dataModel.lists[1] //从数据模型获取list, 第2元素
        
        // 解决 textField 输入文字下移问题， 自动滚动调整 false
        // 原因是： 导航栏+状态栏的存在，高度64，向下偏移64px
        self.automaticallyAdjustsScrollViewInsets = false
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        textField.delegate = self // 文本输入框绑定delegate
        //        self.items = [ChecklistItem]()
        //        self.loadChecklistItems()
        
        let backImg = UIImage(named: "returnIcon")

        
        let leftitem = UIBarButtonItem(image: backImg, style: UIBarButtonItemStyle.plain, target: self, action: #selector(lastweek(_:)))
        
        leftitem.tintColor = UIColor.white
        
        self.navigationItem.leftBarButtonItem = leftitem

        
        // 判断Add Edit
        isAddOrEdit()
        // 表视图
        tableView!.dataSource = self  // 数据源
        tableView!.delegate = self    // 代理
        
        // 注册cell
        tableView.register(UINib.init(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellID)
        
        // 添加子视图
        self.view.addSubview(tableView!)
        
        // 去除毛玻璃效果
//        nextWeekNavigationBar.setBackgroundImage(UIImage(named: "RealRed"), for: .default)
        // 进入即为Add模式
        AddModel()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
        // 判断Add Edit
        isAddOrEdit()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    // loading
//    func loadChecklistItems() {
//        let path = dataFilePath()
//        
//        if let data = try? Data(contentsOf: path) {
//            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
//            nextweeklist = unarchiver.decodeObject(forKey: "ChecklistItems") as! [ChecklistItem]
//            unarchiver.finishDecoding()
//        }
//    }
//    // saving and loading  获得文件全路径
//    func documentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory,
//                                             in: .userDomainMask)
//        return paths[0]
//    }
//    //
//    func dataFilePath() -> URL {
//        return documentsDirectory().appendingPathComponent("NextWeekList.plist")
//    }
//    
//    // save
//    // 获得items数组的内容，转换为二进制数据块，写入data file
//    func saveChecklistItems() {
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWith: data)
//        archiver.encode(items, forKey: "ChecklistItems")
//        archiver.finishEncoding()
//        data.write(to: dataFilePath(), atomically: true)
//    }
    

    
    
    // done 完成Add Item
    @IBAction func done() {
        
        // 创建 item
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
//        item.shouldRemind = true
        item.dueDate = dueDate
        
        item.scheduleNotification()   //推送
        
        // 插入 item
        let newRowIndex = nextweeklist.items.count
        nextweeklist.items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        
        
        // 排序 并 重载数据
        sortItems()
        tableView.reloadData()
        
        
        
        // tableView的底端 滚动到指定位置 (刚刚添加的item处)
        
        var itemRowIndex = 0
        
        for i in 0 ... nextweeklist.items.count-1 {
            if item.itemID == nextweeklist.items[i].itemID {
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
    
    /**
     sortItems  按照 DueDate 对 item 进行升序排列，上层为较早时间
     **/
    func sortItems() {
        nextweeklist.items.sort(by: { item1, item2 in
            return item1.dueDate.compare(item2.dueDate) == .orderedAscending })
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
        AddStateOn()    // 开灯
        CalStateOff()   // 灭灯
        
        textField.becomeFirstResponder()
        
        dueDateNavigationBar.isHidden = true //隐藏日历
        datePicker.isHidden = true;
        
    }
    
    /** 日期范围限制
     **/
    func DateLimit() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        let minDate = dateformatter.date(from: nextweeklist.stTime)
        let maxDate = dateformatter.date(from: nextweeklist.edTime)
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        
    }
    
    /** 日历模式
     **/
    @IBAction func CalModel() {
        CalStateOn()   //开灯
        AddStateOff()  //灭灯
        
        textField.resignFirstResponder()  //撤销键盘
        
        dueDateNavigationBar.isHidden = false   //唤出日历Bar
        dueDateNavigationBar.frame =  CGRect(x:0, y:411, width:375, height:40)
        
        datePicker.isHidden = false;  //唤出datePicker
        
        DateLimit() //日历范围控制
        
        self.view.addSubview(datePicker)
        datePicker.frame = CGRect(x:0, y:451, width:375, height:216)
        
        datePicker.setDate(dueDate, animated: false)
        
        updateDueDate() //更新bar上的date
    }
    
    
    /** 实现键盘上的 next
     进入日历模式
     **/
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //        textField.resignFirstResponder()  // 收起键盘
        //显示日历
        CalModel()
        return true
    }
    
    //        // 修改navigationitem
    //        print("\(dueDateNavigationItem.title!)")
    //        dueDateNavigationItem.title = "xxxx2000"
    
    /** 更新DueDate
     **/
    func updateDueDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "E HH:mm"   //时间格式
        let s = formatter.string(from: dueDate)
        let t = s.uppercased()
        
        let week = "Week \(nextweeklist.weekID) "
        let day = t.substring(to: t.characters.index(t.startIndex, offsetBy: 2))
        let time = t.substring(from: t.characters.index(t.startIndex, offsetBy: 3))
        
        let result = week + " " + day + " " + time
        dueDateNavigationItem.title = result  //时间格式为 Week 5  TH 15:00
    }
    
    
    
    /** dateChanged
     **/
    @IBAction func dateChanged(_ datePicker: UIDatePicker) {
        
        dueDate = datePicker.date
        updateDueDate()
        
    }
    

    /** 点击文本框立刻进入Add模式
     **/
    @IBAction func clickTextField() {
        AddModel()
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
        return nextweeklist.items.count
    }
    
    /** 实现 datasource 协议 cellForRowAt
     **/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        let item = nextweeklist.items[indexPath.row]
        
        let button = cell.viewWithTag(2000) as! UIButton
        // 给button添加点击事件 click
        button.addTarget(self, action: #selector(click(_:)), for: UIControlEvents.touchUpInside)

        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        configureDeadline(for: cell, with: item)
        configureButton(for: cell, with: item)
        
        return cell
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
            let item = nextweeklist.items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    /**   编辑style
     
     本应该override   但是超类不是tableViewController
     **/
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        nextweeklist.items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
    /** Cell上 button 点击事件
     **/
    func click(_ sender: Any) {
        
        // 获取button的cell和indexPath, 从而找到正确的item
        let btn = sender as! UIButton
        let cell = btn.superView(of: UITableViewCell.self)!
        let indexPath = tableView.indexPath(for: cell)
        let row = indexPath?.row
        let item = nextweeklist.items[row!]
        
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
        
        print("in next: \(item.text)")
        shouldRemindToggled(item.shouldRemind) //设置提醒
        item.scheduleNotification()   //推送
        
    }
    
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
    

    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        return nil
//    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
//      label.text = item.text
//        label.text = "\(item.itemID)\(item.text)"
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
    
    
}

/** 
 将navigation bar向上扩展，覆盖状态栏
 **/
extension NextWeekController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

/**
 实现Button点击事件传参
 **/
//extension UIView {
//    //返回该view所在的父view
//    func superView<T: UIView>(of: T.Type) -> T? {
//        for view in sequence(first: self.superview, next: { $0?.superview }) {
//            if let father = view as? T {
//                return father
//            }
//        }
//        return nil
//    }
//}

//
//  AllWeekLists.swift
//  AddPartChecklist
//
//  Created by 黄豪杰 on 2017/7/18.
//  Copyright © 2017年 黄豪杰. All rights reserved.
//

import UIKit

class AllWeekLists: UIViewController,
                    UITableViewDataSource,
                    UITableViewDelegate {
    
    var dataModel: DataModel!

    @IBOutlet weak var tableView: UITableView!
    
    // cancel 返回主界面
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibNameOrNil as? Bundle)
    

    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 表视图
        tableView!.dataSource = self
        tableView!.delegate = self
        
        // 注册cell
        tableView.register(UINib.init(nibName: "ListCell", bundle: nil), forCellReuseIdentifier: "CellW")
        
        // 添加子视图
        self.view.addSubview(tableView!)
        
        print("\(dataModel.lists.count)")
        //  print("\(dataModel.lists[0].name)")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        let index = dataModel.indexOfSelectedChecklist
//        if index >= 0 && index < dataModel.lists.count {
//            let checklist = dataModel.lists[index]
//            // 可直接进入
//        }
//
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 实现 datasource 协议  numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count  //
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = makeCell(for: tableView)
        
        let checklist = dataModel.lists[indexPath.row]
        
        let label = cell.viewWithTag(2000) as! UILabel
        label.text = checklist.name
        
        return cell
    }
    
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "CellW"
        if let cell =
            tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            return cell
        } else {
            return UITableViewCell(style: .subtitle,
                                   reuseIdentifier: cellIdentifier)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataModel.indexOfSelectedChecklist = indexPath.row
        
        if indexPath.row == 0 {
            let controller = AppDelegate.Constants.thisweek
            controller.modalTransitionStyle = .coverVertical
            self.present(controller,animated:true, completion:nil)
            
        } else {
            let controller = AppDelegate.Constants.nextweek
            controller.modalTransitionStyle = .coverVertical
            self.present(controller,animated:true, completion:nil)
            
        }
        
        
        
    }

    func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    

}

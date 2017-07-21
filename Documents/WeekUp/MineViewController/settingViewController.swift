//
//  settingViewController.swift
//  WKTabBarController-Example
//
//  Created by Jerry on 17/7/13.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class settingViewController: UIViewController {

    var settingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Setting"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-left"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftBtnClick))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white

        
        //添加tableView
        settingTableView = UITableView(frame: CGRect(x: 0, y:0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: UITableViewStyle.grouped)
        settingTableView!.delegate = self
        settingTableView!.dataSource = self
        self.view.addSubview(settingTableView)
        
        let cellNib = UINib(nibName: "weekCell", bundle: nil)
        settingTableView.register(cellNib, forCellReuseIdentifier: "weekCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func leftBtnClick(){
        _ = navigationController?.popViewController(animated: true)
    }
}



extension settingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:weekCell = tableView.dequeueReusableCell(withIdentifier: "weekCell") as! weekCell
        if indexPath.section == 0{
            cell.weekNo.text = "Clear Cache"
            cell.allAct.text = "0.42MB"
        }else if indexPath.section == 1{
            if indexPath.row == 0{
                cell.weekNo.text = "Common"
                cell.allAct.text = ""
            }else if indexPath.row == 1{
                cell.weekNo.text = "Help & Feedback"
                cell.allAct.text = ""
            }else if indexPath.row == 2{
                cell.weekNo.text = "About"
                cell.allAct.text = ""
            }
        }
        else if indexPath.section == 2{
            cell.weekNo.text = ""
            cell.allAct.text = ""
            cell.logOut.text = "Log out"
            cell.logOut.textColor = UIColor.red
            cell.logOut.font = UIFont(name: "Avenir-Heavy", size: 14)
            cell.accessoryType = .none
        }

        cell.weekNo.font = UIFont.systemFont(ofSize: 14)
        cell.allAct.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 220))
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else if section == 1{
            return 3
        }else{
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
}

extension settingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            self.present(Login(), animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


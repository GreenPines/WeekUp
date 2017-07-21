//
//  UpTableViewController.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/12.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

protocol BackValueProtocol {
    func backValue()
}

class UpViewController: UIViewController {
    var upTableView: UITableView!
    var selectedTeam = ""
    var rightBtn: UIBarButtonItem!
    var userPhoneNum: String!
    var delegate: BackValueProtocol?
    
    
    func setUp(upUserPhoneNum: String ) {
        //给选中的用户up加一(monyear和week都是当前的)
    }
    
    func setIsUp(userPhoneNum: String, selectedTeam: String) {
        //把当前用户的选中team的isup设成true
    }
    
    func getTeammatesNumOutSelf(selectedTeam: String) -> Int {//没有自己
        return 3
    }
    
    func getTeammatesOutSelf(selectedTeam: String) -> [String] {//没有自己
        return ["22222222", "33333333", "44444444"]
    }
    
    func getCircleProgress(userUpPhoneNum: String) -> Double {
        return 0.5
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
    
    func getUserChecklistNum(userPhoneNum: String) -> Int {
        return 10
    }
    
    func getUserPostNum(userPhoneNum: String) -> Int {
        return 8
    }
    
    func getUserAssessmentNum(userPhoneNum: String) -> Double {
        return 4.5
    }
    
    func getCurrentWeek() -> Int {
        return 3
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.contentInset = UIEdgeInsets(top: 108, left: 0, bottom: 0, right: 0)

        var navigationBar:UINavigationBar?
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 64))
        //print("hhh,,,,,")
        let navigationItem = UINavigationItem()
        navigationItem.title = "Up"
        
        rightBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(UpViewController.onDone))
        navigationItem.setRightBarButton(rightBtn, animated: true)
        rightBtn.isEnabled = false
        let leftBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "return"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(UpViewController.onReturn))
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        navigationBar?.pushItem(navigationItem, animated: true)
        
        navigationBar?.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        view.addSubview(navigationBar!)
        navigationBar?.tintColor = UIColor.white
        var attrs = [String: AnyObject]()
        attrs[NSFontAttributeName] = UIFont.boldSystemFont(ofSize: 20)
        attrs[NSForegroundColorAttributeName] = UIColor.white
        navigationBar?.titleTextAttributes = attrs
        
        navigationBar?.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        
        
        //添加tableView
        upTableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64), style: UITableViewStyle.plain)
        upTableView!.delegate = self
        upTableView!.dataSource = self
        self.view.addSubview(upTableView)
        upTableView.rowHeight = 64
        
        var cellNib = UINib(nibName: "UpTableCell", bundle: nil)
        upTableView.register(cellNib, forCellReuseIdentifier: "UpTableCell")
        cellNib = UINib(nibName: "UpTableHead", bundle: nil)
        upTableView.register(cellNib, forCellReuseIdentifier: "UpTableHead")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onDone() {
        dismiss(animated: true, completion: nil)
        self.delegate?.backValue()
        for index in 0...upTableView.numberOfRows(inSection: 0)-1 {
            let cell = upTableView.cellForRow(at: [0, index]) as! UpTableCell
            if cell.isUp == true {
                setUp(upUserPhoneNum: cell.userPhoneNum)
                setIsUp(userPhoneNum: userPhoneNum, selectedTeam: selectedTeam)
                
            }
        }
    }
    
    func onReturn() {
        dismiss(animated: true, completion: nil)
    }

    
}


extension UpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTeammatesNumOutSelf(selectedTeam: selectedTeam)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = upTableView.dequeueReusableCell(withIdentifier: "UpTableCell", for: indexPath) as! UpTableCell
        cell.upViewController = self
        cell.upTableView = upTableView
        let userUpPhoneNum = getTeammatesOutSelf(selectedTeam: selectedTeam)[indexPath.row]
        cell.circleProgressView.progress = getCircleProgress(userUpPhoneNum: userUpPhoneNum)
        cell.userName.text = getUserName(userPhoneNum: userUpPhoneNum)
        cell.userImage.image = UIImage(named: getUserImg(userPhoneNum: userUpPhoneNum))
        cell.userChecklist.text = "\(getUserChecklistNum(userPhoneNum: userUpPhoneNum))"
        cell.userPost.text = "\(getUserPostNum(userPhoneNum: userUpPhoneNum))"
        cell.userAssessment.text = "\(getUserAssessmentNum(userPhoneNum: userUpPhoneNum))"
        cell.userPhoneNum = userUpPhoneNum
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
//        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
//        view.backgroundColor = UIColor.white
//        let headLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 50, height: 20))
//        headLabel.font = UIFont.systemFont(ofSize: 12)
//        headLabel.textColor = UIColor.black
//        headLabel.text = "hhhhhhhhhhhh"
        
        let vc = upTableView.dequeueReusableCell(withIdentifier: "UpTableHead") as! UpTableHead
        vc.teamName.text = selectedTeam
        vc.week.text = String(format: "Week %d", getCurrentWeek())
        vc.monYear.text = "07.2017"
        return  vc
    }
}

extension UpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}

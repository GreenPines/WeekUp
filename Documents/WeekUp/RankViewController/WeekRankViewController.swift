//
//  WeekRankViewController.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/13.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class WeekRankViewController: UIViewController {
    var weekRankTableView: UITableView!
    
    var selectedTeam: String = ""
    var week: Int!
    var monYear = ""
    
    func getTeammatesNum(seletedTeam: String) -> Int {//包括自己
        return 4
    }
    
    func getTeammates(seletedTeam: String, monYear: String, week: Int) -> [String] {//包括自己且按up数排序
        return ["22222222", "33333333", "11111111", "44444444"]
    }
    
    func getTeammates(seletedTeam: String, monYear: String) -> [String] {//包括自己且按up数排序
        return ["11111111", "22222222", "33333333", "44444444"]
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
    
    func getUserUp(userPhoneNum: String, selectedTeam: String, monYear: String, week: Int) -> Int {
        //如果week==-1 就是获得这个monYear的总赞数
        if week == -1 {
            return 20
        } else {
            return 10
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.contentInset = UIEdgeInsets(top: 108, left: 0, bottom: 0, right: 0)
        
        var navigationBar:UINavigationBar?
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 64))
        //print("hhh,,,,,")
        let navigationItem = UINavigationItem()
        navigationItem.title = "WeekRank"
        
        let leftBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "return"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(WeekRankViewController.onReturn))
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
        weekRankTableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64), style: UITableViewStyle.plain)
        weekRankTableView!.delegate = self
        weekRankTableView!.dataSource = self
        self.view.addSubview(weekRankTableView)
        weekRankTableView.rowHeight = 64
        
        var cellNib = UINib(nibName: "WeekRankTableCell", bundle: nil)
        weekRankTableView.register(cellNib, forCellReuseIdentifier: "WeekRankTableCell")
        cellNib = UINib(nibName: "UpTableHead", bundle: nil)
        weekRankTableView.register(cellNib, forCellReuseIdentifier: "UpTableHead")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onReturn() {
        dismiss(animated: true, completion: nil)
    }
    
    
}


extension WeekRankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTeammatesNum(seletedTeam: selectedTeam)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weekRankTableView.dequeueReusableCell(withIdentifier: "WeekRankTableCell", for: indexPath) as! WeekRankTableCell
        var userPhoneNum: String!
        if week == -1 {
            userPhoneNum = getTeammates(seletedTeam: selectedTeam, monYear: monYear)[indexPath.row]
        } else {
            userPhoneNum = getTeammates(seletedTeam: selectedTeam, monYear: monYear, week: week)[indexPath.row]
        }
        
        cell.userPhoneNum = userPhoneNum
        cell.userName.text = getUserName(userPhoneNum: userPhoneNum)
        cell.userImage.image = UIImage(named: getUserImg(userPhoneNum: userPhoneNum))
        cell.upNum.text = "\(getUserUp(userPhoneNum: userPhoneNum, selectedTeam: selectedTeam, monYear: monYear, week: week))"
        cell.rankNum.text = "\(indexPath.row+1)"
        cell.assessmentNum.text = "\(getUserAssessmentNum(userPhoneNum: userPhoneNum))"
        cell.checklistNum.text = "\(getUserChecklistNum(userPhoneNum: userPhoneNum))"
        cell.postNum.text = "\(getUserPostNum(userPhoneNum: userPhoneNum))"
        cell.circleProgressView.progress = getCircleProgress(userUpPhoneNum: userPhoneNum)
        if indexPath.row == 0 {
            cell.rankBgImage.image = #imageLiteral(resourceName: "red")
        } else if indexPath.row == 1 {
            cell.rankBgImage.image = #imageLiteral(resourceName: "yellow")
        } else {
            cell.rankBgImage.image = #imageLiteral(resourceName: "gray")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let vc = weekRankTableView.dequeueReusableCell(withIdentifier: "UpTableHead") as! UpTableHead
        vc.teamName.text = selectedTeam
        
        if week == -1 {
            vc.week.text = monYear
            vc.monYear.text = ""
        } else {
            vc.week.text = String(format: "Week %d", week)
            vc.monYear.text = monYear
        }
        
        return  vc
    }
}

extension WeekRankViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = weekRankTableView.cellForRow(at: indexPath) as! WeekRankTableCell
        
        let othersHomeVC = othersHomeViewController()
        othersHomeVC.userPhoneNum = cell.userPhoneNum
        othersHomeVC.imageBut.setBackgroundImage(cell.userImage.image, for: .normal)
        self.present(othersHomeVC, animated: true, completion: nil)
    }
    
}


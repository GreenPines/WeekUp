//
//  RankViewController.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/11.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class RankViewController: UIViewController {
    var selectedTeam: String!
    var rankTableView: UITableView!
    var segmented: YSSegmentedControl!
    var teams: [String]!
    var showTeams: [String]!
    let userPhoneNum = "11111111"
    
    
    func getTeams(userPhoneNum: String) -> [String] {
        return ["Mazeal", "Alibaba", "Tencent"]
    }
    
    func getIsUp(userPhoneNum: String, selectedTeam: String) -> Bool {
        return false
    }
    
    func getRank12(selectedTeam: String, monYear: String, week: Int) -> [String] {
        if selectedTeam == "Mazeal" {
            return ["22222222", "33333333"]
        } else {
            return ["22222222", "44444444"]
        }
        
    }
    
    func getRank12(selectedTeam: String, monYear: String) -> [String] {
        if selectedTeam == "Mazeal" {
            return ["11111111", "33333333"]
        } else {
            return ["11111111", "44444444"]
        }
        
    }
    
    func getCurrentWeek() -> Int {
        return 3
    }
    
    func getWeekNum(monYear: String) -> Int {
        return 5
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        teams = getTeams(userPhoneNum: self.userPhoneNum)
        showTeams = teams
        selectedTeam = teams[0]
        
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        self.navigationItem.title = self.tabBarItem.title
        self.navigationController?.navigationBar.barStyle = .black
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        

        //添加segmentedController
        segmented = YSSegmentedControl(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.frame.size.width - 65,
                height: 44),
            titles: self.teams,
            action: {
                control, index in
                print ("segmented did pressed \(index)")
        })
        segmented.delegate = self
        self.view.addSubview(segmented)
    
        
        //添加edit按钮
        let editButton = UIButton.init(frame: CGRect(x: view.frame.size.width - 65, y: 0, width: 65, height: 44))
        editButton.backgroundColor = UIColor(white: 1, alpha: 1.0)
        editButton.setTitle("edit", for: .normal)
        editButton.setTitleColor(UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0), for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        editButton.setTitleColor(.gray, for: .highlighted)
        editButton.addTarget(self, action: #selector(RankViewController.onEdit), for: .touchUpInside)
        self.view.addSubview(editButton)
        
        //添加tableView
        rankTableView = UITableView(frame: CGRect(x: 0, y: 56, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 120), style: UITableViewStyle.grouped)
        rankTableView!.delegate = self
        rankTableView!.dataSource = self
        self.view.addSubview(rankTableView)
        rankTableView.rowHeight = 64
        
        var cellNib = UINib(nibName: "TimeToUp", bundle: nil)
        rankTableView.register(cellNib, forCellReuseIdentifier: "TimeToUp")
        
        cellNib = UINib(nibName: "RankTableCell", bundle: nil)
        rankTableView.register(cellNib, forCellReuseIdentifier: "RankTableCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onEdit() {
        let editTeamVC = EditTeamViewController()
        editTeamVC.teams = teams
        editTeamVC.showTeams = showTeams
        editTeamVC.delegate = self
        self.present(editTeamVC, animated: true, completion: nil)
    }
    
}

extension RankViewController: YSSegmentedControlDelegate {
    func segmentedControl(_ segmentedControl: YSSegmentedControl, willPressItemAt index: Int) {
        //print ("[Delegate] segmented will press \(index)")
    }
    
    func segmentedControl(_ segmentedControl: YSSegmentedControl, didPressItemAt index: Int) {
        print ("[Delegate] segmented did press \(index)")
        
        selectedTeam = showTeams[index]
        print(selectedTeam)
        rankTableView.reloadData()
    }
    
}

extension RankViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath == [0,0] && !getIsUp(userPhoneNum: userPhoneNum, selectedTeam: selectedTeam){
            let cell = rankTableView.dequeueReusableCell(withIdentifier: "TimeToUp", for: indexPath) as! TimeToUp
            cell.upAlarm.text = String(format: "It's Time to Up Your Teammate For Week %d", getCurrentWeek())
            return cell
        } else {
            let cell = rankTableView.dequeueReusableCell(withIdentifier: "RankTableCell", for: indexPath) as! RankTableCell
            
            if indexPath.section == 0 {
                if getIsUp(userPhoneNum: userPhoneNum, selectedTeam: selectedTeam) {
                    let user1 = getRank12(selectedTeam: selectedTeam, monYear: "07.2017", week: getCurrentWeek()-indexPath.row-2)[0]
                    let user2 = getRank12(selectedTeam: selectedTeam, monYear: "07.2017", week: getCurrentWeek()-indexPath.row-2)[1]
                    cell.configure(user1: user1, user2: user2, monYear: "07.2017", week: getCurrentWeek()-indexPath.row-2, selectedTeam: selectedTeam)
                } else {
                    let user1 = getRank12(selectedTeam: selectedTeam, monYear: "07.2017", week: getCurrentWeek()-indexPath.row-1)[0]
                    let user2 = getRank12(selectedTeam: selectedTeam, monYear: "07.2017", week: getCurrentWeek()-indexPath.row-1)[1]
                    cell.configure(user1: user1, user2: user2, monYear: "07.2017", week: getCurrentWeek()-indexPath.row-1, selectedTeam: selectedTeam)
                }
                cell.backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 1)
                
            }
            
            if indexPath.section == 1 {
                if indexPath.row == 0 {
                    let user1 = getRank12(selectedTeam: selectedTeam, monYear: "06.2017")[0]
                    let user2 = getRank12(selectedTeam: selectedTeam, monYear: "06.2017")[1]
                    cell.configure(user1: user1, user2: user2, monYear: "06.2017", week: -1, selectedTeam: selectedTeam)
                } else {
                    let user1 = getRank12(selectedTeam: selectedTeam, monYear: "06.2017", week: getWeekNum(monYear: "06.2017")-indexPath.row)[0]
                    let user2 = getRank12(selectedTeam: selectedTeam, monYear: "06.2017", week: getWeekNum(monYear: "06.2017")-indexPath.row)[1]
                    cell.configure(user1: user1, user2: user2, monYear: "06.2017", week: getWeekNum(monYear: "06.2017")-indexPath.row, selectedTeam: selectedTeam)
                    cell.backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 1)
                }
                
            }
            
            
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if selectedTeam == nil {
            return 0
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
        view.backgroundColor = UIColor.white
        let headLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 50, height: 20))
        headLabel.font = UIFont.systemFont(ofSize: 12)
        headLabel.textColor = UIColor.black
        if section == 0 {
            headLabel.text = "07.2017"
        } else {
            headLabel.text = "06.2017"
        }
        
        view.addSubview(headLabel)
        return  view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if getIsUp(userPhoneNum: userPhoneNum, selectedTeam: selectedTeam) {
                return getCurrentWeek() - 1
            } else {
                return getCurrentWeek()
            }
        } else {
            return getWeekNum(monYear: "06.2017")+1
        }
    }
}

extension RankViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == [0,0] && !getIsUp(userPhoneNum: userPhoneNum, selectedTeam: selectedTeam) {
            let upTableVC = UpViewController()
            upTableVC.selectedTeam = selectedTeam
            upTableVC.userPhoneNum = userPhoneNum
            self.present(upTableVC, animated: true, completion: nil)
            upTableVC.delegate = self
        } else {
            let weekRankTableVC = WeekRankViewController()
            weekRankTableVC.selectedTeam = selectedTeam
            let cell = tableView.cellForRow(at: indexPath) as! RankTableCell
            
            if indexPath == [1,0] {
                weekRankTableVC.week = -1
            } else {
                let lastNum = cell.weekLabel.text!.index(cell.weekLabel.text!.endIndex, offsetBy: -1)
                let suffix = cell.weekLabel.text!.substring(from: lastNum)
                weekRankTableVC.week = Int(suffix)
            }
            
            if indexPath.section == 0 {
                weekRankTableVC.monYear = "07.2017"
            } else {
                weekRankTableVC.monYear = "06.2017"
            }
            
            self.present(weekRankTableVC, animated: true, completion: nil)
        }
    }
    
}

extension RankViewController: BackValueProtocol {
    func backValue() {
        self.rankTableView.reloadData()
    }
}

extension RankViewController: BackTeamProtocol {
    func backTeam(teams: [String], showTeams: [String]) {
        
        var title: [String]! = []
        for index in 0...teams.count-1 {
            if showTeams.index(of: teams[index]) != nil {
                title.append(teams[index])
            }
        }
        
        print(title)
        
        self.teams = teams
        self.showTeams = title
        
        if title != [] {
            self.segmented.titles = title
            self.selectedTeam = title[0]
        } else {
            self.segmented.titles = [" "]
            self.selectedTeam = nil
        }
        
        self.rankTableView.reloadData()
        
    }
}

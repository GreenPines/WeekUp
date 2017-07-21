//
//  TeamViewController.swift
//  WeekUp2
//
//  Created by android on 17/7/14.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit

class TeamViewController: UIViewController {
    
    
    
    
    var teamNameArr =
        ["Mazeal", "Alibaba", "Tencent"]
    var teamImageArr =
        ["Oval","checklist","Oval 2"]
    
    var userNameArr = ["Mary","John","Judy","Mary","John","Judy","Mary","John","Judy"]
    var userimageArr = ["Oval","checklist","Oval 2","Oval","checklist","Oval 2","Oval","checklist","Oval 2"]
    
    
    
    var isOpen: Bool = true

    var TeamTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.tabBarItem.title
        self.navigationController?.navigationBar.barStyle = .black
        
        let rightBtn=UIBarButtonItem(title: "CreateTeam", style: UIBarButtonItemStyle.plain, target: self, action: #selector(createTeam(barButtonItem:)))
        
        self.navigationItem.rightBarButtonItem = rightBtn
        rightBtn.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        TeamTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: UITableViewStyle.grouped)
        TeamTableView.delegate = self
        TeamTableView!.dataSource = self
        
        self.view.addSubview(TeamTableView)
        TeamTableView.rowHeight = 64
        
        var cellNib = UINib(nibName: "TeamCell", bundle: nil)
        TeamTableView.register(cellNib, forCellReuseIdentifier: "TeamCell")
        
        cellNib = UINib(nibName: "TeamMemberCell", bundle: nil)
        TeamTableView.register(cellNib, forCellReuseIdentifier: "TeamMemberCell")
        
        
        
    }
    
    func createTeam(barButtonItem: UIBarButtonItem) {
        let createTeam = CreateTeamViewController()
        self.present(createTeam, animated: true, completion: nil)
        
    }
    
    func tapGestureAction(){
        isOpen = !isOpen
        print(isOpen)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}

extension TeamViewController{
    
    func addOnClickListener(target: AnyObject, action: Selector) {
        let gr = UITapGestureRecognizer(target: target, action: action)
        gr.numberOfTapsRequired = 1

    }
}

extension TeamViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return teamNameArr.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNameArr.count
    }
    
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("hei!!!!!!!!!!");print(isOpen)
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:TeamMemberCell = tableView.dequeueReusableCell(withIdentifier: "TeamMemberCell") as! TeamMemberCell
        
        //cell.avatar.image = UIImage(named: userimageArr[indexPath.row])
        cell.avatar.image = UIImage(named: userimageArr[indexPath.row])

        cell.teamerNameLabel.text = userNameArr[indexPath.row]
        if indexPath.row % 3 == 0 {
            cell.teamerRoleLabel.text = "Admin"
        }else {
            cell.teamerRoleLabel.text = "Member"
        }
        
        return cell
        //}
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let sectionView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 40))
        
        sectionView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction))
        tapGesture.numberOfTapsRequired = 1
        sectionView.addGestureRecognizer(tapGesture)
        
        // let sectionView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        sectionView.backgroundColor = UIColor.white
        sectionView.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0).cgColor
        sectionView.layer.borderWidth = 0.5
        let teamNameLabel = UILabel(frame: CGRect(x: 48, y: 12, width: 50, height: 16))
        teamNameLabel.font  = UIFont(name: "Avenir-Heavy", size: 12)
        teamNameLabel.textColor = UIColor.black
        teamNameLabel.textAlignment = .left
        
        let arrowBtn = UIButton(frame: CGRect(x: 100, y: 15, width: 10, height: 10))
        arrowBtn.setBackgroundImage(#imageLiteral(resourceName: "arrow_right"), for: .normal)
        arrowBtn.addTarget(self, action: #selector(btnRotated), for: .touchUpInside)
        
        let avatar = UIImageView(frame: CGRect(x: 10, y: 5, width: 30, height: 30))

        
        if section == 0 {
            teamNameLabel.text = "Mazeal"
            avatar.image = #imageLiteral(resourceName: "team")
        }else if section == 1 {
            teamNameLabel.text = "Alibaba"
            avatar.image = #imageLiteral(resourceName: "summary")
        }else {
            teamNameLabel.text = "Tencent"
            avatar.image = #imageLiteral(resourceName: "yellow")
        }
        
        sectionView.addSubview(teamNameLabel)
        sectionView.addSubview(arrowBtn)
        sectionView.addSubview(avatar)
   
        
        return sectionView
        
    }
    
    
    
    func btnRotated(sender: UIButton){
        var isOened: Bool = false
        
        if isOened == false {
            sender.setBackgroundImage(#imageLiteral(resourceName: "arrow_down"), for: .normal)
            isOened = true
        }
        else {
            sender.setBackgroundImage(#imageLiteral(resourceName: "arrow_right"), for: .normal)
            isOened = false
        }
    }
}

extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = TeamTableView.cellForRow(at: indexPath) as! TeamMemberCell
        
        let vc = othersHomeViewController()
        
        //vc.imageBut.setImage(cell.avatar.image, for: .normal)
        vc.imageBut.setBackgroundImage(cell.avatar.image, for: .normal)
        self.present(vc, animated: true, completion: nil)
    }
}


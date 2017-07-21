//
//  EditTeamViewController.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/14.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit
protocol BackTeamProtocol {
    func backTeam(teams: [String], showTeams: [String])
}

class EditTeamViewController: UIViewController {
    var editTeamTableView: UITableView!
    
    var teams: [String]!
    var showTeams: [String]!
    var rightBtn: UIBarButtonItem!
    var delegate: BackTeamProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.contentInset = UIEdgeInsets(top: 108, left: 0, bottom: 0, right: 0)
        
        var navigationBar:UINavigationBar?
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 64))
        //print("hhh,,,,,")
        let navigationItem = UINavigationItem()
        navigationItem.title = "Teams Edit"
        
        let leftBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "return"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(EditTeamViewController.onReturn))
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        rightBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(EditTeamViewController.onDone))
        navigationItem.setRightBarButton(rightBtn, animated: true)
        rightBtn.isEnabled = false

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
        editTeamTableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64), style: UITableViewStyle.plain)
        editTeamTableView!.delegate = self
        editTeamTableView!.dataSource = self
        self.view.addSubview(editTeamTableView)
        editTeamTableView.rowHeight = 62
        editTeamTableView.setEditing(true, animated: true)
        
        let cellNib = UINib(nibName: "EditTeamTableCell", bundle: nil)
        editTeamTableView.register(cellNib, forCellReuseIdentifier: "EditTeamTableCell")
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onDone() {
        delegate?.backTeam(teams: teams, showTeams: showTeams)
        dismiss(animated: true, completion: nil)
    }
    
    func onReturn() {
        dismiss(animated: true, completion: nil)
    }
    
    func getMembers(team: String) -> [Int] {
        return [1, 6]
    }
    
    
}


extension EditTeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = editTeamTableView.dequeueReusableCell(withIdentifier: "EditTeamTableCell", for: indexPath) as! EditTeamTableCell
        
        print(cell.contentView.frame.size.width)
        
        cell.teamName.text = teams[indexPath.row]
        cell.showTeams = showTeams
        cell.editTeamViewController = self
        if showTeams.index(of: teams[indexPath.row]) != nil {
            cell.setImage(isCheck: true)
        } else {
            cell.setImage(isCheck: false)
            cell.isCheck = false
        }
        
        let members = getMembers(team: teams[indexPath.row])
        if members[0] > 1 && members[1] > 1{
            cell.teamMembers.text = "\(members[0]) admins and \(members[1]) members"
        } else if members[0] > 1 {
            cell.teamMembers.text = "\(members[0]) admins and \(members[1]) member"
        } else if members[1] > 1 {
            cell.teamMembers.text = "\(members[0]) admin and \(members[1]) members"
        } else {
            cell.teamMembers.text = "\(members[0]) admin and \(members[1]) member"
        }
        
        cell.showsReorderControl = true

        return cell
    }
    
    //返回YES，表示支持单元格的移动
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @objc(tableView:editingStyleForRowAtIndexPath:) func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let str: String!
        str = teams[sourceIndexPath.row]
        teams[sourceIndexPath.row] = teams[destinationIndexPath.row]
        teams[destinationIndexPath.row] = str
        tableView.reloadData()
        rightBtn.isEnabled = true
    }
    
    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        for view in cell.subviews {
            if view.classForCoder.description() == "UITableViewCellReorderControl" {
                let movedReorderControl = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.maxX, height: view.frame.maxY))
                movedReorderControl.addSubview(view)
                cell.addSubview(movedReorderControl)
                let moveLeft = CGSize(width: movedReorderControl.frame.size.width - view.frame.size.width, height: movedReorderControl.frame.size.height - view.frame.size.height)
                var transform = CGAffineTransform.identity
                transform = CGAffineTransform(translationX: -moveLeft.width, y: -moveLeft.height)
                
                movedReorderControl.transform = transform
            }
        }
    }

}

extension EditTeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}


//
//  activitiesViewController.swift
//  WKTabBarController-Example
//
//  Created by Jerry on 17/7/13.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class activitiesViewController: UIViewController {
    
    var activityTableView: UITableView!
    var actImageArr = ["summary","checklist","post2","summary","checklist","post2","summary","checklist","post2"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Steven Ingram"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "arrow-left"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftBtnClick))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        //添加tableView
        activityTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: UITableViewStyle.grouped)
        activityTableView!.delegate = self
        activityTableView!.dataSource = self
        self.view.addSubview(activityTableView)
        
        let cellNib = UINib(nibName: "activityCell", bundle: nil)
        activityTableView.register(cellNib, forCellReuseIdentifier: "actCell")
        let cellNib2 = UINib(nibName: "weekCell", bundle: nil)
        activityTableView.register(cellNib2, forCellReuseIdentifier: "weekCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func leftBtnClick(){
        _ = navigationController?.popViewController(animated: true)
    }

}


extension activitiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell:weekCell = tableView.dequeueReusableCell(withIdentifier: "weekCell") as! weekCell
            return cell
        }else{
        let cell:activityCell = tableView.dequeueReusableCell(withIdentifier: "actCell") as! activityCell
            
            cell.actImage.image = UIImage(named:actImageArr[indexPath.row])
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 || section == 2{
            return 20
        }
        else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 40
        }else{
            return 48
        }
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 220))
        let headLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 375, height: 16))
        headLabel.font = UIFont.systemFont(ofSize: 12)
        headLabel.textColor = UIColor.black
        if section == 0 {
            headLabel.text = "7.2017"
        }else if section == 2 {
            headLabel.text = "6.2017"
        }else{
            headLabel.text = ""
        }
        
        view.addSubview(headLabel)

        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
}

extension activitiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

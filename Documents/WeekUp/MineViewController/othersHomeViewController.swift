//
//  othersHomeViewController.swift
//  WKTabBarController-Example
//
//  Created by Jerry on 17/7/13.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit
import QuartzCore

class othersHomeViewController: UIViewController {
    
    let imageBut = UIButton(frame: CGRect(x: 145, y: 43, width: 86, height: 86))
    
    var userPhoneNum = ""
    var userimage = UIImage()
    
    
    var othersHomeTableView: UITableView!
    var actImageArr = ["summary","checklist","post2","summary","checklist","post","summary","checklist","post2"]
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var navigationBar:UINavigationBar?
        navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 64))
        let navigationItem = UINavigationItem()
        
        let leftBtn=UIBarButtonItem(image: #imageLiteral(resourceName: "closeIcon"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftBtnClick))
        leftBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem=leftBtn
        
        
        if userPhoneNum == "" {
            navigationItem.title = "Steven Ingram"
        } else {
            navigationItem.title = getUserName(userPhoneNum: userPhoneNum)
        }
        
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont(name: "Avenir-Heavy", size: 25)!]
        navigationBar?.pushItem(navigationItem, animated: true)
        self.view.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        navigationBar?.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        navigationBar?.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        
        self.view.addSubview(navigationBar!)
        
        
        //添加tableView
        othersHomeTableView = UITableView(frame: CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 64), style: UITableViewStyle.grouped)
        othersHomeTableView!.delegate = self
        othersHomeTableView!.dataSource = self
        self.view.addSubview(othersHomeTableView)
        
        let cellNib = UINib(nibName: "activityCell", bundle: nil)
        othersHomeTableView.register(cellNib, forCellReuseIdentifier: "actCell")
        let cellNib2 = UINib(nibName: "weekCell", bundle: nil)
        othersHomeTableView.register(cellNib2, forCellReuseIdentifier: "weekCell")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func leftBtnClick(){
        dismiss(animated: true, completion: nil)
    }
}


extension othersHomeViewController: UITableViewDataSource {

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
        if section == 0{
            return 102
        }
        else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 50
        }else{
            return 5
        }
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{

        if section == 0{
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
        let bgColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        view.backgroundColor = bgColor
        
        let upLabel = UILabel(frame: CGRect(x: 127, y: 18, width: 53, height: 19))
        upLabel.font  = UIFont(name: "Avenir-Heavy", size: 14)
        upLabel.textColor = UIColor.white
        upLabel.text = "42 ups"
        upLabel.textAlignment = .center
        
        let lineView = UIView(frame: CGRect(x: 184, y: 21, width: 2, height: 15))
        lineView.backgroundColor = UIColor.white
        
        let teamBut = UIButton(frame: CGRect(x: 192, y: 18, width: 56, height: 19))
        teamBut.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        teamBut.titleLabel?.textColor = UIColor.white
        teamBut.titleLabel?.textAlignment = .center
        teamBut.setTitle("3 teams", for: .normal)
    
        
        //imageBut.setBackgroundImage(#imageLiteral(resourceName: "avatar-border"), for: .normal)
            
        imageBut.layer.cornerRadius = imageBut.bounds.size.width / 2
        imageBut.clipsToBounds = true
        imageBut.layer.borderWidth = 3
        imageBut.layer.borderColor = UIColor.white.cgColor
        //imageBut.addTarget(self, action: #selector(imageButClick), for: .touchUpInside)
        
        view.addSubview(upLabel)
        view.addSubview(lineView)
        view.addSubview(teamBut)
        view.addSubview(imageBut)
            return view
        }
        
        else{
            let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
            let headLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 375, height: 16))
            headLabel.font = UIFont.systemFont(ofSize: 12)
            headLabel.textColor = UIColor.black
            headLabel.text = "7.2017"
            view.addSubview(headLabel)
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 0
        }else{
            return 5
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func activitiesButClick(){
        let activitiesVC = activitiesViewController()
        self.present(activitiesVC, animated: true, completion: nil)
    }
    
}

extension othersHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

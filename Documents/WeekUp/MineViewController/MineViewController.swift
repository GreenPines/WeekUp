//
//  MineViewController.swift
//  WKTabBarController-Example
//
//  Created by Jerry on 17/7/12.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

private let dateFormatter2: DateFormatter = {
    let formatter2 = DateFormatter()
    formatter2.dateStyle = .full
    formatter2.timeStyle = .short
    return formatter2
}()


class MineViewController: UIViewController {

    var MineTableView: UITableView!
    
    
    let imageBut = UIButton(frame: CGRect(x: 145, y: 73, width: 86, height: 86))
    let nameLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 375, height: 29))
    
    var flags:Array<Int> = []
    
    func getMessage() -> [message]{
        let message1 = message(type:"at",userImg:#imageLiteral(resourceName: "Oval"),userName: "Mary", userTeam:"Mazeal", date:"01:17 PM", informMeg:"@ you a message",badge:6)
        let message2 = message(type:"checklist",userImg:#imageLiteral(resourceName: "checklist"),userName: "It's time to create a checklist", userTeam:"", date:"01:17 PM", informMeg:"for week 1", badge:0)
        let message3 = message(type:"summary",userImg:#imageLiteral(resourceName: "summary"),userName: "It's time to summarize you", userTeam:"", date:"01:17 PM", informMeg:"for week 4",badge:0)
        let message4 = message(type:"at",userImg:#imageLiteral(resourceName: "Oval 2"),userName: "Ruby", userTeam:"Tencent", date:"01:17 PM", informMeg:"@ you a message", badge:3)
        let message5 = message(type:"at",userImg:#imageLiteral(resourceName: "Oval 3"),userName: "Judy", userTeam:"Alibaba", date:"01:17 PM", informMeg:"@ you a message", badge:2)

        return [message1,message2,message3,message4,message5]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(getMessage().count)
        imageBut.setImage(#imageLiteral(resourceName: "avatar"), for: .normal)
        flags = Array<Int>(repeating: 1, count:getMessage().count)
        
        self.navigationItem.title = self.tabBarItem.title
        self.navigationController?.navigationBar.barStyle = .black
        
        
        let leftBtn=UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(setAction))
        self.navigationItem.leftBarButtonItem = leftBtn
        leftBtn.tintColor = UIColor.white
        
        let rightBtn=UIBarButtonItem(image: #imageLiteral(resourceName: "pencil"), style: UIBarButtonItemStyle.plain, target: self, action:#selector(profileAction))
        self.navigationItem.rightBarButtonItem = rightBtn
        rightBtn.tintColor = UIColor.white

        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont(name: "Avenir-Heavy", size: 25)!]
        
        
        //添加tableView
        MineTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), style: UITableViewStyle.grouped)
        MineTableView!.delegate = self
        MineTableView!.dataSource = self
        
        MineTableView.backgroundColor = UIColor.white
        
        self.view.addSubview(MineTableView)
        MineTableView.rowHeight = 64
        
        let cellNib = UINib(nibName: "messagesCell", bundle: nil)
        MineTableView.register(cellNib, forCellReuseIdentifier: "cell1")
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //打印年月日
    func format(date:Date) -> String{
        return dateFormatter.string(from: date)
    }
    
    //打印 周/月/日/年
    func format2(date:Date) -> String{
        return dateFormatter2.string(from: date)
    }

    
    //设置
    func setAction(){
        let settingVC = settingViewController()
        //self.present(settingVC, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    //编辑资料
    func profileAction(){
        let profileVC = profileViewController()
        profileVC.delegate = self
        profileVC.userBut.setImage(imageBut.image(for: .normal), for: .normal)
        profileVC.name = self.nameLabel.text
        //self.present(profileVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension MineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:messagesCell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! messagesCell
        
        var currentRow: Int
        currentRow = indexPath.row
        
        cell.type = getMessage()[currentRow].type
        cell.userImage.image = getMessage()[currentRow].userImg
        cell.userName.text = getMessage()[currentRow].userName
        cell.teamName.text = getMessage()[currentRow].userTeam
        cell.time.text = getMessage()[currentRow].date
        cell.inform.text = getMessage()[currentRow].informMeg
        if cell.type != "at"{
            cell.atLabel.text = ""
            cell.teamLabel.text = ""
        }
        let messNum = getMessage()[currentRow].badge
        if messNum > 0{
            cell.setupBadge(text: "\(getMessage()[currentRow].badge)")
            if flags[indexPath.row] == 1 {
                let length = cell.badge.text?.characters.count
                let temp = CGFloat(length! * 10)
                cell.inform.frame.origin.x -= temp
                flags[indexPath.row] = 0
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(section)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 220))
        let view1: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 137))
        let view2: UIView = UIView(frame: CGRect(x: 0, y: 137, width: self.view.frame.size.width, height: 83))
        let bgColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        view.backgroundColor = bgColor
        view2.backgroundColor = UIColor.white
        
        nameLabel.font  = UIFont(name: "Avenir-Heavy", size: 25)
        nameLabel.textColor = UIColor.white
        nameLabel.text = "Steven Ingram"
        nameLabel.textAlignment = .center
        
        let upLabel = UILabel(frame: CGRect(x: 127, y: 38, width: 53, height: 19))
        upLabel.font  = UIFont(name: "Avenir-Heavy", size: 14)
        upLabel.textColor = UIColor.white
        upLabel.text = "42 ups"
        upLabel.textAlignment = .center
        
        let lineView = UIView(frame: CGRect(x: 184, y: 41, width: 2, height: 15))
        lineView.backgroundColor = UIColor.white
        
        let teamBut = UIButton(frame: CGRect(x: 192, y: 39, width: 56, height: 19))
        teamBut.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        teamBut.titleLabel?.textColor = UIColor.white
        teamBut.titleLabel?.textAlignment = .center
        teamBut.setTitle("3 teams", for: .normal)

        teamBut.addTarget(self, action: #selector(teamButClick), for: .touchUpInside)
        
        let heartView = UIImageView(frame: CGRect(x: 27, y: 110, width: 11, height: 10))
        heartView.image = #imageLiteral(resourceName: "favourite_white")
        
        let favorBut = UIButton(frame: CGRect(x: 41, y: 106, width: 78, height: 19))
        favorBut.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        favorBut.titleLabel?.textColor = UIColor.white
        favorBut.titleLabel?.textAlignment = .center
        favorBut.setTitle("30 favorites", for: .normal)
        
        //imageBut.setBackgroundImage(#imageLiteral(resourceName: "avatar-border"), for: .normal)
        
        imageBut.layer.borderColor = UIColor.white.cgColor
        imageBut.layer.borderWidth = 3
        imageBut.layer.cornerRadius = imageBut.bounds.size.width / 2
        imageBut.clipsToBounds = true
        
        imageBut.addTarget(self, action: #selector(imageButClick), for: .touchUpInside)
        
        let activitiesBut = UIButton(frame: CGRect(x: 257, y: 106, width: 94, height: 19))
        activitiesBut.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        activitiesBut.titleLabel?.textColor = UIColor.white
        activitiesBut.titleLabel?.textAlignment = .center
        activitiesBut.setTitle("All Activities", for: .normal)
        activitiesBut.addTarget(self, action: #selector(activitiesButClick), for: .touchUpInside)

        let messageView = UIImageView(frame: CGRect(x: 127, y: 48, width: 12, height: 12))
        messageView.image = #imageLiteral(resourceName: "ion-chatbubble-working - Ionicons")
        
        let messageLabel = UILabel(frame: CGRect(x: 143, y: 48, width: 105, height: 16))
        messageLabel.font  = UIFont(name: "Avenir-Medium", size: 12)
        messageLabel.textColor = UIColor.black
        messageLabel.text = "2 unread messages"
        messageLabel.textAlignment = .center
        
        view1.addSubview(nameLabel)
        view1.addSubview(upLabel)
        view1.addSubview(lineView)
        view1.addSubview(teamBut)
        view1.addSubview(heartView)
        view1.addSubview(favorBut)
        view1.addSubview(imageBut)
        view1.addSubview(activitiesBut)
        view2.addSubview(messageView)
        view2.addSubview(messageLabel)
        view.addSubview(view2)
        view.addSubview(view1)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMessage().count
    }
    
    func teamButClick(){
        print("I‘m teamBut")
    }
    
    
    func activitiesButClick(){
        let activitiesVC = activitiesViewController()
        self.navigationController?.pushViewController(activitiesVC, animated: true)
    }
    
    func imageButClick(){
        let othersHomeVC = othersHomeViewController()
        othersHomeVC.imageBut.setImage(imageBut.image(for: .normal), for: .normal)
        self.present(othersHomeVC, animated: true, completion: nil)
    }
    
}

extension MineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        let cell = MineTableView.cellForRow(at: indexPath) as! messagesCell
        if cell.type == "at"{
            print("应该跳转到at页面")
        }else if cell.type == "summary"{
            print("应该跳转到summary页面")
        }else if cell.type == "checklist"{
            print("应该跳转到checklist页面")
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension MineViewController: backToMine{
    func imageChange(img: UIImage){
        imageBut.setImage(img, for: .normal)
    }
    func nameTrans(name: String) {
        nameLabel.text = name
    }
}

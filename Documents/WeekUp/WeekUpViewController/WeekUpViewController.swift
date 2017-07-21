//
//  WeekUpViewController.swift
//  WeekUp2
//
//  Created by android on 17/7/14.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit

class WeekUpViewController: UIViewController{
    
    var weekUpTableView: UITableView!
    let markBlurTop = UIImageView(image:#imageLiteral(resourceName: "mask_top"))
    let markBlurBottom = UIImageView(image:#imageLiteral(resourceName: "mask_bottom"))
    var test1 = ["haha","haha","haha"]
    
    var isChecked = [1,1,0,1,0,0,0]
    var checkItem = ["The first checklist", "The second checklist","The third checklist","The fourth checklist","The fifth checklist","The sixth checklist", "The seventh checklist"]
    var items = ["item1","item2","item3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print(getCheckItem())

        self.navigationItem.title = self.tabBarItem.title
        self.navigationController?.navigationBar.barStyle = .black
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1.0)
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bg"), for: .default)

        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 375, height: 38))
        searchBar.backgroundColor = UIColor(red:234/255,green:234/255,blue:234/255,alpha:1.0)
        self.view.addSubview(searchBar)
        searchBar.placeholder = "Samovar Tea Lounge"
    
        
        //添加tableView
        weekUpTableView = UITableView(frame: CGRect(x: 0, y: 38, width: self.view.bounds.size.width, height: self.view.bounds.size.height - 100), style: UITableViewStyle.grouped)
        weekUpTableView!.delegate = self
        weekUpTableView!.dataSource = self
        self.view.addSubview(weekUpTableView)
        weekUpTableView.rowHeight = UITableViewAutomaticDimension
        weekUpTableView.estimatedRowHeight = 64
        //weekUpTableView.rowHeight = 64
        
        var cellNib = UINib(nibName: "TimeToUp", bundle: nil)
        weekUpTableView.register(cellNib, forCellReuseIdentifier: "TimeToUp")
        cellNib = UINib(nibName: "checklistTableViewCell", bundle: nil)
        weekUpTableView.register(cellNib, forCellReuseIdentifier: "checklist")
        cellNib = UINib(nibName: "checklistDetailsCell", bundle: nil)
        weekUpTableView.register(cellNib, forCellReuseIdentifier: "itemCell")
        cellNib = UINib(nibName: "showTableViewCell", bundle: nil)
        weekUpTableView.register(cellNib, forCellReuseIdentifier: "showCell")
    
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension WeekUpViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
    
        if indexPath.row == 0{
            let cell = weekUpTableView.dequeueReusableCell(withIdentifier: "TimeToUp", for: indexPath) as! TimeToUp
            cell.upAlarm.text = String(format: "It's Time to Up Your Teammate For Week %d", getCurrentWeek())
            return cell
        }else if indexPath.row == 1{
            let cell = weekUpTableView.dequeueReusableCell(withIdentifier: "checklist", for: indexPath) as! checklistTableViewCell
            return cell
        }else if indexPath.row == 2 {
            let cell = weekUpTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! checklistDetailsCell
            let label = cell.viewWithTag(1000) as! UILabel
            let checkbox = cell.viewWithTag(1001) as! UIImageView
            getCheckItem()
            label.text = items[0]
            checkbox.image = #imageLiteral(resourceName: "checkbox2")
            cell.addSubview(markBlurTop)
            return cell
        }else if indexPath.row == 3 {
            let cell = weekUpTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! checklistDetailsCell
            let label = cell.viewWithTag(1000) as! UILabel

            label.text = items[1]
            
            return cell
        }else if indexPath.row == 4 {
            let cell = weekUpTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! checklistDetailsCell
            let label = cell.viewWithTag(1000) as! UILabel

            label.text = items[2]
            cell.addSubview(markBlurBottom)
            return cell
        }else {
            let cell = weekUpTableView.dequeueReusableCell(withIdentifier: "checklist", for: indexPath) as! checklistTableViewCell
            cell.activityImage.image = #imageLiteral(resourceName: "activity")
            cell.activityName.text = "Activity"
            cell.activityDetail.image = nil
            cell.more.text = ""
            cell.accessoryType = .none
            
            return cell
            }
        }
            //加载activity block
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "showCell") as! showTableViewCell
            
            cell.detailLabel.numberOfLines = 5
            cell.detailLabel.text = "modern in style, and the liquid crystals that make them work have allowed humanity to create slimmer, more portable technology than we’ve ever had access to before. From your wrist watch to your laptop, a lot of modern in style, and the liquid crystals modern in style, and the liquid crystals modern in style, and the liquid crystals modern in style, and the liquid crystals modern in style, and the liquid crystals modern in style, and the liquid crystals modern in style, and the liquid crystals modern in style, and the liquid crystals modern in style, and the liquid crystals..."
            cell.midView.image = #imageLiteral(resourceName: "articlePic")
            cell.mainView.layer.borderWidth = 1
            cell.mainView.layer.borderColor = UIColor(red:199/255,green:199/255,blue:199/255,alpha:100/255).cgColor
            cell.mainView.layer.cornerRadius = 10
            
            cell.updateFocusIfNeeded()
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0.1
        } else {
            return 20
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 6
        }else{
            return 1
        }
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            if  indexPath.row == 0{
            return 64
        }else if indexPath.row == 1
        {
            return 40
        }else{
            return 46
            }
        }
        else{
            return UITableViewAutomaticDimension
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
        view.backgroundColor = UIColor.white
        let headLabel = UILabel(frame: CGRect(x: 15, y: 0, width: 50, height: 20))
        headLabel.font = UIFont.systemFont(ofSize: 12)
        headLabel.textColor = UIColor.black
        if section == 0 {
            return nil
        } else {
            headLabel.text = "Today"
        }
        
        view.addSubview(headLabel)
        return view
    }
    
    
    func getCheckItem() -> [Int]{
        let len = isChecked.count - 1
        var temp = [0,0,0]
        var flag = 1
        for index in 0...len{
            if flag >= 0{
                if isChecked[index] == 0{
                temp[2-flag] = index
                flag -= 1
                }
            }
        }
        //print(checkItem[temp-1])
        temp[0] = temp[1]-1
        items[0] = checkItem[temp[0]]
        items[1] = checkItem[temp[1]]
        items[2] = checkItem[temp[2]]
        print(temp)
        return temp
    }
    
    func getCurrentWeek() -> Int {
        return 3
    }
}

extension WeekUpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0{
            let upTableVC = RankViewController()
            //self.present(upTableVC, animated: true, completion: nil)
            self.navigationController?.navigationBar.tintColor = UIColor.white
            self.navigationController?.pushViewController(upTableVC, animated: true)
            
        }
        
        if indexPath.section == 0 && indexPath.row == 3{
            if let cell = tableView.cellForRow(at: indexPath){
                let checkbox = cell.viewWithTag(1001) as! UIImageView
                let temp = getCheckItem()

                if checkbox.image == #imageLiteral(resourceName: "checkbox1"){
                    checkbox.image = #imageLiteral(resourceName: "checkbox2")
                    if temp[1] != 6{
                        isChecked[temp[1]] = 1
                        self.viewDidLoad()
                    }
                }else if checkbox.image == #imageLiteral(resourceName: "checkbox2"){
                    if temp[1] == 6 {
                        print("Congratulation! you have done all activities")
                        
                        
                        let alertController = UIAlertController(title: "warning!", message: "checklist finished", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (ACTION) -> Void in
                            
                        }
                        
                        alertController.addAction(okAction);
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

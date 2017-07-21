//
//  EditTeamTableCell.swift
//  WKTabBarController-Example
//
//  Created by 密码是1-8 on 2017/7/14.
//  Copyright © 2017年 Wonderkiln. All rights reserved.
//

import UIKit

class EditTeamTableCell: UITableViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamMembers: UILabel!
    
    var button: UIButton!
    var isCheck = true
    var showTeams: [String]!
    var editTeamViewController: EditTeamViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        button = UIButton(frame: CGRect(x: self.contentView.frame.size.width-20, y: 24, width: 14, height: 14))
        button.addTarget(self, action: #selector(EditTeamTableCell.onBotton), for: .touchUpInside)
        self.addSubview(button)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func onBotton() {
        if isCheck {
            button.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
            isCheck = false
            showTeams.remove(at: showTeams.index(of: teamName.text!)!)
        } else {
            button.setImage(#imageLiteral(resourceName: "show-check"), for: .normal)
            isCheck = true
            showTeams.append(teamName.text!)
        }
        editTeamViewController.showTeams = showTeams
        for index in 0...editTeamViewController.editTeamTableView.numberOfRows(inSection: 0)-1 {
            let cell = editTeamViewController.editTeamTableView.cellForRow(at: [0,index]) as! EditTeamTableCell
            cell.showTeams = showTeams
        }
        editTeamViewController.rightBtn.isEnabled = true
    }
    
    func setImage(isCheck: Bool) {
        if isCheck {
            button.setImage(#imageLiteral(resourceName: "show-check"), for: .normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "uncheck"), for: .normal)
        }
    }
    
    
}

//
//  TeamCell.swift
//  WeekUp2
//
//  Created by zuhui on 2017/7/18.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit

class TeamCell: UITableViewCell {
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var profilePictureView: UIImageView!
    
    @IBOutlet weak var isOpen: UIButton!
    @IBAction func isCollapsed(_ sender: Any) {
    }
    
    // MARK: - 变量
    var isOpend: Bool!
    var downloadTask: URLSessionDownloadTask?
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        print("TeamCell")
        return String(describing: self)
        
    }
    
    /*
     func configure(for teamCell: TeamCell) {
     teamNameLabel.text = teamCell.name
     
     if teamCell.teamNameLabel.isEmpty {
     teamNameLabel.text = NSLocalizedString("Unknown", comment: "Unknown artist name")
     } else {
     teamNameLabel.text = String(format: NSLocalizedString("ARTIST_NAME_LABEL_FORMAT", comment: "Format for artist name label"), teamCell.teamNameLabel, teamCell.kindForDisplay())
     }
     
     profilePictureView.image = UIImage(named: "Placeholder")
     if let smallURL = URL(string: teamCell.artworkSmallURL) {
     downloadTask = profilePictureView.loadImage(url: smallURL)
     }
     }*/
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
        profilePictureView?.layer.cornerRadius = 50
        profilePictureView?.clipsToBounds = true
        profilePictureView?.contentMode = .scaleAspectFit
        profilePictureView?.backgroundColor = UIColor.lightGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        downloadTask?.cancel()
        downloadTask = nil
        profilePictureView?.image = nil
        
        
    }
    
}

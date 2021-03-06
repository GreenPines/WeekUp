//
//  CollapsibleTableViewHeader.swift
//  WeekUp2
//
//  Created by zuhui on 2017/7/18.
//  Copyright © 2017年 android. All rights reserved.
//


import Foundation
import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //
        // Constraint the size of arrow label for auto layout
        //
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowLabel)
        
        //
        // Call tapHeader when tapping on this header
        //
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = UIColor.clear
        
        titleLabel.textColor = UIColor.black
        arrowLabel.textColor = UIColor(hex: 444444)
        
        //
        // Autolayout the lables
        //
        let views = [
            "titleLabel" : titleLabel,
            "arrowLabel" : arrowLabel,
            ]
        
        //        contentView.addConstraints(NSLayoutConstraint.constraints(
        //            withVisualFormat: "H:|-20-[titleLabel]-[arrowLabel]-20-|",
        //            options: [],
        //            metrics: nil,
        //            views: views
        //        ))
        //
        //        contentView.addConstraints(NSLayoutConstraint.constraints(
        //            withVisualFormat: "V:|-[titleLabel]-|",
        //            options: [],
        //            metrics: nil,
        //            views: views
        //        ))
        //
        //        contentView.addConstraints(NSLayoutConstraint.constraints(
        //            withVisualFormat: "V:|-[arrowLabel]-|",
        //            options: [],
        //            metrics: nil,
        //            views: views
        //        ))
    }
    
    //
    // Trigger toggle section when tapping on the header
    //
    func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        
        delegate?.toggleSection(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        //
        // Animate the arrow rotation (see Extensions.swf)
        //
        arrowLabel.rotate(collapsed ? 0.0 : CGFloat(M_PI_2))
    }
    
}

//
//  AllTabBarController.swift
//  WeekUp2
//
//  Created by android on 17/7/14.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit

class AllTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundImage = #imageLiteral(resourceName: "blur")
        
        self.addCenterButton(btnimage: UIImage(named: "add")!, selectedbtnimg: UIImage(named: "add")!, selector: "showModalViewController", view: self.view)

        // Do any additional setup after loading the view.
        let controller1 = WeekUpViewController.init()
        let controller2 = RankViewController.init()
        let controller3 = AddViewController.init()
        let controller4 = TeamViewController.init()
        let controller5 = MineViewController.init()
        
        
        setupChildController(controller: controller1, title: "WeekUp", image: "weekup_normal", selectedImage: "weekup_highlighted")
        
        setupChildController(controller: controller2, title: "Rank", image: "rank_normal", selectedImage: "rank_highlighted")
        
        setupChildController(controller: controller3, title: "", image: "", selectedImage: "")
        
        setupChildController(controller: controller4, title: "Team", image: "team_normal", selectedImage: "team_highlighted")
        
        setupChildController(controller: controller5, title: "Mine", image: "me_normal", selectedImage: "me_highlighted")
        
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.red], for: .selected)
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
            
            controller5.tabBarItem.pp.addBadge(text: "9")
            
        }

    }
    
    
    
    func setupChildController(controller: UIViewController, title: String, image: String, selectedImage: String) {
        
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage.init(named: image)?.withRenderingMode(.alwaysOriginal)
        controller.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(UINavigationController.init(rootViewController: controller))
        
    }
    
    //参数说明
    //btnimage 按钮图片
    //selectedbtnimg 点击时图片
    //selector 按钮方法名称
    //view 按钮添加到view  正常是 self.view就可以
    func addCenterButton(btnimage buttonImage:UIImage,selectedbtnimg selectedimg:UIImage,selector:String,view:UIView)
    {
        //创建一个自定义按钮
        let button:UIButton = UIButton(type: UIButtonType.custom)
        //btn.autoresizingMask
        //button大小为适应图片
        button.frame = CGRect(x:0, y:0, width:72, height:49)
        button.setImage(buttonImage, for: .normal)
        button.setImage(selectedimg, for: .selected)

        //去掉阴影
        button.adjustsImageWhenDisabled = true
        //按钮的代理方法
        button.addTarget(self, action: Selector(selector), for: .touchUpInside)
        button.center = self.tabBar.center
        //高度差
        let heightDifference:CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
        if (heightDifference < 0){
            button.center = self.tabBar.center
        }
        else
        {
            var center:CGPoint = self.tabBar.center
            center.y = center.y - heightDifference/2.0
            button.center = center;
        }
        view.addSubview(button);
    }
    
    
    @objc private func showModalViewController() {
        let vc = AddViewController()
       
        present(vc, animated: true, completion: nil)
    }

}

//
//  AppDelegate.swift
//  WeekUp
//
//  Created by android on 17/7/20.
//  Copyright © 2017年 android. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate{

    var window: UIWindow?
    let dataModel = DataModel()
    // 公用数据模型
    
    /** 静态常量 3个controller
     **/
    struct Constants{
        static let allweeks = AllWeekLists(nibName: "AllWeekLists", bundle: nil)
        static let thisweek = ThisWeekController(nibName: "ThisWeekController", bundle: nil)
        static let nextweek = NextWeekController(nibName: "NextWeekController", bundle: nil)
    }
    
    /** 用户通知
     **/
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Received local notification \(notification)")
    }



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        //self.window?.rootViewController = AllTabBarController.init()
        self.window?.rootViewController = Walkthrough.init()
        
        self.window?.makeKeyAndVisible()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        /**
         数据模型 && 通知推送
         **/
        Constants.allweeks.dataModel = dataModel
        Constants.thisweek.dataModel = dataModel
        Constants.nextweek.dataModel = dataModel
        
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        
        return true
    }
    
    /**
     保存数据
     **/
    func saveData() {
        dataModel.saveChecklists()
        
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        saveData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        saveData()
    }


}


//
//  AppDelegate.swift
//  AppForLearn
//
//  Created by charles on 2017/9/21.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //当 app 再次打开时，在这里可以收到 push 的 info
        if launchOptions != nil {
            let pushInfo = launchOptions![UIApplicationLaunchOptionsKey.remoteNotification]
            let userDefaults = UserDefaults.standard
            userDefaults.set(pushInfo, forKey: "pushInfoSave")
            if pushInfo != nil {
//                PushHandler.instance.handlerPush(pushInfo as! NSMutableDictionary )
            }
        }
       
        
        
        registerAPN(application)
        application.registerForRemoteNotifications()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    /// 注册推送服务
    func registerAPN(_ application: UIApplication) {
        //向用户申请通知权限
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if granted {
                //用户授予通知权限
            } else {
                //用户未授予通知权限
            }
        }
    }
    
    /// 申请 DeviceToken 成功后的回调
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //拿到 deviceToken(形如“<b71c532c ace3ee28 ac6c07a7 49ae8593 89975b66 d9b008ee 8fc414a5 117df41c>”，需要去掉尖括号和空格)
        var tokenString = String.init(format: "%@", deviceToken as CVarArg)
        tokenString = tokenString.replacingOccurrences(of: " ", with: "")
        tokenString = tokenString.replacingOccurrences(of: "<", with: "")
        tokenString = tokenString.replacingOccurrences(of: ">", with: "")
        
        //将 deviceToken 上传至我们自己的服务器，这里我使用自己搭建的测试服务器（NWPusher）
        
        print(tokenString)
    }
    
    /// 申请 DeviceToken 失败后的回调
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("申请失败:", error)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }


}


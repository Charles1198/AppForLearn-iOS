//
//  PushNotificationVC.swift
//  AppForLearn
//
//  Created by charles on 2017/9/21.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit
import UserNotifications

class PushNotificationVC: UIViewController {
    
    var notificationRequest : UNNotificationRequest?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let userDefaults = UserDefaults.standard
//        let pushInfo = userDefaults.object(forKey: "pushInfoSave")
//
//        if pushInfo != nil {
//            let alert = UIAlertController.init(title: "pushInfo", message: pushInfo.debugDescription, preferredStyle: .alert)
//            alert.addAction(UIAlertAction.init(title: "好的", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }

        // Do any additional setup after loading the view.
        self.navigationItem.title = "推送通知"
        
        //添加 app 进入前台的回调
        NotificationCenter.default.addObserver(self, selector: #selector(detectAppEnterForground), name: .UIApplicationWillEnterForeground, object: nil)
        
        //添加 app 进入后台的回调
        NotificationCenter.default.addObserver(self, selector: #selector(detectAppEnterBackground), name: .UIApplicationDidEnterBackground, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func detectAppEnterForground() {
        if notificationRequest != nil {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
    }
    
    @objc func detectAppEnterBackground() {
        let content = UNMutableNotificationContent.init()
        content.title = "这是通知的title"
        content.body = "这是通知的body"
        content.subtitle = "这是通知的subtitle"
        content.sound = UNNotificationSound.default()
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5, repeats: false)
        notificationRequest = UNNotificationRequest.init(identifier: "push", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notificationRequest!, withCompletionHandler: nil)
    }

}

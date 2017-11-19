//
//  PushHandler.swift
//  AppForLearn
//
//  Created by charles on 2017/9/21.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit

class PushHandler: NSObject {
    static let instance = PushHandler()
    
    override init() {}

    func sharedInstance() -> PushHandler {
        return .instance
    }
    
    func handlerPush(_ info: NSMutableDictionary) {
        //定义：t 表示操作类型，p 表示操作参数
        let userDefaults = UserDefaults.standard
        let aps = info["aps"]
        userDefaults.set(aps, forKey: "pushInfo")
    }
    
}

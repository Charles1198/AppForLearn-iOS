//
//  MovingPoint.swift
//  AppForLearn
//
//  Created by charles on 2018/1/10.
//  Copyright © 2018年 bqteam. All rights reserved.
//

import UIKit

class MovingPoint: NSObject {
    //圆点坐标、半径、透明度
    var x = 0.0
    var y = 0.0
    var r = 0.0
    var alpha = 0.0
    
    //圆点横向和纵向移动速度
    var vx = Double(arc4random_uniform(100)) / 100 - 0.5
    var vy = Double(arc4random_uniform(100)) / 100 + 0.2
    
    init(x: Double, y: Double, r: Double, alpha: Double) {
        self.x = x
        self.y = y
        self.r = r
        self.alpha = alpha
    }
    
    
    /// 移动圆点，范围不超过画布
    ///
    /// - Parameters:
    ///   - width: 画布宽
    ///   - height: 画布高
    func moveIn(width: Int, height: Int) {
        if (x <= 0 || x >= Double(width)) {
            vx = 0 - vx
        }
        if (y <= 0) {
            y += Double(height)
        }
        x += vx;
        y -= vy;
    }
}

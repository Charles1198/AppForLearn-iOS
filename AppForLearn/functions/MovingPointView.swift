//
//  MovingPointView.swift
//  AppForLearn
//
//  Created by charles on 2018/1/10.
//  Copyright © 2018年 bqteam. All rights reserved.
//

import UIKit

class MovingPointView: UIView {
    var canvasWidth = 0
    var canvasHeight = 0
    
    let pointCount = 60
    var pointList = Array<MovingPoint>()
    
    var timer: Timer?
    
    // MARK: - 初始化界面
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true, block: { (t) in
            self.setNeedsDisplay()
        })
    }
    
    func stopMoving() {
        timer?.invalidate()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        canvasWidth = Int(self.frame.size.width)
        canvasHeight = Int(self.frame.size.height)
        initPoints()
        
        setNeedsDisplay()
    }
    
    func initPoints() {
        if pointList.count > 0 {
            return
        }
        for _ in 0 ..< 60 {
            let p = MovingPoint.init(x: Double(arc4random_uniform(UInt32(canvasWidth))), y: Double(arc4random_uniform(UInt32(canvasHeight))), r: Double(arc4random_uniform(2) + 2), alpha: Double(arc4random_uniform(60)) / 100 + 0.1)
            pointList.append(p)
        }
    }

    override func draw(_ rect: CGRect) {
        for p in pointList {
            let path = UIBezierPath.init(arcCenter: CGPoint.init(x: p.x, y: p.y), radius: CGFloat(p.r), startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            UIColor.init(white: 0, alpha: CGFloat(p.alpha)).setFill()
            path.fill()
            p.moveIn(width: canvasWidth, height: canvasHeight)
        }
    }
}

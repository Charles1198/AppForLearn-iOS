//
//  BallGameVC.swift
//  AppForLearn
//
//  Created by charles on 2017/12/21.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit
import CoreMotion

class BallGameVC: UIViewController {
    var motionManager: CMMotionManager?
    var ball: UIView?
    let windowWidth = UIScreen.main.bounds.size.width
    let windowHeight = UIScreen.main.bounds.size.height
    var lastPosition: CGPoint?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        motionManager = CMMotionManager.init()
        addBall()
        getAccelerationValue()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        motionManager?.stopAccelerometerUpdates()
    }

    // MARK: - 加速度计
    
    func getAccelerationValue() {
        if !((motionManager?.isAccelerometerAvailable)!) {
            return
        }
        
        motionManager?.accelerometerUpdateInterval = 1
        motionManager?.startAccelerometerUpdates(to: OperationQueue.main, withHandler: { (accelerometerData, error) in
            if error != nil {
                return
            }
            let acceleration = accelerometerData?.acceleration
            let x = (acceleration?.x)!
            let y = (acceleration?.y)!
            self.moveBall(x: x, y: y)
        })
    }
    
    func addBall() {
        ball = UIView.init(frame: CGRect.init(x: windowWidth / 2 - 20, y: windowHeight / 2 - 20, width: 40, height: 40))
        ball?.backgroundColor = UIColor.gray
        ball?.layer.cornerRadius = 20
        self.view.addSubview(ball!)
        lastPosition = ball?.center
    }
    
    func moveBall(x: Double, y: Double) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.ball?.center = CGPoint.init(x: x * 2 * Double(self.windowWidth), y: y * 2 * Double(self.windowWidth))
        }, completion: nil)
    }
}

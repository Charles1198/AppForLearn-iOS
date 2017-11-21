//
//  SensorVC.swift
//  AppForLearn
//
//  Created by charles on 2017/11/21.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit
import CoreMotion

class SensorVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var motionManager: CMMotionManager?
    
    let titleArray = ["磁力计", "加速度计", "陀螺仪", "姿态", "旋转", "重力", "加速度"]
    var valueArray = ["", "", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "传感器的使用"
        tableView.delegate = self
        tableView.dataSource = self
        
        motionManager = CMMotionManager.init()
        
        getMagnetometerValue()
        getAccelerationValue()
        getGyroValue()
        getDeviceMotionValue()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        motionManager?.stopMagnetometerUpdates()
        motionManager?.stopAccelerometerUpdates()
        motionManager?.stopGyroUpdates()
        motionManager?.stopDeviceMotionUpdates()
        motionManager = nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: String(indexPath.row))
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.detailTextLabel?.text = valueArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - 磁力计
    
    func getMagnetometerValue() {
        if !(motionManager?.isMagnetometerAvailable)! {
            valueArray[0] = "磁力计不可用"
            self.tableView.reloadRows(at:[IndexPath.init(row: 0, section: 0)], with: .automatic)
            return
        }
        
        motionManager?.magnetometerUpdateInterval = 1
        motionManager?.startMagnetometerUpdates(to: OperationQueue.main, withHandler: { (magnetometerData, error) in
            if error != nil {
                return
            }
            
            let field = magnetometerData?.magneticField
            let x = Int((field?.x)!)
            let y = Int((field?.y)!)
            let z = Int((field?.z)!)
            let value = "x:" + x.description + ", y:" + y.description + ", z:" + z.description
            self.valueArray[0] = value
            self.tableView.reloadRows(at:[IndexPath.init(row: 0, section: 0)], with: .automatic)
        })
    }
    
    // MARK: - 加速度计
    
    func getAccelerationValue() {
        if !((motionManager?.isAccelerometerAvailable)!) {
            valueArray[1] = "加速度计不可用"
            self.tableView.reloadRows(at:[IndexPath.init(row: 1, section: 0)], with: .automatic)
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
            let z = (acceleration?.z)!
            let value = "x:" + x.description + ", y:" + y.description + ", z:" + z.description
            self.valueArray[1] = value
            self.tableView.reloadRows(at:[IndexPath.init(row: 1, section: 0)], with: .automatic)
        })
    }
    
    // MARK: - 陀螺仪
    
    func getGyroValue() {
        if !((motionManager?.isGyroAvailable)!) {
            valueArray[2] = "陀螺仪不可用"
            self.tableView.reloadRows(at:[IndexPath.init(row: 2, section: 0)], with: .automatic)
            return
        }
        
        motionManager?.gyroUpdateInterval = 1
        motionManager?.startGyroUpdates(to: OperationQueue.main, withHandler: { (gyroData, error) in
            if error != nil {
                return
            }
            let rotationRate = gyroData?.rotationRate
            let x = (rotationRate?.x)!
            let y = (rotationRate?.y)!
            let z = (rotationRate?.z)!
            let value = "x:" + x.description + ", y:" + y.description + ", z:" + z.description
            self.valueArray[2] = value
            self.tableView.reloadRows(at:[IndexPath.init(row: 2, section: 0)], with: .automatic)
        })
    }
    
    func getDeviceMotionValue() {
        if !((motionManager?.isDeviceMotionAvailable)!) {
            valueArray[3] = "陀螺仪不可用"
            self.tableView.reloadRows(at:[IndexPath.init(row: 3, section: 0)], with: .automatic)
            return
        }
        
        motionManager?.deviceMotionUpdateInterval = 1
        motionManager?.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { (deviceMotion, error) in
            if error != nil {
                return
            }
            
            // 姿态
            let attitude = deviceMotion?.attitude
            let x1 = (attitude?.pitch)!
            let y1 = (attitude?.roll)!
            let z1 = (attitude?.yaw)!
            let value1 = "x:" + x1.description + ", y:" + y1.description + ", z:" + z1.description
            self.valueArray[3] = value1
            
            // 选转
            let rotationRate = deviceMotion?.rotationRate
            let x2 = (rotationRate?.x)!
            let y2 = (rotationRate?.y)!
            let z2 = (rotationRate?.z)!
            let value2 = "x:" + x2.description + ", y:" + y2.description + ", z:" + z2.description
            self.valueArray[4] = value2
            
            // 重力加速度
            let gravity = deviceMotion?.gravity
            let x3 = (gravity?.x)!
            let y3 = (gravity?.y)!
            let z3 = (gravity?.z)!
            let value3 = "x:" + x3.description + ", y:" + y3.description + ", z:" + z3.description
            self.valueArray[5] = value3
            
            // 加速度
            let acceleration = deviceMotion?.userAcceleration
            let x4 = (acceleration?.x)!
            let y4 = (acceleration?.y)!
            let z4 = (acceleration?.z)!
            let value4 = "x:" + x4.description + ", y:" + y4.description + ", z:" + z4.description
            self.valueArray[6] = value4
            
            self.tableView.reloadRows(at:[IndexPath.init(row: 3, section: 0), IndexPath.init(row: 4, section: 0), IndexPath.init(row: 5, section: 0), IndexPath.init(row: 6, section: 0)], with: .automatic)
        })
    }
}

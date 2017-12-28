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
    
    let titleArray = ["磁力计", "加速度计", "陀螺仪", "姿态", "旋转", "重力", "加速度", "光线传感器", "距离传感器"]
    var valueArray = ["", "", "", "", "", "", "", "", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "传感器"
        tableView.delegate = self
        tableView.dataSource = self
        
        motionManager = CMMotionManager.init()
        
        getMagnetometerValue()
        getAccelerationValue()
        getGyroValue()
        getDeviceMotionValue()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getBrightness), name: .UIScreenBrightnessDidChange, object: nil)
        
        UIDevice.current.isProximityMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(getProximityState), name: .UIDeviceProximityStateDidChange, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        motionManager?.stopMagnetometerUpdates()
        motionManager?.stopAccelerometerUpdates()
        motionManager?.stopGyroUpdates()
        motionManager?.stopDeviceMotionUpdates()
        motionManager = nil
        
        NotificationCenter.default.removeObserver(self, name: .UIScreenBrightnessDidChange, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIDeviceProximityStateDidChange, object: nil)
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
//        let sb = UIStoryboard.init(name: "Main", bundle: nil)
//        switch indexPath.row {
//        case 1:
//            let ballGameVC = sb.instantiateViewController(withIdentifier: "ballGame")
//            self.navigationController?.pushViewController(ballGameVC, animated: true)
//            break
//        default:
//            break
//        }
    }
    
    // MARK: - 磁力计
    
    func getMagnetometerValue() {
        if !(motionManager?.isMagnetometerAvailable)! {
            valueArray[0] = "磁力计不可用"
            self.tableView.reloadRows(at:[IndexPath.init(row: 0, section: 0)], with: .none)
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
            self.tableView.reloadRows(at:[IndexPath.init(row: 0, section: 0)], with: .none)
        })
    }
    
    // MARK: - 加速度计
    
    func getAccelerationValue() {
        if !((motionManager?.isAccelerometerAvailable)!) {
            valueArray[1] = "加速度计不可用"
            self.tableView.reloadRows(at:[IndexPath.init(row: 1, section: 0)], with: .none)
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
            self.valueArray[1] = self.toString(x, y, z)
            self.tableView.reloadRows(at:[IndexPath.init(row: 1, section: 0)], with: .none)
        })
    }
    
    // MARK: - 陀螺仪
    
    func getGyroValue() {
        if !((motionManager?.isGyroAvailable)!) {
            valueArray[2] = "陀螺仪不可用"
            self.tableView.reloadRows(at:[IndexPath.init(row: 2, section: 0)], with: .none)
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
            self.valueArray[2] = self.toString(x, y, z)
            self.tableView.reloadRows(at:[IndexPath.init(row: 2, section: 0)], with: .none)
        })
    }
    
    func getDeviceMotionValue() {
        if !((motionManager?.isDeviceMotionAvailable)!) {
            valueArray[3] = "陀螺仪不可用"
            self.tableView.reloadRows(at:[IndexPath.init(row: 3, section: 0)], with: .none)
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
            self.valueArray[3] = self.toString(x1, y1, z1)
            
            // 旋转
            let rotationRate = deviceMotion?.rotationRate
            let x2 = (rotationRate?.x)!
            let y2 = (rotationRate?.y)!
            let z2 = (rotationRate?.z)!
            self.valueArray[4] = self.toString(x2, y2, z2)
            
            // 重力加速度
            let gravity = deviceMotion?.gravity
            let x3 = (gravity?.x)!
            let y3 = (gravity?.y)!
            let z3 = (gravity?.z)!
            self.valueArray[5] = self.toString(x3, y3, z3)
            
            // 加速度
            let acceleration = deviceMotion?.userAcceleration
            let x4 = (acceleration?.x)!
            let y4 = (acceleration?.y)!
            let z4 = (acceleration?.z)!
            self.valueArray[6] = self.toString(x4, y4, z4)
            
            self.tableView.reloadRows(at:[IndexPath.init(row: 3, section: 0), IndexPath.init(row: 4, section: 0), IndexPath.init(row: 5, section: 0), IndexPath.init(row: 6, section: 0)], with: .none)
        })
    }
    
    // MARK: - 光线传感器
    
    @objc func getBrightness() {
        let brightness = UIScreen.main.brightness
        self.valueArray[7] = self.toString(Double(brightness))
        self.tableView.reloadRows(at:[IndexPath.init(row: 7, section: 0)], with: .none)
    }
    
    @objc func getProximityState() {
        let proximityState = UIDevice.current.proximityState
        self.valueArray[8] = proximityState ? "有物体接近" : "有物体远离"
        self.tableView.reloadRows(at:[IndexPath.init(row: 8, section: 0)], with: .none)
    }
    
    func toString(_ value: Double) -> String {
        let i = Int(value * 10000)
        let d = Double(i) / 10000
        return d.description
    }
    
    func toString(_ value1: Double, _ value2: Double, _ value3: Double) -> String {
        return "x:" + self.toString(value1) + ", y:" + self.toString(value2) + ", z:" + self.toString(value3)
    }
}

//
//  MapKitVC.swift
//  AppForLearn
//
//  Created by charles on 2017/9/26.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit
import MapKit

class MapKitVC: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapScale: UIStepper!
    
    var lastStepperValue = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showUserLoaction()
//        setRegion()
        
        mapScale.value = lastStepperValue;
        mapScale.addTarget(self, action: #selector(stepperValueChanged(stepper:)), for: .valueChanged)
    }
    
    /// 显示用户所在位置
    func showUserLoaction() {
        mapView.userTrackingMode = .follow
        mapView.showsUserLocation = true
    }
    
    /// 使用 UIStepper 控件使地图放大或缩小
    ///
    /// - Parameter stepper: UIStepper 控件
    @objc func stepperValueChanged(stepper: UIStepper) {
        var region = mapView.region
        if stepper.value > lastStepperValue {
            region.span.latitudeDelta = region.span.latitudeDelta * 2
            region.span.longitudeDelta = region.span.longitudeDelta * 2
        }
        if stepper.value < lastStepperValue {
            region.span.latitudeDelta = region.span.latitudeDelta / 2
            region.span.longitudeDelta = region.span.longitudeDelta / 2
        }
        if region.span.latitudeDelta <= 180.0 && region.span.longitudeDelta <= 360 {
            mapView.setRegion(region, animated: true)
            lastStepperValue = stepper.value
        }
        
    }

}

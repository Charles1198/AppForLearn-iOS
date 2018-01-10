//
//  MovingPointVC.swift
//  AppForLearn
//
//  Created by charles on 2018/1/10.
//  Copyright © 2018年 bqteam. All rights reserved.
//

import UIKit

class MovingPointVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let movingPointView = MovingPointView()
        view.addSubview(movingPointView)
        movingPointView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

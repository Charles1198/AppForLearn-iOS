//
//  IconfontVC.swift
//  AppForLearn
//
//  Created by charles on 2017/12/28.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit


class IconfontVC: UIViewController {
    let viewHeight = 40

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = UILabel.init(frame: CGRect.init(x: 16, y: 66, width: 375, height: 40))
        label.font = UIFont.init(name: "iconFont", size: 24)
        label.text = "\u{e6a0} \u{e6a2} \u{e6ac} \u{e6ae} \u{e507} \u{e508} \u{e50c} \u{e512}"
        self.view.addSubview(label)
        
        
    }
}

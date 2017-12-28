//
//  AnimUIViewVC.swift
//  AppForLearn
//
//  Created by charles on 2017/12/23.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit

class AnimUIViewVC: UIViewController {
    
    @IBOutlet weak var animView: UIView!
    @IBOutlet weak var controlViewsParent: UIView!
    
    let viewHeight = 60
    
    var p: CGPoint?
    var duration = 0.0
    var delay = 0.0
    var dampingRatio = 1.0
    var velocity = 0.0
    var options = UIViewAnimationOptions.curveLinear
    
    var durationLabel: UILabel?
    var delayLabel: UILabel?
    var dampingRatioLabel: UILabel?
    var velocityLabel: UILabel?
    var optionBtn: UIButton?
    var optionSelector: UIAlertController?
    
    let optionList = [UIViewAnimationOptions.curveLinear, UIViewAnimationOptions.curveEaseIn, UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.curveEaseInOut]
    let optionStringList = ["curveLinear", "curveEaseIn", "curveEaseOut", "curveEaseInOut"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addDurationControl()
        addDelayControl()
        addDampingRatioControl()
        addVelocityControl()
        addOptionsControl()
        
        p = animView.center
    }
    @IBAction func executeAnim(_ sender: Any) {
        animView.center = p!
        var animP = p!
        animP.x += 200
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: CGFloat(dampingRatio), initialSpringVelocity: CGFloat(velocity), options: .transitionCurlUp , animations: {
            self.animView.center = animP
        }, completion: { (bool) in
            
        })
    }
    
    // MARK: - 添加控制器
    
    func addDurationControl() {
        durationLabel = labelWith(title: "duration:" + duration.description)
        putLabel(durationLabel!, inScrollView: 0)
        
        let slider = UISlider.init()
        slider.maximumValue = 10.0
        putSlider(slider, besideLabel: durationLabel!)
        slider.addTarget(self, action: #selector(getDurationFrom(slider:)), for: .valueChanged)
    }
    
    @objc func getDurationFrom(slider: UISlider) {
        duration = Double(slider.value)
        durationLabel?.text = "duration:" + toString(duration)
    }
    
    func addDelayControl() {
        delayLabel = labelWith(title: "delay" + delay.description)
        putLabel(delayLabel!, inScrollView: 1)
        
        let slider = UISlider.init()
        slider.maximumValue = 10.0
        putSlider(slider, besideLabel: delayLabel!)
        slider.addTarget(self, action: #selector(getDelayFrom(slider:)), for: .valueChanged)
    }
    
    @objc func getDelayFrom(slider: UISlider) {
        delay = Double(slider.value)
        delayLabel?.text = "delay:" + toString(delay)
    }
    
    func addDampingRatioControl() {
        dampingRatioLabel = labelWith(title: "dampingRatio" + dampingRatio.description)
        putLabel(dampingRatioLabel!, inScrollView: 2)
        
        let slider = UISlider.init()
        slider.maximumValue = 1.0
        putSlider(slider, besideLabel: dampingRatioLabel!)
        slider.addTarget(self, action: #selector(getDampingRatioFrom(slider:)), for: .valueChanged)
    }
    
    @objc func getDampingRatioFrom(slider: UISlider) {
        dampingRatio = Double(slider.value)
        dampingRatioLabel?.text = "dampingRatio:" + toString(dampingRatio)
    }
    
    func addVelocityControl() {
        velocityLabel = labelWith(title: "velocity" + velocity.description)
        putLabel(velocityLabel!, inScrollView: 3)
        
        let slider = UISlider.init()
        slider.maximumValue = 1.0
        putSlider(slider, besideLabel: velocityLabel!)
        slider.addTarget(self, action: #selector(getVelocityFrom(slider:)), for: .valueChanged)
    }
    
    @objc func getVelocityFrom(slider: UISlider) {
        velocity = Double(slider.value)
        velocityLabel?.text = "velocity:" + toString(velocity)
    }
    
    func addOptionsControl() {
        let label = labelWith(title: "options")
        putLabel(label, inScrollView: 4)
        
        optionBtn = UIButton.init()
        optionBtn?.setTitle(optionStringList[0], for: .normal)
        optionBtn?.setTitleColor(UIColor.blue, for: .normal)
        optionBtn?.setTitleColor(UIColor.lightGray, for: .highlighted)
        controlViewsParent.addSubview(optionBtn!)
        optionBtn?.snp.makeConstraints { (make) in
            make.left.equalTo(label.snp.right).offset(16)
            make.centerY.equalTo(label)
        }
        optionBtn?.addTarget(self, action: #selector(selectOptions(btn:)), for: .touchUpInside)
    }
    
    @objc func selectOptions(btn: UIButton) {
        optionSelector = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        for i in 0 ..< optionList.count {
            optionSelector?.addAction(UIAlertAction.init(title: optionStringList[i], style: .default, handler: { (action) in
                self.selectOptions(index: i)
            }))
        }
        self.present(optionSelector!, animated: true, completion: nil)
    }
    
    func selectOptions(index: Int) {
        optionSelector?.dismiss(animated: true, completion: nil)
        
        optionBtn?.setTitle(optionStringList[index], for: .normal)
        
        let lastOption = options
        options.insert(optionList[index])
        options.remove(lastOption)
    }
    
    func labelWith(title:String) -> UILabel {
        let label = UILabel.init()
        label.text = title
        return label
    }
    
    func putLabel(_ label:UILabel, inScrollView index: Int) {
        controlViewsParent.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.height.equalTo(viewHeight)
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(viewHeight * index)
        }
    }
    
    func putSlider(_ slider:UISlider, besideLabel label: UILabel) {
        controlViewsParent.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.width.equalTo(200)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(label)
        }
    }
    
    func toString(_ value: Double) -> String {
        let i = Int(value * 10)
        let d = Double(i) / 10
        return d.description
    }
}

//
//  LottieVC.swift
//  AppForLearn
//
//  Created by charles on 2017/9/22.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit
import Lottie

class LottieVC: UIViewController, UIViewControllerTransitioningDelegate {
    var animationView: LOTAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Lottie 特效动画"

        animationView = LOTAnimationView(name: "favourite_app_icon")
        self.view.addSubview(animationView!)
        animationView?.frame = CGRect.init(x: 0, y: 64, width: 200, height: 200)
//        animationView.play()
        
//        let playBtn = 
        
    }
    
    @IBAction func normalAnim(_ sender: Any) {
        let curProgress = animationView?.animationProgress
        animationView?.play(fromProgress: curProgress!, toProgress: 1 - curProgress!, withCompletion: nil)
    }
    
    @IBAction func transitionAnim(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "Animation")
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let vcTransition = LOTAnimationTransitionController.init(animationNamed: "transition_1", fromLayerNamed: "outLayer", toLayerNamed: "inLayer", applyAnimationTransform: false)
        return vcTransition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let vcTransition = LOTAnimationTransitionController.init(animationNamed: "transition_2", fromLayerNamed: "outLayer", toLayerNamed: "inLayer", applyAnimationTransform: false)
        return vcTransition
    }
}

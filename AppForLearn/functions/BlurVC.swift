//
//  BlurVC.swift
//  AppForLearn
//
//  Created by charles on 2017/12/29.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit

class BlurVC: UIViewController {
    var imageView: UIImageView?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        image = UIImage.init(named: "shan")
        imageView = UIImageView.init(image: image)
        imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(imageView!)
        imageView?.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let slider = UISlider.init()
        slider.maximumValue = 10
        self.view.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.bottom.equalToSuperview().offset(-16)
        }
        slider.addTarget(self, action: #selector(getVelocityFrom(slider:)), for: .valueChanged)
    }
    
    @objc func getVelocityFrom(slider: UISlider) {
        imageView?.image = coreBlurImage(image: image!, withBlurNumber: slider.value)
    }
    
    func coreBlurImage(image: UIImage, withBlurNumber number: Float) -> UIImage {
        let context = CIContext.init()
        let inputImage = CIImage.init(cgImage: image.cgImage!)

        let filter = CIFilter.init(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(number, forKey: "inputRadius")

        let result = filter?.value(forKey: kCIOutputImageKey) as! CIImage

        let outputImage = context.createCGImage(result, from: result.extent)

        let blurImage = UIImage.init(cgImage: outputImage!)
        return blurImage
    }
}

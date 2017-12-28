//
//  KaTexVC.swift
//  AppForLearn
//
//  Created by charles on 2017/11/26.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit
import WebKit

class KaTexVC: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    let katexHeader = "<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.9.0-alpha1/katex.min.css\"><script src=\"https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.9.0-alpha1/katex.min.js\"></script>"
    let testInput = "<p><span id=\"mykatex\">...</span></p><script>katex.render(\"f(a,b,c) = (a^2+b^2+c^2)^3\", mykatex);</script>"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let htmlString = "<!DOCTYPE HTML><html><header>\(katexHeader)</header><body style=\"background-color: transparent;font-size: 40px\">\(testInput)</body></html>"
        webView.loadHTMLString(htmlString, baseURL: nil)
    }



}

//
//  WKWebViewCell.swift
//  AppForLearn
//
//  Created by charles on 2017/11/17.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

protocol WebViewCellHeightDelegate:class {
    func cell(height: Int, withTag tag: Int)
}

class WKWebViewCell: UITableViewCell, WKNavigationDelegate, UIWebViewDelegate {
    
    let HTML_HEAD = "<!DOCTYPE HTML><html><head><title>Math</title><meta charset='utf-8'/><meta name='viewport' content='width=device-width, initial-scale=1'/><style>body{margin:0px;border:0px}</style></head><body id='bqteam-math-body'>"
    let HTML_FOOT = "</body></html>"
    let IMAGE = "<img src='https://gold-cdn.xitu.io/v3/static/img/logo.a7995ad.svg'>"

    var delegate:WebViewCellHeightDelegate?
    
    let placeholdView = UIView()
    let webView = WKWebView()
    let uiWebView = UIWebView()
    var cellHeight = 0
    var animating = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
    }
    
    func initView() {
        contentView.addSubview(webView)
        webView.navigationDelegate = self
        webView.isOpaque = false
        webView.scrollView.bounces = false
        webView.backgroundColor = UIColor.clear
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
        webView.isHidden = true
        
        contentView.addSubview(uiWebView)
        uiWebView.delegate = self
        uiWebView.isOpaque = false
        uiWebView.scrollView.bounces = false
        uiWebView.backgroundColor = UIColor.clear
        uiWebView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
        uiWebView.isHidden = true
        
        contentView.addSubview(placeholdView)
        placeholdView.backgroundColor = UIColor.init(white: 0.94, alpha: 1)
        placeholdView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsetsMake(10, 10, 10, 10))
        }
    }
    
    func setContent(_ content: String, andHeight height: Int) {
        cellHeight = height
        webView.loadHTMLString(HTML_HEAD + content + IMAGE + HTML_FOOT, baseURL: nil)
//        uiWebView.loadHTMLString(HTML_HEAD + content + HTML_FOOT, baseURL: nil)
        if !animating {
            scalePlaceholdView(self.tag)
            animating = true
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let height = webView.stringByEvaluatingJavaScript(from: "document.getElementById('bqteam-math-body').offsetHeight;")
        var h = (height == "") ? 0 : Int(height!)!
        h = h + 20
        if (h != self.cellHeight) {
            self.delegate?.cell(height: h, withTag: self.tag)
        } else {
            self.uiWebView.isHidden = false
            self.hidePlaceholdView()
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
            let h = (result as! Int) + 20
            if (h != self.cellHeight) {
                self.delegate?.cell(height: h, withTag: self.tag)
            } else {
                self.webView.isHidden = false
                self.hidePlaceholdView()
            }
        }
    }
    
    func scalePlaceholdView(_ index: Int) {
        let scaleAnimation = CABasicAnimation.init(keyPath: "transform.scale.x")
        if index % 2 == 0 {
            scaleAnimation.fromValue = 0.8
            scaleAnimation.toValue = 1
        } else {
            scaleAnimation.fromValue = 1
            scaleAnimation.toValue = 0.8
        }
        scaleAnimation.duration = 0.5
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = 10000
        
        placeholdView.layer.add(scaleAnimation, forKey: "")
    }

    func hidePlaceholdView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.placeholdView.alpha = 0
        }) { (bool) in
            self.placeholdView.isHidden = true
        }
    }
}

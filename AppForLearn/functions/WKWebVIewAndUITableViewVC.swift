//
//  WKWebVIewAndUITableViewVC.swift
//  AppForLearn
//
//  Created by charles on 2017/11/17.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit

class WKWebVIewAndUITableViewVC: UIViewController, UITableViewDelegate, UITableViewDataSource, WebViewCellHeightDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let htmlStringArray = [
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>",
        "<span>考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。考研复习，首先大家必须要了解自己的考试科目，区分考试难度，考研数学分数学一、数学二和数学三，下面分析三者的不同，大家先了解后规划。</span>"
    ]
    
    var cellHeightArray = [60, 60, 60, 60,60, 60, 60, 60,60, 60, 60, 60,60, 60, 60, 60,60, 60, 60, 60]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WKWebViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return htmlStringArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeightArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WKWebViewCell
        cell.delegate = self
        cell.tag = indexPath.row
        cell.setContent(htmlStringArray[indexPath.row], andHeight: cellHeightArray[indexPath.row])
        return cell
    }
    
    func cell(height: Int, withTag tag: Int) {
        cellHeightArray[tag] = height
        tableView.reloadRows(at: [IndexPath (row: tag, section: 0)], with: .none)
    }


}
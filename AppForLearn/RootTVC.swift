//
//  RootTVC.swift
//  AppForLearn
//
//  Created by charles on 2017/9/21.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit

class RootTVC: UITableViewController {
   
    @IBOutlet var rootTableView: UITableView!
    
    let headTitles = ["iOS基础", "第三方库"]
    let cellTitlesOriginalFunction = ["推送通知", "地图", "WKWebView 与 UITableView"]
    let cellTitlesLibraries = ["Lottie 特效动画"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        rootTableView.delegate = self
        rootTableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cellTitlesOriginalFunction.count
        case 1:
            return cellTitlesLibraries.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = cellTitlesOriginalFunction[indexPath.row]
        case 1:
            cell.textLabel?.text = cellTitlesLibraries[indexPath.row]
        default:
            return cell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            jumpToFunctions(indexPath.row)
        case 1:
            jumpToLibraries(indexPath.row)
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headTitles[section]
    }
    
    // MARK: - 页面跳转
    
    
    /// iOS基础
    func jumpToFunctions(_ index: Int) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        var vc = UIViewController()
        switch index {
        case 0:
            vc = sb.instantiateViewController(withIdentifier: "PushNotification")
        case 1:
            vc = sb.instantiateViewController(withIdentifier: "MapKit")
        case 2:
            vc = sb.instantiateViewController(withIdentifier: "WKWebVIewAndUITableView")
        default:
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 第三方库
    func jumpToLibraries(_ index: Int) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        var vc = UIViewController()
        switch index {
        case 0:
            vc = sb.instantiateViewController(withIdentifier: "Lottie")
        default:
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

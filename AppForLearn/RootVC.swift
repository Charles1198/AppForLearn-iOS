//
//  RootTVC.swift
//  AppForLearn
//
//  Created by charles on 2017/9/21.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit

class RootVC: UITableViewController {
   
    @IBOutlet var rootTableView: UITableView!
    
    let headTitles = ["iOS基础", "第三方库", "动画"]
    let cellTitlesOriginalFunction = ["推送通知", "地图", "WKWebView 与 UITableView", "传感器"]
    let cellTitlesLibraries = ["Lottie 动画", "KaTex 与 LaTex 键盘", "iconfont"]
    let cellTitlesAnim = ["UIView 动画"]
    
    let identifierOriginalFunction = ["PushNotification", "MapKit", "WKWebVIewAndUITableView", "Sensor"]
    let identifierLibraries = ["Lottie", "KaTex", "iconfont"]
    let identifierAnim = ["uiview"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "AppForLearn"
        rootTableView.delegate = self
        rootTableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return headTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return cellTitlesOriginalFunction.count
        case 1:
            return cellTitlesLibraries.count
        case 2:
            return cellTitlesAnim.count
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
        case 2:
            cell.textLabel?.text = cellTitlesAnim[indexPath.row]
        default:
            return cell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var sb = UIStoryboard()
        var vc = UIViewController()
        switch indexPath.section {
        case 0:
            sb = UIStoryboard.init(name: "Main", bundle: nil)
            vc = sb.instantiateViewController(withIdentifier: identifierOriginalFunction[indexPath.row])
        case 1:
            sb = UIStoryboard.init(name: "Main", bundle: nil)
            vc = sb.instantiateViewController(withIdentifier: identifierLibraries[indexPath.row])
        case 2:
            sb = UIStoryboard.init(name: "Anim", bundle: nil)
            vc = sb.instantiateViewController(withIdentifier: identifierAnim[indexPath.row])
        default:
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headTitles[section]
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

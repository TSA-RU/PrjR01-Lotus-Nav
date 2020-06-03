//
//  MainNavViewController.swift
//  PrjR01 Lotus Nav
//
//  Created by Sergey Tolnykin on 27.05.2020.
//  Copyright © 2020 Sergey Tolnykin. All rights reserved.
//

import UIKit

class MainNavViewController: UITableViewController {

    var divider = 2
    var colapse = false
    
    struct menuItem {
        var id: Int
        var title: String
        var isSection: Bool
        var expanded: Bool
        var visible: Bool
        var color: UIColor
        var changed: Bool
        var tag: Int
    }
    
    var mainMenu = [
        menuItem(id: 10000, title: "Календарь", isSection: true, expanded: false, visible: true, color: .systemGray3, changed: false, tag: 0),
        menuItem(id: 10100, title: "Личный", isSection: false, expanded: false, visible: false, color: .white, changed: false, tag: 2),
        menuItem(id: 10200, title: "Копоративный", isSection: false, expanded: false, visible: false, color: .white, changed: false, tag: 0),
        menuItem(id: 20000, title: "Персонал", isSection: true, expanded: false, visible: true, color: .systemGray3, changed: false, tag: 0),
        menuItem(id: 20100, title: "SubMenu 2.1", isSection: true, expanded: false, visible: false, color: .systemGray5, changed: false, tag: 0),
        menuItem(id: 20101, title: "Item 2.1.1", isSection: false, expanded: false, visible: false, color: .white, changed: false, tag: 0),
        menuItem(id: 20102, title: "Item 2.1.2", isSection: false, expanded: false, visible: false, color: .white, changed: false, tag: 0),
        menuItem(id: 20103, title: "Item 2.1.3", isSection: false, expanded: false, visible: false, color: .white, changed: false, tag: 0),
        menuItem(id: 20104, title: "Item 2.1.4", isSection: false, expanded: false, visible: false, color: .white, changed: false, tag: 0),
        menuItem(id: 20200, title: "SubMenu 2.2", isSection: true, expanded: false, visible: false, color: .systemGray5, changed: false, tag: 0),
        menuItem(id: 30000, title: "Финансы", isSection: true, expanded: false, visible: true, color: .systemGray3, changed: false, tag: 0),
        menuItem(id: 40000, title: "Поручения", isSection: true, expanded: false, visible: true, color: .systemGray3, changed: false, tag: 0),
        menuItem(id: 50000, title: "Администрирование", isSection: true, expanded: false, visible: true, color: .systemGray3, changed: false, tag: 0),
        menuItem(id: 50100, title: "SubMenu 2.2", isSection: true, expanded: false, visible: false, color: .systemGray5, changed: false, tag: 0),
        menuItem(id: 60000, title: "Проекты", isSection: true, expanded: false, visible: true, color: .systemGray3, changed: false, tag: 0),
        menuItem(id: 70000, title: "Коммуникации", isSection: true, expanded: false, visible: true, color: .systemGray3, changed: false, tag: 0),
        menuItem(id: 70100, title: "Почта", isSection: false, expanded: false, visible: false, color: .white, changed: false, tag: 3),
        menuItem(id: 70200, title: "Корреспонденция", isSection: false, expanded: false, visible: false, color: .white, changed: false, tag: 0)
        ]
    
    @IBOutlet weak var rootVC: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @IBAction func colapseBtn(_ sender: UIBarButtonItem) {
        colapse = !colapse
        tableView.beginUpdates()
        for row in 0..<mainMenu.count {
            tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        }
        tableView.endUpdates()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mainMenu.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        var prefix = ""
        if mainMenu[indexPath.row].isSection && mainMenu[indexPath.row].expanded {prefix = "- "}
        if mainMenu[indexPath.row].isSection && !mainMenu[indexPath.row].expanded {prefix = "+ "}
        cell?.textLabel?.text = prefix + mainMenu[indexPath.row].title
        cell?.backgroundColor = mainMenu[indexPath.row].color
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if mainMenu[indexPath.row].visible || colapse {return 44}
        else {return 0}
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        colapse = !colapse
//        rootVC.title = mainMenu[indexPath.row].title
        
        if !mainMenu[indexPath.row].isSection{
            rootVC.title = "\(mainMenu[indexPath.row].tag)"
            switch mainMenu[indexPath.row].tag {
                case 2:
                    UIApplication.shared.open(NSURL(string: "calshow://")! as URL)
                case 3:
                    UIApplication.shared.open(NSURL(string: "message://")! as URL)
                default: return
            }
            return
        }
        else {
            let mask = mainMenu[indexPath.row].id
            let mask1 = mask / 10000
            let mask2 = (mask - mask1 * 10000) / 100
            let mask3 = mask % 100
//            rootVC.title = "m:\(mask), m1:\(mask1), m2:\(mask2), m3:\(mask3)"
            mainMenu[indexPath.row].expanded = !mainMenu[indexPath.row].expanded
            mainMenu[indexPath.row].changed = true
            
            for row in 0..<mainMenu.count {
                let subMask = mainMenu[row].id
                let subMask1 = subMask / 10000
                let subMask2 = (subMask - subMask1 * 10000) / 100
                let subMask3 = subMask % 100
//                print("m:\(subMask), m1:\(subMask1), m2:\(subMask2), m3:\(subMask3)")
                
                //   It's 1st Level?                It's 2 SubLevel?                   It's equal?
                if (mask2 == 0 && mask3 == 0) && (subMask3 == 0 && subMask2 != 0) && (mask1 == subMask1){
                    if mainMenu[row].isSection {mainMenu[row].expanded = false}
                    mainMenu[row].visible = mainMenu[indexPath.row].expanded
                    mainMenu[row].changed = true
                }
                
                //   It's 2st Level?                It's 3 SubLevel?                   It's equal?
                if (mask2 != 0 && mask3 == 0) && (subMask3 != 0 && subMask2 != 0) && (mask1 == subMask1 && mask2 == subMask2){
                    mainMenu[row].visible = mainMenu[indexPath.row].expanded
                    mainMenu[row].changed = true
                }
                
                //   It's 1st Level?                It's 3rd SubLevel?                   It's equal?          Expand 1st level off?
                if (mask2 == 0 && mask3 == 0) && (subMask3 != 0 && subMask2 != 0) && (mask1 == subMask1) && !mainMenu[indexPath.row].expanded{
                    if mainMenu[row].isSection {mainMenu[row].expanded = false}
                    mainMenu[row].visible = false
                    mainMenu[row].changed = true
                }
                
                
            }
            
            

        }
        
        tableView.beginUpdates()
        for row in 0..<mainMenu.count {
            if mainMenu[row].changed {
                tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
                mainMenu[row].changed = false
            }
        }
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        var ress = 0
        if mainMenu[indexPath.row].isSection && (mainMenu[indexPath.row].id % 10000) == 0 {ress =  0}
        else {ress =  1}
        if !mainMenu[indexPath.row].isSection {ress = 2}
        return ress
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

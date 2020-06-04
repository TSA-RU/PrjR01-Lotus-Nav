//
//  MainNavViewController.swift
//  PrjR01 Lotus Nav
//
//  Created by Sergey Tolnykin on 27.05.2020.
//  Copyright © 2020 Sergey Tolnykin. All rights reserved.
//

import UIKit

class MainNavViewController: UITableViewController {

//    var divider = 2
//    var colapse = false
    
    let levelIdent = 1 //Отступ следующего уровня
    let expandedChar = "-"
    let collapsedChar = "+"
    let collapseOther = true //Схлопывать не активные уровни
    let maxLevels = 8
    
    struct menuItem {
        var id: Int = 0
        var level: Int = 0
        var parent: Int = 0
        var title: String
        var isSection: Bool
        var expanded: Bool = false
        var visible: Bool
        var color: UIColor
        var changed: Bool = false
        var tag: Int
    }
    
    var mainMenu = [
        menuItem(id: 1, title: "Календарь", isSection: true, expanded: true, visible: true, color: .systemGray3, tag: 0),
        menuItem(level: 1, parent: 1, title: "Личный", isSection: false, expanded: false, visible: true, color: .white, tag: 2),
        menuItem(level: 1, parent: 1, title: "Копоративный", isSection: false, expanded: false, visible: true, color: .white,  tag: 0),
        menuItem(id: 2, title: "Персонал", isSection: true, expanded: false, visible: true, color: .systemGray3,  tag: 0),
        menuItem(id: 21, level: 1, parent: 2, title: "SubMenu 2.1", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(level: 2, parent: 21, title: "Item 2.1.1", isSection: false, expanded: false, visible: false, color: .white,  tag: 0),
        menuItem(level: 2, parent: 21, title: "Item 2.1.2", isSection: false, expanded: false, visible: false, color: .white,  tag: 0),
        menuItem(level: 2, parent: 21, title: "Item 2.1.3", isSection: false, expanded: false, visible: false, color: .white,  tag: 0),
        menuItem(level: 2, parent: 21, title: "Item 2.1.4", isSection: false, expanded: false, visible: false, color: .white,  tag: 0),
        menuItem(id: 22, level: 1, parent: 2, title: "SubMenu 2.2", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 23, level: 1, parent: 2, title: "SubMenu 2.3", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 231, level: 2, parent: 23, title: "SubMenu 2.3.1", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 2311, level: 3, parent: 231, title: "SubMenu 2.3.1.1", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 23111, level: 4, parent: 2311, title: "SubMenu 2.3.1.1.1", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 231111, level: 5, parent: 23111, title: "SubMenu 2.3.1.1.1.1", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 2311111, level: 6, parent: 231111, title: "SubMenu 2.3.1.1.1.1.1", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 23111111, level: 7, parent: 2311111, title: "SubMenu 2.3.1.1.1.1.1.1", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(level: 8, parent: 23111111, title: "Item 2.1.1.1.1.1.1.1", isSection: false, expanded: false, visible: false, color: .white,  tag: 0),
        menuItem(id: 23112, level: 4, parent: 2311, title: "SubMenu 2.3.1.1.2", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 2312, level: 3, parent: 231, title: "SubMenu 2.3.1.2", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 2313, level: 3, parent: 231, title: "SubMenu 2.3.1.3", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 232, level: 2, parent: 23, title: "SubMenu 2.3.2", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 3, title: "Финансы", isSection: true, expanded: false, visible: true, color: .systemGray3,  tag: 0),
        menuItem(id: 4, title: "Поручения", isSection: true, expanded: false, visible: true, color: .systemGray3, tag: 0),
        menuItem(id: 5, title: "Администрирование", isSection: true, expanded: false, visible: true, color: .systemGray3, tag: 0),
        menuItem(id: 5, title: "SubMenu 2.2", isSection: true, expanded: false, visible: false, color: .systemGray5, tag: 0),
        menuItem(id: 6, title: "Проекты", isSection: true, expanded: false, visible: true, color: .systemGray3,  tag: 0),
        menuItem(id: 7, title: "Коммуникации", isSection: true, expanded: false, visible: true, color: .systemGray3, tag: 0),
        menuItem(level: 1, parent: 7, title: "Почта", isSection: false, expanded: false, visible: false, color: .white, tag: 3),
        menuItem(level: 1, parent: 7, title: "Корреспонденция", isSection: false, expanded: false, visible: false, color: .white, tag: 0)
        ]
    
    @IBOutlet weak var rootVC: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        if mainMenu[indexPath.row].isSection && mainMenu[indexPath.row].expanded {prefix = expandedChar}
        if mainMenu[indexPath.row].isSection && !mainMenu[indexPath.row].expanded {prefix = collapsedChar}
        cell?.textLabel?.text = prefix + mainMenu[indexPath.row].title
        cell?.backgroundColor = mainMenu[indexPath.row].color
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if mainMenu[indexPath.row].visible {return 44}
        else {return 0}
    }
    
    func collapseCells(cellNum: Int, collapse: Bool){
        if mainMenu[cellNum].expanded || collapse {
            for row in 0..<mainMenu.count{
                if mainMenu[row].parent == mainMenu[cellNum].id {
                    mainMenu[row].visible = false
                    mainMenu[row].changed = true
                    if mainMenu[row].isSection {
                        collapseCells(cellNum: row, collapse: true)
                    }
                }
                mainMenu[cellNum].expanded = false
                mainMenu[cellNum].changed = true
            }
        }
        else{
            for row in 0..<mainMenu.count{
                if mainMenu[row].parent == mainMenu[cellNum].id{
                    mainMenu[row].visible = true
                    mainMenu[row].changed = true
                    
                }
                if collapseOther && (mainMenu[row].level == mainMenu[cellNum].level) && (row != cellNum) && (mainMenu[row].isSection) &&  mainMenu[row].expanded {
                    collapseCells(cellNum: row, collapse: true)
                }
                mainMenu[cellNum].expanded = true
                mainMenu[cellNum].changed = true
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        colapse = !colapse
//        rootVC.title = mainMenu[indexPath.row].title
        
        if !mainMenu[indexPath.row].isSection{
            rootVC.title = "\(mainMenu[indexPath.row].tag)"
            switch mainMenu[indexPath.row].tag {
                case 0:
                        performSegue(withIdentifier: "UnderContructionSegue", sender: nil)
                case 2:
                    UIApplication.shared.open(NSURL(string: "calshow://")! as URL)
                case 3:
                    UIApplication.shared.open(NSURL(string: "message://")! as URL)
                default: return
            }
            return
        }
        else {
            collapseCells(cellNum: indexPath.row, collapse: mainMenu[indexPath.row].expanded)
            
            
/*            let mask = mainMenu[indexPath.row].id
            let mask1 = mask / 10000
            let mask2 = (mask - mask1 * 10000) / 100
            let mask3 = mask % 100

            mainMenu[indexPath.row].expanded = !mainMenu[indexPath.row].expanded
            mainMenu[indexPath.row].changed = true
            
            for row in 0..<mainMenu.count {
                let subMask = mainMenu[row].id
                let subMask1 = subMask / 10000
                let subMask2 = (subMask - subMask1 * 10000) / 100
                let subMask3 = subMask % 100
             
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
                
                
            }*/
            
            

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
/*        if mainMenu[indexPath.row].isSection && (mainMenu[indexPath.row].id % 10000) == 0 {ress =  0}
        else {ress =  1}
        if !mainMenu[indexPath.row].isSection {ress = 2}*/
        ress = levelIdent * mainMenu[indexPath.row].level
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
    @IBAction func cancelAction(_ segue: UIStoryboardSegue){}
}

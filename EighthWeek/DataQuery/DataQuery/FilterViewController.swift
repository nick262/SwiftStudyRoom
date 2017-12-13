//
//  FilterViewController.swift
//  DataQuery
//
//  Created by Nick Wang on 13/12/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
import CoreData

class FilterViewController: UIViewController {
    var queryConditions: String!
    
    @IBAction func cancelBtnClick(_ sender: Any) {
        dismiss(animated: true) {
            print("取消")
        }
    }
    @IBAction func searchBtnClick(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Filter"), object: self.queryConditions)
        print("查询")
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
extension FilterViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 4
        }else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "PRICE"
        }else if section == 1 {
            return "MOST POPULAR"
        }else {
            return "SORT BY"
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "Cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellID)
        }
        if indexPath.section == 0 && indexPath.row == 0 {
            cell?.textLabel?.text = "$"
            cell?.detailTextLabel?.text = "\(getCount(str: "$")) bubble tea places"
        }else if indexPath.section == 0 && indexPath.row == 1 {
            cell?.textLabel?.text = "$$"
            cell?.detailTextLabel?.text = "\(getCount(str: "$$")) bubble tea places"
        }else if indexPath.section == 0 && indexPath.row == 2 {
            cell?.textLabel?.text = "$$$"
            cell?.detailTextLabel?.text = "\(getCount(str: "$$$")) bubble tea places"
        }else if indexPath.section == 1 && indexPath.row == 0 {
            cell?.textLabel?.text = "Offering a deal"
        }else if indexPath.section == 1 && indexPath.row == 1 {
            cell?.textLabel?.text = "Within walking distance"
            cell?.detailTextLabel?.text = "<500m"
        }else if indexPath.section == 1 && indexPath.row == 2 {
            cell?.textLabel?.text = "Has User Tips"
        }else if indexPath.section == 2 && indexPath.row == 0 {
            cell?.textLabel?.text = "Name(A-Z)"
        }else if indexPath.section == 2 && indexPath.row == 1 {
            cell?.textLabel?.text = "Name(Z-A)"
        }else if indexPath.section == 2 && indexPath.row == 2 {
            cell?.textLabel?.text = "Distance"
        }else {
            cell?.textLabel?.text = "Price"
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let oldIndex = tableView.indexPathForSelectedRow {
            tableView.cellForRow(at: oldIndex)?.accessoryType = UITableViewCellAccessoryType.none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        
        if indexPath.section == 0 && indexPath.row == 0 {
            queryConditions = "price = $"
        }else if indexPath.section == 0 && indexPath.row == 1 {
            queryConditions = "price = $$"
        }else if indexPath.section == 0 && indexPath.row == 2 {
            queryConditions = "price = $$$"
        }else if indexPath.section == 1 && indexPath.row == 1 {
            queryConditions = "distance < 500"
        }else if (indexPath.section == 1) && (indexPath.row == 0 || indexPath.row == 2 )  {
            queryConditions = "tierAsc"
        }else if indexPath.section == 2 && indexPath.row == 0 {
            queryConditions = "nameAsc"
        }else if indexPath.section == 2 && indexPath.row == 1 {
            queryConditions = "nameDesc"
        }else if indexPath.section == 2 && indexPath.row == 2 {
             queryConditions = "distanceAsc"
        }else {
            queryConditions = "priceAsc"
        }
        
        return indexPath
    }
    func  getCount(str:String) -> Int {
        let app = UIApplication.shared.delegate as! AppDelegate
        let contexts = app.persistentContainer.viewContext
        let entityName = "Tea"
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: contexts)
        fetchRequest.entity = entity
        let predicate = NSPredicate(format: "price = %@ ", str)
        fetchRequest.predicate = predicate
        do {
            let fetchedObjects = try contexts.fetch(fetchRequest) as! [Tea]
            return fetchedObjects.count
        } catch  {
            let nserror = error as NSError
            fatalError("查询错误： \(nserror), \(nserror.userInfo)")
        }
    }
    
}

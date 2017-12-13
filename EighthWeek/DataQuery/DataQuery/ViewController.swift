//
//  ViewController.swift
//  DataQuery
//
//  Created by Nick Wang on 09/12/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var dataArr = [Tea]()
    
    @IBOutlet weak var filterBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bubble Tea!"
        // 第一步：清理之前的旧数据
        cleanAllOldData()
        // 第二步：解析本地JSON文件并写入到CoreData数据库
        loadData()
        // 第三步：从CoreData数据库读取到内存数组中
        getAllDataList()
        NotificationCenter.default.addObserver(self, selector: #selector(filterNotification(_:)), name: NSNotification.Name(rawValue: "Filter"), object: nil)
    }
    func getAllDataList() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let contexts = app.persistentContainer.viewContext
        let entityName = "Tea"
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: contexts)
        fetchRequest.entity = entity
        do {
            let fetchedObjects = try contexts.fetch(fetchRequest) as! [Tea]
            for tea in fetchedObjects {
                dataArr.append(tea)
            }
        } catch  {
            let nserror = error as NSError
            fatalError("查询错误： \(nserror), \(nserror.userInfo)")
        }
    }

    func cleanAllOldData() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let contexts = app.persistentContainer.viewContext
        let entityName = "Tea"
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: contexts)
        fetchRequest.entity = entity
        do {
            let fetchedObjects = try contexts.fetch(fetchRequest) as! [Tea]
            for one: Tea in fetchedObjects {
                contexts.delete(one)
            }
            app.saveContext()
        } catch  {
            let nserror = error as NSError
            fatalError("查询错误： \(nserror), \(nserror.userInfo)")
        }
    }
    func loadData() {
        guard let jsonPath = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("无法找到json资源！")
            return
        }
        let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonPath))
        let json = try! JSON(data: jsonData)
        if let venues =  json["response"]["venues"].arrayObject{
            //        步骤一：获取总代理和托管对象总管
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedObectContext = appDelegate.persistentContainer.viewContext
            
            for index in 0...venues.count - 1{

                let dic = venues[index] as! NSDictionary
                let location = dic["location"] as! NSDictionary
                let price = dic["price"] as! NSDictionary
                
                //        步骤二：建立一个entity
                let entity = NSEntityDescription.entity(forEntityName: "Tea", in: managedObectContext)
                let tea = NSManagedObject(entity: entity!, insertInto: managedObectContext)
                //        步骤三：保存文本框中的值到tea
                tea.setValue(dic["name"], forKey: "name")
                tea.setValue(location["distance"], forKey: "distance")
                tea.setValue(String(describing: price["currency"]!), forKey: "price")
                tea.setValue(price["tier"], forKey: "tier")
            }
            //        步骤四：保存entity到托管对象中。如果保存失败，进行处理
            do {
                try managedObectContext.save()
            } catch  {
                fatalError("无法保存")
            }
        }

    }
    @objc func filterNotification(_ notification:Notification){
        
        guard notification.object != nil else {
            return
        }
        let app = UIApplication.shared.delegate as! AppDelegate
        let contexts = app.persistentContainer.viewContext
        let entityName = "Tea"
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest()
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: contexts)
        fetchRequest.entity = entity
        let conditions = notification.object as! String
        var predicate: NSPredicate
        var sortDescriptor: NSSortDescriptor
//        self.dataArr = self.sql.queryTeaData(sql:conditions)
        switch conditions {
        case "price = $":
            predicate = NSPredicate(format: "price = '$'", "")
             fetchRequest.predicate = predicate
        case "price = $$":
            predicate = NSPredicate(format: "price = '$$'", "")
             fetchRequest.predicate = predicate
        case "price = $$$":
            predicate = NSPredicate(format: "price = '$$$'")
             fetchRequest.predicate = predicate
        case "distance < 500":
            predicate = NSPredicate(format:"distance < 500") //NSPredicate(format: "distance < 500")
             fetchRequest.predicate = predicate
        case "tierAsc":
            sortDescriptor = NSSortDescriptor(key: "tier", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
        case "nameAsc":
            sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
        case "nameDesc":
            sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
        case "distanceAsc":
            sortDescriptor = NSSortDescriptor(key: "tier", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
        case "priceAsc":
            sortDescriptor = NSSortDescriptor(key: "price", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]

        default:
            print("无查找条件")
        }
        dataArr.removeAll()
        do {
            let fetchedObjects = try contexts.fetch(fetchRequest) as! [Tea]
            for tea in fetchedObjects {
                dataArr.append(tea)
            }
        } catch  {
            let nserror = error as NSError
            fatalError("查询错误： \(nserror), \(nserror.userInfo)")
        }
        self.tableView.reloadData()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cellId = "Cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: cellId)
        }
        let tea = self.dataArr[indexPath.row]
        cell?.textLabel?.text = tea.name
        cell?.detailTextLabel?.text = tea.price
        
        print()
        return cell!
    }
    
    
}


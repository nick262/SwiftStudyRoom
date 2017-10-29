//
//  ViewController.swift
//  Project03-TodoList
//
//  Created by Nick Wang on 27/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
struct Model {
    var icon: String
    var todoTitle: String
    var date: String
    var tag: Int
}

class ViewController: UIViewController {
    var arr: [Model]?
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // 配置导航栏文字和按钮
        view.backgroundColor = UIColor.white
        title = "Todo List"
        let leftBtn = UIButton(frame: CGRect(x:0,y:0,width:65,height:30))
        leftBtn.setTitle("Edit", for: .normal)
        leftBtn.setTitle("Done", for: .selected)
        leftBtn.setTitleColor(UIColor.init(red: 21/255, green: 126/255, blue: 251/255, alpha: 1), for: .normal)
        leftBtn.addTarget(self, action: #selector(clickEditBtn), for: .touchUpInside)
        navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: leftBtn)]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        
        // 添加tableView
        tableView = UITableView(frame: CGRect(x:0,y:0,width:view.bounds.size.width,height:view.bounds.size.height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        // 准备数据
        let goToDisney = Model(icon: "wheel", todoTitle: "Go to Disney", date: "2014-10-20", tag: 1)
        let cicsoShopping = Model(icon: "cart", todoTitle: "Cicso Shopping", date: "2014-10-28", tag: 3)
        let callJobs = Model(icon: "phone", todoTitle: "Call Jobs", date: "2014-10-30", tag: 2)
        let europeJourney = Model(icon: "plane", todoTitle: "Europe Journey", date: "2014-10-31", tag: 4)
        arr = [goToDisney,cicsoShopping,callJobs,europeJourney]
        
    }
    @objc func addNewTask()  {
        let nkVC = NKViewController()
        nkVC.title = "New Todo"
        nkVC.isNew = true
        nkVC.sendValueClsure = { (newTask: Model) -> Void in
            self.arr?.append(newTask)
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(nkVC, animated: true)
    }
    @objc func clickEditBtn(sender:UIButton){
        let flag = !tableView.isEditing
        tableView.setEditing(flag, animated: true)
        navigationItem.leftBarButtonItem?.style = .done
        sender.isSelected = flag
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        }
        let model = arr![indexPath.row]
        cell?.imageView?.image = UIImage(named: model.icon)
        cell?.textLabel?.text = model.todoTitle
        cell?.detailTextLabel?.text = model.date
        cell?.selectionStyle = .none
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = arr![indexPath.row]
        let editVC = NKViewController()
        editVC.isNew = false
        editVC.editModel = task
        editVC.title = "Edit Task"
        editVC.sendValueClsure = { (newTask: Model) -> Void in
            self.arr!.remove(at: indexPath.row)
            self.arr?.insert(newTask, at: indexPath.row)
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(editVC, animated: true)
        
    }
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.arr?.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let task = arr![sourceIndexPath.row]
        self.arr?.remove(at: sourceIndexPath.row)
        self.arr?.insert(task, at: destinationIndexPath.row)
    }

    
    
}

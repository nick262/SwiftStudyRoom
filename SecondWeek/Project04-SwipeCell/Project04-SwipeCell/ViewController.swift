//
//  ViewController.swift
//  Project04-SwipeCell
//
//  Created by Nick Wang on 29/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Swipe Cell"
        let tableView = UITableView(frame: CGRect(x:0,y:0,width:view.bounds.size.width,height:view.bounds.size.height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
            if cell == nil {
                cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            }
            let imageName = "00" + "\((arc4random() % 5) + 1)"
            cell?.imageView?.image = UIImage(named: imageName)
        
        let myImageSize: CGSize = CGSize(width: 180, height: 80)
        UIGraphicsBeginImageContextWithOptions(myImageSize, false, 0.0)
        let myImageRect = CGRect(x:0, y:0, width: myImageSize.width, height:myImageSize.height)
        cell?.imageView!.image?.draw(in: myImageRect)
        cell?.imageView!.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
            cell?.textLabel?.text = "model.todoTitle"
            cell?.selectionStyle = .none
            cell?.backgroundColor = UIColor.init(red: 252/255, green: 255/255, blue: 237/255, alpha: 1)
            return cell!
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: "🗑\nDelete") { action, index in
        }
        delete.backgroundColor = UIColor.lightGray
        let share = UITableViewRowAction(style: .normal, title: "🤗\nShare") { action, index in
            let items = ["hello",UIImage(named: "003")!,URL.init(string: "https://www.baidu.com") as Any] as [Any]
            let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
//            activityController.excludedActivityTypes = [UIActivityType.print,UIActivityType.airDrop]
            self.navigationController?.present(activityController, animated: true, completion: nil)
        }
        share.backgroundColor = UIColor.red
        let download = UITableViewRowAction(style: .normal, title: "⬇️\nDownload") { action, index in
        }
        download.backgroundColor = UIColor.blue
        return [download,share,delete]
    }
    
    
}

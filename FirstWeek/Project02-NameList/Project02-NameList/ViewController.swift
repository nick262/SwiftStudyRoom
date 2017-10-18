//
//  ViewController.swift
//  Project02-NameList
//
//  Created by Nick Wang on 17/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    let names = [["Ado","Abbe","Abby","Ave"], ["Bbo","Bond","Beck","Bliss","Bake"], ["Calvin","Cici","Chris","Clark"],["Davina","Delica","Diane","Doris","Dodo"],["Ela","Edision","Elise","Ena","Elle"],["Jack","Jake","James","Jazz"],["Zed"]];
    let titles = ["A","B","C","D","E","J","Z"]
    let tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Names"
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return names.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return titles[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arr = names[indexPath.section]
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = arr[indexPath.row]
        return cell
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return titles
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}




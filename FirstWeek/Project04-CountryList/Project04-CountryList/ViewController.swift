//
//  ViewController.swift
//  Project04-CountryList
//
//  Created by Nick Wang on 19/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
class ContinentModel {
    
    var name : String
    var countries : [CountryModel]
    var isOpen = true
//    func touch() {
//        isOpen = !isOpen
//    }
    init(name:String,countries:[CountryModel]) {
        self.name = name
        self.countries = countries
    }
}
class CountryModel {
    var name : String
    var provinces: [String]
    var isOpen = false
//    func touch() {
//        isOpen = !isOpen
//    }
    init(name:String,provinces:[String]) {
        self.name = name
        self.provinces = provinces
    }
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NKHeaderViewDelegate,NKTableViewCellDelegate{
    
    var continents : [ContinentModel]?
    var tableView : UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let China = CountryModel(name: "中国", provinces: ["北京","上海","广州","深圳"])
        let Russia = CountryModel(name: "俄罗斯", provinces: ["莫斯科","新西伯利亚","叶卡捷琳堡"])
        let Asia = ContinentModel(name: "亚洲", countries: [China,Russia])
        let Brazil = CountryModel(name: "巴西", provinces: [])
        let Argentina = CountryModel(name: "阿根廷", provinces: [])
        let SouthAmerica = ContinentModel(name: "南美洲", countries: [Brazil,Argentina])
        let Australia = CountryModel(name: "澳大利亚", provinces: [])
        let NewZealand = CountryModel(name: "新西兰", provinces: [])
        let Oceania = ContinentModel(name: "大洋洲", countries: [Australia,NewZealand])
        continents = [Asia,SouthAmerica,Oceania]
        tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        view.addSubview(tableView!)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (continents?.count)!
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return continents![section].name
//    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = NKHeaderView.init(frame: CGRect(x:0,y:0,width:view.bounds.size.width, height:10), continet: continents![section], index: section)
        headerView.delegate = self
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let country = continents![indexPath.section].countries[indexPath.row]
        return CGFloat(country.isOpen ? 40 + (country.provinces.count * 40) : 40)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return continents![section].isOpen ? continents![section].countries.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = continents![indexPath.section].countries[indexPath.row]
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//        cell.textLabel?.text = country.name
//        return cell
        let cell = NKTableViewCell(style: .default, reuseIdentifier: "Cell", country: country, indexPath: indexPath as NSIndexPath)
        cell.delegate = self
        return cell
        
        
    }
    // NKHeaderViewDelegate
    func openOrCloseContent(index: Int) {
        continents![index].isOpen = !continents![index].isOpen
        tableView?.reloadSections(IndexSet.init(integer: index), with: .automatic)
    }
    // NKTableViewCellDelegate
    func openOrCloseContents(indexPath: NSIndexPath) {
        continents![indexPath.section].countries[indexPath.row].isOpen = !continents![indexPath.section].countries[indexPath.row].isOpen
        tableView?.reloadRows(at: [indexPath as IndexPath] , with: .automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


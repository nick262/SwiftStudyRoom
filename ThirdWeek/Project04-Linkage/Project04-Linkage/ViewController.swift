//
//  ViewController.swift
//  Project04-Linkage
//
//  Created by Nick Wang on 05/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

struct Model {
    var name: String
    var goods: [String]
}

class ViewController: UIViewController {
    var category: [String] = ["龙虾", "蟹类", "贝类"]
    var collectionView: UICollectionView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.white
        title = "联动"
        let tableView = UITableView(frame: CGRect(x:0,y:0,width: 100,height:view.bounds.height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.showsVerticalScrollIndicator = false
        
        let line = UIView(frame: CGRect(x: tableView.bounds.width - 1, y: 0, width: 1, height: tableView.bounds.height))
        line.backgroundColor = UIColor.black
        view.addSubview(tableView)
        view.addSubview(line)
        
        let customFlowLayout = UICollectionViewFlowLayout()
        let itemWidth = (view.bounds.width - tableView.bounds.width - 30) / 2
        customFlowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.3)
        customFlowLayout.minimumInteritemSpacing = 10
        customFlowLayout.minimumLineSpacing = 10
        customFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        customFlowLayout.headerReferenceSize = CGSize(width: view.bounds.width - tableView.bounds.width - 20, height: 50)
        
         collectionView = UICollectionView(frame: CGRect(x:tableView.bounds.width,y:0,width:view.bounds.width - tableView.bounds.width,height:view.bounds.height), collectionViewLayout: customFlowLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "NKCollectionViewHeader",bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HEADER")
        collectionView.register(UINib.init(nibName: "NKCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CELLID")
        view.addSubview(collectionView)
    }
    

}
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell.init(style: .default, reuseIdentifier: "CELL")
        cell.textLabel?.text = category[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collectionViewSection = indexPath.row
        let collectionIndexPath = IndexPath(row: 0, section: collectionViewSection)
        collectionView.scrollToItem(at: collectionIndexPath, at: .top, animated: true)
    }

    
}
extension ViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    fileprivate func nameList(category: String) -> [String] {
        switch category {
        case "龙虾":
            return ["加拿大龙虾","美国龙虾","爱尔兰龙虾","南澳龙","南非油龙"]
        case "蟹类":
            return ["河蟹","石蟹","花蟹","梭子蟹","青蟹","面包蟹","红蟹"]
        case "贝类":
            return ["牡蛎","贻贝","扇贝","蛤"]
        default:
            return []
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return category.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameList(category: category[section]).count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLID", for: indexPath) as! NKCollectionViewCell
        cell.titleLabel.text = nameList(category: category[indexPath.section])[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HEADER", for: indexPath) as! NKCollectionViewHeader
        headerView.backgroundColor = UIColor.lightGray
        headerView.titleLabel.text = category[indexPath.section]
        return headerView
    }



}


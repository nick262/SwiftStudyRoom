//
//  ViewController.swift
//  Project03-CollectionViewWithNavgationBarAndTabBar
//
//  Created by Nick Wang on 01/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var data = [Model]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 准备首页collectionView的数据
         prepareData()
        // 添加collectionView
        let customFlowLayout = NKCollectionViewFlowLayout()
        customFlowLayout.modelList = data
        customFlowLayout.column = 2
        customFlowLayout.minimumLineSpacing = 2
        customFlowLayout.minimumInteritemSpacing = 2
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: customFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "NKCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CELLID")
        view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func prepareData(){
        data = [Model(width: 200, height: 275, tag: false, img: "1"),
                Model(width: 200, height: 300, tag: false, img: "2"),
                Model(width: 200, height: 270, tag: false, img: "3"),
                Model(width: 200, height: 265, tag: false, img: "4"),
                Model(width: 200, height: 270, tag: false, img: "5"),
                Model(width: 200, height: 354, tag: false, img: "1"),
                Model(width: 200, height: 270, tag: false, img: "2"),
                Model(width: 200, height: 267, tag: false, img: "3"),
                Model(width: 200, height: 276, tag: false, img: "4"),
                Model(width: 200, height: 322, tag: false, img: "5"),
                Model(width: 200, height: 288, tag: false, img: "1"),
                Model(width: 200, height: 300, tag: false, img: "2"),
                Model(width: 200, height: 307, tag: false, img: "3"),
                Model(width: 200, height: 333, tag: false, img: "4"),
                Model(width: 200, height: 262, tag: false, img: "5")
        ]
        
    }


}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLID", for: indexPath) as! NKCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.imageView.image = UIImage(named: "\(data[indexPath.row].img)")
        cell.imageView.layer.cornerRadius = 15
        cell.imageView.layer.masksToBounds = true
        cell.iconImageView.image = UIImage(named: "\(data[indexPath.row].img)")
        cell.iconImageView.layer.cornerRadius = 15
        cell.iconImageView.layer.masksToBounds = true
        return cell
    }
    
    
}


//
//  ViewController.swift
//  Project02-EquilateralCollectionView
//
//  Created by Nick Wang on 31/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var collectionView: UICollectionView!
    var arr = ["1","2","3","4","5","6","7","8"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        title = "CollectionView"
        let customLayout = UICollectionViewFlowLayout.init()
        customLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 30) / 2, height: (UIScreen.main.bounds.size.width - 30) / 2)
        customLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: customLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "NKCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CELLID")

        view.addSubview(collectionView)
    }

}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLID", for: indexPath) as! NKCollectionViewCell
        cell.backgroundColor = UIColor.yellow
        cell.imageView.image = UIImage(named: "\(arr[indexPath.row])")
        cell.imageView.layer.cornerRadius = 10
        cell.imageView.layer.masksToBounds = true
        return cell
    }
}


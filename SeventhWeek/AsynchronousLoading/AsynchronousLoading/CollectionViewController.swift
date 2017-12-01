//
//  CollectionViewController.swift
//  AsynchronousLoading
//
//  Created by Nick Wang on 30/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    let imageLoadQueue = OperationQueue()
    var imageOperations = [(Item,Operation?)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageLoadQueue.maxConcurrentOperationCount = 2
        imageLoadQueue.qualityOfService = .userInteractive
        
        imageOperations = Item.creatItems(count: 100).map({ (images) -> (Item,Operation?) in
            return (images,nil)
        })
        collectionView?.reloadData()

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageOperations.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
    
        cell.imageView.image = nil
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! CollectionViewCell
        let (item, operation) = imageOperations[indexPath.row]
        // 由于cell是复用的, 先取消操作, 以防万一
        operation?.cancel()
        weak var weakCell = cell
        let newOperation = ImageLoadOperation(forItem: item) { (image) in
            DispatchQueue.main.async {
                weakCell?.imageView.image = image
            }
        }
        imageLoadQueue.addOperation(newOperation)
        imageOperations[indexPath.row] = (item,newOperation)
        
    }
    // UICollectionViewDelegateFlowLayout代理方法
    // 设置Cell宽高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width / 2 - 5
        return CGSize(width: width, height: width)
    }
}

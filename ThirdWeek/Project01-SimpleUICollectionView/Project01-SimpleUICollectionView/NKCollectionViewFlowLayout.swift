//
//  NKCollectionViewFlowLayout.swift
//  Project01-SimpleUICollectionView
//
//  Created by Nick Wang on 31/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
let kCellsInOneRow = 4
let kNumberOfRows = 2
class NKCollectionViewFlowLayout: UICollectionViewFlowLayout {
    fileprivate var attributesArr: [UICollectionViewLayoutAttributes] = []
    override func prepare() {
        super.prepare()
//        let itemWidth = UIScreen.main.bounds.size.width / CGFloat(kCellsInOneRow)
        var page = 0
        let itemsCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        for itemIndex in 0 ..< itemsCount {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            page = itemIndex / (kNumberOfRows * kCellsInOneRow)
            var x = sectionInset.left + (itemSize.width + minimumLineSpacing) * CGFloat(itemIndex % Int(kCellsInOneRow))
              x += CGFloat(page) * UIScreen.main.bounds.size.width
            let y = sectionInset.top + (itemSize.height + minimumInteritemSpacing) * CGFloat((itemIndex - page * kCellsInOneRow * kNumberOfRows) / kCellsInOneRow)
            attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
            attributesArr.append(attributes)
        }
        
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var rectAttributes: [UICollectionViewLayoutAttributes] = []
        _ = attributesArr.map({
            if rect.contains($0.frame) {
                rectAttributes.append($0)
            }
        })
        return rectAttributes
    }
    override var collectionViewContentSize: CGSize {
        let size: CGSize = super.collectionViewContentSize
        let collectionViewWidth: CGFloat = self.collectionView!.frame.size.width
        let nbOfScreen: Int = Int(ceil(size.width / collectionViewWidth)) //ceil函数的作用是求不小于给定实数的最小整数。
        let newSize: CGSize = CGSize(width: collectionViewWidth * CGFloat(nbOfScreen), height: size.height)
        return newSize
    }
}

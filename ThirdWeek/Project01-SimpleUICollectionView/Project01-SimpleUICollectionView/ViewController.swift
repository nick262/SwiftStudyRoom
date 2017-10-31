//
//  ViewController.swift
//  Project01-SimpleUICollectionView
//
//  Created by Nick Wang on 30/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

//let CELL_ID = "cellId"

class ViewController: UIViewController {
    var pageControl: UIPageControl!
    var collectionView: UICollectionView!
    var arr = ["0","1","2","3","4","5","6","7","8","9","10"] //,"11","12","13","14","15"
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        let customLayout = NKCollectionViewFlowLayout.init()
        collectionView = UICollectionView(frame: CGRect(x:0,y:100,width:UIScreen.main.bounds.size.width,height:(UIScreen.main.bounds.size.width - 50) / 2 + 30), collectionViewLayout: customLayout)
        customLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 50) / 4, height: (UIScreen.main.bounds.size.width - 50) / 4)
        customLayout.scrollDirection = .horizontal
        //设置行间距
        customLayout.minimumLineSpacing = 10
        //设置列间距
        customLayout.minimumInteritemSpacing = 10
        customLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView.backgroundColor = UIColor.cyan
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
    collectionView.register(UINib.init(nibName: "NKCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CELLID")
        pageControl = UIPageControl(frame: CGRect(x: 150, y: 100, width: 80, height: 40))
        pageControl.center = CGPoint(x: UIScreen.main.bounds.size.width / 2 , y: 100 + collectionView.frame.size.height + 20 )
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = arr.count / 8 + 1
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageChanged(_:)), for: .valueChanged)
        view .addSubview(pageControl)
        
    }
    
    //点击页控件时事件处理
    @objc func pageChanged(_ sender:UIPageControl) {
        //根据点击的页数，计算scrollView需要显示的偏移量
        var frame = collectionView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        //展现当前页面内容
        collectionView.scrollRectToVisible(frame, animated: true)
    }

}
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLID", for: indexPath) as! NKCollectionViewCell
        cell.backgroundColor = UIColor.yellow
        cell.label.text = arr[indexPath.row]
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = page
    }
    
}

//
//  NKTabBarController.swift
//  Project03-CollectionViewWithNavgationBarAndTabBar
//
//  Created by Nick Wang on 01/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class NKTabBarController: UITabBarController, NKTabBarDelegate, NKSegmentedViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nkTabBar = NKTabBar()
        nkTabBar.tabBarDelegate = self
        self.setValue(nkTabBar, forKey: "tabBar")
        
        let vc1 = ViewController()
        vc1.title = "首页"
        // 自定义导航栏
        let nav1 = UINavigationController.init(rootViewController: vc1)
        nav1.tabBarItem.title = "首页"
        nav1.tabBarItem.image = UIImage(named:"home0")
        nav1.tabBarItem.selectedImage = UIImage(named:"home1")
        let segmentedView =  NKSegmentedView.init(frame: CGRect(x: 0, y: -20, width: view.frame.size.width, height: 64), titles: ["推荐","随听","视频","图片","段子","排行","互动区","网红"])
        segmentedView.backgroundColor = UIColor.red
        segmentedView.delegate = self
        vc1.navigationController?.navigationBar.barStyle = .black
        vc1.navigationController?.navigationBar.addSubview(segmentedView)
        addChildViewController(nav1)
        
        let vc2 = ViewController()
        vc2.title = "标签"
        let nav2 = UINavigationController.init(rootViewController: vc2)
        nav2.tabBarItem.title = "标签"
        nav2.tabBarItem.image = UIImage(named:"tag0")
        addChildViewController(nav2)
        
        let vc3 = ViewController()
        vc3.title = "联系"
        let nav4 = UINavigationController.init(rootViewController: vc3)
        nav4.tabBarItem.title = "联系"
        nav4.tabBarItem.image = UIImage(named:"chat0")
        addChildViewController(nav4)
        
        let vc4 = ViewController()
        vc4.title = "我"
        let nav5 = UINavigationController.init(rootViewController: vc4)
        nav5.tabBarItem.title = "我"
        nav5.tabBarItem.image = UIImage(named:"me0")
        addChildViewController(nav5)
        
        tabBar.tintColor = UIColor.lightGray
        
    }
    // MARK: NKTabBar的代理方法
    func tabBarDidCickMidBtn(tabBar: NKTabBar) {
        print("中间按钮被点击")
    }
    // MARK: NKSegmentedView的代理方法
    func segmentedView(_ sementedView: NKSegmentedView, selectedIndex index: Int) {
        print("点击了\(sementedView.titles[index])")
    }
    
   
}


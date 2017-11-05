//
//  NKTabBar.swift
//  Project03-CollectionViewWithNavgationBarAndTabBar
//
//  Created by Nick Wang on 02/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
protocol NKTabBarDelegate {
    func tabBarDidCickMidBtn(tabBar: NKTabBar)
}
class NKTabBar: UITabBar {
    var midBtn: UIButton!
    var tabBarDelegate: NKTabBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        midBtn = NKButton.init()
        midBtn.setImage(UIImage(named: "edit1")?.tint(color: UIColor.red, blendMode: .destinationIn), for: .normal)
        midBtn.addTarget(self, action: #selector(midBtnClick), for: .touchUpInside)
        addSubview(midBtn)
      
    }
    @objc func midBtnClick() {
        if tabBarDelegate != nil{
            tabBarDelegate?.tabBarDidCickMidBtn(tabBar: self)
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置中间按钮的位置
        var temp = midBtn.center
        temp.x = frame.size.width / 2
        temp.y = frame.size.height / 2
        midBtn.center = temp
        midBtn.frame.size = CGSize(width: 44, height: 44)
        
        // 设置其他UITabBarButton的位置和尺寸
        let width = frame.size.width / 5
        var tabBarButtonIndex = 0
        for item in subviews {
            if item.isKind(of: NSClassFromString("UITabBarButton")!){
                var tmp = item.frame
                tmp.size.width = width
                tmp.origin.x = CGFloat(tabBarButtonIndex) * width
                item.frame = tmp
                tabBarButtonIndex += 1
                if tabBarButtonIndex == 2 {
                    tabBarButtonIndex += 1
                }
            }
        }
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension UIImage {
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(rect)
        draw(in: rect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}

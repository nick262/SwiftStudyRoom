//
//  ViewController.swift
//  HeartBeat
//
//  Created by Nick Wang on 07/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = self.createLayer(position: CGPoint(x: view.center.x, y: 100), withImage: (UIImage(named: "heart")?.cgImage)!)
        layer.add(createAnimation(keyPath: "transform.scale", toValue: 0.8), forKey: nil)

        UIView.animate(withDuration: 3.0) {
            self.photoView.alpha = 0
        }
       
    }

}
extension ViewController{
    fileprivate func createLayer (position: CGPoint, withImage: CGImage) -> CALayer {
        let layer = CALayer()
        //设置位置和大小
        layer.position = position
        layer.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        layer.contents = withImage
        //把layer添加到UIView的layer上
        self.view.layer.addSublayer(layer)
        return layer
    }
    
    //创建基础Animation
    fileprivate func createAnimation (keyPath: String, toValue: CGFloat) -> CABasicAnimation {
        //创建动画对象
        let scaleAni = CABasicAnimation()
        //设置动画属性
        scaleAni.keyPath = keyPath

        //设置动画的起始位置。也就是动画从哪里到哪里。不指定起点，默认就从positoin开始
        scaleAni.toValue = toValue
        
        //动画持续时间
        scaleAni.duration = 1.0;
        
       // 动画的节奏
        scaleAni.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        //动画重复次数
        scaleAni.repeatCount = Float(CGFloat.greatestFiniteMagnitude)
        
        return scaleAni;
    }
    
}

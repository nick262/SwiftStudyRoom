//
//  ViewController.swift
//  LogoDiffuse
//
//  Created by Nick Wang on 07/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var maskLayer: CALayer = {
        let layer = CALayer()
        layer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        layer.contents = UIImage(named: "apple")?.cgImage
        return layer
    }()
    override func viewDidLoad() {
        let imageView = UIImageView(frame: view.frame)
        imageView.image = UIImage(named: "linyuner")
        view.addSubview(imageView)
        view.backgroundColor = UIColor.cyan
        maskLayer.position = view.center
        maskLayer.add(maskAnimation(), forKey: nil)
//        view.layer.mask = maskLayer //遮罩背景是全黑
        imageView.layer.mask = maskLayer //遮罩背景为父view的背景色
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController {
    fileprivate func maskAnimation() -> (CAKeyframeAnimation){
        let maskAni = CAKeyframeAnimation(keyPath: "bounds")
        maskAni.duration = 1.5 // 动画持续时间
        maskAni.beginTime = CACurrentMediaTime() + 0.5 // 动画延迟0.5秒播放
        let startRect = maskLayer.frame
        let tmpRect = CGRect(x: 0, y: 0, width: 300, height: 300)
        let endRect = CGRect(x: 0, y: 0, width: 3000, height: 3000)
        maskAni.values = [startRect,tmpRect,endRect]
         //    设置关键帧动画的运动节奏
        maskAni.timingFunctions = [CAMediaTimingFunction(name: "easeInEaseOut"),
                                   CAMediaTimingFunction(name: "easeOut"),
                                   CAMediaTimingFunction(name: "easeOut")]
        // 动画播放结束后是否移除动画
        maskAni.isRemovedOnCompletion = false
        // 动画填充模式：kCAFillModeForwards:当动画结束后，layer会一直保持着动画最后的状态
        maskAni.fillMode = kCAFillModeForwards
        return maskAni
        
    }
}

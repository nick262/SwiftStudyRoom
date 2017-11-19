//
//  ViewController.swift
//  PlayerIndicator
//
//  Created by Nick Wang on 16/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlayerIndicator()
        
        
    }
    func setupPlayerIndicator() {
        let layer = CALayer()
        layer.frame = CGRect(x: 10, y: 100, width: 10, height: 80)
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.add(scaleAnimation(), forKey: nil)
        addReplicatorLayer(with: layer)
        
    }
    fileprivate func scaleAnimation() -> CABasicAnimation{
        let animation = CABasicAnimation.init(keyPath: "transform.scale.y")
        animation.toValue = 0.1
        animation.duration = 0.4
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        return animation
    }
    func addReplicatorLayer(with layer: CALayer) {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.instanceCount = 8
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(45, 0, 0)
        replicatorLayer.instanceDelay = 0.2
        replicatorLayer.instanceColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
       // 颜色的渐变，相对于前一个层的渐变（取值-1~+1）.RGB有三种颜色，所以这里也是绿红蓝三种。
        replicatorLayer.instanceGreenOffset = -0.2
        replicatorLayer.instanceRedOffset = -0.2
        replicatorLayer.instanceBlueOffset = -0.2
        replicatorLayer.addSublayer(layer)
        view.layer.addSublayer(replicatorLayer)
    }
   


}


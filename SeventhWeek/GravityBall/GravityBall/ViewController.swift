//
//  ViewController.swift
//  GravityBall
//
//  Created by Nick Wang on 28/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    @IBOutlet weak var ballImageView: UIImageView!
    
    let motionManager = CMMotionManager()
    var movePoint = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 判断加速度计是否可用
        if !motionManager.isAccelerometerAvailable {
            print("不支持重力传感器")
        }
        // 设置采样间隔
        motionManager.accelerometerUpdateInterval = 0.01
        // 开始采样
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (accelerometerData: CMAccelerometerData?, error: Error?) in
            self.ballMoveWith(acceleration: (accelerometerData?.acceleration)!)
        }
    }

    func ballMoveWith(acceleration: CMAcceleration) {
        print("Acceleration: x=\(String(format:"%.9f",acceleration.x)) y=\(String(format:"%.9f",acceleration.y)) z=\(String(format:"%.9f",acceleration.z))")
       // 获取加速度的偏移值
        movePoint.x += CGFloat(acceleration.x)
        movePoint.y += CGFloat(acceleration.y)
        // 获取小球当前的位置
        let currentRect = ballImageView.frame
        //使用偏移矩形CGRectOffset设置小球的新位置：  第一个参数：原始矩形  第二个参数：x轴偏移量  第三个参数：y轴偏移量
        //加速器是笛卡尔坐标系，y轴向上为正，向下为负。而iPhone屏幕的y轴正方向是向下，所以这里y轴的偏移量应该与加速器的偏移量相反
        var rect = currentRect.offsetBy(dx: movePoint.x, dy: -movePoint.y)
        
        // x轴边界检测
        if  rect.origin.x <= 0{
            rect.origin.x = 0
            movePoint.x *= -0.5
        }
        else if (rect.origin.x > view.bounds.size.width-rect.size.width){
            rect.origin.x = view.bounds.size.width-rect.size.width
            movePoint.x *= -0.5
        }
        // y轴边界检测
        if  rect.origin.y <= 0{
            rect.origin.y = 0
            movePoint.y *= -0.5
        }
        else if (rect.origin.y > view.bounds.size.height-rect.size.height){
            rect.origin.y = view.bounds.size.height-rect.size.height
            //一旦超出边界，设置回弹（把偏移量的设为原来的反方向即可）
            //在实际游戏开发中，回弹量的大小与小球材料有关（高中物理知识），这里我们就暂时设为一半0.5
            movePoint.y *= -0.5
        }
        // 修改小球的位置
        ballImageView.frame = rect
        
    }


}


//
//  ViewController.swift
//  Dynamics
//
//  Created by Nick Wang on 01/12/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let panGesture = UIPanGestureRecognizer()
    var balls = [UIImageView]()
    var animator: UIDynamicAnimator?
    var attachmentBehavior: UIAttachmentBehavior?
    var attachments = [UIAttachmentBehavior]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        // 循环创建6个球
        for count in 0...5 {
            let imageView = UIImageView(image:#imageLiteral(resourceName: "ball"))
            imageView.frame = CGRect(x: Int(view.bounds.size.width * 0.5), y: 200 + 40 * count, width: 30, height: 30)
            
            balls.append(imageView)
            view.addSubview(imageView)
        }
        // 给第一个球添加手势
        panGesture.addTarget(self, action: #selector(handleGesture(gesture:)))
        view.addGestureRecognizer(panGesture)
        
        // animator就是一个播放者，容器。一个容纳动力系统的环境，而referenceView就是该环境的坐标系，物体运动的参照系。
        animator = UIDynamicAnimator.init(referenceView: view)
        
        // 为所有的球添加重力行为
        // gravityBehavior，初始化一个重力行为，行为的受力物体是balls数组里面的UIImageView
        let gravitBehavior = UIGravityBehavior(items: balls)
        // 设置重力行为的: angle:角度(弧度)  magnitude:量级(重力系数)
        gravitBehavior.setAngle(.pi / 2 + 0.1, magnitude: 0.9)
        animator?.addBehavior(gravitBehavior)
        
        // 为所有球添加碰撞行为
        let collisionBehavior = UICollisionBehavior(items: balls)
        collisionBehavior.collisionMode = UICollisionBehaviorMode.everything
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collisionBehavior)
        
        // 为第二到第五个球添加吸附行为
        for count in 1...(balls.count-1) {
            let attachment = UIAttachmentBehavior(item: balls[count], attachedTo: balls[count - 1])
            attachment.frequency = -0.2
            attachment.length = 50
            animator?.addBehavior(attachment)
            
        }
        
        
    }
    @objc func handleGesture(gesture:UIPanGestureRecognizer) {
        let point = gesture.location(in: view)
        if gesture.state == UIGestureRecognizerState.began {
            attachmentBehavior = UIAttachmentBehavior(item: balls.first!, attachedToAnchor: balls.first!.center)
            attachmentBehavior?.anchorPoint = point
            animator?.addBehavior(attachmentBehavior!)
            
        } else if gesture.state == UIGestureRecognizerState.changed {
            attachmentBehavior?.anchorPoint = point
            
        } else if (gesture.state == UIGestureRecognizerState.ended ||
                    gesture.state == UIGestureRecognizerState.cancelled ||
                    gesture.state == UIGestureRecognizerState.failed) {
            animator?.removeBehavior(attachmentBehavior!)
        }
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let point = touch?.location(in: view)
        attachmentBehavior?.anchorPoint = point!
    }


}


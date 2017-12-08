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
    // animator就是一个播放者，容器。一个容纳动力系统的环境，而referenceView就是该环境的坐标系，物体运动的参照系。
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: view)
    }()
    var attachmentBehavior: UIAttachmentBehavior!
    var attachments = [UIAttachmentBehavior]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
        // 循环创建6个球
        for count in 0...5 {
            let imageView = UIImageView.init(image:UIImage.init(named: "ball"))
            imageView.frame = CGRect(x: count * 60, y: 200, width: 30, height: 30)
            balls.append(imageView)
            view.addSubview(imageView)
        }
      
        // 物体属性
        let ballsBehavior = UIDynamicItemBehavior(items: balls)
        // 角速度阻尼：用于动态元素所受角速度阻尼大小。有效范围从0.0到CGFLOAT_MAX，值越大，角速度阻尼越大，旋转减速越快，到停止。
        ballsBehavior.angularResistance = 0.6
        // 相对质量密度:用于动态元素相对密度。其连同动态元素大小，决定动态元素的有效质量。其参与的动力学行为包括摩擦、碰撞、推动等.
        ballsBehavior.density = 10
        // 弹性系数:用于碰撞行为的动态元素的弹性量,默认值为0.0，有效范围从0.0(没有碰撞)到1.0(完全碰撞)。
        ballsBehavior.elasticity = 0.6
        // 摩擦系数:用于两个发生摩擦的动态元素,默认值0.0(没有摩擦)，当值为1.0时，强烈摩擦。如果设置更高的摩擦，可以使用更高的数值。
        ballsBehavior.friction = 0.3
        // 线速度阻尼:用于动态元素所受线速度阻尼大小,默认值是0.0。有效范围从0.0(没有速度阻尼)到CGFLOAT_MAX(最大速度阻尼)。当设置为1.0，动态元素会立马停止就像没有力量作用于它一样。
        ballsBehavior.resistance = 0.3
        animator.addBehavior(ballsBehavior)
        // 给第一个球添加手势
        panGesture.addTarget(self, action: #selector(handleGesture(gesture:)))
        view.addGestureRecognizer(panGesture)
    
        
        // 为所有的球添加重力行为
        // gravityBehavior，初始化一个重力行为，行为的受力物体是balls数组里面的UIImageView
        let gravitBehavior = UIGravityBehavior(items: balls)
        animator.addBehavior(gravitBehavior)
        
        // 为所有球添加碰撞行为
        let collisionBehavior = UICollisionBehavior(items: balls)
        collisionBehavior.collisionMode = UICollisionBehaviorMode.everything
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collisionBehavior)
        
        // 为第一个球添加吸附行为
        if let ball = balls.first {
            attachmentBehavior = UIAttachmentBehavior.init(item: ball, attachedToAnchor: ball.center)
            attachmentBehavior.anchorPoint = CGPoint(x: 150, y: 80)
            attachmentBehavior.length = 35
            attachmentBehavior.damping = 1
            attachmentBehavior.frequency = 3
            animator.addBehavior(attachmentBehavior)
        }
        for count in 1...(balls.count-1) {
            let attachment = UIAttachmentBehavior(item: balls[count], attachedTo: balls[count - 1])
            attachment.length = 35
            attachment.frequency = 3
            attachment.damping = 1
            animator.addBehavior(attachment)
        }
 
    }
    @objc func handleGesture(gesture:UIPanGestureRecognizer) {
        if (animator.behaviors.contains(attachmentBehavior) == false) {
            animator.addBehavior(attachmentBehavior)
        }
        let point = panGesture.location(in: view)
        attachmentBehavior.anchorPoint = point
        if panGesture.state == .ended {
            animator.removeBehavior(attachmentBehavior)
        }

    }
}


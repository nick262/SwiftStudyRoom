//
//  NKPopTransition.swift
//  Project05-Transition
//
//  Created by Nick Wang on 05/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class NKPopTransition: NSObject, UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //1.获取动画的源控制器和目标控制器
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! NKDetailVC
        let toVC =  transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! ViewController
        
        let container = transitionContext.containerView
        
        //2.创建一个 Cell 中 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
        let snapshotView = fromVC.imgView.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = container.convert((fromVC.imgView.frame), from: fromVC.view)
        fromVC.imgView.isHidden = true
        
        //3.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
        toVC.view.frame = transitionContext.finalFrame(for: toVC)
        toVC.selectedCell?.imgView.isHidden = true
        toVC.view.alpha = 0
        
        
        //4.都添加到 container 中。注意顺序不能错了
        container.addSubview(toVC.view)
        container.addSubview(snapshotView!)
        
        //5.执行动画
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            snapshotView?.frame = container.convert((toVC.selectedCell?.imgView.frame)!, from: toVC.selectedCell)
            toVC.view.alpha = 1
        }) { (finished: Bool) in
            toVC.selectedCell?.imgView.isHidden = false
            snapshotView?.removeFromSuperview()
            fromVC.imgView.isHidden = false
            //一定要记得动画完成后执行此方法，让系统管理 navigation
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    

}

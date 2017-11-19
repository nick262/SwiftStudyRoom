//
//  NKLoadingView.swift
//  Loading
//
//  Created by Nick Wang on 19/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

enum AnimationStatus {
    case normal
    case animating
    case pause
}

class NKLoadingView: UIView {
    
    // 线的宽度
    var lineWidth: CGFloat = 0
    // 线的长度
    var lineLength: CGFloat = 0
    // 边距
    var margin: CGFloat = 0
    // 动画时间
    var duration: Double = 3
    // 四条线的颜色
    var colors: [UIColor] = [.red,.yellow,.blue,.green]
    // 动画的状态
    private(set) var status: AnimationStatus = .normal
    // 四条线
    private var lines: [CAShapeLayer] = []
    
    // MARK: Public Methods
    func startAnimation()  {
        angleAnimation()
        lineAnimationOne()
        lineAnimationTwo()
        lineAnimationThree()
    }
    // MARK: Initial Methods
    convenience init(frame:CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = colors
        config()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
        backgroundColor = UIColor.black
        startAnimation()
    }
    
   private func config() {
        lineLength = max(frame.width, frame.height)
        lineWidth = lineLength/6.0
        margin = lineLength/4.5 + lineWidth/2
        drawShapeLayer()
        transform = CGAffineTransform.identity.rotated(by: (-30 * (.pi / 180)))
    }
    private func drawShapeLayer(){
        let startPoints = [point(lineWidth/2, margin),
                          point(lineLength-margin, lineWidth/2),
                          point(lineLength-lineWidth/2, lineLength-margin),
                          point(margin, lineLength-lineWidth/2)]
        let endPoints = [point(lineLength-lineWidth/2, margin),
                        point(lineLength-margin, lineLength-lineWidth/2),
                        point(lineWidth/2, lineLength-margin),
                        point(margin, lineWidth/2)]
        for i in 0...(startPoints.count-1) {
            let line = CAShapeLayer()
            line.lineWidth = lineWidth
            line.lineCap = kCALineCapRound
            line.opacity = 0.8
            line.strokeColor = colors[i].cgColor
            line.path = makeLinePath(startPoint: startPoints[i], endPoint: endPoints[i]).cgPath
            layer.addSublayer(line)
            lines.append(line)
        }
    }
    private func makeLinePath(startPoint: CGPoint, endPoint: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path
    }
    // MARK:旋转动画（旋转两周）
    private func angleAnimation(){
        let angleAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        angleAnimation.beginTime = CACurrentMediaTime()
        angleAnimation.fromValue = -30 * (CGFloat.pi / 180)
        angleAnimation.toValue = 690 * (CGFloat.pi / 180)
        angleAnimation.fillMode = kCAFillModeForwards
        angleAnimation.isRemovedOnCompletion = false
        angleAnimation.duration = duration
        layer.add(angleAnimation, forKey: "angleAnimation")
    }
    // MARK:线的缩短动画
    private func lineAnimationOne(){
        let lineAnimationOne = CABasicAnimation(keyPath: "strokeEnd")
        lineAnimationOne.beginTime = CACurrentMediaTime()
        lineAnimationOne.duration = duration/2
        lineAnimationOne.fillMode = kCAFillModeForwards
        lineAnimationOne.isRemovedOnCompletion = false
        lineAnimationOne.fromValue = 1
        lineAnimationOne.toValue = 0
        for i in 0...3 {
            let lineLayer = lines[i]
            lineLayer.add(lineAnimationOne, forKey: "lineAnimationOne")
        }
    }
    // MARK:线向中间平移
    private func lineAnimationTwo(){
        for i in 0...3 {
            var keypath = "transform.translation.x"
            if i%2 == 1 {
                keypath = "transform.translation.y"
            }
            let lineAnimationTwo = CABasicAnimation(keyPath: keypath)
            lineAnimationTwo.beginTime = CACurrentMediaTime() + duration/2
            lineAnimationTwo.duration = duration/4
            lineAnimationTwo.fillMode = kCAFillModeForwards
            lineAnimationTwo.isRemovedOnCompletion = false
            lineAnimationTwo.autoreverses = true
            lineAnimationTwo.fromValue = 0
            if i<2 {
                lineAnimationTwo.toValue = lineLength/4
            }else {
                lineAnimationTwo.toValue = -lineLength/4
            }
            lines[i].add(lineAnimationTwo, forKey: "lineAnimationTwo")
        }
        //三角形两边的比例
        let scale = (lineLength - 2*margin)/(lineLength - lineWidth)
        for i in 0...3 {
            var keypath = "transform.translation.y"
            if i%2 == 1 {
                keypath = "transform.translation.x"
            }
            let lineAnimationTwo                   = CABasicAnimation.init(keyPath: keypath)
            lineAnimationTwo.beginTime             = CACurrentMediaTime() + duration/2
            lineAnimationTwo.duration              = duration/4
            lineAnimationTwo.fillMode              = kCAFillModeForwards
            lineAnimationTwo.isRemovedOnCompletion = false
            lineAnimationTwo.autoreverses          = true
            lineAnimationTwo.fromValue             = 0
            if i == 0 || i == 3 {
                lineAnimationTwo.toValue = lineLength/4 * scale
            }else {
                lineAnimationTwo.toValue = -lineLength/4 * scale
            }
            let lineLayer = lines[i]
            lineLayer.add(lineAnimationTwo, forKey: "lineAnimationThree")
        }
    }
    
    /**
     线的第三步动画，线由短变长
     */
    private func lineAnimationThree() {
        //线移动的动画
        let lineAnimationFour                   = CABasicAnimation.init(keyPath: "strokeEnd")
        lineAnimationFour.beginTime             = CACurrentMediaTime() + duration
        lineAnimationFour.duration              = duration/4
        lineAnimationFour.fillMode              = kCAFillModeForwards
        lineAnimationFour.isRemovedOnCompletion = false
        lineAnimationFour.fromValue             = 0
        lineAnimationFour.toValue               = 1
        for i in 0...3 {
            if i == 3 {
                lineAnimationFour.delegate = self
            }
            let lineLayer = lines[i]
            lineLayer.add(lineAnimationFour, forKey: "lineAnimationFour")
        }
    }
    
    func point(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
}
extension NKLoadingView: CAAnimationDelegate{
    
    //MARK: Animation Delegate
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animation = anim as? CABasicAnimation {
            if animation.keyPath == "strokeEnd" {
                startAnimation()
            }
        }
    }
}










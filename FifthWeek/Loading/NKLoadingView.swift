//
//  NKLoadingView.swift
//  Loading
//
//  Created by Nick Wang on 19/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit



class NKLoadingView: UIView {
    
    // 线的宽度
    var lineWidth: CGFloat = 0
    // 线的长度
    var lineLength: CGFloat = 0
    // 边距
    var margin: CGFloat = 0
    // 动画时间
    var duration: Double = 3
    //动画的间隔时间
    var interval:Double = 1
    // 四条线的颜色
    var colors: [UIColor] = [.red,.yellow,.blue,.green]
    // 动画的状态
    private(set) var status: AnimationStatus = .normal
    // 四条线
    private var lines: [CAShapeLayer] = []
    
    enum AnimationStatus {
        case normal
        case animating
        case pause
    }
    // MARK: Public Methods
    // 开始动画
    func startAnimation()  {
        angleAnimation()
        lineAnimationOne()
        lineAnimationTwo()
        lineAnimationThree()
        status = .animating
    }
    // 暂停动画
    func pauseAnimation()  {
        layer.pauseAnimation()
        for lineLayer in lines {
            lineLayer.pauseAnimation()
        }
        status = .pause
    }
    // 恢复动画
    func resumeAnimation() {
        layer.resumeAnimation()
        for lineLayer in lines {
            lineLayer.resumeAnimation()
        }
        status = .animating
    }
    // 结束动画
    func stopAnimation() {
        layer.removeAllAnimations()
        for lineLayer in lines {
            lineLayer.removeAllAnimations()
        }
        status = .normal
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
            let lineAnimation  =  CABasicAnimation(keyPath: keypath)
            lineAnimation.beginTime = CACurrentMediaTime() + duration/2
            lineAnimation.duration = duration/4
            lineAnimation.fillMode = kCAFillModeForwards
            lineAnimation.isRemovedOnCompletion = false
            lineAnimation.autoreverses = true
            lineAnimation.fromValue = 0
            if i == 0 || i == 3 {
                lineAnimation.toValue = lineLength/4 * scale
            }else {
                lineAnimation.toValue = -lineLength/4 * scale
            }
            lines[i].add(lineAnimation, forKey: "lineAnimation")
        }
        
    }
    
    // MARK:线由短变长
    private func lineAnimationThree() {
        let lineAnimationThree = CABasicAnimation(keyPath: "strokeEnd")
        lineAnimationThree.beginTime = CACurrentMediaTime() + duration
        lineAnimationThree.duration = duration/4
        lineAnimationThree.fillMode = kCAFillModeForwards
        lineAnimationThree.isRemovedOnCompletion = false
        lineAnimationThree.fromValue = 0
        lineAnimationThree.toValue = 1
        for i in 0...3 {
            if i == 3 {
                lineAnimationThree.delegate = self
            }
            let lineLayer = lines[i]
            lineLayer.add(lineAnimationThree, forKey: "lineAnimationThree")
        }
    }
   
    
    func point(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y)
    }
    deinit {
        print("loadingViewDeinit")
    }
}

extension NKLoadingView: CAAnimationDelegate{
    //MARK: Animation Delegate
    func animationDidStart(_ anim: CAAnimation) {
        if let animation = anim as? CABasicAnimation {
            if animation.keyPath == "transform.rotation.z" {
                status = .animating
            }
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animation = anim as? CABasicAnimation {
            if animation.keyPath == "strokeEnd" {
                if flag {
                    status = .normal
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(interval) * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                        if self.status != .animating {
                            self.startAnimation()
                        }
                    })
                }
            }
        }
    }
    
}
extension CALayer {
    // 暂停动画
    func pauseAnimation() {
        // 将当前时间CACurrentMediaTime转换为layer上的时间, 即将parent time转换为localtime
        let pauseTime   = convertTime(CACurrentMediaTime(), from: nil)
        // 设置layer的timeOffset, 在继续操作也会使用到
        timeOffset = pauseTime
        // localtime与parenttime的比例为0, 意味着localtime暂停了
        speed = 0
    }
    //继续动画
    func resumeAnimation() {
        let pausedTime = timeOffset
        speed          = 1
        timeOffset     = 0
        beginTime      = 0
        // 计算暂停时间
        let sincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        // local time相对于parent time时间的beginTime
        beginTime      = sincePause
    }
    
}









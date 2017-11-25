//
//  ViewController.swift
//  RollerCoaster
//
//  Created by Nick Wang on 24/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    func k_SCREEN_HEIGHT() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    func k_LAND_BEGIN_HEIGHT() -> CGFloat {
        return k_SCREEN_HEIGHT() - CGFloat(20)
    }
    func k_SIZE() -> CGSize {
        return self.view.frame.size
    }
    
    var landLayer: CAShapeLayer = CAShapeLayer()
    var yellowTrackLayer: CAShapeLayer = CAShapeLayer()
    var greenTrackLayer: CAShapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 第一步.初始化渐变色天空
        initBlueSky()
        // 第二步.初始化雪山
        initSnowberg()
        // 第三步.初始化草地
        initLawn()
        // 第四步.初始化大地
        initLand()
        // 第五步.初始化黄色轨道
        initYellowTrack()
        // 第六步.初始化绿色轨道
        initGreenTrack()
        // 第七步.添加小树
        initTrees()
        // 第八步.添加云彩和动画
        initCloudAnimation()
        // 第九步.添加黄色车运动
        addCarAnimation(carImageName: "car", trackLayer: yellowTrackLayer, animationDuration: 8.0, beginTime: CACurrentMediaTime() + 1)
        // 第十步.添加绿色车运动
        addCarAnimation(carImageName: "otherCar", trackLayer: greenTrackLayer, animationDuration: 5.0, beginTime: CACurrentMediaTime())
    }
    func initBlueSky() {
        let blueSkyLayer = CAGradientLayer()
        // 渐变色天空的高度要减去屏幕下方地面的高度
        blueSkyLayer.frame = CGRect(x: 0, y: 0, width: k_SIZE().width, height: k_LAND_BEGIN_HEIGHT())
        let lightColor = UIColor(red: 40.0/255.0, green: 150.0/255.0, blue: 200.0/255.0, alpha: 1.0)
        let darkColor = UIColor(red: 255.0/255.0, green:250.0/255.0, blue:250.0/255.0, alpha:1.0)
        blueSkyLayer.colors = [lightColor.cgColor,darkColor.cgColor]
        
        // 让变色呈45度角度变色
        blueSkyLayer.startPoint = CGPoint(x: 0, y: 0)
        blueSkyLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(blueSkyLayer);
    }
    func initSnowberg(){
        // 左边的雪山,一个白色的大三角形
        let leftSnowberg = CAShapeLayer()
        let leftSnowbergPath = UIBezierPath()
        // 把leftSnowbergPath的起点移动到雪山左下角
        leftSnowbergPath.move(to: CGPoint(x: 0, y: k_SIZE().height - 120))
        // 画一条线到山顶
        leftSnowbergPath.addLine(to: CGPoint(x: 100, y: 100))
        // 画一条线到雪山右下角->左下角->闭合
        leftSnowbergPath.addLine(to: CGPoint(x: k_SIZE().width/2, y: k_LAND_BEGIN_HEIGHT()))
        leftSnowbergPath.addLine(to: CGPoint(x: 0, y: k_LAND_BEGIN_HEIGHT()))
        leftSnowbergPath.close()
        leftSnowberg.path = leftSnowbergPath.cgPath
        leftSnowberg.fillColor = UIColor.white.cgColor
        view.layer.addSublayer(leftSnowberg)
        
        // 左边雪山未被雪覆盖的部分
        let leftSnowbergBody = CAShapeLayer()
        let leftSnowbergBodyPath = UIBezierPath()
        let startPoint = CGPoint(x: 0, y: k_SIZE().height - 120)
        let endPoint = CGPoint(x: 100, y: 100)
        let firstPathPoint = getPointWithXValue(xValue: 20, startPoint: startPoint, endPoint: endPoint)
        leftSnowbergBodyPath.move(to: startPoint)
        leftSnowbergBodyPath.addLine(to: firstPathPoint)
        leftSnowbergBodyPath.addLine(to: CGPoint(x: 60, y: firstPathPoint.y))
        leftSnowbergBodyPath.addLine(to: CGPoint(x: 100, y: firstPathPoint.y + 30))
        leftSnowbergBodyPath.addLine(to: CGPoint(x: 140, y: firstPathPoint.y))
        leftSnowbergBodyPath.addLine(to: CGPoint(x: 180, y: firstPathPoint.y-20))
        let secondPathPoint = getPointWithXValue(xValue: k_SIZE().width / 2 - 125, startPoint: endPoint, endPoint: CGPoint(x: k_SIZE().width / 2, y: k_LAND_BEGIN_HEIGHT()))
        leftSnowbergBodyPath.addLine(to: secondPathPoint)
        leftSnowbergBodyPath.addLine(to: CGPoint(x: k_SIZE().width / 2, y: k_LAND_BEGIN_HEIGHT()))
        leftSnowbergBodyPath.addLine(to: CGPoint(x: 0, y: k_LAND_BEGIN_HEIGHT()))
        leftSnowbergBodyPath.close()
        leftSnowbergBody.path = leftSnowbergBodyPath.cgPath
        leftSnowbergBody.fillColor = UIColor(red: 139.0 / 255.0, green: 92.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0).cgColor
        view.layer.addSublayer(leftSnowbergBody)
        
        // 中间的山
        let midSnowberg = CAShapeLayer()
        let midSnowbergPath = UIBezierPath()
        let midStartPoint = CGPoint(x: k_SIZE().width / 3, y: k_LAND_BEGIN_HEIGHT())// 左山脚
        let midTopPoint = CGPoint(x: k_SIZE().width / 2, y: 200) // 山顶
        let midEndPoint = CGPoint(x: k_SIZE().width / 1.2, y: k_LAND_BEGIN_HEIGHT()) // 右山脚
        midSnowbergPath.move(to: midStartPoint)
        midSnowbergPath.addLine(to: midTopPoint)
        midSnowbergPath.addLine(to: midEndPoint)
        midSnowbergPath.close()
        midSnowberg.path = midSnowbergPath.cgPath
        midSnowberg.fillColor = UIColor.white.cgColor
        view.layer.addSublayer(midSnowberg)
        
        
        // 中间山未被雪覆盖部分
        let midSnowbergBody = CAShapeLayer()
        let midSnowbergBodyPath = UIBezierPath()
        midSnowbergBodyPath.move(to: midStartPoint)
        let midSnowbergBodyPathFirstPoint = getPointWithXValue(xValue: midStartPoint.x + 70, startPoint: midStartPoint, endPoint: midTopPoint)
        midSnowbergBodyPath.addLine(to: midSnowbergBodyPathFirstPoint)
        midSnowbergBodyPath.addLine(to: CGPoint(x: midSnowbergBodyPathFirstPoint.x + 20, y: midSnowbergBodyPathFirstPoint.y))
        midSnowbergBodyPath.addLine(to: CGPoint(x: midSnowbergBodyPathFirstPoint.x + 50, y: midSnowbergBodyPathFirstPoint.y + 30))
        midSnowbergBodyPath.addLine(to: CGPoint(x: midSnowbergBodyPathFirstPoint.x + 80, y: midSnowbergBodyPathFirstPoint.y - 10))
        midSnowbergBodyPath.addLine(to: CGPoint(x: midSnowbergBodyPathFirstPoint.x + 120, y: midSnowbergBodyPathFirstPoint.y + 20))
        let midSnowbergBodyPathSecondPoint = getPointWithXValue(xValue: midEndPoint.x - 120, startPoint: midTopPoint, endPoint: midEndPoint)
        midSnowbergBodyPath.addLine(to: CGPoint(x: midSnowbergBodyPathSecondPoint.x - 30, y: midSnowbergBodyPathSecondPoint.y))
        midSnowbergBodyPath.addLine(to: midSnowbergBodyPathSecondPoint)
        midSnowbergBodyPath.addLine(to: midEndPoint)
        midSnowbergBodyPath.close()
        midSnowbergBody.path = midSnowbergBodyPath.cgPath
        midSnowbergBody.fillColor = UIColor(red: 139.0 / 255.0, green: 92.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0).cgColor
        view.layer.addSublayer(midSnowbergBody)
        
    }
    func initLawn() {
        // 左边的草地
        let leftLawn = CAShapeLayer()
        let leftLawnPath = UIBezierPath()
        let leftLawnStartPoint = CGPoint(x: 0, y: k_LAND_BEGIN_HEIGHT())
        leftLawnPath.move(to: leftLawnStartPoint)
        leftLawnPath.addLine(to: CGPoint(x: 0, y: k_SIZE().height - 100))
        // 添加一条贝塞尔曲线
        leftLawnPath.addQuadCurve(to: CGPoint(x:k_SIZE().width / 3, y: k_LAND_BEGIN_HEIGHT()), controlPoint: CGPoint(x: k_SIZE().width / 5, y: k_SIZE().height - 100))
        leftLawn.path = leftLawnPath.cgPath
        leftLawn.fillColor = UIColor(displayP3Red: 82.0 / 255.0, green: 177.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0).cgColor
        view.layer.addSublayer(leftLawn)
        // 右边的草地
        let rightLawn = CAShapeLayer()
        let rightLawnPath = UIBezierPath()
        rightLawnPath.move(to: leftLawnStartPoint)
        rightLawnPath.addQuadCurve(to: CGPoint(x:k_SIZE().width,y:k_SIZE().height - 80), controlPoint: CGPoint(x: k_SIZE().width / 2, y: k_SIZE().height - 100))
        rightLawnPath.addLine(to: CGPoint(x: k_SIZE().width, y: k_LAND_BEGIN_HEIGHT()))
        rightLawn.path = rightLawnPath.cgPath
        rightLawn.fillColor = UIColor(displayP3Red: 92.0/255.0, green: 195.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        view.layer.addSublayer(rightLawn)
    }
    // 根据y=kx+b,算出点的坐标
    func getPointWithXValue(xValue:CGFloat,startPoint:CGPoint,endPoint:CGPoint) -> CGPoint {
        //    求出两点连线的斜率
        let k = (endPoint.y - startPoint.y) / (endPoint.x - startPoint.x);
        let b = startPoint.y - startPoint.x * k
        let yValue = k * xValue + b
        return CGPoint(x: xValue, y: yValue)
    }
    func initLand() {
        landLayer.frame = CGRect(x: 0, y: k_LAND_BEGIN_HEIGHT(), width: k_SIZE().width, height: 20)
        landLayer.backgroundColor = UIColor(patternImage: UIImage(named: "ground")!).cgColor
        view.layer.addSublayer(landLayer)
    }
    func initYellowTrack() {
        yellowTrackLayer.lineWidth = 5
        yellowTrackLayer.strokeColor = UIColor(displayP3Red: 210.0 / 255.0, green: 179.0 / 255.0, blue: 54.0 / 255.0, alpha: 1.0).cgColor
        
        let trackPath = UIBezierPath()
        trackPath.move(to: CGPoint(x: 0, y: k_SIZE().height - 60))
        trackPath.addCurve(to: CGPoint(x:k_SIZE().width / 1.5,y:k_SIZE().height / 2.0 - 20), controlPoint1: CGPoint(x:k_SIZE().width / 6.0,y:k_SIZE().height - 200), controlPoint2: CGPoint(x:k_SIZE().width / 3.0,y:k_SIZE().height + 50))
        trackPath.addQuadCurve(to: CGPoint(x:k_SIZE().width + 50,y:k_SIZE().height / 3.0), controlPoint: CGPoint(x: k_SIZE().width - 100, y: 50))
        trackPath.addLine(to: CGPoint(x: k_SIZE().width + 10, y: k_SIZE().height + 10 ))
        trackPath.addLine(to: CGPoint(x: 0, y: k_SIZE().height + 10 ))
        yellowTrackLayer.path = trackPath.cgPath
        yellowTrackLayer.fillColor = UIColor(patternImage: UIImage(named: "yellow")!).cgColor
        view.layer.insertSublayer(yellowTrackLayer, below: landLayer)
        
        let trackLine = CAShapeLayer()
        trackLine.lineCap = kCALineCapRound
        trackLine.strokeColor = UIColor.white.cgColor
        trackLine.lineDashPattern = [1.0,6.0]
        trackLine.lineWidth = 2.5
        trackLine.fillColor = UIColor.clear.cgColor
        trackLine.path = trackPath.cgPath
        yellowTrackLayer.addSublayer(trackLine)
        
    }
    func initGreenTrack() {
        greenTrackLayer.lineWidth = 5
        greenTrackLayer.strokeColor = UIColor(displayP3Red: 0, green: 147.0 / 255.0, blue: 163.0 / 255.0, alpha: 1.0).cgColor
        
        let trackPath = UIBezierPath()
        trackPath.move(to: CGPoint(x: k_SIZE().width + 10, y: k_LAND_BEGIN_HEIGHT()))
        trackPath.addLine(to: CGPoint(x: k_SIZE().width + 10, y: k_SIZE().height - 70))
        trackPath.addQuadCurve(to: CGPoint(x: k_SIZE().width / 1.5, y: k_SIZE().height - 70), controlPoint: CGPoint(x: k_SIZE().width - 150, y: 200))
        trackPath.addArc(withCenter: CGPoint(x:k_SIZE().width / 1.6,y:k_SIZE().height - 140), radius: 70, startAngle: .pi/2, endAngle: .pi * 2.5, clockwise: true)
        trackPath.addCurve(to: CGPoint(x:0,y:k_SIZE().height - 100), controlPoint1: CGPoint(x:k_SIZE().width / 1.8 - 60,y:k_SIZE().height - 60), controlPoint2: CGPoint(x: 150, y: k_SIZE().height / 2.3))
        trackPath.addLine(to: CGPoint(x: -10, y: k_LAND_BEGIN_HEIGHT()))
        greenTrackLayer.path = trackPath.cgPath
        greenTrackLayer.fillColor = UIColor(patternImage: UIImage(named: "green")!).cgColor
        view.layer.addSublayer(greenTrackLayer)
        
    }
    func initTrees() {
        addTrees(number: 7, treeFrame: CGRect(x: 0, y: k_LAND_BEGIN_HEIGHT() - 20, width: 13, height: 23))
        addTrees(number: 7, treeFrame: CGRect(x: 0, y: k_LAND_BEGIN_HEIGHT() - 64, width: 18, height: 32))
        addTrees(number: 7, treeFrame: CGRect(x: 0, y: k_LAND_BEGIN_HEIGHT() - 90, width: 13, height: 23))
    }
    private func addTrees(number:Int,treeFrame:CGRect){
        let tree = UIImage(named: "tree")
        for index in 0...number {
            let treeLayer = CALayer()
            treeLayer.contents = tree?.cgImage
            treeLayer.frame = CGRect(x: k_SIZE().width - 50 * CGFloat(index) * CGFloat(arc4random_uniform(4) + 1 ), y: treeFrame.origin.y, width: treeFrame.size.width, height: treeFrame.size.height)
            view.layer.insertSublayer(treeLayer, above: greenTrackLayer)
        }
    }
    func initCloudAnimation() {
        let cloud = CALayer()
        cloud.contents = UIImage(named: "cloud")?.cgImage
        cloud.frame = CGRect(x: 0, y: 0, width: 63, height: 20)
        view.layer.addSublayer(cloud)
        
        let cloudPath = UIBezierPath()
        cloudPath.move(to: CGPoint(x: k_SIZE().width + 63, y: 50))
        cloudPath.addLine(to: CGPoint(x: -63, y: 50))
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = cloudPath.cgPath
        animation.duration = 30
        animation.autoreverses = false
        animation.repeatCount = Float.greatestFiniteMagnitude
        animation.calculationMode = kCAAnimationPaced
        
        cloud.add(animation, forKey: "CloudAnimation")
    }
    func addCarAnimation(carImageName: String, trackLayer: CAShapeLayer, animationDuration: TimeInterval, beginTime: TimeInterval) {
        let car = CALayer()
        car.frame = CGRect(x: 0, y: 0, width: 22, height: 15)
        car.contents = UIImage(named: carImageName)?.cgImage
        
        let ani = CAKeyframeAnimation(keyPath: "position")
        ani.path = trackLayer.path
        ani.duration = animationDuration
        ani.beginTime = beginTime
        ani.autoreverses = false
        ani.repeatCount = Float.greatestFiniteMagnitude
        ani.calculationMode = kCAAnimationPaced
        ani.rotationMode = kCAAnimationRotateAuto
        
        trackLayer .addSublayer(car)
        car.add(ani, forKey: "carAni")
    
    }
    

}



























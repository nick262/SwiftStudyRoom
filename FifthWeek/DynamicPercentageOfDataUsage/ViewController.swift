//
//  ViewController.swift
//  FifthWeek
//
//  Created by Nick Wang on 16/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var animationBtn: UIButton!
    @IBOutlet weak var currentValueLabel: UILabel!
    var timer = Timer()
    var currentProgressValue: Float = 0.0
    // 灰色圆环背景
    lazy var backgroundCircleLayer: CAShapeLayer = {
        let backgroundCircleLayer = CAShapeLayer()
        let circleBounds = CGRect(x: 0, y: 0, width: 300, height: 300)
        backgroundCircleLayer.bounds = circleBounds
        backgroundCircleLayer.position = CGPoint(x: circleBounds.width/2, y: circleBounds.height/2)
        let circlePath = UIBezierPath(ovalIn: circleBounds)
        backgroundCircleLayer.path = circlePath.cgPath
        backgroundCircleLayer.lineWidth = 10
        backgroundCircleLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundCircleLayer.fillColor = UIColor.clear.cgColor
        return backgroundCircleLayer
    }()
    // 蓝色进度环
    lazy var progressCircleLayer: CAShapeLayer = {
        let progressCircleLayer = CAShapeLayer()
        let circleBounds = CGRect(x: 0, y: 0, width: 300, height: 300)
        progressCircleLayer.bounds = circleBounds
        progressCircleLayer.position = CGPoint(x: circleBounds.width/2, y: circleBounds.height/2)
        let circlePath = UIBezierPath(ovalIn: circleBounds)
        progressCircleLayer.path = circlePath.cgPath
        progressCircleLayer.lineWidth = 10
        progressCircleLayer.strokeColor = UIColor.blue.cgColor
        progressCircleLayer.fillColor = UIColor.clear.cgColor
        progressCircleLayer.strokeStart = 0
        progressCircleLayer.strokeEnd = 0
        return progressCircleLayer
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
         progressView.layer.addSublayer(backgroundCircleLayer)
        progressView.layer.addSublayer(progressCircleLayer)
        animationBtn.addTarget(self, action: #selector(showProgress), for: .touchUpInside)
        
    }
    @objc private func showProgress() {
        
        self.currentValueLabel.text = "0.0%"
        self.currentProgressValue = 0
        self.progressCircleLayer.strokeEnd = 0
        
        let expectValue = (self.inputTextField.text! as NSString).floatValue
        
        if (inputTextField.text?.isEmpty)! || expectValue > 100 || expectValue < 0{
            print("请输入有效数字")
            return
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: {_ in
        
            if self.currentProgressValue > expectValue - 1 && self.currentProgressValue < expectValue{
                self.timer.invalidate()
                self.progressCircleLayer.strokeEnd = CGFloat(expectValue / 100)
                return
            }
            if self.currentProgressValue > expectValue {
                 self.timer.invalidate()
                return
            }
            self.progressCircleLayer.strokeEnd = CGFloat(self.currentProgressValue / 100)
            self.currentValueLabel.text = String(format:"%.1f%%",self.currentProgressValue)
            self.currentProgressValue += 1
            
        })
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}


//
//  ViewController.swift
//  AnalogClock
//
//  Created by Nick Wang on 07/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {    
    let secondHand = UIView()
    let minuteHand = UIView()
    let hourHand = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置表盘
        let dialLayer = CALayer()
        dialLayer.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        dialLayer.position = view.center
        dialLayer.contents = UIImage(named: "clock")?.cgImage
        view.layer.addSublayer(dialLayer)
        
        //设置秒针
        secondHand.backgroundColor = UIColor.red
        secondHand.bounds = CGRect(x: 0, y: 0, width: 1, height: 50)
        secondHand.center = view.center
        secondHand.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        view.addSubview(secondHand)
        
        //设置分针
        minuteHand.backgroundColor = UIColor.black
        minuteHand.bounds = CGRect(x: 0, y: 0, width: 2, height: 45)
        minuteHand.center = view.center
        minuteHand.layer.anchorPoint = CGPoint(x: 1, y: 1)
        view.addSubview(minuteHand)
        
        //设置时针
        hourHand.backgroundColor = UIColor.black
        hourHand.bounds = CGRect(x: 0, y: 0, width: 2, height: 35)
        hourHand.center = view.center
        hourHand.layer.anchorPoint = CGPoint(x: 1, y: 1)
        view.addSubview(hourHand)
        
        // 添加针盖
        let cover = UIView()
        cover.bounds = CGRect(x: 0, y: 0, width: 5, height: 5)
        cover.center = view.center
        cover.backgroundColor = UIColor.white
        cover.layer.borderWidth = 0.5
        cover.layer.cornerRadius = 2.5
        cover.layer.masksToBounds = true
        cover.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(cover)
        
        let link = CADisplayLink.init(target: self, selector: #selector(clockRunning))
        link.add(to: RunLoop.main, forMode: .commonModes)
        
       
    }
    
    @objc func clockRunning(){
        // 获取本地时区
        let timeZone = NSTimeZone.local
        // 获取日历
        var calendar = Calendar.current
        // 获取当前系统时间
        let date = NSDate()
        // 设置日历的时区
        calendar.timeZone = timeZone
        let componentsSet = Set<Calendar.Component>([.hour, .minute, .second])
        // 取出当前的时分秒
        let currentTime = calendar.dateComponents(componentsSet, from: date as Date)
        
        let angle = (.pi * 2 / 60) * CGFloat(currentTime.second!)
        secondHand.transform = CGAffineTransform(rotationAngle: angle)
        
        let muniteAngle = (.pi * 2 / 60) * CGFloat(currentTime.minute!)
        minuteHand.transform = CGAffineTransform(rotationAngle: muniteAngle)
        
        let hourAngle = (.pi * 2 / 12) * CGFloat(currentTime.hour!) + (.pi * 2 / 12 / 60 ) * CGFloat(currentTime.minute!)
        hourHand.transform = CGAffineTransform(rotationAngle: hourAngle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


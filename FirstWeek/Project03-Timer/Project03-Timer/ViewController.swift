//
//  ViewController.swift
//  Project03-Timer
//
//  Created by Nick Wang on 18/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer : DispatchSourceTimer?
    var a = 0.0
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var pauseBtn: UIButton!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var numLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        startBtn.setImage(UIImage(named:"play")?.tint(color: UIColor.white, blendMode: .destinationIn), for: .normal)
        startBtn.setImage(UIImage(named:"play")?.tint(color: UIColor.lightText, blendMode: .destinationIn), for: .highlighted)
        startBtn.addTarget(self, action: #selector(timerStart), for: .touchUpInside)
        pauseBtn.setImage(UIImage(named: "pause")?.tint(color: UIColor.white, blendMode: .destinationIn), for: .normal)
        pauseBtn.setImage(UIImage(named: "pause")?.tint(color: UIColor.lightText, blendMode: .destinationIn), for: .highlighted)
        pauseBtn.addTarget(self, action: #selector(timerPause), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(reset), for: .touchUpInside)
    }
    @objc func reset() {
        timer?.cancel()
        self.a = 0.0
        DispatchQueue.main.async {
            self.numLabel.text = String(format:"%.1f",self.a)
        }
    }
    @objc func timerStart() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer?.schedule(wallDeadline: .now(), repeating: .milliseconds(250), leeway: .milliseconds(100))
        timer?.setEventHandler {
            self.a += 0.1
            DispatchQueue.main.async {
                self.numLabel.text = String(format:"%.1f",self.a)
            }
        }
        timer?.resume()
    }
    @objc func timerPause() {
        timer?.cancel()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension UIImage {
    func tint(color: UIColor, blendMode: CGBlendMode) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.setFill()
        UIRectFill(rect)
        draw(in: rect, blendMode: blendMode, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
}


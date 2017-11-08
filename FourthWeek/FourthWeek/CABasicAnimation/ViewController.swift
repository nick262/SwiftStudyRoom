//
//  ViewController.swift
//  CABasicAnimation
//
//  Created by Nick Wang on 07/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var grayView: UIView!
    
    override func viewDidLoad() {
        titleLabel.text = "吓死宝宝了！"
        self.titleLabel.isHidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
            UIView.animate(withDuration: 0.9, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .transitionCurlUp, animations: {

                    self.yellowView.center = CGPoint(x: self.view.bounds.size.width - self.yellowView.center.x, y: self.yellowView.center.y + 30)
                    self.greenView.center = CGPoint(x: self.view.bounds.size.width - self.greenView.center.x, y: self.greenView.center.y + 30)
                    self.grayView.frame = CGRect(x: self.grayView.frame.origin.x, y: self.grayView.frame.origin.y, width: self.grayView.frame.width, height: 200)
                
            }, completion: { (finished) in
                UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .transitionCurlUp, animations: {
                    self.titleLabel.isHidden = false
                }, completion: nil)
            })
        
        }
        
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


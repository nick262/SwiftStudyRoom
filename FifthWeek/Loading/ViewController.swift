//
//  ViewController.swift
//  Loading
//
//  Created by Nick Wang on 17/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loadingView: NKLoadingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        loadingView.backgroundColor = UIColor.black
        loadingView.startAnimation()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch loadingView.status {
        case .animating:
            loadingView.pauseAnimation()
        case .pause:
            loadingView.resumeAnimation()
        case .normal:
            loadingView.startAnimation()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


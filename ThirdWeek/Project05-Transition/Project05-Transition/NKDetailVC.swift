//
//  NKDetailVC.swift
//  Project05-Transition
//
//  Created by Nick Wang on 05/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class NKDetailVC: UIViewController {

    var image: UIImage! {
        didSet {
            setupUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.delegate = self
    }
    
    lazy var imgView: UIImageView = {
        let iv = UIImageView.init(frame: view.bounds)
        return iv
    }()
    
    
    fileprivate func setupUI() {
        
        view.addSubview(imgView)
        imgView.backgroundColor = UIColor.lightGray
        title = "Raikou"
    }
   
}
extension NKDetailVC: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return NKPopTransition()
        } else {
            return nil
        }
    }
    
}

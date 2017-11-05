//
//  ViewController.swift
//  Project05-Transition
//
//  Created by Nick Wang on 05/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var selectedCell: NKCollectionViewCell!
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! NKCollectionViewCell
        cell.imgView.image = UIImage(named: "\(indexPath.row % 6 + 1)")
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = NKDetailVC()
        selectedCell = (collectionView.cellForItem(at: indexPath) as! NKCollectionViewCell)
        detailVC.image = selectedCell?.imgView.image
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return NKMoveTransition()
        } else {
            return nil
        }
    }
}




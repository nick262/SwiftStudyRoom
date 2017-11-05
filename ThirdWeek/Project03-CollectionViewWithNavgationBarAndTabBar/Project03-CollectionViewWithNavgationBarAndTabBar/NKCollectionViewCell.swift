//
//  NKCollectionViewCell.swift
//  Project03-CollectionViewWithNavgationBarAndTabBar
//
//  Created by Nick Wang on 04/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class NKCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tagBtn: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
    }
    @objc func btnClicked(){
        tagBtn.isSelected = !tagBtn.isSelected
    }

}

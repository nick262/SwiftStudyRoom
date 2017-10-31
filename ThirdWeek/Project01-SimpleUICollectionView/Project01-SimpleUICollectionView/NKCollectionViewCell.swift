//
//  NKCollectionViewCell.swift
//  Project01-SimpleUICollectionView
//
//  Created by Nick Wang on 30/10/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class NKCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var label: UILabel!
    let screenWidth = UIScreen.main.bounds.size.width

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

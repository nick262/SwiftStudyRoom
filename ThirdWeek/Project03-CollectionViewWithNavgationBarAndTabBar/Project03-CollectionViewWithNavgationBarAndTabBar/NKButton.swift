//
//  NKButton.swift
//  Project03-CollectionViewWithNavgationBarAndTabBar
//
//  Created by Nick Wang on 02/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class NKButton: UIButton {

    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        super.imageRect(forContentRect: contentRect)
        return CGRect(x:0.0, y:0.0, width:self.frame.size.width, height:self.frame.size.height)
    }
}

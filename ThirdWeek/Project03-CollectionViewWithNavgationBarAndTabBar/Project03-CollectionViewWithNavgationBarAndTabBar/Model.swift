//
//  Model.swift
//  Project03-CollectionViewWithNavgationBarAndTabBar
//
//  Created by Nick Wang on 04/11/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class Model {
   var width: Int
    var height: Int
    var tag: Bool
    var img: String
    init(width:Int, height:Int, tag:Bool, img: String) {
        self.width = width
        self.height = height
        self.tag = tag
        self.img = img
    }
}

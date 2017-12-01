//
//  Item.swift
//  AsynchronousLoading
//
//  Created by Nick Wang on 01/12/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//

import UIKit

class Item {
    /// Item的编号
    let count: Int
    /// 初始化方法
    init(number: Int) {
        count = number
    }
    
    /// 类方法
    ///
    /// - Parameter count: 传入需要创建的Item数量
    /// - Returns: 返回创建好的Item数组, 元素编号从1到总数量
    static func creatItems(count: Int) -> [Item] {
        var items = [Item]()
        for index in 1...count {
            items.append(Item(number: index))
        }
        return items
    }
    
    /// 实例方法
    ///
    /// - Returns: 返回item的图片地址
    func imageUrl() -> URL? {
        return URL(string:"https://placeholdit.imgix.net/~text?txtsize=33&txt=image+\(count)&w=300&h=300")
    }
}

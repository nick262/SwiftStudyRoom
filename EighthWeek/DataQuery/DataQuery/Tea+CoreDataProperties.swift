//
//  Tea+CoreDataProperties.swift
//  DataQuery
//
//  Created by Nick Wang on 13/12/2017.
//  Copyright © 2017 Nick Wang. All rights reserved.
//
//

import Foundation
import CoreData


extension Tea {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tea> {
        return NSFetchRequest<Tea>(entityName: "Tea")
    }

    @NSManaged public var price: String?
    @NSManaged public var distance: Int16
    @NSManaged public var name: String?
    @NSManaged public var tier: Int16

}

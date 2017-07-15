//
//  Entity+CoreDataProperties.swift
//  test
//
//  Created by vika on 7/13/17.
//  Copyright © 2017 vika. All rights reserved.
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var sound: String?
    @NSManaged public var soundName: String?
    @NSManaged public var soundImage: String?

}

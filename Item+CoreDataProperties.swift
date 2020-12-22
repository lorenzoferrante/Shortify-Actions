//
//  Item+CoreDataProperties.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String
    @NSManaged public var category: UUID?
    @NSManaged public var link: String

}

extension Item : Identifiable {

}

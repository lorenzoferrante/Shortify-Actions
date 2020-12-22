//
//  Category+CoreDataProperties.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var colorType: Int16
    @NSManaged public var icon: String

}

extension Category : Identifiable {

}

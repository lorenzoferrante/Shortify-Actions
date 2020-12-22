//
//  Persistence.swift
//  Shortify Actions
//
//  Created by Lorenzo Ferrante on 11/13/20.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let newCategory = Category(context: viewContext)
        newCategory.name = "Videos"
        newCategory.id = UUID()
        newCategory.colorType = CustomColors.Orange.rawValue
        newCategory.icon = ""
        
        let newItem = Item(context: viewContext)
        newItem.category = newCategory.id
        newItem.id = UUID()
        newItem.title = "DuckDuck Go"
        newItem.link = "https://duckduckgo.com"
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Shortify_Actions")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    public func addNewCategory(category: CategoryField) {
        let newCategory = Category(context: self.container.viewContext)
        newCategory.id = UUID()
        newCategory.name = category.name
        newCategory.icon = category.icon
        newCategory.colorType = category.color.rawValue
        saveData()
    }
    
    public func addNewAction(action: ActionField) {
        let newAction = Item(context: self.container.viewContext)
        newAction.category = action.category
        newAction.title = action.title
        newAction.link = action.link
        newAction.id = UUID()
        saveData()
    }
    
    public func editAction(action: ActionField) {
        let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        do {
            let items = try self.container.viewContext.fetch(fetchRequest) as [Item]
            for item in items {
                if item.id == action.id {
                    item.title = action.title
                    item.link = action.link
                    saveData()
                }
            }
        } catch {
            print("Unable to fetch items!")
        }
    }
    
    private func saveData() {
        do {
            try self.container.viewContext.save()
        } catch {
            print("Error saving the new action")
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

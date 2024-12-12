//
//  CoreDataManager.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import CoreData
import Foundation
import UIKit

final class CoreDataManager: LocalDatabaseProtocol {
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Calendar")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func createNewEntity<T>(entityName: String) -> T? where T: NSManagedObject {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("Failed to find entity: \(entityName)")
            return nil
        }
        let object = T(entity: entityDescription, insertInto: context)
        return object
    }

    func fetchObjects<T>(entityName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [T]? where T: NSManagedObject {
        let request = NSFetchRequest<T>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors

        do {
            return try context.fetch(request)
        } catch {
            print("Failed to fetch data: \(error)")
            return nil
        }
    }

    func deleteObject<T: NSManagedObject>(_ object: T) {
        context.delete(object)
        saveContext()
    }

    func deleteAll(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error deleting all objects in \(entityName): \(error)")
        }
    }
}

//
//  CoreDataManager.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import CoreData
import Foundation
import RxCocoa
import RxSwift
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

    func createNewEntity(entityName: String) -> EventItem? {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            print("Failed to find entity: \(entityName)")
            return nil
        }
        let object = NSManagedObject(entity: entityDescription, insertInto: context)
        saveContext()
        return EventItem(from: object)
    }

    func saveEventItem(object: EventItem) {
        let managedObject = context.object(with: object.id)
        managedObject.setValue(object.title, forKey: "title")
        managedObject.setValue(object.startDate, forKey: "startDate")
        managedObject.setValue(object.endDate, forKey: "endDate")
        managedObject.setValue(object.isCompleted, forKey: "isCompleted")
        saveContext()
    }

    func fetchObjects(entityName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Observable<[EventItem]?> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors

        return Observable.create { observer in
            do {
                let data = try self.context.fetch(request)
                observer.onNext(data.compactMap { EventItem(from: $0 as! NSManagedObject)
                })
            } catch {
                print("Failed to fetch data: \(error)")
                observer.onError(error)
            }

            return Disposables.create()
        }
    }

    func deleteObject(_ object: EventItem) {
        let managedObject = context.object(with: object.id)
        context.delete(managedObject)
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

//
//  LocalDatabaseProtocol.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//
import CoreData
import Foundation

protocol LocalDatabaseProtocol {
    func saveContext() throws
    func fetchObjects<T: NSManagedObject>(entityName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> [T]?
    func createNewEntity<T: NSManagedObject>(entityName: String) -> T?
    func deleteObject<T: NSManagedObject>(_ object: T)
    func deleteAll(entityName: String)
}

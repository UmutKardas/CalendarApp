//
//  LocalDatabaseProtocol.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import CoreData
import Foundation
import RxCocoa
import RxSwift

protocol LocalDatabaseProtocol {
    func saveContext() throws
    func saveEventItem(object: EventItem)
    func fetchObjects(entityName: String, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Observable<[EventItem]?>
    func createNewEntity(entityName: String) -> EventItem?
    func deleteObject(_ object: EventItem)
    func deleteAll(entityName: String)
}

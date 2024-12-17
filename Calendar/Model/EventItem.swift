//
//  Event.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 17.12.2024.
//

import CoreData
import Foundation

struct EventItem {
    var title: String
    var startDate: Date
    var endDate: Date
    var isCompleted: Bool
    var id: NSManagedObjectID

    init(from managedObject: NSManagedObject) {
        self.title = managedObject.value(forKey: "title") as? String ?? ""
        self.startDate = managedObject.value(forKey: "startDate") as? Date ?? Date()
        self.endDate = managedObject.value(forKey: "endDate") as? Date ?? Date()
        self.isCompleted = managedObject.value(forKey: "isCompleted") as? Bool ?? false
        self.id = managedObject.objectID // objectID ile NSManagedObject'ı temsil ediyoruz
    }

    init(title: String, startDate: Date, endDate: Date, isCompleted: Bool, id: NSManagedObjectID) {
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.isCompleted = isCompleted
        self.id = id
    }
}

extension EventItem {
    static let coreDataEntityName = "Item"
}

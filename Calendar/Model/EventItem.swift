//
//  Event.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 17.12.2024.
//

import CoreData
import Foundation

struct EventItem {
    var eventId: String = UUID().uuidString
    var title: String
    var isCompleted: Bool
    var startDate: Date
    var endDate: Date
    var id: NSManagedObjectID?

    init(from managedObject: NSManagedObject) {
        self.title = managedObject.value(forKey: "title") as? String ?? ""
        self.isCompleted = managedObject.value(forKey: "isCompleted") as? Bool ?? false
        self.startDate = managedObject.value(forKey: "startDate") as? Date ?? Date()
        self.endDate = managedObject.value(forKey: "endDate") as? Date ?? Date()
        self.id = managedObject.objectID
    }

    init(title: String, isCompleted: Bool, startDate: Date, endDate: Date) {
        self.title = title
        self.isCompleted = isCompleted
        self.startDate = startDate
        self.endDate = endDate
        self.id = nil
    }
}

extension EventItem {
    static let coreDataEntityName = "Item"
}

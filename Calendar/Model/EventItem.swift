//
//  Event.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 17.12.2024.
//

import CoreData
import Foundation

struct EventItem {
    var day: Int
    var title: String
    var about: String
    var isCompleted: Bool
    var id: NSManagedObjectID?

    init(from managedObject: NSManagedObject) {
        self.day = managedObject.value(forKey: "day") as? Int ?? 1
        self.title = managedObject.value(forKey: "title") as? String ?? ""
        self.about = managedObject.value(forKey: "about") as? String ?? ""
        self.isCompleted = managedObject.value(forKey: "isCompleted") as? Bool ?? false
        self.id = managedObject.objectID
    }

    init(day: Int, title: String, about: String, isCompleted: Bool) {
        self.day = day
        self.title = title
        self.about = about
        self.isCompleted = isCompleted
        self.id = nil
    }
}

extension EventItem {
    static let coreDataEntityName = "Item"
}

//
//  Item.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import CoreData

@objc(Item)
public class Item: NSManagedObject {
    @NSManaged var title: String
    @NSManaged var startDate: Date
    @NSManaged var endDate: Date
    @NSManaged var isCompleted: Bool
}

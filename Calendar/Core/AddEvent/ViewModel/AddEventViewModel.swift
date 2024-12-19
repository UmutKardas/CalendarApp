//
//  AddEventViewModel.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 18.12.2024.
//

import Foundation
import RxCocoa
import RxSwift

final class AddEventViewModel {
    let title = BehaviorRelay<String>(value: "")
    let startDate = BehaviorRelay<TimeInterval>(value: 0)
    let endDate = BehaviorRelay<TimeInterval>(value: 0)
    let error = PublishSubject<String>()

    private var database: LocalDatabaseProtocol

    init(database: LocalDatabaseProtocol) {
        self.database = database
    }

    func addEvent() -> Bool {
        guard validate() else { return false }

        let startDate = Date(timeIntervalSince1970: self.startDate.value)
        let endDate = Date(timeIntervalSince1970: self.endDate.value)
            
        guard var eventItem = database.createNewEntity(entityName: EventItem.coreDataEntityName) else {
            error.onNext("Failed to create event")
            return false
        }

        eventItem.title = title.value
        eventItem.startDate = startDate
        eventItem.endDate = endDate
        database.saveEventItem(object: eventItem)

        return true
    }

    private func validate() -> Bool {
        if title.value.isEmpty {
            error.onNext("Title cannot be empty")
            return false
        }

        if startDate.value.isZero || endDate.value.isZero {
            error.onNext("Please select start and end dates")
            return false
        }

        if startDate.value >= endDate.value {
            error.onNext("End date must be after start date")
            return false
        }

        return true
    }
}

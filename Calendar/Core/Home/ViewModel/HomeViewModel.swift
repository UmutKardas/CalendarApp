//
//  HomeViewModel.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeViewModel {
    let groupedEvents = BehaviorSubject<[[EventItem]]?>(value: nil)

    private let database: LocalDatabaseProtocol
    private let disposeBag = DisposeBag()

    var currentDay: Int = Calendar.current.component(.day, from: Date())

    init(localDatabase: LocalDatabaseProtocol) {
        self.database = localDatabase
        fetchData()
    }

    private func fetchData() {
        database.fetchObjects(entityName: EventItem.coreDataEntityName, predicate: nil, sortDescriptors: nil)
            .subscribe(
                onNext: { [weak self] events in
                    let sortedEvents = events?.sorted(by: { $0.startDate < $1.startDate })

                    var groupedEvents: [[EventItem]] = []

                    sortedEvents?.forEach { event in
                        let dayOfMonth = self?.getDayOfMonth(from: event.startDate) ?? 0

                        if let index = groupedEvents.firstIndex(where: { self?.getDayOfMonth(from: $0.first?.startDate ?? Date()) == dayOfMonth }) {
                            groupedEvents[index].append(event)
                        }
                        else {
                            groupedEvents.append([event])
                        }
                    }

                    self?.groupedEvents.onNext(groupedEvents)

                },
                onError: { error in
                    print("Error fetching data: \(error.localizedDescription)")
                }
            )
            .disposed(by: disposeBag)
    }

    func getDayOfMonth(from date: Date) -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: date)
    }

    func dayDetails(for index: Int) -> (originalIndex: Int, day: Day) {
        let dayIndex = index % Day.allCases.count
        return (originalIndex: index + 1, day: Day.allCases[dayIndex])
    }

    func dayDetails(for eventItem: EventItem) -> (originalIndex: Int, day: Day) {
        guard let dayIndex = Calendar.current.dateComponents([.day], from: eventItem.startDate).day else {
            fatalError("Unable to extract day component from eventItem.startDate")
        }
        return dayDetails(for: dayIndex - 1)
    }

    func isEventInProgress(eventItem: EventItem) -> Bool {
        let currentDate = Date()
        return currentDate >= eventItem.startDate && currentDate <= eventItem.endDate
    }
}

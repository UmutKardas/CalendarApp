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
    let eventData: BehaviorSubject<[EventItem]?> = .init(value: nil)
    var currentDay: Int = Calendar.current.component(.day, from: Date())

    private var database: LocalDatabaseProtocol
    private let disposeBag = DisposeBag()

    init(localDatabase: LocalDatabaseProtocol) {
        self.database = localDatabase
        fetchData()
    }

    private func fetchData() {
        database.fetchObjects(entityName: EventItem.coreDataEntityName, predicate: nil, sortDescriptors: nil)
            .subscribe { [weak self] events in
                self?.eventData.onNext(events)
            } onError: { error in
                print("Error fetching data: \(error.localizedDescription)")
            }
            .disposed(by: disposeBag)
    }

    func getDayDetails(for index: Int) -> (originalIndex: Int, day: Day) {
        let dayIndex = index % Day.allCases.count
        return (originalIndex: index + 1, day: Day.allCases[dayIndex])
    }
}

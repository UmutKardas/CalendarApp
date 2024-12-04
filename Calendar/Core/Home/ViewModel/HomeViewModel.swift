//
//  HomeViewModel.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import Foundation

final class HomeViewModel {
    var currentDayValue: Int = Calendar.current.component(.day, from: Date())

    func fetchDayData(for index: Int) -> (originalIndex: Int, day: Day) {
        let dayIndex = index % Day.allCases.count
        return (originalIndex: index + 1, day: Day.allCases[dayIndex])
    }
}

//
//  AppContainer.swift
//  Calendar
//
//  Created by Hüseyin Umut Kardaş on 1.12.2024.
//

import Foundation
import Swinject

final class AppContainer {
    static let shared = AppContainer()
    private let container: Container = .init()

    var database: CoreDataManager {
        guard let instance = container.resolve(CoreDataManager.self) else {
            fatalError("CoreDataManager could not be resolved")
        }
        return instance
    }

    init() {
        registerDependencies()
    }

    private func registerDependencies() {
        container.register(CoreDataManager.self) { _ in CoreDataManager() }
    }
}

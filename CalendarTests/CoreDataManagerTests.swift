//
//  CoreDataManagerTests.swift
//  CalendarTests
//
//  Created by Hüseyin Umut Kardaş on 12.12.2024.
//

@testable import Calendar
import CoreData
import XCTest

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManager()
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
    }

    func testCreateNewEntity() throws {
        let newEntity = coreDataManager.createNewEntity(entityName: "Item")
        XCTAssertNotNil(newEntity, "Entity creation failed")

        let fetchedEntities = coreDataManager.fetchObjects(entityName: "Item", predicate: nil, sortDescriptors: nil)
        XCTAssertTrue(fetchedEntities!.contains(newEntity!), "Entity was not found in fetch")

        coreDataManager.deleteObject(newEntity!)
    }

    func testSaveContext() throws {
        let newEntity = coreDataManager.createNewEntity(entityName: "Item")
        coreDataManager.saveContext()

        if let fetchedEntities = coreDataManager.fetchObjects(entityName: "Item", predicate: nil, sortDescriptors: nil) {
            XCTAssertTrue(fetchedEntities.contains(newEntity!), "Entity was not saved")
        } else {
            XCTFail("Failed to fetch entities")
        }

        coreDataManager.deleteObject(newEntity!)
        coreDataManager.saveContext()

        if let fetchedEntities = coreDataManager.fetchObjects(entityName: "Item", predicate: nil, sortDescriptors: nil) {
            XCTAssertFalse(fetchedEntities.contains(newEntity!), "Entity was not deleted")
        } else {
            XCTFail("Failed to fetch entities after deletion")
        }
    }

    func testFetchObjects() throws {
        let newEntity = coreDataManager.createNewEntity(entityName: "Item")

        let entities = coreDataManager.fetchObjects(entityName: "Item", predicate: nil, sortDescriptors: nil)
        XCTAssertNotNil(entities, "Failed to fetch objects")
        XCTAssertTrue(entities!.contains(newEntity!), "Fetched objects do not contain the created entity")

        coreDataManager.deleteObject(newEntity!)
    }

    func testDeleteAll() throws {
        let newEntity1 = coreDataManager.createNewEntity(entityName: "Item")
        let newEntity2 = coreDataManager.createNewEntity(entityName: "Item")

        coreDataManager.saveContext()

        coreDataManager.deleteAll(entityName: "Item")

        let remainingEntities = coreDataManager.fetchObjects(entityName: "Item", predicate: nil, sortDescriptors: nil)
        XCTAssertEqual(remainingEntities?.count, 0, "Not all entities were deleted")
    }
}

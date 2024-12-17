//
//  CoreDataManagerTests.swift
//  CalendarTests
//
//  Created by Hüseyin Umut Kardaş on 12.12.2024.
//

@testable import Calendar
import CoreData
import RxCocoa
import RxSwift
import RxTest
import XCTest

final class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        coreDataManager = CoreDataManager()
        disposeBag = DisposeBag()
    }

    override func tearDownWithError() throws {
        coreDataManager = nil
        disposeBag = nil
    }

    func testCreateNewEntity_Success() throws {
        let newEntity = coreDataManager.createNewEntity(entityName: EventItem.coreDataEntityName)
        XCTAssertNotNil(newEntity, "Entity creation failed")
    }

    func testSaveEventItem_Success() throws {
        let newEntity = coreDataManager.createNewEntity(entityName: EventItem.coreDataEntityName)
        guard let entity = newEntity else {
            XCTFail("Entity creation failed")
            return
        }

        coreDataManager.saveEventItem(object: entity)

        let expectation = self.expectation(description: "Fetching entities")

        var fetchedEntities: [EventItem]? = nil

        coreDataManager.fetchObjects(entityName: EventItem.coreDataEntityName, predicate: nil, sortDescriptors: nil)
            .subscribe(onNext: { entities in
                fetchedEntities = entities
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(fetchedEntities, "Fetched entities should not be nil")
        XCTAssertTrue(fetchedEntities?.contains(where: { $0.id == entity.id }) == true, "Entity was not found in fetch")
    }

    func testDeleteObject_Success() throws {
        let newEntity = coreDataManager.createNewEntity(entityName: EventItem.coreDataEntityName)
        guard let entity = newEntity else {
            XCTFail("Entity creation failed")
            return
        }

        coreDataManager.saveEventItem(object: entity)
        coreDataManager.deleteObject(entity)

        let expectation = self.expectation(description: "Fetching entities")

        var fetchedEntities: [EventItem]? = nil

        coreDataManager.fetchObjects(entityName: EventItem.coreDataEntityName, predicate: nil, sortDescriptors: nil)
            .subscribe(onNext: { entities in
                fetchedEntities = entities
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertFalse(fetchedEntities?.contains(where: { $0.id == entity.id }) == true, "Entity was not deleted successfully")
    }

    func testDeleteAll_Success() throws {
        let newEntity1 = coreDataManager.createNewEntity(entityName: EventItem.coreDataEntityName)
        let newEntity2 = coreDataManager.createNewEntity(entityName: EventItem.coreDataEntityName)

        coreDataManager.saveContext()

        coreDataManager.deleteAll(entityName: EventItem.coreDataEntityName)

        let expectation = self.expectation(description: "Fetching entities")

        var fetchedEntities: [EventItem]? = nil

        coreDataManager.fetchObjects(entityName: EventItem.coreDataEntityName, predicate: nil, sortDescriptors: nil)
            .subscribe(onNext: { entities in
                fetchedEntities = entities
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertEqual(fetchedEntities?.count, 0, "Not all entities were deleted")
    }
}

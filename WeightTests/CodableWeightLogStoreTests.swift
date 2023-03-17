//
//  CodableWeightLogStoreTests.swift
//  WeightTests
//
//  Created by John Gers on 3/16/23.
//

import XCTest
import Weight

class CodableWeightLogStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        setupEmptyStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        
        undoStoreSideEffects()
    }
    
    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        
        expect(sut, toRetrieve: .empty)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()

        expect(sut, toRetrieveTwice: .empty)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
        let log = uniqueWeightLog().local
        let sut = makeSUT()
        
        save(log, to: sut)        
        expect(sut, toRetrieve: .found(log: log))
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        let log = uniqueWeightLog().local
        let sut = makeSUT()
        
        save(log, to: sut)
        expect(sut, toRetrieveTwice: .found(log: log))
    }
    
    func test_retrieve_deliversFailureOnRetrievalError() {
        let storeURL = testSpecificStoreURL()
        let sut = makeSUT(storeURL: storeURL)
        
        try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
    
        expect(sut, toRetrieve: .failure(anyNSError()))
    }
    
    func test_retrieve_hasNoSideEffectsOnRetrievalError() {
        let storeURL = testSpecificStoreURL()
        let sut = makeSUT(storeURL: storeURL)
        
        try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
    
        expect(sut, toRetrieveTwice: .failure(anyNSError()))
    }
    
    func test_save_appendsNewDataToPreviouslyInsertedCacheValues() {
        let sut = makeSUT()
        
        let log = uniqueWeightLog().local
        let firstSaveError = save(log, to: sut)
        XCTAssertNil(firstSaveError, "Expected to save cache successfully")

        let latestLog = uniqueWeightLog().local
        let latestSaveError = save(latestLog, to: sut)
        XCTAssertNil(latestSaveError, "Expected to append to cache successfully")
        
        expect(sut, toRetrieve: .found(log: latestLog + log))
    }
    
    func test_save_deliversErrorOnInsertionError() {
        let invalidStoreURL = URL(string: "invaid://store-url")!
        let sut = makeSUT(storeURL: invalidStoreURL)
        let log = uniqueWeightLog().local
        
        let saveError = save(log, to: sut)
        XCTAssertNotNil(saveError, "Expected to save cache successfully")
    }
    
    func test_delete_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed")
        expect(sut, toRetrieve: .empty)
    }
    
    func test_delete_emptiesPreviouslyInsertedCache() {
        let sut = makeSUT()
        save(uniqueWeightLog().local, to: sut)
        
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed")
        expect(sut, toRetrieve: .empty)
    }
    
    func test_delete_deliversErrorOnDeletionError() {
        let noDeletePermissionURL = cachesDirectory()
        let sut = makeSUT(storeURL: noDeletePermissionURL)
        
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNotNil(deletionError, "Expected cache deletion to fail")
        expect(sut, toRetrieve: .empty)
    }
    
    func test_storeSideEffect_runSerially() {
        let sut = makeSUT()
        var completedOperationsInOrder: [XCTestExpectation] = []
        
        let op1 = expectation(description: "Operation 1")
        sut.save(uniqueWeightLog().local) { _ in
            completedOperationsInOrder.append(op1)
            op1.fulfill()
        }
        
        let op2 = expectation(description: "Operation 2")
        sut.deleteCachedLog { _ in
            completedOperationsInOrder.append(op2)
            op2.fulfill()
        }
        
        let op3 = expectation(description: "Operation 3")
        sut.save(uniqueWeightLog().local) { _ in
            completedOperationsInOrder.append(op3)
            op3.fulfill()
        }
        
        waitForExpectations(timeout: 5.0)
        
        XCTAssertEqual(completedOperationsInOrder, [op1, op2, op3], "Expected side-effects to run serially but operations finished in the wrong order")
    }
    
    // - MARK: Helpers
    
    private func makeSUT(storeURL: URL? = nil, file: StaticString = #file, line: UInt = #line) -> CodableWeightLogStore {
        let sut = CodableWeightLogStore(storeURL: storeURL ?? testSpecificStoreURL())
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    @discardableResult
    private func save(_ cache: [LocalWeightItem], to sut: WeightLogStore, file: StaticString = #file, line: UInt = #line) -> Error? {
        let exp = expectation(description: "Wait for cache retrieval")
        
        var saveError: Error?
        sut.save(cache) { retrievedSaveError  in
            saveError = retrievedSaveError
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return saveError
    }
    
    private func deleteCache(from sut: WeightLogStore) -> Error? {
        let exp = expectation(description: "Wait for cache deletion")
        var deletionError: Error?
        sut.deleteCachedLog { deletionResult in
            switch deletionResult {
            case .success:
                deletionError = nil
            case let .failure(error):
                deletionError = error
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
        return deletionError
    }
    
    private func expect(_ sut: WeightLogStore, toRetrieveTwice expectedResult: RetrieveCachedLogResult, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }

    private func expect(_ sut: WeightLogStore, toRetrieve expectedResult: RetrieveCachedLogResult, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { retrievedResult in
            switch (expectedResult, retrievedResult) {
            case (.empty, .empty),
                (.failure, .failure):
                break
                
            case let (.found(expected), .found(retrieved)):
                XCTAssertEqual(retrieved, expected, file: file, line: line)
                
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }

    
    private func setupEmptyStoreState() {
        deleteStoreArtifacts()
    }
    
    private func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }
    
    private func deleteStoreArtifacts() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL())
    }
    
    private func testSpecificStoreURL() -> URL {
        cachesDirectory().appendingPathComponent("\(type(of: self)).store")
    }
    
    private func cachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    private func uniqueItem() -> WeightItem {
        return WeightItem(id: UUID(), weight: 100.0, date: Date())
    }
    
    private func uniqueWeightLog() -> (models: [WeightItem], local: [LocalWeightItem]) {
        let items = [uniqueItem()]
        let localItems = items.map { LocalWeightItem(id: $0.id, weight: $0.weight, date: $0.date) }
        return (items, localItems)
    }
}

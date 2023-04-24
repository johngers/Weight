//
//  XCTestCase+WeightItemStoreSpecs.swift
//  WeightTests
//
//  Created on 4/15/23.
//

import XCTest
import Weight

extension WeightItemStoreSpecs where Self: XCTestCase {
    
    func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieveTwice: .success(.none), file: file, line: line)
    }
    
    func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        let log = uniqueWeightLog().local
        
        save(log, to: sut)
        
        expect(sut, toRetrieve: .success(CachedLog(log)), file: file, line: line)
    }
    
    func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        let log = uniqueWeightLog().local
        
        save(log, to: sut)
        
        expect(sut, toRetrieveTwice: .success(CachedLog(log)), file: file, line: line)
    }
    
    func assertThatSaveDeliversNoErrorOnEmptyCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        let insertionError = save(uniqueWeightLog().local, to: sut)
        
        XCTAssertNil(insertionError, "Expected to insert cache successfully", file: file, line: line)
    }
    
    func assertThatSaveDeliversNoErrorOnNonEmptyCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        save(uniqueWeightLog().local, to: sut)
        
        let insertionError = save(uniqueWeightLog().local, to: sut)
        
        XCTAssertNil(insertionError, "Expected to override cache successfully", file: file, line: line)
    }
    
    
    func assertThatSaveAppendsNewDataToPreviouslyInsertedCacheValues(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        assertThatInsertOverridesPreviouslyInsertedCacheValues(on: sut, file: file, line: line)
    }
    
    func assertThatInsertOverridesPreviouslyInsertedCacheValues(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        save(uniqueWeightLog().local, to: sut)
        
        let latestLog = uniqueWeightLog().local
        save(latestLog, to: sut)
        
        expect(sut, toRetrieve: .success(CachedLog(latestLog)), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNil(deletionError, "Expected empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        deleteCache(from: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
    func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        save(uniqueWeightLog().local, to: sut)
        
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed", file: file, line: line)
    }
    
    func assertThatDeleteEmptiesPreviouslyInsertedCache(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        save(uniqueWeightLog().local, to: sut)
        
        deleteCache(from: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
    
    func assertThatSideEffectsRunSerially(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
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
        
        waitForExpectations(timeout: 3.0)
        
        XCTAssertEqual(completedOperationsInOrder, [op1, op2, op3], "Expected side-effects to run serially but operations finished in the wrong order")
    }
}

extension WeightItemStoreSpecs where Self: XCTestCase {
    @discardableResult
    func save(_ cache: [LocalWeightItem], to sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) -> Error? {
        let exp = expectation(description: "Wait for cache retrieval")
        
        var saveError: Error?
        sut.save(cache) { result  in
            if case let Result.failure(error) = result { saveError = error }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return saveError
    }
    
    @discardableResult
    func deleteCache(from sut: WeightItemStore) -> Error? {
        let exp = expectation(description: "Wait for cache deletion")
        var deletionError: Error?
        sut.deleteCachedLog { result in
            if case let Result.failure(error) = result { deletionError = error }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        return deletionError
    }
    
    func expect(_ sut: WeightItemStore, toRetrieveTwice expectedResult: WeightItemStore.RetrievalResult, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: WeightItemStore, toRetrieve expectedResult:  WeightItemStore.RetrievalResult, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { retrievedResult in
            switch (expectedResult, retrievedResult) {
            case (.success(.none), .success(.none)),
                (.failure, .failure):
                break
                
            case let (.success(.some(expected)), .success(.some(retrieved))):
                XCTAssertEqual(retrieved, expected, file: file, line: line)
                
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}

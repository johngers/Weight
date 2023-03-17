//
//  XCTestCase+WeightLogStoreSpecs.swift
//  WeightTests
//
//  Created by John Gers on 3/17/23.
//

import XCTest
import Weight

extension WeightLogStoreSpecs where Self: XCTestCase {
    
    @discardableResult
    func save(_ cache: [LocalWeightItem], to sut: WeightLogStore, file: StaticString = #file, line: UInt = #line) -> Error? {
        let exp = expectation(description: "Wait for cache retrieval")
        
        var saveError: Error?
        sut.save(cache) { retrievedSaveError  in
            saveError = retrievedSaveError
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return saveError
    }
    
    @discardableResult
    func deleteCache(from sut: WeightLogStore) -> Error? {
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
        wait(for: [exp], timeout: 5.0)
        return deletionError
    }
    
    func expect(_ sut: WeightLogStore, toRetrieveTwice expectedResult: RetrieveCachedLogResult, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }
    
    func expect(_ sut: WeightLogStore, toRetrieve expectedResult: RetrieveCachedLogResult, file: StaticString = #file, line: UInt = #line) {
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
}

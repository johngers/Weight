//
//  DeleteLogFromCacheUseCaseTests.swift
//  WeightTests
//
//  Created on 3/17/23.
//

import XCTest
import Weight

class DeleteFromCacheUseCaseTests: XCTestCase {
    
    func test_init_doesNotSendMessageUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_delete_requestsCacheDeletion() {
        let (sut, store) = makeSUT()
        
        sut.delete { _ in }
    
        XCTAssertEqual(store.receivedMessages, [.deleteCachedLog])
    }
    
    func test_delete_failsOnDeletionError() {
        let (sut, store) = makeSUT()
        let deletionError = anyNSError()

        expect(sut, toCompleteWith: .failure(deletionError), when: {
            store.completeDeletion(with: deletionError)
        })
    }
    
    func test_delete_deliversNoErrorEmptyCache() {
        let (sut, store) = makeSUT()

        expect(sut, toCompleteWith: .success(()), when: {
            store.completeDeletionWithEmptyCache()
        })
    }
    
    func test_delete_deliversNoErrorOnNonEmptyCache() {
        let (sut, store) = makeSUT()

        expect(sut, toCompleteWith: .success(()), when: {
            store.completeDeletionSuccessfully()
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let store = WeightLogStoreSpy()
        var sut: LocalWeightLogLoader? = LocalWeightLogLoader(store: store)
        
        var receivedResults: [LocalWeightLogLoader.LoadResult] = []
        sut?.load { receivedResults.append($0) }
        
        sut = nil
        store.completeRetrievalWithEmptyCache()
        XCTAssertTrue(receivedResults.isEmpty)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LocalWeightLogLoader, store: WeightLogStoreSpy) {
        let store = WeightLogStoreSpy()
        let sut = LocalWeightLogLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, store)
    }
    
    private func expect(_ sut: LocalWeightLogLoader, toCompleteWith expectedResult: LocalWeightLogLoader.DeleteResult, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")

        sut.delete { receivedResult in
            switch (receivedResult, expectedResult) {
            case (.success, .success):
                XCTAssertTrue(true, "Expected success, got success", file: file, line: line)
            case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail("Expected result \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }

        
        action()
        wait(for: [exp], timeout: 1.0)
    }
}

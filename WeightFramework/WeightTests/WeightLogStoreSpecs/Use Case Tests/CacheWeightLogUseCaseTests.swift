//
//  CacheWeightLogUseCase.swift
//  WeightTests
//
//  Created on 3/16/23.
//

import XCTest
import Weight

class CacheWeightLogUseCaseTests: XCTestCase {
    func test_init_doesNotSendMessageUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_delete_requestsCacheDeletion() {
        let (sut, store) = makeSUT()
        
        sut.delete { _ in }
        
        XCTAssertEqual(store.receivedMessages, [.deleteCachedLog])
    }
    
    func test_save_saves() {
        let (sut, store) = makeSUT()
        let log = uniqueWeightLog()
        
        sut.save(log.models) { _ in }

        XCTAssertEqual(store.receivedMessages, [.save(log.local)])
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LocalWeightLogLoader, store: WeightLogStoreSpy) {
        let store = WeightLogStoreSpy()
        let sut = LocalWeightLogLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut)
        return (sut, store)
    }
}

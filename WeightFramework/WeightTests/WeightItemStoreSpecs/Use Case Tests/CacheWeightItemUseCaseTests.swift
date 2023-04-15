//
//  CacheWeightItemUseCaseTests.swift
//  WeightTests
//
//  Created by John Gers on 4/15/23.
//

import XCTest
import Weight

class CacheWeightItemUseCaseTests: XCTestCase {
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
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LocalWeightItemLoader, store: WeightItemStoreSpy) {
        let store = WeightItemStoreSpy()
        let sut = LocalWeightItemLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut)
        return (sut, store)
    }
}

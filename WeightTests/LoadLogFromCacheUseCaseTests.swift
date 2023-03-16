//
//  LoadLogFromCacheUseCaseTests.swift
//  WeightTests
//
//  Created by John Gers on 3/16/23.
//

import XCTest
import Weight

class LoadLogFromCacheUseCaseTests: XCTestCase {
    
    func test_init_doesNotSendMessageUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LocalWeightLogLoader, store: WeightLogStoreSpy) {
        let store = WeightLogStoreSpy()
        let sut = LocalWeightLogLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut)
        return (sut, store)
    }
}

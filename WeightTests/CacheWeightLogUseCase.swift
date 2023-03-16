//
//  CacheWeightLogUseCase.swift
//  WeightTests
//
//  Created by John Gers on 3/16/23.
//

import XCTest
import Weight

class LocalWeightLogLoader {
    private let store: WeightLogStore

    init(store: WeightLogStore) {
        self.store = store
    }
    
    func save(_ items: [WeightItem]) {
        store.save(items)
    }
}

class WeightLogStore {
    enum ReceivedMessage: Equatable {
        case save([WeightItem])
    }

    private(set) var receivedMessages: [ReceivedMessage] = []
    
    func save(_ items: [WeightItem]) {
        receivedMessages.append(.save(items))
    }
}

class CacheWeightLogUseCaseTests: XCTestCase {
    func test_init_doesNotSendMessageUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_save_saves() {
        let items = [uniqueItem()]
        let (sut, store) = makeSUT()
        
        sut.save(items)

        XCTAssertEqual(store.receivedMessages, [.save(items)])
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LocalWeightLogLoader, store: WeightLogStore) {
        let store = WeightLogStore()
        let sut = LocalWeightLogLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut)
        return (sut, store)
    }
    
    private func uniqueItem() -> WeightItem {
        return WeightItem(id: UUID(), weight: 100.0, date: Date())
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}

//
//  CacheWeightLogUseCase.swift
//  WeightTests
//
//  Created by John Gers on 3/16/23.
//

import XCTest
import Weight

class CacheWeightLogUseCaseTests: XCTestCase {
    func test_init_doesNotSendMessageUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_save_saves() {
        let items = [uniqueItem()]
        let localItems = items.map { LocalWeightItem(id: $0.id, weight: $0.weight, date: $0.date) }
        let (sut, store) = makeSUT()
        
        sut.save(items) { _ in }

        XCTAssertEqual(store.receivedMessages, [.save(localItems)])
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: LocalWeightLogLoader, store: WeightLogStoreSpy) {
        let store = WeightLogStoreSpy()
        let sut = LocalWeightLogLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut)
        return (sut, store)
    }
    
    private class WeightLogStoreSpy: WeightLogStore {
        enum ReceivedMessage: Equatable {
            case save([LocalWeightItem])
        }

        private(set) var receivedMessages: [ReceivedMessage] = []
        private var saveCompletions: [SaveCompletion] = []
        
        func save(_ items: [LocalWeightItem], completion: @escaping SaveCompletion) {
            receivedMessages.append(.save(items))
            saveCompletions.append(completion)
        }
    }
    
    private func uniqueItem() -> WeightItem {
        return WeightItem(id: UUID(), weight: 100.0, date: Date())
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "any error", code: 0)
    }
}

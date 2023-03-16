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
    var saveCallCount = 0
    
    func save(_ items: [WeightItem]) {
        saveCallCount += 1
    }
}

class CacheWeightLogUseCaseTests: XCTestCase {
    func test_save_saves() {
        let items = [uniqueItem()]
        let (sut, store) = makeSUT()
        
        sut.save(items)

        XCTAssertEqual(store.saveCallCount, 1)
    }
    
    private func makeSUT() -> (sut: LocalWeightLogLoader, store: WeightLogStore) {
        let store = WeightLogStore()
        let sut = LocalWeightLogLoader(store: store)
        return (sut, store)
    }
    
    private func uniqueItem() -> WeightItem {
        return WeightItem(id: UUID(), weight: 100.0, date: Date())
    }
}

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
        let store = WeightLogStore()
        let sut = LocalWeightLogLoader(store: store)
        let items = [uniqueItem()]
        
        sut.save(items)

        XCTAssertEqual(store.saveCallCount, 1)
    }
    
    private func uniqueItem() -> WeightItem {
        return WeightItem(id: UUID(), weight: 100.0, date: Date())
    }
}

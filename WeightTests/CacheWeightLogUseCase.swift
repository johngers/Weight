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
        store.save(items) { [unowned self] error in
            if error == nil {
                self.store.insert(items)
            }
        }
    }
}

class WeightLogStore {
    typealias InsertionCompletion = (Error?) -> Void
    var saveCallCount = 0
    var insertCallCount = 0
    
    private var insertionCompletions: [InsertionCompletion] = []
    func save(_ items: [WeightItem], completion: @escaping InsertionCompletion) {
        saveCallCount += 1
        insertionCompletions.append(completion)
    }
    
    func completeInsertion(with error: Error, at index: Int = 0) {
        insertionCompletions[index](error)
    }
    
    func completeInsertionSuccessfully(at index: Int = 0) {
        insertionCompletions[index](nil)
    }
    
    func insert(_ items: [WeightItem]) {
        insertCallCount += 1
    }
}

class CacheWeightLogUseCaseTests: XCTestCase {
    func test_save_saves() {
        let items = [uniqueItem()]
        let (sut, store) = makeSUT()
        
        sut.save(items)

        XCTAssertEqual(store.saveCallCount, 1)
    }
    
    func test_save_doesNotSaveOnSaveError() {
        let items = [uniqueItem()]
        let (sut, store) = makeSUT()
        let saveError = anyNSError()
    
        sut.save(items)
        store.completeInsertion(with: saveError)
        
        XCTAssertEqual(store.insertCallCount, 0)
    }
    
    func test_save_requestsNewCacheInsertionOnSuccessfulInsertion() {
        let items = [uniqueItem()]
        let (sut, store) = makeSUT()

        sut.save(items)
        store.completeInsertionSuccessfully()
        
        XCTAssertEqual(store.insertCallCount, 1)
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

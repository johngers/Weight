//
//  CodableWeightLogStoreTests.swift
//  WeightTests
//
//  Created by John Gers on 3/16/23.
//

import XCTest
import Weight

class CodableWeightLogStore {
    private struct Cache: Codable {
        let log: [CodableWeightItem]
        
        var localLog: [LocalWeightItem] {
            return log.map { $0.local }
        }
    }
    
    private struct CodableWeightItem: Codable {
        private let id: UUID
        private let weight: Double
        private let date: Date
        
        init(_ item: LocalWeightItem) {
            id = item.id
            weight = item.weight
            date = item.date
        }
        
        var local: LocalWeightItem {
            return LocalWeightItem(id: id, weight: weight, date: date)
        }
    }
    
    private let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("weight-log.store")

    func retrieve(completion: @escaping WeightLogStore.RetrievalCompletion) {
        guard let data = try? Data(contentsOf: storeURL) else {
            return completion(.empty)
        }
    
        let decoder = JSONDecoder()
        let cache = try! decoder.decode(Cache.self, from: data)
        completion(.found(log: cache.localLog))
    }
    
    func insert(_ log: [LocalWeightItem], completion: @escaping WeightLogStore.SaveCompletion) {
        let encoder = JSONEncoder()
        let cache = Cache(log: log.map(CodableWeightItem.init))
        let encoded = try! encoder.encode(cache)
        try! encoded.write(to: storeURL)
        completion(nil)
    }
}

class CodableWeightLogStoreTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        
        let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("weight-log.store")
        try? FileManager.default.removeItem(at: storeURL)
    }

    override class func tearDown() {
        super.tearDown()
        
        let storeURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("weight-log.store")
        try? FileManager.default.removeItem(at: storeURL)
    }

    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = CodableWeightLogStore()
        let exp = expectation(description: "Wait for cache retrieval")

        sut.retrieve { result  in
            switch result {
            case .empty:
                break
            default:
                XCTFail("Expected empty result, got \(result) instead")
            }
            
            exp.fulfill()
        }
                        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = CodableWeightLogStore()
        let exp = expectation(description: "Wait for cache retrieval")

        sut.retrieve { firstResult  in
            sut.retrieve { secondResult  in
                switch (firstResult, secondResult) {
                case (.empty, .empty):
                    break
                default:
                    XCTFail("Expected retrieving twice from empty cache to deliver same empty result, got \(firstResult) and \(secondResult) instead")
                }
                
                exp.fulfill()
            }
        }
                        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_retrieveAfterInsertingToEmptyCache_deliversInsertedValues() {
        let log = uniqueWeightLog().local
        let sut = CodableWeightLogStore()
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.insert(log) { insertionError  in
            XCTAssertNil(insertionError, "Expected log to be inserted successfully")
    
            sut.retrieve { retrievedResult  in
                switch retrievedResult {
                case let .found(retrievedLog):
                    XCTAssertEqual(retrievedLog, log)
                default:
                    XCTFail("Expected found result with log \(log), got \(retrievedResult) instead")
                }
                
                exp.fulfill()
            }
        }
                        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func uniqueItem() -> WeightItem {
        return WeightItem(id: UUID(), weight: 100.0, date: Date())
    }
    
    private func uniqueWeightLog() -> (models: [WeightItem], local: [LocalWeightItem]) {
        let items = [uniqueItem()]
        let localItems = items.map { LocalWeightItem(id: $0.id, weight: $0.weight, date: $0.date) }
        return (items, localItems)
    }
}

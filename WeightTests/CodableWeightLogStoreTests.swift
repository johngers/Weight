//
//  CodableWeightLogStoreTests.swift
//  WeightTests
//
//  Created by John Gers on 3/16/23.
//

import XCTest
import Weight

class CodableWeightLogStore: WeightLogStore {    
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
    
    private let storeURL: URL
    
    init(storeURL: URL) {
        self.storeURL = storeURL
    }

    func retrieve(completion: @escaping WeightLogStore.RetrievalCompletion) {
        guard let data = try? Data(contentsOf: storeURL) else {
            return completion(.empty)
        }
    
        let decoder = JSONDecoder()
        let cache = try! decoder.decode(Cache.self, from: data)
        completion(.found(log: cache.localLog))
    }
    
    func save(_ log: [LocalWeightItem], completion: @escaping WeightLogStore.SaveCompletion) {
        let encoder = JSONEncoder()
        let cache = Cache(log: log.map(CodableWeightItem.init))
        let encoded = try! encoder.encode(cache)
        try! encoded.write(to: storeURL)
        completion(nil)
    }
}

class CodableWeightLogStoreTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        setupEmptyStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        
        undoStoreSideEffects()
    }
    
    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        
        expect(sut, toRetrieve: .empty)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
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
        let sut = makeSUT()
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.save(log) { insertionError  in
            XCTAssertNil(insertionError, "Expected log to be inserted successfully")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        
        expect(sut, toRetrieve: .found(log: log))
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        let log = uniqueWeightLog().local
        let sut = makeSUT()
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.save(log) { insertionError  in
            XCTAssertNil(insertionError, "Expected log to be inserted successfully")
            
            sut.retrieve { firstResult  in
                sut.retrieve { secondResult  in
                    switch (firstResult, secondResult) {
                    case let (.found(firstFound), .found(secondFound)):
                        XCTAssertEqual(firstFound, log)
                        XCTAssertEqual(secondFound, log)
                        
                    default:
                        XCTFail("Expected retrieving twice from non empty cache to deliver same found result with log \(log), got \(firstResult) and \(secondResult) instead")
                    }
                    
                    exp.fulfill()
                }
            }
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // - MARK: Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> CodableWeightLogStore {
        let sut = CodableWeightLogStore(storeURL: testSpecificStoreURL())
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func expect(_ sut: WeightLogStore, toRetrieve expectedResult: RetrieveCachedLogResult, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for cache retrieval")
        
        sut.retrieve { retrievedResult in
            switch (expectedResult, retrievedResult) {
            case (.empty, .empty),
                (.failure, .failure):
                break
                
            case let (.found(expected), .found(retrieved)):
                XCTAssertEqual(retrieved, expected, file: file, line: line)
                
            default:
                XCTFail("Expected to retrieve \(expectedResult), got \(retrievedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }

    
    private func setupEmptyStoreState() {
        deleteStoreArtifacts()
    }
    
    private func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }
    
    private func deleteStoreArtifacts() {
        try? FileManager.default.removeItem(at: testSpecificStoreURL())
    }
    
    private func testSpecificStoreURL() -> URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("\(type(of: self)).store")
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

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
    
        do {
            let decoder = JSONDecoder()
            let cache = try decoder.decode(Cache.self, from: data)
            completion(.found(log: cache.localLog))
        } catch {
            completion(.failure(error))
        }
    }
    
    func save(_ log: [LocalWeightItem], completion: @escaping WeightLogStore.SaveCompletion) {
        var cachedLog: [LocalWeightItem] = []
        retrieve(completion: { result in
            switch result {
            case .found(log: let log):
                cachedLog = log
            default:
                break
            }
        })
        
        do {
            let log = log + cachedLog
            let encoder = JSONEncoder()
            let cache = Cache(log: log.map(CodableWeightItem.init))
            let encoded = try! encoder.encode(cache)
            try encoded.write(to: storeURL)
            completion(nil)
        } catch {
            completion(error)
        }
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

        expect(sut, toRetrieveTwice: .empty)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
        let log = uniqueWeightLog().local
        let sut = makeSUT()
        
        save(log, to: sut)        
        expect(sut, toRetrieve: .found(log: log))
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        let log = uniqueWeightLog().local
        let sut = makeSUT()
        
        save(log, to: sut)
        expect(sut, toRetrieveTwice: .found(log: log))
    }
    
    func test_retrieve_deliversFailureOnRetrievalError() {
        let storeURL = testSpecificStoreURL()
        let sut = makeSUT(storeURL: storeURL)
        
        try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
    
        expect(sut, toRetrieve: .failure(anyNSError()))
    }
    
    func test_retrieve_hasNoSideEffectsOnRetrievalError() {
        let storeURL = testSpecificStoreURL()
        let sut = makeSUT(storeURL: storeURL)
        
        try! "invalid data".write(to: storeURL, atomically: false, encoding: .utf8)
    
        expect(sut, toRetrieveTwice: .failure(anyNSError()))
    }
    
    func test_save_appendsNewDataToPreviouslyInsertedCacheValues() {
        let sut = makeSUT()
        
        let log = uniqueWeightLog().local
        let firstSaveError = save(log, to: sut)
        XCTAssertNil(firstSaveError, "Expected to save cache successfully")

        let latestLog = uniqueWeightLog().local
        let latestSaveError = save(latestLog, to: sut)
        XCTAssertNil(latestSaveError, "Expected to append to cache successfully")
        
        expect(sut, toRetrieve: .found(log: latestLog + log))
    }
    
    func test_save_deliversErrorOnInsertionError() {
        let invalidStoreURL = URL(string: "invaid://store-url")!
        let sut = makeSUT(storeURL: invalidStoreURL)
        let log = uniqueWeightLog().local
        
        let saveError = save(log, to: sut)
        XCTAssertNotNil(saveError, "Expected to save cache successfully")
    }
    
    // - MARK: Helpers
    
    private func makeSUT(storeURL: URL? = nil, file: StaticString = #file, line: UInt = #line) -> CodableWeightLogStore {
        let sut = CodableWeightLogStore(storeURL: storeURL ?? testSpecificStoreURL())
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    @discardableResult
    private func save(_ cache: [LocalWeightItem], to sut: WeightLogStore, file: StaticString = #file, line: UInt = #line) -> Error? {
        let exp = expectation(description: "Wait for cache retrieval")
        
        var saveError: Error?
        sut.save(cache) { retrievedSaveError  in
            saveError = retrievedSaveError
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        return saveError
    }
    
    private func expect(_ sut: WeightLogStore, toRetrieveTwice expectedResult: RetrieveCachedLogResult, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
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

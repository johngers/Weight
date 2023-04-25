//
//  WeightItemIntegrationTests.swift
//  WeightTests
//
//  Created on 4/15/23.
//

import XCTest
import Weight

class WeightItemIntegrationTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        setupEmptyStoreState()
    }
    
    override func tearDown() {
        super.tearDown()
        
        undoStoreSideEffects()
    }
    
    func test_load_deliversNoItemsOnEmptyCache() {
        let sut = makeSUT()
        
        expect(sut, toLoad: nil)
    }
    
    func test_load_deliversItemsSavedOnASeparateInstance() {
        let sutToPerformSave = makeSUT()
        let sutToPerformLoad = makeSUT()
        let item = uniqueItem().model
        
        save(item, with: sutToPerformSave)
        
        expect(sutToPerformLoad, toLoad: item)
    }
    
    func test_save_overridesItemsSavedOnASeparateInstance() {
        let sutToPerformFirstSave = makeSUT()
        let sutToPerformLastSave = makeSUT()
        let sutToPerformLoad = makeSUT()
        let firstItem = uniqueItem().model
        let latestItem = uniqueItem().model

        save(firstItem, with: sutToPerformFirstSave)
        save(latestItem, with: sutToPerformLastSave)

        expect(sutToPerformLoad, toLoad: latestItem)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> LocalWeightItemLoader {
        let storeURL = storeURLForTests()
        let store = try! CoreDataStore(storeURL: storeURL)
        let sut = LocalWeightItemLoader(store: store)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
    
    private func expect(_ sut: LocalWeightItemLoader, toLoad expectedItem: WeightItem?, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case let .success(loadedItem):
                XCTAssertEqual(loadedItem, expectedItem, file: file, line: line)
            case let .failure(error):
                XCTFail("Expected successful log result, got \(error) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1.0)
    }
    
    private func save(_ item: WeightItem, with loader: LocalWeightItemLoader, file: StaticString = #file, line: UInt = #line) {
        let saveExp = expectation(description: "Wait for save completion")
        loader.save(item) { result in
            if case let Result.failure(error) = result {
                XCTAssertNil(error, "Expected to save feed successfully", file: file, line: line)
            }
            saveExp.fulfill()
        }
        wait(for: [saveExp], timeout: 1.0)
    }
    
    private func setupEmptyStoreState() {
        deleteStoreArtifacts()
    }

    private func undoStoreSideEffects() {
        deleteStoreArtifacts()
    }

    private func deleteStoreArtifacts() {
        try? FileManager.default.removeItem(at: storeURLForTests())
    }
    
    private func storeURLForTests() -> URL {
        return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
    }

    private func cachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
}

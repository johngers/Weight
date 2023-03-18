//
//  CoreDataWeightLogStoreTests.swift
//  WeightTests
//
//  Created by John Gers on 3/17/23.
//

import CoreData
import XCTest
@testable import Weight

class CoreDataWeightLogStoreTests: XCTestCase, WeightLogStoreSpecs {
    
    func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
    }
    
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
    }
    
    func test_save_deliversNoErrorOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatSaveDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_save_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatSaveDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    func test_save_appendsNewDataToPreviouslyInsertedCacheValues() {
        let sut = makeSUT()
        
        assertThatSaveAppendsNewDataToPreviouslyInsertedCacheValues(on: sut)
    }
    
    func test_delete_deliversNoErrorOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    func test_delete_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    func test_delete_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    func test_delete_emptiesPreviouslyInsertedCache() {
        let sut = makeSUT()
        
        assertThatDeleteEmptiesPreviouslyInsertedCache(on: sut)
    }
    
    func test_storeSideEffects_runSerially() {
        let sut = makeSUT()
        
        assertThatSideEffectsRunSerially(on: sut)
    }
    
    func test_invalid_deliversError() {
        do {
            let result = try makeInvalidSUT()
            XCTFail("Expected modelNotFoundError, got \(String(describing: result)) instead")
        } catch {
            XCTAssertEqual(error as NSError, NSPersistentContainer.LoadingError.modelNotFound as NSError)
        }
    }
    
    // - MARK: Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> WeightLogStore {
        let storeBundle = Bundle(for: CoreDataWeightLogStore.self)
        let storeURL = URL(fileURLWithPath: "/dev/null")
        let sut = try! CoreDataWeightLogStore(storeURL: storeURL, bundle: storeBundle)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
 
    private func makeInvalidSUT(file: StaticString = #file, line: UInt = #line) throws -> WeightLogStore {
        do {
            let invalidBundle = Bundle()
            let storeURL = URL(fileURLWithPath: "/dev/null")
            let sut = try CoreDataWeightLogStore(storeURL: storeURL, bundle: invalidBundle)
            trackForMemoryLeaks(sut, file: file, line: line)
            return sut
        } catch {
            throw NSPersistentContainer.LoadingError.modelNotFound
        }
    }
}

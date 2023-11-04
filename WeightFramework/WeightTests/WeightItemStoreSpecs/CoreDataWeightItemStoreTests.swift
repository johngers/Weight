//
//  CoreDataWeightItemStoreTests.swift
//  WeightTests
//
//  Created on 4/15/23.
//

import XCTest
@testable import Weight

class CoreDataWeightItemStoreTests: XCTestCase, WeightItemStoreSpecs {
    
    @MainActor func test_retrieve_deliversEmptyOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
    }
    
    @MainActor func test_retrieve_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    @MainActor func test_retrieve_deliversFoundValuesOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on: sut)
    }
    
    @MainActor func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on: sut)
    }
    
    @MainActor func test_save_deliversNoErrorOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatSaveDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    @MainActor func test_save_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatSaveDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    @MainActor func test_save_appendsNewDataToPreviouslyInsertedCacheValues() {
        let sut = makeSUT()
        
        assertThatSaveAppendsNewDataToPreviouslyInsertedCacheValues(on: sut)
    }
    
    @MainActor func test_delete_deliversNoErrorOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteDeliversNoErrorOnEmptyCache(on: sut)
    }
    
    @MainActor func test_delete_hasNoSideEffectsOnEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteHasNoSideEffectsOnEmptyCache(on: sut)
    }
    
    @MainActor func test_delete_deliversNoErrorOnNonEmptyCache() {
        let sut = makeSUT()
        
        assertThatDeleteDeliversNoErrorOnNonEmptyCache(on: sut)
    }
    
    @MainActor func test_delete_emptiesPreviouslyInsertedCache() {
        let sut = makeSUT()
        
        assertThatDeleteEmptiesPreviouslyInsertedCache(on: sut)
    }
    
    @MainActor func test_storeSideEffects_runSerially() {
        let sut = makeSUT()
        
        assertThatSideEffectsRunSerially(on: sut)
    }
    
    // - MARK: Helpers
    
    @MainActor private func makeSUT(file: StaticString = #file, line: UInt = #line) -> SwiftDataStore {
        let storeURL = URL(fileURLWithPath: "/dev/null")
        let sut = try! SwiftDataStore(storeURL: storeURL, isStoredInMemoryOnly: true)
     //   trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}

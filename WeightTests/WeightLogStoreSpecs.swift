//
//  WeightLogStoreSpecs.swift
//  WeightTests
//
//  Created by John Gers on 3/17/23.
//

import Foundation

protocol WeightLogStoreSpecs {
    func test_retrieve_deliversEmptyOnEmptyCache()
    func test_retrieve_hasNoSideEffectsOnEmptyCache()
    func test_retrieve_deliversFoundValuesOnNonEmptyCache()
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache()
 
    func test_save_deliversNoErrorOnEmptyCache()
    func test_save_deliversNoErrorNonEmptyCache()
    func test_save_appendsNewDataToPreviouslyInsertedCacheValues()

    func test_delete_deliversNoErrorOnEmptyCache()
    func test_delete_hasNoSideEffectsOnEmptyCache()
    func test_delete_deliversNoErrorOnNonEmptyCache()
    func test_delete_emptiesPreviouslyInsertedCache()

    func test_storeSideEffect_runSerially()
}

protocol FailableRetrieveWeightLogStoreSpecs: WeightLogStoreSpecs {
    func test_retrieve_deliversFailureOnRetrievalError()
    func test_retrieve_hasNoSideEffectsOnRetrievalError()
}

protocol FailableSaveWeightLogStoreSpecs: WeightLogStoreSpecs {
    func test_save_deliversErrorOnInsertionError()
    func test_save_hasNoSideEffectsOnInsertionError()
}

protocol FailableDeleteWeightLogStoreSpecs: WeightLogStoreSpecs {
    func test_delete_deliversErrorOnDeletionError()
    func test_delete_hasNoSideEffectsOnDeletionError()
}

typealias FailableWeightLogStoreSpecs = FailableRetrieveWeightLogStoreSpecs & FailableSaveWeightLogStoreSpecs & FailableDeleteWeightLogStoreSpecs

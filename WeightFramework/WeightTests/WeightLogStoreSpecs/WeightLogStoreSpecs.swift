//
//  WeightLogStoreSpecs.swift
//  WeightTests
//
//  Created on 3/17/23.
//

import Foundation

protocol WeightLogStoreSpecs {
    func test_retrieve_deliversEmptyOnEmptyCache()
    func test_retrieve_hasNoSideEffectsOnEmptyCache()
    func test_retrieve_deliversFoundValuesOnNonEmptyCache()
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache()
 
    func test_save_deliversNoErrorOnEmptyCache()
    func test_save_deliversNoErrorOnNonEmptyCache()
    func test_save_appendsNewDataToPreviouslyInsertedCacheValues()

    func test_delete_deliversNoErrorOnEmptyCache()
    func test_delete_hasNoSideEffectsOnEmptyCache()
    func test_delete_deliversNoErrorOnNonEmptyCache()
    func test_delete_emptiesPreviouslyInsertedCache()

    func test_storeSideEffects_runSerially()
}

protocol FailableRetrieveWeightLogStoreSpecs: WeightLogStoreSpecs {
    func test_retrieve_deliversFailureOnRetrievalError()
    func test_retrieve_hasNoSideEffectsOnRetrievalError()
}

protocol FailableSaveWeightLogStoreSpecs: WeightLogStoreSpecs {
    func test_save_deliversErrorOnSaveError()
    func test_save_hasNoSideEffectsOnSaveError()
}

protocol FailableDeleteWeightLogStoreSpecs: WeightLogStoreSpecs {
    func test_delete_deliversErrorOnDeletionError()
    func test_delete_hasNoSideEffectsOnDeletionError()
}

typealias FailableWeightLogStoreSpecs = FailableRetrieveWeightLogStoreSpecs & FailableSaveWeightLogStoreSpecs & FailableDeleteWeightLogStoreSpecs

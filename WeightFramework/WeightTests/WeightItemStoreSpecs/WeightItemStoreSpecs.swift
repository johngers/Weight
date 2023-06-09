//
//  WeightItemStoreSpecs.swift
//  WeightTests
//
//  Created on 4/15/23.
//

import Foundation

protocol WeightItemStoreSpecs {
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

protocol FailableRetrieveWeightItemStoreSpecs: WeightItemStoreSpecs {
    func test_retrieve_deliversFailureOnRetrievalError()
    func test_retrieve_hasNoSideEffectsOnRetrievalError()
}

protocol FailableSaveWeightItemStoreSpecs: WeightItemStoreSpecs {
    func test_save_deliversErrorOnSaveError()
    func test_save_hasNoSideEffectsOnSaveError()
}

protocol FailableDeleteWeightItemStoreSpecs: WeightItemStoreSpecs {
    func test_delete_deliversErrorOnDeletionError()
    func test_delete_hasNoSideEffectsOnDeletionError()
}

 typealias FailableWeightItemStoreSpecs = FailableRetrieveWeightItemStoreSpecs & FailableSaveWeightItemStoreSpecs & FailableDeleteWeightItemStoreSpecs

//
//  CodableWeightLogStoreTests.swift
//  WeightTests
//
//  Created by John Gers on 3/16/23.
//

import XCTest
import Weight

class CodableWeightLogStore {
    func retrieve(completion: @escaping WeightLogStore.RetrievalCompletion) {
        completion(.empty)
    }
}

class CodableWeightLogStoreTests: XCTestCase {

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
}

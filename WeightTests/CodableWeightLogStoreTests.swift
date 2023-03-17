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
}

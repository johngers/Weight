//
//  XCTestCase+FailableDeleteWeightLogStoreSpecs.swift
//  WeightTests
//
//  Created by John Gers on 3/17/23.
//

import XCTest
import Weight

extension FailableDeleteWeightLogStoreSpecs where Self: XCTestCase {
    func assertThatDeleteDeliversErrorOnDeletionError(on sut: WeightLogStore, file: StaticString = #file, line: UInt = #line) {
        let deletionError = deleteCache(from: sut)
        
        XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
    }
    
    func assertThatDeleteHasNoSideEffectsOnDeletionError(on sut: WeightLogStore, file: StaticString = #file, line: UInt = #line) {
        deleteCache(from: sut)
        
        expect(sut, toRetrieve: .success(.empty), file: file, line: line)
    }
}

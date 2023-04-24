//
//  XCTestCase+FailableRetrieveWeightLogStoreSpecs.swift
//  WeightTests
//
//  Created on 3/17/23.
//

import XCTest
import Weight

 extension FailableRetrieveWeightLogStoreSpecs where Self: XCTestCase {
     func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: WeightLogStore, file: StaticString = #file, line: UInt = #line) {
         expect(sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
     }

     func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: WeightLogStore, file: StaticString = #file, line: UInt = #line) {
         expect(sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
     }
 }

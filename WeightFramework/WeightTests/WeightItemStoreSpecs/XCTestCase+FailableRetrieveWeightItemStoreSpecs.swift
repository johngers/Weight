//
//  XCTestCase+FailableRetrieveWeightItemStoreSpecs.swift
//  WeightTests
//
//  Created by John Gers on 4/15/23.
//

import XCTest
import Weight

 extension FailableRetrieveWeightItemStoreSpecs where Self: XCTestCase {
     func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
         expect(sut, toRetrieve: .failure(anyNSError()), file: file, line: line)
     }

     func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
         expect(sut, toRetrieveTwice: .failure(anyNSError()), file: file, line: line)
     }
 }

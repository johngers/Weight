//
//  XCTestCase+FailableSaveWeightLogStoreSpecs.swift
//  WeightTests
//
//  Created by John Gers on 3/17/23.
//

import XCTest
import Weight

extension FailableSaveWeightLogStoreSpecs where Self: XCTestCase {
    
    func assertThatSaveDeliversErrorSaveError(on sut: WeightLogStore, file: StaticString = #file, line: UInt = #line) {
        let saveError = save(uniqueWeightLog().local, to: sut)
        

        XCTAssertNotNil(saveError, "Expected cache save to fail with an error", file: file, line: line)
    }
    
    func assertThatSaveHasNoSideEffectsOnSaveError(on sut: WeightLogStore, file: StaticString = #file, line: UInt = #line) {
        save(uniqueWeightLog().local, to: sut)
        
        expect(sut, toRetrieve: .success(.none), file: file, line: line)
    }
}

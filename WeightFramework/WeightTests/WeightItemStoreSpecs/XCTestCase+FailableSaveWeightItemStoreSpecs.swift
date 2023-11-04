//
//  XCTestCase+FailableSaveWeightItemStoreSpecs.swift
//  WeightTests
//
//  Created on 4/15/23.
//

import XCTest
import Weight

extension FailableSaveWeightItemStoreSpecs where Self: XCTestCase {
    
    func assertThatSaveDeliversErrorSaveError(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        let saveError = save(uniqueItem().local, to: sut)
        

        XCTAssertNotNil(saveError, "Expected cache save to fail with an error", file: file, line: line)
    }
    
    func assertThatSaveHasNoSideEffectsOnSaveError(on sut: WeightItemStore, file: StaticString = #file, line: UInt = #line) {
        save(uniqueItem().local, to: sut)
        
        expect(sut, toRetrieve: .success([]), file: file, line: line)
    }
}

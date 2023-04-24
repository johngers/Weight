//
//  ProgressCardViewSnapshotTests.swift
//  WeightiOSTests
//
//  Created on 3/18/23.
//

@testable import WeightiOS

import XCTest
import SwiftUI

// record
// assert

class ProgressCardViewSnapshotTests: XCTestCase {

//    func test_progressCardView_record() {
//        let sut = makeSUT()
//
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "progress_card_light")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "progress_card_dark")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "progress_card_light_extraExtraExtraLarge")
//    }
    
    func test_progressCardView_assert() {
        let sut = makeSUT()

        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "progress_card_light")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "progress_card_dark")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "progress_card_light_extraExtraExtraLarge")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> ProgressCardView {
        return ProgressCardView()
    }
}

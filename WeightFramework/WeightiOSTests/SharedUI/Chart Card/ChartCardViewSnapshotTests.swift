//
//  ChartCardViewSnapshotTests.swift
//  WeightiOSTests
//
//  Created by John Gers on 3/18/23.
//

@testable import WeightiOS

import XCTest
import SwiftUI

// record
// assert

class ChartCardViewSnapshotTests: XCTestCase {

//    func test_chartCardView_record() {
//        let sut = makeSUT()
//
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "chart_card_light")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "chart_card_dark")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "chart_card_light_extraExtraExtraLarge")
//    }
    
    func test_chartCardView_assert() {
        let sut = makeSUT()

        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "chart_card_light")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "chart_card_dark")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "chart_card_light_extraExtraExtraLarge")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> ChartCardView {
        return ChartCardView()
    }
}

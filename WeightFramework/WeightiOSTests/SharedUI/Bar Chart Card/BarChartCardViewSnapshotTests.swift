//
//  BarChartCardViewSnapshotTests.swift
//  WeightiOSTests
//
//  Created on 3/24/23.
//

@testable import WeightiOS

import XCTest
import SwiftUI

// record
// assert

class BarChartCardViewSnapshotTests: XCTestCase {

//    func test_chartCardView_record() {
//        let sut = makeSUT()
//
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "bar_chart_card_light")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "bar_chart_card_dark")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "bar_chart_card_light_extraExtraExtraLarge")
//    }
    
    func test_chartCardView_assert() {
        let sut = makeSUT()

        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "bar_chart_card_light")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "bar_chart_card_dark")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "bar_chart_card_light_extraExtraExtraLarge")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> BarChartCardView {
        return BarChartCardView(date: .init(timeIntervalSince1970: 1682296934))
    }
}

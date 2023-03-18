//
//  TabHeaderViewSnapshotTests.swift
//  WeightiOSTests
//
//  Created by John Gers on 3/18/23.
//

@testable import WeightiOS

import XCTest
import SwiftUI

// record
// assert

class TabHeaderViewSnapshotTests: XCTestCase {

//    func test_tabHeaderView_record() {
//        let sut = makeSUT()
//
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "tab_header_light")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "tab_header_dark")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "tab_header_light_extraExtraExtraLarge")
//    }
    
    func test_tabHeaderView_assert() {
        let sut = makeSUT()

        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "tab_header_light")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "tab_header_dark")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "tab_header_light_extraExtraExtraLarge")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> TabHeaderView {
        return TabHeaderView(imageName: "scalemass", title: "Statistics", tabTitle: "Weight", color: .systemMint, settingsSelection: { })
    }
}

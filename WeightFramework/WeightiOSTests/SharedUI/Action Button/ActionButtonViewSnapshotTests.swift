//
//  ActionButtonViewSnapshotTests.swift
//  WeightiOSTests
//
//  Created on 3/18/23.
//

@testable import WeightiOS

import XCTest
import SwiftUI

// record
// assert

class ActionButtonViewSnapshotTests: XCTestCase {

//    func test_actionButtonView_record() {
//        let sut = makeSUT()
//
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "action_button_light")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "action_button_dark")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "action_button_light_extraExtraExtraLarge")
//    }
    
    @MainActor func test_actionButtonView_assert() {
        let sut = makeSUT()

        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "action_button_light")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "action_button_dark")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "action_button_light_extraExtraExtraLarge")
    }
    
    // MARK: - Helpers
    
    @MainActor private func makeSUT() -> ActionButtonView {
        return ActionButtonView(buttonSelection: { })
    }
}

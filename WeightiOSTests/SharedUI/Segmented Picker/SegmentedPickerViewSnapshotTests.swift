//
//  SegmentedPickerViewSnapshotTests.swift
//  WeightiOSTests
//
//  Created by John Gers on 3/18/23.
//

@testable import WeightiOS

import XCTest
import SwiftUI
import UIKit

// record
// assert

class SegmentedPickerViewSnapshotTests: XCTestCase {

//    func test_segmentedPickerView_record() {
//        let sut = makeSUT()
//
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "seg_picker_light")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "seg_picker_dark")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "seg_picker_light_extraExtraExtraLarge")
//    }
    
//    func test_segmentedPickerView__assert() {
//        let sut = makeSUT()
//
//        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "seg_picker_light")
//        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "seg_picker_dark")
//        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "seg_picker_light_extraExtraExtraLarge")
//    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> SegmentedPickerView {
        return SegmentedPickerView(selectedUnit: .lb, options: [.lb, .kg], color: .systemMint)
    }
}



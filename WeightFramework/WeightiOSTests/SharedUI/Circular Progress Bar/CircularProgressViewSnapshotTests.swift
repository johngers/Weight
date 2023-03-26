//
//  CircularProgressViewSnapshotTests.swift
//  WeightiOSTests
//
//  Created by John Gers on 3/19/23.
//

@testable import WeightiOS

import XCTest
import SwiftUI

// record
// assert

class CircularProgressViewSnapshotTests: XCTestCase {

//    func test_circularProgressView_record() {
//        let sut = makeSUT()
//
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "circular_progress_light")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "circular_progress_dark")
//        record(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "circular_progress_light_extraExtraExtraLarge")
//    }
    
    func test_circularProgressView_assert() {
        let sut = makeSUT()

        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light)), named: "circular_progress_light")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .dark)), named: "circular_progress_dark")
        assert(snapshot: sut.snapshot(for: .iPhone14Pro(style: .light, contentSize: .extraExtraExtraLarge)), named: "circular_progress_light_extraExtraExtraLarge")
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> CircularProgressView {
        return CircularProgressView()
    }
}

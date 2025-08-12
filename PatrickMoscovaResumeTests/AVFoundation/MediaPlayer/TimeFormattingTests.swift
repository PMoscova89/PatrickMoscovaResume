//
//  TimeFormattingTests.swift
//  PatrickMoscovaResume
//
//  Created by Patrick Moscova on 8/11/25.
//


import XCTest
@testable import PatrickMoscovaResume

final class TimeFormattingTests: XCTestCase {
    func test_mmss_formatsProperly() {
        XCTAssertEqual(TimeFormatting.mmss(0), "0:00")
        XCTAssertEqual(TimeFormatting.mmss(5), "0:05")
        XCTAssertEqual(TimeFormatting.mmss(65), "1:05")
        XCTAssertEqual(TimeFormatting.mmss(600), "10:00")
    }
}
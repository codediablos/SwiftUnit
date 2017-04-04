//
//  AssertsTest.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 2016/9/26.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import XCTest
@testable import SwiftUnit

class AssertTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAssertTrueIsTrue() {
        let tc = WasAssert("testAssertTrueIsTrue")
        tc.run()
        XCTAssertEqual("", tc.result.details())
    }

    func testAssertTrueIsFalse() {
        let tc = WasAssert("testAssertTrueIsFalse")
        tc.run()
        XCTAssertEqual("WasAssert.testAssertTrueIsFalse is failed\nLine:23 - message(AssertTrue).\n", tc.result.details())
    }

    func testAssertFalseIsTrue() {
        let tc = WasAssert("testAssertFalseIsTrue")
        tc.run()
        XCTAssertEqual("WasAssert.testAssertFalseIsTrue is failed\nLine:27 - message(AssertFalse).\n", tc.result.details())
    }

    func testAssertFalseIsFalse() {
        let tc = WasAssert("testAssertFalseIsFalse")
        tc.run()
        XCTAssertEqual("", tc.result.details())
    }

    func testAssertEqualIsEqual() {
        let tc = WasAssert("testAssertEqualIsEqual")
        tc.run()
        XCTAssertEqual("1 run, 0 failed, 0 error", tc.result.summary())
        XCTAssertEqual("", tc.result.details())
    }

    func testAssertEqualIsNotEqual() {
        let tc = WasAssert("testAssertEqualIsNotEqual")
        tc.run()
        XCTAssertEqual("1 run, 1 failed, 0 error", tc.result.summary())
        XCTAssertEqual("WasAssert.testAssertEqualIsNotEqual is failed\nLine:39 (Expected) is not equal to (Actual) - message(AssertEqual).\n", tc.result.details())
    }

    func testAssertEqualMultipleFailed() {
        let tc = WasAssert("testAssertEqualMultipleFailed")
        tc.run()
        XCTAssertEqual("1 run, 1 failed, 0 error", tc.result.summary())
        XCTAssertEqual("WasAssert.testAssertEqualMultipleFailed is failed\nLine:43 (Expected) is not equal to (Actual).\nLine:44 (0) is not equal to (1) - message(AssertEqualMultiple).\n", tc.result.details())
    }
}

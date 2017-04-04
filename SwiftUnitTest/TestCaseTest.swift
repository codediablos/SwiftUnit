//
//  TestCaseTest.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 2016/9/6.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import XCTest
@testable import SwiftUnit

class TestCaseTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTemplateMethod() {
        let tc = WasRun("testMethod")
        tc.run()
        XCTAssertEqual("setUp testMethod tearDown", tc.log)
    }

    func testResult() {
        let tc = WasRun("testMethod")
        tc.run()
        XCTAssertEqual("1 run, 0 failed, 0 error", tc.result.summary())
    }

    func testFailedResult() {
        let tc = WasRun("testBrokenMethod")
        tc.run()
        XCTAssertEqual("1 run, 1 failed, 0 error", tc.result.summary())
    }

    func testFailedResultFormatting() {
        let result = TestResult()
        let tc = WasRun("testMethod")
        result.testStarted(tc)
        result.testFailed(tc)
        XCTAssertEqual("1 run, 1 failed, 0 error", result.summary())
    }

    func testTearDownAfterTestFailed() {
        let tc = WasRun("testBrokenMethod")
        tc.run()
        XCTAssertEqual("setUp  tearDown", tc.log)
    }

    func testCatchSetUpErrorAndReport() {
        let tc = WasFailed("testMethod")
        tc.run()
        XCTAssertEqual("1 run, 0 failed, 1 error", tc.result.summary())
        XCTAssertEqual("WasFailed.testMethod is error - setUp error.\n", tc.result.details())
    }
}

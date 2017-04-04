//
//  TestCaseTest.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 9/14/16.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

class TestCaseTest: TestCase {

    override func setUp() throws { }

    func testTemplateMethod() {
        let tc = WasRun("testMethod")
        tc.run()
        AssertEqual("setUp testMethod tearDown", tc.log)
    }

    func testResult() {
        let tc = WasRun("testMethod")
        tc.run()
        AssertEqual("1 run, 0 failed, 0 error", tc.result.summary())
    }

    func testFailedResult() {
        let tc = WasRun("testBrokenMethod")
        tc.run()
        AssertEqual("1 run, 1 failed, 0 error", tc.result.summary())
    }

    func testFailedResultFormatting() {
        let result = TestResult()
        let tc = WasRun("testMethod")
        result.testStarted(tc)
        result.testFailed(tc)
        AssertEqual("1 run, 1 failed, 0 error", result.summary())
    }

    func testTearDownAfterTestFailed() {
        let tc = WasRun("testBrokenMethod")
        tc.run()
        AssertEqual("setUp  tearDown", tc.log)
    }

    func testCatchSetUpErrorAndReport() {
        let tc = WasFailed("testMethod")
        tc.run()
        AssertEqual("WasFailed.testMethod is error - setUp error.\n", tc.result.details())
    }

    func testMetohdNotExist() {
        let tc = WasRun("testNotExist")
        tc.run()
        AssertEqual("WasRun.testNotExist is error - method not exist.\n", tc.result.details())
    }
}

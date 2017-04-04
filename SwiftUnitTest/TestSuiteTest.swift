//
//  TestSuiteTest.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 2016/9/26.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import XCTest
@testable import SwiftUnit

class TestSuiteTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSuite() {
        let suite = TestSuite()
        suite.add(WasRun("testMethod"))
        suite.add(WasRun("testBrokenMethod"))
        suite.run()
        XCTAssertEqual("2 run, 1 failed, 0 error", suite.result.summary())
    }

    func testCreateTestSuiteFromTestCase() {
        let suite = TestSuite()
        suite.addAll(WasRun.self)
        suite.run()
        XCTAssertEqual("2 run, 1 failed, 0 error", suite.result.summary())
    }

    func testDuplicateSuite() {
        let suite = TestSuite()
        suite.add(WasRun("testMethod"))
        suite.add(WasRun("testMethod"))
        suite.add(WasRun("testBrokenMethod"))
        suite.add(WasRun("testBrokenMethod"))
        suite.run()
        XCTAssertEqual("2 run, 1 failed, 0 error", suite.result.summary())
    }
}

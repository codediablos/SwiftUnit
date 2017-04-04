//
//  TestSuiteTest.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 2016/9/27.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

class TestSuiteTest: TestCase {

    override func setUp() throws { }

    func testSuite() {
        let suite = TestSuite()
        suite.add(WasRun("testMethod"))
        suite.add(WasRun("testBrokenMethod"))
        suite.run()
        AssertEqual("2 run, 1 failed, 0 error", suite.result.summary())
    }

    func testCreateTestSuiteFromTestCase() {
        let suite = TestSuite()
        suite.addAll(WasRun.self)
        suite.run()
        AssertEqual("2 run, 1 failed, 0 error", suite.result.summary())
    }

    func testDuplicateSuite() {
        let suite = TestSuite()
        suite.add(WasRun("testMethod"))
        suite.add(WasRun("testMethod"))
        suite.add(WasRun("testBrokenMethod"))
        suite.add(WasRun("testBrokenMethod"))
        suite.run()
        AssertEqual("2 run, 1 failed, 0 error", suite.result.summary())
    }

    func testSuiteCustomStringConvertible() {
        let suite = TestSuite()
        suite.add(WasRun("testMethod"))
        suite.run()
        AssertEqual("1 run, 0 failed, 0 error\n", String(describing: suite))
    }
}

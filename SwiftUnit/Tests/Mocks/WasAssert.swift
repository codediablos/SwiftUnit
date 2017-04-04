//
//  WasAssert.swift
//  SwiftUnit
//
//  Created by CodeDiablos on 2016/10/4.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

class WasAssert: TestCase {
    var log = ""

    override func setUp() throws { }

    override func tearDown() { }

    func testAssertTrueIsTrue() {
        AssertTrue(true)
    }

    func testAssertTrueIsFalse() {
        AssertTrue(false, "AssertTrue")
    }

    func testAssertFalseIsTrue() {
        AssertFalse(true, "AssertFalse")
    }

    func testAssertFalseIsFalse() {
        AssertFalse(false)
    }

    func testAssertEqualIsEqual() {
        AssertEqual("Expected", "Expected")
    }

    func testAssertEqualIsNotEqual() {
        AssertEqual("Expected", "Actual", "AssertEqual")
    }

    func testAssertEqualMultipleFailed() {
        AssertEqual("Expected", "Actual")
        AssertEqual(0, 1, "AssertEqualMultiple")
    }

    func testAssertEqualArrayPass() {
        AssertEqual([2, 1], [2, 1])
    }

    func testAssertEqualArrayFailed() {
        AssertEqual([2, 1], [])
    }

    func testAssertWithExecption() {
        let execption = { () -> Bool in
            throw TestError.TestBroken
        }
        AssertTrue(try execption())
    }

    func testAssertEqualDictionaryPass() {
        AssertEqual(["1": 1], ["1": 1])
    }

    func testAssertEqualDictionaryFailed() {
        AssertEqual(["1": 1], ["2": 2])
    }

    func testAssertWithOptionalPass() {
        let value1: String? = nil
        let value2: String? = nil
        AssertEqual(value1, value2)
    }

    func testAssertWithOptionalFailed() {
        let value1: String? = "test"
        let value2: String? = nil
        AssertEqual(value1, value2)
    }
}

//
//  AssertsTest.swift
//  SwiftUnit
//
//  Created by CodeDiablos on 2016/10/4.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

class AssertsTest: TestCase {

    override func setUp() throws { }

    func testAssertTrueIsTrue() {
        let tc = WasAssert("testAssertTrueIsTrue")
        tc.run()
        AssertEqual("", tc.result.details())
    }

    func testAssertTrueIsFalse() {
        let tc = WasAssert("testAssertTrueIsFalse")
        tc.run()
        AssertEqual("WasAssert.testAssertTrueIsFalse is failed\nLine:23 - message(AssertTrue).\n", tc.result.details())
    }

    func testAssertFalseIsTrue() {
        let tc = WasAssert("testAssertFalseIsTrue")
        tc.run()
        AssertEqual("WasAssert.testAssertFalseIsTrue is failed\nLine:27 - message(AssertFalse).\n", tc.result.details())
    }

    func testAssertFalseIsFalse() {
        let tc = WasAssert("testAssertFalseIsFalse")
        tc.run()
        AssertEqual("", tc.result.details())
    }

    func testAssertEqualIsEqual() {
        let tc = WasAssert("testAssertEqualIsEqual")
        tc.run()
        AssertEqual("", tc.result.details())
    }

    func testAssertEqualIsNotEqual() {
        let tc = WasAssert("testAssertEqualIsNotEqual")
        tc.run()
        AssertEqual("WasAssert.testAssertEqualIsNotEqual is failed\nLine:39 (Expected) is not equal to (Actual) - message(AssertEqual).\n", tc.result.details())
    }

    func testAssertEqualMultipleFailed() {
        let tc = WasAssert("testAssertEqualMultipleFailed")
        tc.run()
        AssertEqual("WasAssert.testAssertEqualMultipleFailed is failed\nLine:43 (Expected) is not equal to (Actual).\nLine:44 (0) is not equal to (1) - message(AssertEqualMultiple).\n", tc.result.details())
    }

    func testAssertEqualArrayPass() {
        let tc = WasAssert("testAssertEqualArrayPass")
        tc.run()
        AssertEqual("", tc.result.details())
    }

    func testAssertEqualArrayFailed() {
        let tc = WasAssert("testAssertEqualArrayFailed")
        tc.run()
        AssertEqual("WasAssert.testAssertEqualArrayFailed is failed\nLine:52 ([2, 1]) is not equal to ([]).\n", tc.result.details())
    }

    func testAssertWithExecption() {
        let tc = WasAssert("testAssertWithExecption")
        tc.run()
        AssertEqual("WasAssert.testAssertWithExecption is error line:59.\n", tc.result.details())
    }

    func testAssertEqualDictionaryPass() {
        let tc = WasAssert("testAssertEqualDictionaryPass")
        tc.run()
        AssertEqual("", tc.result.details())
    }

    func testAssertEqualDictionaryFailed() {
        let tc = WasAssert("testAssertEqualDictionaryFailed")
        tc.run()
        AssertEqual("WasAssert.testAssertEqualDictionaryFailed is failed\nLine:67 ([\"1\": 1]) is not equal to ([\"2\": 2]).\n", tc.result.details())
    }

    func testAssertWithOptionalPass() {
        let tc = WasAssert("testAssertWithOptionalPass")
        tc.run()
        AssertEqual("", tc.result.details())
    }

    func testAssertWithOptionalFailed() {
        let tc = WasAssert("testAssertWithOptionalFailed")
        tc.run()
        AssertEqual("WasAssert.testAssertWithOptionalFailed is failed\nLine:79 (Optional(\"test\")) is not equal to (nil).\n", tc.result.details())
    }
}

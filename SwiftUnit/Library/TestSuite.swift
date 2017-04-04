//
//  TestSuite.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 2016/9/25.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

open class TestSuite: CustomStringConvertible {
    private var tests: [TestCase] = []

    open var result: TestResult {
        get {
            return _result
        }
        set (result) {
            _result = result
        }
    }

    private var _result = TestResult()

    open func add(_ test: TestCase) {
        tests.append(test)
    }

    open func addAll(_ cls: AnyClass) {
        if let testCaseType = cls as? TestCase.Type {
            Utils.getAllMethodNamesForClass(testCaseType) {
                (name: String) -> Void in add(testCaseType.init(name))
            }
        }
    }

    open func run() {
        for test in tests {
            test.result = _result
            test.run()
        }
    }

    public var description: String {
        return result.summary() + "\n" + result.details()
    }
}

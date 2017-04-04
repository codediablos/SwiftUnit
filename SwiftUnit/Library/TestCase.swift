//
//  TestCase.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 2016/9/6.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

open class TestCase: NSObject {
    open var name: String {
        return _name
    }

    private var _name: String

    open var result: TestResult {
        get {
            return _result
        }
        set (result) {
            _result = result
        }
    }

    private var _result: TestResult

    public required init(_ name: String) {
        self._name = name
        self._result = TestResult()
    }

    open func setUp() throws { }

    open func tearDown() { }

    open func run() {
        result.testStarted(self)
        do {
            try setUp()
            do {
                try invokeMethod()
            } catch TestError.TestNotExist {
                result.testError(self, message: "method not exist")
            } catch {
                result.testFailed(self)
            }
        } catch {
            result.testError(self, message: "setUp error")
        }
        defer {
            tearDown()
        }
    }

    func invokeMethod() throws {
        if let method = Utils.getMethodNamesForClass(type(of: self), name) {
            let testMethod = Utils.extractMethodFrom(self, method)
            testMethod()
        } else {
            var err: NSError?
            let throwName = name.appending("AndReturnError:")
            if let method = Utils.getMethodNamesForClass(type(of: self), throwName) {
                let testMethod = Utils.extractThrowMethodFrom(self, method)
                try testMethod(&err)
                if err != nil {
                    if let error = TestError.convert(err: err!) {
                        throw error
                    }
                }
            } else {
                throw TestError.TestNotExist
            }
        }
    }
}

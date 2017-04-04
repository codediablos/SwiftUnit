//
//  Asserts.swift
//  SwiftUnit
//
//  Created by CodeDiablos on 2016/9/27.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

public extension TestCase {
    private func _AssertExecution(file: StaticString, line: UInt,
                                  _ expression: () throws -> Void) {
        do {
            try expression()
        } catch {
            result.testError(self, file, line)
        }
    }

    public func AssertTrue(_ expression: @autoclosure () throws -> Bool,
                    _ message: @autoclosure () -> String = "",
                    file: StaticString = #file, line: UInt = #line) {
        _AssertExecution(file: file, line: line) {
            let value = try expression()
            if !value {
                result.testAssertFailed(self, message(), file, line)
            }
        }
    }

    public func AssertFalse(_ expression: @autoclosure () throws -> Bool,
                    _ message: @autoclosure () -> String = "",
                    file: StaticString = #file, line: UInt = #line) {
        _AssertExecution(file: file, line: line) {
            let value = try expression()
            if value {
                result.testAssertFailed(self, message(), file, line)
            }
        }
    }

    public func AssertEqual<T: Equatable>(_ expression1: @autoclosure () throws -> T,
                     _ expression2: @autoclosure () throws -> T,
                     _ message: @autoclosure () -> String = "",
                     file: StaticString = #file, line: UInt = #line) {
        _AssertExecution(file: file, line: line) {
            let (value1, value2) = (try expression1(), try expression2())
            if value1 != value2 {
                result.testAssertFailed(self, message(), file, line,
                                        String(describing: value1),
                                        String(describing: value2))
            }
        }
    }

    public func AssertEqual<T: Equatable>(_ expression1: @autoclosure () throws -> T?,
                            _ expression2: @autoclosure () throws -> T?,
                            _ message: @autoclosure () -> String = "",
                            file: StaticString = #file, line: UInt = #line) {
        _AssertExecution(file: file, line: line) {
            let (value1, value2) = (try expression1(), try expression2())
            if value1 != value2 {
                result.testAssertFailed(self, message(), file, line,
                                        String(describing: value1),
                                        String(describing: value2))
            }
        }
    }

    public func AssertEqual<T: Equatable>(_ expression1: @autoclosure () throws -> [T],
                            _ expression2: @autoclosure () throws -> [T],
                            _ message: @autoclosure () -> String = "",
                            file: StaticString = #file, line: UInt = #line) {
        _AssertExecution(file: file, line: line) {
            let (value1, value2) = (try expression1(), try expression2())
            if value1 != value2 {
                result.testAssertFailed(self, message(), file, line,
                                        String(describing: value1),
                                        String(describing: value2))
            }
        }
    }

    public func AssertEqual<T, U: Equatable>(_ expression1: @autoclosure () throws -> [T: U],
                            _ expression2: @autoclosure () throws -> [T: U],
                            _ message: @autoclosure () -> String = "",
                            file: StaticString = #file, line: UInt = #line) {
        _AssertExecution(file: file, line: line) {
            let (value1, value2) = (try expression1(), try expression2())
            if value1 != value2 {
                result.testAssertFailed(self, message(), file, line,
                                        String(describing: value1),
                                        String(describing: value2))
            }
        }
    }
}

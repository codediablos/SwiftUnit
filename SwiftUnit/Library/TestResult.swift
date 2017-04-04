//
//  TestResult.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 9/20/16.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

enum Type {
    case Unknown, Error, GeneralFailed, AssertFailed, AssertEqualFailed
}

struct RecordData {
    var message = ""
    var file = ""
    var line = ""
    var expected = ""
    var actual = ""
}

class Record {
    var testCase: TestCase
    var type: Type
    var data: [RecordData] = []

    init(_ testCase: TestCase, _ type: Type) {
        self.testCase = testCase
        self.type = type
    }

    func isFailed() -> Bool {
        return type == Type.GeneralFailed ||
            type == Type.AssertFailed ||
            type == Type.AssertEqualFailed
    }
}

open class TestResult {
    var records = [String: Record]()

    func getRecord(_ testCase: TestCase, _ type: Type) -> Record {
        let key = String(describing: type(of:testCase)) + "." + testCase.name
        if let record = records[key] {
            record.type = type
            return record
        } else {
            let record = Record(testCase, type)
            records[key] = record
            return record
        }
    }

    func getFailedCount() -> Int {
        var count = 0
        for (_, record) in records {
            if record.isFailed() {
                count += 1
            }
        }
        return count
    }

    func getErrorCount() -> Int {
        var count = 0
        for (_, record) in records {
            if record.type == Type.Error {
                count += 1
            }
        }
        return count
    }

    func testStarted(_ testCase: TestCase) {
        let _ = getRecord(testCase, Type.Unknown)
    }

    func testFailed(_ testCase: TestCase) {
        let _ = getRecord(testCase, Type.GeneralFailed)
    }

    func testError(_ testCase: TestCase, _ file: StaticString = #file, _ line: UInt = #line, message: String = "") {
        var data = RecordData()
        data.file = String(describing: file)
        data.line = String(line)
        data.message = message

        let record = getRecord(testCase, Type.Error)
        record.data.append(data)
    }

    func testAssertFailed(_ testCase: TestCase, _ message: String,
                          _ file: StaticString, _ line: UInt) {
        var data = RecordData()
        data.message += message
        data.file = String(describing: file)
        data.line = String(line)

        let record = getRecord(testCase, Type.AssertFailed)
        record.data.append(data)
    }

    func testAssertFailed(_ testCase: TestCase, _ message: String,
                          _ file: StaticString, _ line: UInt,
                          _ expected: String, _ actual: String) {
        var data = RecordData()
        data.message += message
        data.file = String(describing: file)
        data.line = String(line)
        data.expected = expected
        data.actual = actual

        let record = getRecord(testCase, Type.AssertEqualFailed)
        record.data.append(data)
    }

    open func summary() -> String {
        return String(format: "%d run, %d failed, %d error",
                      records.count, getFailedCount(), getErrorCount())
    }

    open func details() -> String {
        var ret = ""
        for (key, record) in records {
            if record.type == Type.Error {
                for data in record.data {
                    if data.message == "" {
                        return key + " is error line:" + data.line + ".\n"
                    } else {
                        return key + " is error - " + data.message + ".\n"
                    }
                }
            } else if record.isFailed() {
                ret += key + " is failed\n"
                for data in record.data {
                    ret += "Line:" + data.line
                    if record.type == Type.AssertEqualFailed {
                        ret += " (" + data.expected + ")" + " is not equal to (" + data.actual + ")"
                    }
                    if data.message != "" {
                        ret += " - message(" + data.message + ")"
                    }
                    ret += ".\n"
                }
            }
        }
        return ret
    }
}

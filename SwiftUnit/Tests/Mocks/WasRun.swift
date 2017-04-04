//
//  WasRun.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 9/9/16.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

class WasRun: TestCase {
    var log = ""

    override func setUp() throws {
        log = "setUp "
    }

    override func tearDown() {
        log += " tearDown"
    }

    func testMethod() {
        log += "testMethod"
    }

    func testBrokenMethod() throws {
        throw TestError.TestBroken
    }
}

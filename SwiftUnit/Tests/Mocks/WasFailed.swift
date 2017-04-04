//
//  WasFailed.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 2016/9/27.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

class WasFailed: TestCase {
    var log = ""

    override func setUp() throws {
        throw TestError.TestBroken
    }

    override func tearDown() { }

    func testMethod() { }
}

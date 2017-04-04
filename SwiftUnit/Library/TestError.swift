//
//  TestError.swift
//  SwiftUnit
//
//  Created by CodeDiablos on 2016/9/28.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

enum TestError: Error {
    case TestBroken
    case TestNotExist

    static var errorDomain: String {
        return "TestError"
    }

    static func convert(err: NSError) -> TestError? {
        if err.domain.hasSuffix(errorDomain) {
            switch err.code {
            case TestBroken._code:
                return TestBroken
            case TestNotExist._code:
                return TestNotExist
            default:
                return nil
            }
        }
        return nil
    }
}

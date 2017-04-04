//
//  main.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 2016/9/6.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

let suite = TestSuite()
suite.addAll(TestCaseTest.self)
suite.addAll(TestSuiteTest.self)
suite.addAll(AssertsTest.self)
suite.run()
print(suite)

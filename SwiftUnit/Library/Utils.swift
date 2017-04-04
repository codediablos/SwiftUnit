//
//  Utils.swift
//  SwiftUnix
//
//  Created by CodeDiablos on 2016/9/27.
//  Copyright © 2016 CodeDiablos. All rights reserved.
//

import Foundation

class Utils {
    static func extractMethodFrom(_ owner: AnyObject, _ method: Method!) -> (() -> Void) {
        let implementation = method_getImplementation(method)

        typealias Function = @convention(c) (AnyObject, Method) -> Void
        let function = unsafeBitCast(implementation, to: Function.self)

        return { void in function(owner, method) }
    }

    static func extractThrowMethodFrom(_ owner: AnyObject, _ method: Method!) -> ((NSErrorPointer) throws -> Void) {
        let implementation = method_getImplementation(method)

        typealias Function = @convention(c) (AnyObject, Method, NSErrorPointer) -> Void
        let function = unsafeBitCast(implementation, to: Function.self)

        return { (error) -> () in function(owner, method, error) }
    }

    /// Given pointer to first element of a C array, invoke a function for each element
    static func enumerateCArray<T>(array: UnsafePointer<T>, count: UInt32, f: (UInt32, T) -> ()) {
        var ptr = array
        for i in 0..<count {
            f(i, ptr.pointee)
            ptr = ptr.successor()
        }
    }

    /// Return name for a method
    static func methodName(m: Method) -> String? {
        let sel = method_getName(m)
        let nameCString = sel_getName(sel)
        return String(cString: nameCString!)
    }

    /// Get the names for each method in a class
    static func getMethodNamesForClass(_ cls: AnyClass, _ method: String) -> Method? {
        var methodCount: UInt32 = 0
        let methodList = class_copyMethodList(cls, &methodCount)
        var ret: Method? = nil
        if methodList != nil && methodCount > 0 {
            enumerateCArray(array: methodList!, count: methodCount) { i, m in
                let name = methodName(m: m!) ?? "unknown"
                if name == method {
                    ret = m
                }
            }
            free(methodList)
        }
        return ret
    }

    /// Get the names for each method in a class
    static func getAllMethodNamesForClass(_ cls: AnyClass, _ f: (String) -> Void) {
        var methodCount: UInt32 = 0
        let methodList = class_copyMethodList(cls, &methodCount)
        if methodList != nil && methodCount > 0 {
            enumerateCArray(array: methodList!, count: methodCount) { i, m in
                var name = methodName(m: m!) ?? "unknown"
                if name.hasPrefix("test") {
                    if name.hasSuffix("AndReturnError:") {
                        name = name.replacingOccurrences(of: "AndReturnError:", with: "")
                    }
                    f(name)
                }
            }
            free(methodList)
        }
    }

    /// Get the names for each method in a class with a specified name
    static func getMethodNamesForClassNamed(classname: String, method: String) -> Method? {
        // NSClassFromString() is declared to return AnyClass!, but should be AnyClass?
        let maybeClass: AnyClass? = NSClassFromString(classname)
        if let cls: AnyClass = maybeClass {
            return getMethodNamesForClass(cls, method)
        } else {
            //print("\(classname): no such class")
            return nil
        }
    }
}

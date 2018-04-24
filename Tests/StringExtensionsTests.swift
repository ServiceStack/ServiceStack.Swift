#if true
//
//  StringExtensionsTests.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 1/30/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation
import XCTest
@testable import ServiceStackClient

class StringExtensionsTests: XCTestCase {

    func test_Can_splitOn_first() {
        XCTAssertEqual("1,2,3".splitOn(first: ","), ["1","2,3"])
        XCTAssertEqual("1,2,3".splitOn(first: ";"), ["1,2,3"])
        XCTAssertEqual("1::2::3".splitOn(first: "::"), ["1","2::3"])

        XCTAssertEqual("1H".splitOn(first: "H"), ["1",""])
    }
    
    func test_Can_splitOnLast() {
        XCTAssertEqual("1,2,3".splitOn(last: ","), ["1,2","3"])
        XCTAssertEqual("1,2,3".splitOn(last: ";"), ["1,2,3"])
        XCTAssertEqual("1::2::3".splitOn(last: "::"), ["1::2","3"])
    }
    
    func test_Can_Split() {
        XCTAssertEqual("1,2,3".split(","), ["1","2","3"])
        XCTAssertEqual("1::2::3".split("::"), ["1","2","3"])
    }
    
    func test_Can_IndexOf() {
        XCTAssertEqual("1,2,3".indexOf(","), 1)
        XCTAssertEqual("1,2,3".indexOf(",2"), 1)
        XCTAssertEqual("1,2,3".indexOf(";"), -1)
    }
    
    func test_Can_LastIndexOf() {
        XCTAssertEqual("1,2,3".lastIndexOf(","), 3)
        XCTAssertEqual("1,2,3".lastIndexOf(",3"), 3)
        XCTAssertEqual("1,2,3".lastIndexOf(";"), -1)
    }
    
    func test_String_subscript() {
        XCTAssertEqual("cat"[1..<"cat".length], "at")
        XCTAssertEqual(String("cat"[0]), "c")
    }
    
    func test_Can_serialize_JSON_String()
    {
        XCTAssertEqual(jsonString("s\"\n    "), "\"s\\\"\\n    \"")
        XCTAssertEqual(jsonString("=== normal string ==="), "\"=== normal string ===\"")
    }
}
    
#endif

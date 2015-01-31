//
//  StringExtensionsTests.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 1/30/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation
import XCTest

class StringExtensionsTests: XCTestCase {

    func test_Can_splitOnFirst() {
        XCTAssertEqual("1,2,3".splitOnFirst(","), ["1","2,3"])
        XCTAssertEqual("1,2,3".splitOnFirst(";"), ["1,2,3"])
        XCTAssertEqual("1::2::3".splitOnFirst("::"), ["1","2::3"])

        XCTAssertEqual("1H".splitOnFirst("H"), ["1",""])
}
    
    func test_Can_splitOnLast() {
        XCTAssertEqual("1,2,3".splitOnLast(","), ["1,2","3"])
        XCTAssertEqual("1,2,3".splitOnLast(";"), ["1,2,3"])
        XCTAssertEqual("1::2::3".splitOnLast("::"), ["1::2","3"])
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
}

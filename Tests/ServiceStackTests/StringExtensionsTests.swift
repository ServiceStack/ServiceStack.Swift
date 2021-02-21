//
//  StringExtensionsTests.swift
//  ServiceStack
//
//  Created by Demis Bellot on 1/30/15.
//  Copyright (c) 2021 ServiceStack, Inc. All rights reserved.
//

 import Foundation
 @testable import ServiceStack
 import XCTest

 class StringExtensionsTests: XCTestCase {
    func test_Can_splitOn_first() {
        XCTAssertEqual("1,2,3".splitOn(first: ","), ["1", "2,3"])
        XCTAssertEqual("1,2,3".splitOn(first: ";"), ["1,2,3"])
        XCTAssertEqual("1::2::3".splitOn(first: "::"), ["1", "2::3"])

        XCTAssertEqual("1H".splitOn(first: "H"), ["1", ""])
    }

    func test_Can_splitOnLast() {
        XCTAssertEqual("1,2,3".splitOn(last: ","), ["1,2", "3"])
        XCTAssertEqual("1,2,3".splitOn(last: ";"), ["1,2,3"])
        XCTAssertEqual("1::2::3".splitOn(last: "::"), ["1::2", "3"])
    }

    func test_Can_Split() {
        XCTAssertEqual("1,2,3".split(","), ["1", "2", "3"])
        XCTAssertEqual("1::2::3".split("::"), ["1", "2", "3"])
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
        XCTAssertEqual("cat"[1 ..< "cat".count], "at")
        XCTAssertEqual(String("cat"[0]), "c")
    }

    func test_Can_serialize_JSON_String() {
        XCTAssertEqual(toJson("s\"\n    "), "\"s\\\"\\n    \"")
        XCTAssertEqual(toJson("=== normal string ==="), "\"=== normal string ===\"")
    }

    func test_First_Lowercased() {
        XCTAssertEqual("message".firstLowercased(), "message")
        XCTAssertEqual("Message".firstLowercased(), "message")
        XCTAssertEqual("MEssage".firstLowercased(), "mEssage")
        XCTAssertEqual("MESSAGE".firstLowercased(), "mESSAGE")
        XCTAssertEqual("some message".firstLowercased(), "some message")
        XCTAssertEqual("Some message".firstLowercased(), "some message")
        XCTAssertEqual("Some Message".firstLowercased(), "some Message")
    }

    func test_First_Uppercased() {
        XCTAssertEqual("message".firstUppercased(), "Message")
        XCTAssertEqual("Message".firstUppercased(), "Message")
        XCTAssertEqual("mEssage".firstUppercased(), "MEssage")
        XCTAssertEqual("MESSAGE".firstUppercased(), "MESSAGE")
        XCTAssertEqual("some message".firstUppercased(), "Some message")
        XCTAssertEqual("some Message".firstUppercased(), "Some Message")
        XCTAssertEqual("Some message".firstUppercased(), "Some message")
    }
 }

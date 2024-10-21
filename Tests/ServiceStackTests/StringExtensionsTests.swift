//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import ServiceStack

final class StringExtensionsTests : @unchecked Sendable {

    @Test func Can_splitOn_first() {
        #expect("1,2,3".splitOn(first: ",") == ["1", "2,3"])
        #expect("1,2,3".splitOn(first: ";") == ["1,2,3"])
        #expect("1::2::3".splitOn(first: "::") == ["1", "2::3"])

        #expect("1H".splitOn(first: "H") == ["1", ""])
    }

    @Test func Can_splitOnLast() {
        #expect("1,2,3".splitOn(last: ",") == ["1,2", "3"])
        #expect("1,2,3".splitOn(last: ";") == ["1,2,3"])
        #expect("1::2::3".splitOn(last: "::") == ["1::2", "3"])
    }

    @Test func Can_Split() {
        #expect("1,2,3".split(",") == ["1", "2", "3"])
        #expect("1::2::3".split("::") == ["1", "2", "3"])
    }

    @Test func Can_IndexOf() {
        #expect("1,2,3".indexOf(",") == 1)
        #expect("1,2,3".indexOf(",2") == 1)
        #expect("1,2,3".indexOf(";") == -1)
    }

    @Test func Can_LastIndexOf() {
        #expect("1,2,3".lastIndexOf(",") == 3)
        #expect("1,2,3".lastIndexOf(",3") == 3)
        #expect("1,2,3".lastIndexOf(";") == -1)
    }

    @Test func String_subscript() {
        #expect("cat"[1 ..< "cat".count] == "at")
        #expect(String("cat"[0]) == "c")
    }

    @Test func Can_serialize_JSON_String() {
        #expect(toJson("s\"\n    ") == "\"s\\\"\\n    \"")
        #expect(toJson("=== normal string ===") == "\"=== normal string ===\"")
    }

    @Test func First_Lowercased() {
        #expect("message".firstLowercased() == "message")
        #expect("Message".firstLowercased() == "message")
        #expect("MEssage".firstLowercased() == "mEssage")
        #expect("MESSAGE".firstLowercased() == "mESSAGE")
        #expect("some message".firstLowercased() == "some message")
        #expect("Some message".firstLowercased() == "some message")
        #expect("Some Message".firstLowercased() == "some Message")
    }

    @Test func First_Uppercased() {
        #expect("message".firstUppercased() == "Message")
        #expect("Message".firstUppercased() == "Message")
        #expect("mEssage".firstUppercased() == "MEssage")
        #expect("MESSAGE".firstUppercased() == "MESSAGE")
        #expect("some message".firstUppercased() == "Some message")
        #expect("some Message".firstUppercased() == "Some Message")
        #expect("Some message".firstUppercased() == "Some message")
    }
 }

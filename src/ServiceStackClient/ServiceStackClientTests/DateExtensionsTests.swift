#if true
//
//  DateExtensionsTests.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 1/31/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation
import XCTest

class DateExtensionsTests: XCTestCase {
    
    func test_Can_Parse_WCF_Date() {
        XCTAssertEqual(NSDate.fromString("/Date(978325200000-0000)/")!, NSDate(year: 2001, month: 1, day: 1))
        XCTAssertEqual(NSDate.fromString("/Date(978325200000+0000)/")!, NSDate(year: 2001, month: 1, day: 1))
    }
    
    func test_Can_parse_pre_UnixTime(){
        XCTAssertEqual(NSDate.fromString("\\/Date(-30610224000)\\/")!, NSDate(timeIntervalSince1970: -30610224000 / 1000))
    }
    
    func test_Can_Parse_ISO8601_Date() {
        println("2001-01-01T00:00:00".length)
        XCTAssertEqual(NSDate.fromString("2001-01-01T00:00:00.0000000")!, NSDate(year: 2001, month: 1, day: 1))
        XCTAssertEqual(NSDate.fromString("2001-01-01T00:00:00.000")!, NSDate(year: 2001, month: 1, day: 1))
        XCTAssertEqual(NSDate.fromString("2001-01-01T00:00:00")!, NSDate(year: 2001, month: 1, day: 1))

        XCTAssertEqual(NSDate.fromString("2001-01-01T05:00:00.000Z")!, NSDate(year: 2001, month: 1, day: 1))
    }
    
    func test_Can_Serialize_ISO8601_Date() {
        XCTAssertEqual(NSDate(year: 2001, month: 1, day: 1).toJson(), "\"2001-01-01T05:00:00.000Z\"")
    }
    
    func test_Can_Serialize_NSTimeInterval() {
        XCTAssertEqual(NSTimeInterval.fromTimeIntervalString("P365D")!, Double(365 * 24 * 60 * 60))
        XCTAssertEqual(NSTimeInterval.fromTimeIntervalString("PT1H")!, Double(1 * 60 * 60))
        XCTAssertEqual(NSTimeInterval.fromTimeIntervalString("PT1M")!, Double(1 * 60))
        XCTAssertEqual(NSTimeInterval.fromTimeIntervalString("PT1S")!, Double(1))
        XCTAssertEqual(NSTimeInterval.fromTimeIntervalString("PT0.001S")!, Double(0.001))

        //1year + 1day + 1hr + 1min + 1s + 1ms
        XCTAssertEqual(NSTimeInterval.fromTimeIntervalString("P365DT1H1M1.001S")!, 31539661.001)
    }

}
    
#endif

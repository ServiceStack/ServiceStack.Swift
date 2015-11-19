#if true
//
//  JsonTests.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 3/22/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import XCTest

class JsonTests: XCTestCase {

    func test_can_Serialize_TimeSpan() {
        let oneDay:NSTimeInterval = 24 * 60 * 60
        XCTAssertEqual(oneDay.toXsdDuration(),"P1D")
        let oneHour:NSTimeInterval = 60 * 60
        XCTAssertEqual(oneHour.toXsdDuration(),"PT1H")
        let oneMin:NSTimeInterval = 60
        XCTAssertEqual(oneMin.toXsdDuration(),"PT1M")
        let oneSec:NSTimeInterval = 1
        XCTAssertEqual(oneSec.toXsdDuration(),"PT1S")
        let oneMs:NSTimeInterval = 0.001
        XCTAssertEqual(oneMs.toXsdDuration(),"PT0.001S")

        let oneAll:NSTimeInterval = oneDay + oneHour + oneMin + oneSec + oneMs
        XCTAssertEqual(oneAll.toXsdDuration(),"P1DT1H1M1.001S")
        
        let oneTick:NSTimeInterval = 1 / NSTimeInterval.ticksPerSecond
        XCTAssertEqual(oneTick.toXsdDuration(),"PT0.0000001S")
        let zero:NSTimeInterval = NSTimeInterval(0)
        XCTAssertEqual(zero.toXsdDuration(),"PT0S")
        let tenYears:NSTimeInterval = 10 * 365 * 24 * 60 * 60
        XCTAssertEqual(tenYears.toXsdDuration(),"P3650D")
    }
    
    func test_can_deserialize_TimeSpan() {
        let oneDay:NSTimeInterval = 24 * 60 * 60
        XCTAssertEqual(NSTimeInterval.fromXsdDuration("P1D")!, oneDay)
        let oneHour:NSTimeInterval = 60 * 60
        XCTAssertEqual(NSTimeInterval.fromXsdDuration("PT1H")!, oneHour)
        let oneMin:NSTimeInterval = 60
        XCTAssertEqual(NSTimeInterval.fromXsdDuration("PT1M")!, oneMin)
        let oneSec:NSTimeInterval = 1
        XCTAssertEqual(NSTimeInterval.fromXsdDuration("PT1S")!, oneSec)
        let oneMs:NSTimeInterval = 0.001
        XCTAssertEqual(NSTimeInterval.fromXsdDuration("PT0.001S")!, oneMs)
        
        let oneAll:NSTimeInterval = oneDay + oneHour + oneMin + oneSec + oneMs
        XCTAssertEqual(NSTimeInterval.fromXsdDuration("P1DT1H1M1.001S")!, oneAll)
        
        let oneTick:NSTimeInterval = 1 / NSTimeInterval.ticksPerSecond
        XCTAssertEqual(NSTimeInterval.fromXsdDuration("PT0.0000001S")!, oneTick)
        let zero:NSTimeInterval = NSTimeInterval(0)
        XCTAssertEqual(NSTimeInterval.fromXsdDuration("PT0S")!, zero)
        let tenYears:NSTimeInterval = 10 * 365 * 24 * 60 * 60
        XCTAssertEqual(NSTimeInterval.fromXsdDuration("P3650D")!, tenYears)
    }

    func test_does_serialize_DateTime_in_QueryString() {
        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")
        let request = HelloDateTime()
//        request.dateTime = NSDate(timeIntervalSince1970: 978310861000 / 1000)
        request.dateTime = NSDate.fromIsoDateString("2001-01-01T01:01:01Z")!
        
        let url = client.createUrl(request)
        
        print(request.dateTime?.dateAndTimeString)
        print(request.dateTime?.isoDateString)
       
        print(url)
        
        XCTAssertEqual("http://test.servicestack.net/json/reply/HelloDateTime?dateTime=" + "/Date(978310861000-0000)/".urlEncode()!, url)
    }
}

public class HelloDateTime : IReturn
{
    public typealias Return = HelloDateTime
    
    required public init(){}
    public var dateTime:NSDate?
}


extension HelloDateTime : JsonSerializable
{
    public static var typeName:String { return "HelloDateTime" }
    public static var metadata = Metadata.create([
        Type<HelloDateTime>.optionalProperty("dateTime", get: { $0.dateTime }, set: { $0.dateTime = $1 }),
        ])
}
    
#endif

#if true
//
//  JsonTests.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 3/22/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import XCTest
@testable import ServiceStackClient

class JsonTests: XCTestCase {

    func test_can_Serialize_TimeSpan() {
        let oneDay:TimeInterval = 24 * 60 * 60
        XCTAssertEqual(oneDay.toXsdDuration(),"P1D")
        let oneHour:TimeInterval = 60 * 60
        XCTAssertEqual(oneHour.toXsdDuration(),"PT1H")
        let oneMin:TimeInterval = 60
        XCTAssertEqual(oneMin.toXsdDuration(),"PT1M")
        let oneSec:TimeInterval = 1
        XCTAssertEqual(oneSec.toXsdDuration(),"PT1S")
        let oneMs:TimeInterval = 0.001
        XCTAssertEqual(oneMs.toXsdDuration(),"PT0.001S")

        let oneAll:TimeInterval = oneDay + oneHour + oneMin + oneSec + oneMs
        XCTAssertEqual(oneAll.toXsdDuration(),"P1DT1H1M1.001S")
        
        let oneTick:TimeInterval = 1 / TimeInterval.ticksPerSecond
        XCTAssertEqual(oneTick.toXsdDuration(),"PT0.0000001S")
        let zero:TimeInterval = TimeInterval(0)
        XCTAssertEqual(zero.toXsdDuration(),"PT0S")
        let tenYears:TimeInterval = 10 * 365 * 24 * 60 * 60
        XCTAssertEqual(tenYears.toXsdDuration(),"P3650D")
    }
    
    func test_can_deserialize_TimeSpan() {
        let oneDay:TimeInterval = 24 * 60 * 60
        XCTAssertEqual(TimeInterval.fromXsdDuration("P1D")!, oneDay)
        let oneHour:TimeInterval = 60 * 60
        XCTAssertEqual(TimeInterval.fromXsdDuration("PT1H")!, oneHour)
        let oneMin:TimeInterval = 60
        XCTAssertEqual(TimeInterval.fromXsdDuration("PT1M")!, oneMin)
        let oneSec:TimeInterval = 1
        XCTAssertEqual(TimeInterval.fromXsdDuration("PT1S")!, oneSec)
        let oneMs:TimeInterval = 0.001
        XCTAssertEqual(TimeInterval.fromXsdDuration("PT0.001S")!, oneMs)
        
        let oneAll:TimeInterval = oneDay + oneHour + oneMin + oneSec + oneMs
        XCTAssertEqual(TimeInterval.fromXsdDuration("P1DT1H1M1.001S")!, oneAll)
        
        let oneTick:TimeInterval = 1 / TimeInterval.ticksPerSecond
        XCTAssertEqual(TimeInterval.fromXsdDuration("PT0.0000001S")!, oneTick)
        let zero:TimeInterval = TimeInterval(0)
        XCTAssertEqual(TimeInterval.fromXsdDuration("PT0S")!, zero)
        let tenYears:TimeInterval = 10 * 365 * 24 * 60 * 60
        XCTAssertEqual(TimeInterval.fromXsdDuration("P3650D")!, tenYears)
    }

    func test_does_serialize_DateTime_in_QueryString() {
        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")
        let request = TestDateTime()
//        request.dateTime = NSDate(timeIntervalSince1970: 978310861000 / 1000)
        request.dateTime = Date.fromIsoDateString("2001-01-01T01:01:01Z")!
        
        let url = client.createUrl(dto: request)
        
        print(request.dateTime?.dateAndTimeString as Any)
        print(request.dateTime?.isoDateString as Any)
       
        print(url)
        
        XCTAssertEqual("http://test.servicestack.net/json/reply/HelloDateTime?dateTime=" + "/Date(978310861000-0000)/".urlEncode()!, url)
    }
}
   
public class TestDateTime : IReturn
{
    public typealias Return = TestDateTime
    
    required public init(){}
    public var dateTime:Date?
}
extension TestDateTime : JsonSerializable
{
    public static var typeName:String { return "HelloDateTime" }
    public static var metadata = Metadata.create([
        Type<TestDateTime>.optionalProperty("dateTime", get: { $0.dateTime }, set: { $0.dateTime = $1 }),
        ])
}

    
//public class HelloListReturn : IReturn
//{
//    public typealias Return = [ListResult]
//    
//    required public init(){}
//    public var names:[String] = []
//}
//
//extension HelloListReturn : JsonSerializable {
//    public static var typeName:String { return "HelloListReturn" }
//    public static var metadata = Metadata.create([
//            Type<HelloListReturn>.arrayProperty("names", get: { $0.names }, set: { $0.names = $1 })
//        ])
//}
    
//extension Array : JsonSerializable  {
//
//    typealias Element = ListResult
//    
//    public static var typeName:String { return "ListResult[]" }
//    public static var metadata:Metadata { Metadata.create([ ]) }
//}
    
    
#endif

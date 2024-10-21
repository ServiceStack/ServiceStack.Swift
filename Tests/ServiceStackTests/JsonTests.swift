//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import ServiceStack

final class JsonTests : @unchecked Sendable {

    @Test func Can_capture_CodingKeys_properties() {
        let request = QueryPosts()
        request.ids = [1001, 6860, 6848]
        request.orderByDesc = "Points"
        request.take = 3

        let props = AnyEncodable.properties(request)
        for kvp in props {
            print("\(kvp.key) = \(kvp.value) / \(toJson(kvp.value) ?? "")")
        }
    }

    @Test func Can_Serialize_TimeSpan() {
        let oneDay: TimeInterval = 24 * 60 * 60
        #expect(oneDay.toXsdDuration() == "P1D")
        let oneHour: TimeInterval = 60 * 60
        #expect(oneHour.toXsdDuration() == "PT1H")
        let oneMin: TimeInterval = 60
        #expect(oneMin.toXsdDuration() == "PT1M")
        let oneSec: TimeInterval = 1
        #expect(oneSec.toXsdDuration() == "PT1S")
        let oneMs: TimeInterval = 0.001
        #expect(oneMs.toXsdDuration() == "PT0.001S")

        let oneAll: TimeInterval = oneDay + oneHour + oneMin + oneSec + oneMs
        #expect(oneAll.toXsdDuration() == "P1DT1H1M1.001S")

        let oneTick: TimeInterval = 1 / TimeInterval.ticksPerSecond
        #expect(oneTick.toXsdDuration() == "PT0.0000001S")
        let zero: TimeInterval = TimeInterval(0)
        #expect(zero.toXsdDuration() == "PT0S")
        let tenYears: TimeInterval = 10 * 365 * 24 * 60 * 60
        #expect(tenYears.toXsdDuration() == "P3650D")
    }

    @Test func Can_deserialize_TimeSpan() {
        let oneDay: TimeInterval = 24 * 60 * 60
        #expect(TimeInterval.fromXsdDuration("P1D")! == oneDay)
        let oneHour: TimeInterval = 60 * 60
        #expect(TimeInterval.fromXsdDuration("PT1H")! == oneHour)
        let oneMin: TimeInterval = 60
        #expect(TimeInterval.fromXsdDuration("PT1M")! == oneMin)
        let oneSec: TimeInterval = 1
        #expect(TimeInterval.fromXsdDuration("PT1S")! == oneSec)
        let oneMs: TimeInterval = 0.001
        #expect(TimeInterval.fromXsdDuration("PT0.001S")! == oneMs)

        let oneAll: TimeInterval = oneDay + oneHour + oneMin + oneSec + oneMs
        #expect(TimeInterval.fromXsdDuration("P1DT1H1M1.001S")! == oneAll)

        let oneTick: TimeInterval = 1 / TimeInterval.ticksPerSecond
        #expect(TimeInterval.fromXsdDuration("PT0.0000001S")! == oneTick)
        let zero: TimeInterval = TimeInterval(0)
        #expect(TimeInterval.fromXsdDuration("PT0S")! == zero)
        let tenYears: TimeInterval = 10 * 365 * 24 * 60 * 60
        #expect(TimeInterval.fromXsdDuration("P3650D")! == tenYears)
    }

    @Test func Does_serialize_DateTime_in_QueryString() {
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")
        let request = TestDateTime()
//        request.dateTime = NSDate(timeIntervalSince1970: 978310861000 / 1000)
        request.dateTime = Date.fromIsoDateString("2001-01-01T01:01:01Z")!

        let url = client.createUrl(dto: request)

        print(request.dateTime?.dateAndTimeString as Any)
        print(request.dateTime?.isoDateString as Any)

        print(url)

        let expected = "https://test.servicestack.net/api/TestDateTime?dateTime=/Date(978310861000-0000)/"
        #expect(expected == url.absoluteString)
    }
    
    @Test func Can_Deserialize_DTO_with_keywords() {
        let dto = Keywords()
        dto.name = "name"
        dto.Description = "description"
        dto.Is = "is"
        
        let json = toJson(dto)!
        print("json: \(json)")
        let obj = fromJson(Keywords.self, json)!
        #expect(obj.name == dto.name)
        #expect(obj.Description == dto.Description)
        #expect(obj.Is == dto.Is)
        
        let defaultJson = "{\"name\":\"name\",\"is\":\"is\",\"description\":\"description\"}"
        let defaultDto = fromJson(Keywords.self, defaultJson)!
        #expect(defaultDto.name == dto.name)
        #expect(defaultDto.Description == dto.Description)
        #expect(defaultDto.Is == dto.Is)
    }
}

public class TestDateTime: IReturn, Codable {
    public typealias Return = TestDateTime

    public required init() {}
    public var dateTime: Date?
}

public class Keywords : Codable {
    public var name: String?
    public var Description: String?
    public var Is: String?
}

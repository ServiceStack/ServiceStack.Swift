//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import ServiceStack

final class DateExtensionsTests : @unchecked Sendable {

    init() async throws {
        // @Alex: Run Tests under various time zones.
        NSTimeZone.default = TimeZone(secondsFromGMT: 0)!
    }

    @Test func Can_Parse_WCF_Date() {
        #expect(Date.fromString("/Date(978307200000-0000)/")! == Date(year: 2001, month: 1, day: 1))
        #expect(Date.fromString("/Date(978307200000+0000)/")! == Date(year: 2001, month: 1, day: 1))
    }

    @Test func Can_parse_pre_UnixTime() {
        #expect(Date.fromString("\\/Date(-30610224000)\\/")! == Date(timeIntervalSince1970: -30_610_224_000 / 1000))
    }

    @Test func Can_Parse_ISO8601_Date() {
        print("2001-01-01T00:00:00".count)
        #expect(Date.fromString("2001-01-01T00:00:00.0000000")! == Date(year: 2001, month: 1, day: 1))
        #expect(Date.fromString("2001-01-01T00:00:00.000")! == Date(year: 2001, month: 1, day: 1))
        #expect(Date.fromString("2001-01-01T00:00:00")! == Date(year: 2001, month: 1, day: 1))
        #expect(Date.fromString("2001-01-01T00:00:00.000Z")! == Date(year: 2001, month: 1, day: 1))
    }

    @Test func Can_Serialize_ISO8601_Date() {
        #expect(Date(year: 2001, month: 1, day: 1).isoDateString == "2001-01-01T00:00:00.000Z")
    }

    @Test func Can_Serialize_Wcf_Json_Date() {
        #expect(toJson(Date(year: 2001, month: 1, day: 1)) == "\"\\/Date(978307200000-0000)\\/\"")
    }

    @Test func Can_Serialize_TimeInterval() {
        #expect(TimeInterval.fromTimeIntervalString("P365D")! == Double(365 * 24 * 60 * 60))
        #expect(TimeInterval.fromTimeIntervalString("PT1H")! == Double(1 * 60 * 60))
        #expect(TimeInterval.fromTimeIntervalString("PT1M")! == Double(1 * 60))
        #expect(TimeInterval.fromTimeIntervalString("PT1S")! == Double(1))
        #expect(TimeInterval.fromTimeIntervalString("PT0.001S")! == Double(0.001))

        // 1year + 1day + 1hr + 1min + 1s + 1ms
        #expect(TimeInterval.fromTimeIntervalString("P365DT1H1M1.001S")! == 31_539_661.001)
    }
}

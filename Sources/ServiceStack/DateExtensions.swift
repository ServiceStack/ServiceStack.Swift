//
//  DateExtensions.swift
//  ServiceStack
//
//  Created by Demis Bellot on 1/30/15.
//  Copyright (c) 2021 ServiceStack, Inc. All rights reserved.
//

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Foundation

// From .NET DateTime (WCF JSON or ISO Date) to Swift Date
func fromDateTime(_ jsonDate:String) -> Date? {
    return Date.fromString(jsonDate)
}

// From Swift Date to .NET DateTime (WCF JSON Date)
func toDateTime(_ dateTime:Date) -> String {
    return dateTime.jsonDate;
}

public extension Date {
    init(dateString: String, format: String = "yyyy-MM-dd") {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone.default
        fmt.dateFormat = format
        let d = fmt.date(from: dateString)
        self.init(timeInterval: 0, since: d!)
    }

    init(year: Int, month: Int, day: Int) {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day

        let gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let d = gregorian?.date(from: c as DateComponents)
        self.init(timeInterval: 0, since: d!)
    }

    func components() -> DateComponents {
        let components = NSCalendar.current.dateComponents(
            [Calendar.Component.day, Calendar.Component.month, Calendar.Component.year],
            from: self as Date
        )

        return components
    }

    var year: Int {
        return components().year!
    }

    var month: Int {
        return components().month!
    }

    var day: Int {
        return components().day!
    }

    var shortDateString: String {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone.default
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt.string(from: self as Date)
    }

    var dateAndTimeString: String {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone.default
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return fmt.string(from: self as Date)
    }

    var jsonDate: String {
        let unixEpoch = Int64(timeIntervalSince1970 * 1000)
        return "/Date(\(unixEpoch)-0000)/"
    }

    var isoDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: self as Date).appendingFormat("Z")
    }

    static func fromIsoDateString(_ string: String) -> Date? {
        let isUtc = string.hasSuffix("Z")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = isUtc ? TimeZone(abbreviation: "UTC") : TimeZone.ReferenceType.default // TimeZone.ReferenceType.local
        dateFormatter.dateFormat = string.count == 19 || (isUtc && string.count == 20)
            ? "yyyy-MM-dd'T'HH:mm:ss"
            : "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"

        return isUtc
            ? dateFormatter.date(from: string[0 ..< string.count - 1])
            : dateFormatter.date(from: string)
    }

    static func fromString(_ string: String) -> Date? {
        let str = string.hasPrefix("\\")
            ? string[1 ..< string.count]
            : string
        let wcfJsonPrefix = "/Date("
        if str.hasPrefix(wcfJsonPrefix) {
            let body = str.splitOn(first: "(")[1].splitOn(last: ")")[0]
            let unixTime = (
                body.splitOn(first: "-", startIndex: 1)[0]
                    .splitOn(first: "+", startIndex: 1)[0] as NSString
            ).doubleValue
            return Date(timeIntervalSince1970: unixTime / 1000) // ms -> secs
        }
        return Date.fromIsoDateString(string)
    }
}

public func > (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedDescending
}

public func >= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedDescending
        || lhs == rhs
}

public func < (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedAscending
}

public func <= (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedAscending
        || lhs == rhs
}

public func == (lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedSame
}

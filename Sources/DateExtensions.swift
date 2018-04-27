//
//  DateExtensions.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 1/30/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public extension Date {
    
    public init(dateString:String, format:String="yyyy-MM-dd") {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone.default
        fmt.dateFormat = format
        let d = fmt.date(from: dateString)
        self.init(timeInterval:0, since:d!)
    }
    
    public init(year:Int, month:Int, day:Int) {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        let gregorian = NSCalendar(identifier:NSCalendar.Identifier.gregorian)
        let d = gregorian?.date(from: c as DateComponents)
        self.init(timeInterval:0, since:d!)
    }
    
    public func components() -> DateComponents {
        let components  = NSCalendar.current.dateComponents(
            [Calendar.Component.day, Calendar.Component.month, Calendar.Component.year],
            from: self as Date)
        
        return components
    }
    
    public var year:Int {
        return components().year!
    }
    
    public var month:Int {
        return components().month!
    }
    
    public var day:Int {
        return components().day!
    }
    
    public var shortDateString:String {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone.default
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt.string(from: self as Date)
    }
    
    public var dateAndTimeString:String {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone.default
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return fmt.string(from: self as Date)
    }
    
    public var jsonDate:String {
        let unixEpoch = Int64(self.timeIntervalSince1970 * 1000)
        return "/Date(\(unixEpoch)-0000)/"
    }
    
    public var isoDateString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: self as Date).appendingFormat("Z")
    }
    
    public static func fromIsoDateString(_ string:String) -> Date? {
        let isUtc = string.hasSuffix("Z")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        dateFormatter.timeZone = isUtc ? TimeZone(abbreviation: "UTC") : TimeZone.ReferenceType.default // TimeZone.ReferenceType.local
        dateFormatter.dateFormat = string.length == 19 || (isUtc && string.length == 20)
            ? "yyyy-MM-dd'T'HH:mm:ss"
            : "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"

        return isUtc
            ? dateFormatter.date(from: string[0..<string.length-1])
            : dateFormatter.date(from: string)
    }
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedDescending
}
public func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedDescending
        || lhs == rhs
}
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedAscending
}
public func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedAscending
        || lhs == rhs
}
public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedSame
}

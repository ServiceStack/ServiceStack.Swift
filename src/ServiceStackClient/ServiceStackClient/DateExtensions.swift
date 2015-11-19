//
//  DateExtensions.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 1/30/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public extension NSDate {
    
    public convenience init(dateString:String, format:String="yyyy-MM-dd") {
        let fmt = NSDateFormatter()
        fmt.timeZone = NSTimeZone.defaultTimeZone()
        fmt.dateFormat = format
        let d = fmt.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    public convenience init(year:Int, month:Int, day:Int) {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        let gregorian = NSCalendar(identifier:NSCalendarIdentifierGregorian)
        let d = gregorian?.dateFromComponents(c)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    public func components() -> NSDateComponents {
        let components  = NSCalendar.currentCalendar().components(
            [NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year],
            fromDate: self)
        
        return components
    }
    
    public var year:Int {
        return components().year
    }
    
    public var month:Int {
        return components().month
    }
    
    public var day:Int {
        return components().day
    }
    
    public var shortDateString:String {
        let fmt = NSDateFormatter()
        fmt.timeZone = NSTimeZone.defaultTimeZone()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt.stringFromDate(self)
    }
    
    public var dateAndTimeString:String {
        let fmt = NSDateFormatter()
        fmt.timeZone = NSTimeZone.defaultTimeZone()
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return fmt.stringFromDate(self)
    }
    
    public var jsonDate:String {
        let unixEpoch = Int(self.timeIntervalSince1970 * 1000)
        return "/Date(\(unixEpoch)-0000)/"
    }
    
    public var isoDateString:String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.stringFromDate(self).stringByAppendingString("Z")
    }
    
    public class func fromIsoDateString(string:String) -> NSDate? {
        let isUtc = string.hasSuffix("Z")
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = isUtc ? NSTimeZone(abbreviation: "UTC") : NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = string.length == 19 || (isUtc && string.length == 20)
            ? "yyyy-MM-dd'T'HH:mm:ss"
            : "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        
        return isUtc
            ? dateFormatter.dateFromString(string[0..<string.length-1])
            : dateFormatter.dateFromString(string)
    }
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedDescending
}
public func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedDescending
        || lhs == rhs
}
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}
public func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
        || lhs == rhs
}
public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedSame
}
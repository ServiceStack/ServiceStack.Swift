//
//  StringExtensions.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 1/30/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public extension String
{
    public var count: Int { return countElements(self) }
    
    public func contains(s:String) -> Bool {
        return (self as NSString).containsString(s)
    }
    
    public func trim() -> String {
        return (self as String).stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
    }
    
    public subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
    
    public func urlEncode() -> String? {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
    }
    
    public func combinePath(path:String) -> String {
        return (self.hasSuffix("/") ? self : self + "/") + (path.hasPrefix("/") ? path[1..<path.count] : path)
    }
    
    public func splitOnFirst(separator:String) -> [String] {
        var to = [String]()
        if let range = self.rangeOfString(separator) {
            to.append(self[startIndex..<range.startIndex])
            to.append(self[range.endIndex..<endIndex])
        }
        else {
            to.append(self)
        }
        return to
    }
    
    public func splitOnLast(separator:String) -> [String] {
        var to = [String]()
        if let range = self.rangeOfString(separator, options:NSStringCompareOptions.BackwardsSearch) {
            to.append(self[startIndex..<range.startIndex])
            to.append(self[range.endIndex..<endIndex])
        }
        else {
            to.append(self)
        }
        return to
    }
    
    public func split(separator:String) -> [String] {
        return self.componentsSeparatedByString(separator)
    }
    
    public func indexOf(needle:String) -> Int {
        if let range = self.rangeOfString(needle) {
            return distance(startIndex, range.startIndex)
        }
        return -1
    }
    
    public func lastIndexOf(needle:String) -> Int {
        if let range = self.rangeOfString(needle, options:NSStringCompareOptions.BackwardsSearch) {
            return distance(startIndex, range.startIndex)
        }
        return -1
    }
    
    public func replace(needle:String, withString:String) -> String {
        return self.stringByReplacingOccurrencesOfString(needle, withString: withString)
    }
    
    public func toDouble() -> Double {
        return (self as NSString).doubleValue
    }
    
    public func print() -> String {
        println(self)
        return self
    }
}

extension Array
{
    func print() -> String {
        var sb = ""
        for item in self {
            if sb.count > 0 {
                sb += ","
            }
            sb += "\(item)"
        }
        println(sb)
        return sb
    }
}


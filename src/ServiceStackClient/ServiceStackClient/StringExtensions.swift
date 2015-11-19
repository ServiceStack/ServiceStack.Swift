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
    public var length: Int { return self.characters.count }
    
    public func contains(s:String) -> Bool {
        return (self as NSString).containsString(s)
    }
    
    public func trim() -> String {
        return (self as String).stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
    }
    
    public func trimEnd(needle: Character) -> String {
        var i: Int = self.characters.count - 1, j: Int = i
        
        while i >= 0 && self[self.startIndex.advancedBy(i)] == needle {
            --i
        }
        
        return self.substringWithRange(Range<String.Index>(start: self.startIndex, end: self.endIndex.advancedBy(-(j - i))))
    }
    
    public subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
    
    public func urlEncode() -> String? {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
    }
    
    public func combinePath(path:String) -> String {
        return (self.hasSuffix("/") ? self : self + "/") + (path.hasPrefix("/") ? path[1..<path.length] : path)
    }

    public func splitOnFirst(separator:String) -> [String] {
        return splitOnFirst(separator, startIndex: 0)
    }
    
    public func splitOnFirst(separator:String, startIndex:Int) -> [String] {
        var to = [String]()
        
        let startRange = self.startIndex.advancedBy(startIndex)
        if let range = self.rangeOfString(separator,
            options: NSStringCompareOptions.LiteralSearch,
            range: Range<String.Index>(start: startRange, end: self.endIndex))
        {
            to.append(self[self.startIndex..<range.startIndex])
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
            return startIndex.distanceTo(range.startIndex)
        }
        return -1
    }
    
    public func lastIndexOf(needle:String) -> Int {
        if let range = self.rangeOfString(needle, options:NSStringCompareOptions.BackwardsSearch) {
            return startIndex.distanceTo(range.startIndex)
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
        Swift.print(self)
        return self
    }
    
    public func stripQuotes() -> String {
        return self.hasPrefix("\"") && self.hasSuffix("\"")
            ? self[1..<self.length-1]
            : self
    }
}

extension Array
{
    func print() -> String {
        var sb = ""
        for item in self {
            if sb.length > 0 {
                sb += ","
            }
            sb += "\(item)"
        }
        Swift.print(sb)
        return sb
    }
}

extension NSData
{
    func toUtf8String() -> String? {
        if let str = NSString(data: self, encoding: NSUTF8StringEncoding) {
            return str as String
        }
        return nil
    }
    
    func print() -> String {
        return self.toUtf8String()!.print()
    }
}

extension NSError
{
    func convertUserInfo<T : JsonSerializable>() -> T? {
        return self.populateUserInfo(T())
    }

    func populateUserInfo<T : JsonSerializable>(instance:T) -> T? {
        let to = populateFromDictionary(T(), map: self.userInfo, propertiesMap: T.propertyMap)
        return to
    }
}

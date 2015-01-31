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
}
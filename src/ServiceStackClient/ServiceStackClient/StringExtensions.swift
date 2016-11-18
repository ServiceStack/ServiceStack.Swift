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

    func index(_ from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    public func contains(s:String) -> Bool {
        return (self as NSString).contains(s)
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    public func trimEnd(_ needle: Character) -> String {
        var i: Int = self.characters.count - 1
        
        while i >= 0 && self[self.index(self.startIndex, offsetBy: i)] == needle {
            i -= 1
        }
        
        let s = self.substring(to: index(i + 1))
        return s
    }
    
    public subscript (i: Int) -> Character {
        return self[index(i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    public subscript (r: Range<Int>) -> String {
        return substring(with: index(r.lowerBound)..<index(r.upperBound))
    }
    
    public func urlEncode() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlHostAllowed)
    }
    
    public func combinePath(_ path:String) -> String {
        return (self.hasSuffix("/") ? self : self + "/") + (path.hasPrefix("/") ? path[1..<path.length] : path)
    }

    public func splitOn(first:String) -> [String] {
        return splitOn(first: first, startIndex: 0)
    }
    
    public func splitOn(first:String, startIndex:Int) -> [String] {
        var to = [String]()
        
        let startRange = index(startIndex)
        if let range = self.range(of: first,
            options: NSString.CompareOptions.literal,
            range: startRange ..< self.endIndex)
        {
            to.append(self[self.startIndex..<range.lowerBound])
            to.append(self[range.upperBound..<endIndex])
        }
        else {
            to.append(self)
        }
        return to
    }
    
    public func splitOn(last:String) -> [String] {
        var to = [String]()
        if let range = self.range(of: last, options:NSString.CompareOptions.backwards) {
            to.append(self[startIndex..<range.lowerBound])
            to.append(self[range.upperBound..<endIndex])
        }
        else {
            to.append(self)
        }
        return to
    }
    
    public func split(_ separator:String) -> [String] {
        return self.components(separatedBy: separator)
    }
    
    public func indexOf(_ needle:String) -> Int {
        if let range = self.range(of: needle) {
            return self.distance(from: startIndex, to: range.lowerBound)
        }
        return -1
    }
    
    public func lastIndexOf(_ needle:String) -> Int {
        if let range = self.range(of: needle, options:NSString.CompareOptions.backwards) {
            return self.distance(from: startIndex, to: range.lowerBound)
        }
        return -1
    }
    
    public func replace(_ needle:String, withString:String) -> String {
        return self.replacingOccurrences(of: needle, with: withString)
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

extension Data
{
    func toUtf8String() -> String? {
        if let str = NSString(data: self as Data, encoding: String.Encoding.utf8.rawValue) {
            return str as String
        }
        return nil
    }
    
    func print() -> String {
        return self.toUtf8String()!.print()
    }
}

extension Error
{
    func convertUserInfo<T : JsonSerializable>() -> T? {
        return self.populateUserInfo(instance: T())
    }

    func populateUserInfo<T : JsonSerializable>(instance:T) -> T? {
        let to = populateFromDictionary(instance: T(), map: (self as NSError).userInfo, propertiesMap: T.propertyMap)
        return to
    }

    var responseStatus:ResponseStatus {
        return (self as NSError).responseStatus
    }
}

extension NSError {
    var responseStatus:ResponseStatus {
        let status:ResponseStatus = self.convertUserInfo() ?? ResponseStatus()
        if status.errorCode == nil {
            status.errorCode = self.code.toString()
        }
        if status.message == nil {
            status.message = self.localizedDescription
        }
        return status
    }
}


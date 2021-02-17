//
//  StringExtensions.swift
//  ServiceStack
//
//  Created by Demis Bellot on 1/30/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start ..< end])
    }

    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }

    subscript(i: Int) -> Character {
        return self[index(i)]
    }

    subscript(i: Int) -> String {
        return String(self[i] as Character)
    }

    func index(_ from: Int) -> Index {
        return index(startIndex, offsetBy: from)
    }

    func contains(s: String) -> Bool {
        return (self as NSString).contains(s)
    }

    func trim() -> String {
        return trimmingCharacters(in: NSCharacterSet.whitespaces)
    }

    func trimEnd(_ needle: Character) -> String {
        var i: Int = count - 1

        while i >= 0 && self[self.index(self.startIndex, offsetBy: i)] == needle {
            i -= 1
        }

        let s = String(prefix(upTo: index(i + 1)))
        return s
    }

    func urlEncode() -> String? {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
    }

    func combinePath(_ path: String) -> String {
        return (hasSuffix("/") ? self : self + "/") + (path.hasPrefix("/") ? path[1 ..< path.count] : path)
    }

    func leftPart(_ needle: String) -> String {
        let pos = indexOf(needle)
        return pos == -1 ? self : self[0 ..< pos]
    }

    func lastLeftPart(_ needle: String) -> String {
        let pos = lastIndexOf(needle)
        return pos == -1 ? self : self[0 ..< pos]
    }

    func rightPart(_ needle: String) -> String {
        let pos = indexOf(needle)
        return pos == -1 ? self : self[(pos + needle.count)...]
    }

    func lastRightPart(_ needle: String) -> String {
        let pos = lastIndexOf(needle)
        return pos == -1 ? self : self[(pos + needle.count)...]
    }

    func splitOn(first: String) -> [String] {
        return splitOn(first: first, startIndex: 0)
    }

    func splitOn(first: String, startIndex: Int) -> [String] {
        var to = [String]()

        let startRange = index(startIndex)
        if let range = self.range(of: first,
                                  options: NSString.CompareOptions.literal,
                                  range: startRange ..< self.endIndex) {
            to.append(String(self[self.startIndex ..< range.lowerBound]))
            to.append(String(self[range.upperBound ..< endIndex]))
        } else {
            to.append(self)
        }
        return to
    }

    func splitOn(last: String) -> [String] {
        var to = [String]()
        if let range = self.range(of: last, options: NSString.CompareOptions.backwards) {
            to.append(String(self[startIndex ..< range.lowerBound]))
            to.append(String(self[range.upperBound ..< endIndex]))
        } else {
            to.append(self)
        }
        return to
    }

    func split(_ separator: String) -> [String] {
        return components(separatedBy: separator)
    }

    func indexOf(_ needle: String) -> Int {
        if let range = self.range(of: needle) {
            return distance(from: startIndex, to: range.lowerBound)
        }
        return -1
    }

    func lastIndexOf(_ needle: String) -> Int {
        if let range = self.range(of: needle, options: NSString.CompareOptions.backwards) {
            return distance(from: startIndex, to: range.lowerBound)
        }
        return -1
    }

    func replace(_ needle: String, withString: String) -> String {
        return replacingOccurrences(of: needle, with: withString)
    }

    func toDouble() -> Double {
        return (self as NSString).doubleValue
    }

    func print() -> String {
        Swift.print(self)
        return self
    }

    func stripQuotes() -> String {
        return hasPrefix("\"") && hasSuffix("\"")
            ? self[1 ..< self.count - 1]
            : self
    }

    func firstUppercased() -> String {
        guard let first = first else { return "" }
        return String(first).uppercased() + dropFirst()
    }

    func firstLowercased() -> String {
        guard let first = first else { return "" }
        return String(first).lowercased() + dropFirst()
    }
}

public extension Array {
    func print() -> String {
        var sb = ""
        for item in self {
            if sb.count > 0 {
                sb += ","
            }
            sb += "\(item)"
        }
        Swift.print(sb)
        return sb
    }
}

public extension Data {
    func toUtf8String() -> String? {
        if let str = NSString(data: self as Data, encoding: String.Encoding.utf8.rawValue) {
            return str as String
        }
        return nil
    }

    func print() -> String {
        return toUtf8String()!.print()
    }
}

public extension Error {
    func convertUserInfo<T: JsonSerializable>() -> T? {
        return populateUserInfo(instance: T())
    }

    func populateUserInfo<T: JsonSerializable>(instance _: T) -> T? {
        let to = populateFromDictionary(instance: T(), map: (self as NSError).userInfo, propertiesMap: T.propertyMap)
        return to
    }

    var responseStatus: ResponseStatus {
        return (self as NSError).responseStatus
    }
}

public extension NSError {
    var responseStatus: ResponseStatus {
        let status: ResponseStatus = convertUserInfo() ?? ResponseStatus()
        if status.errorCode == nil {
            status.errorCode = code.toString()
        }
        if status.message == nil {
            status.message = localizedDescription
        }
        return status
    }
}

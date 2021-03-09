//
// Created by Demis Bellot on 2/19/21.
// Copyright (c) 2021 ServiceStack. All rights reserved.
//

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Foundation

public protocol Instantiable {
    init()
}

public protocol Dto: Codable, Instantiable {}
public protocol RequestDto: IReturn, Codable {}

public protocol IReturn {
    associatedtype Return: Codable
}

public protocol IReturnVoid: Instantiable {}

public protocol IGet {}
public protocol IPost {}
public protocol IPut {}
public protocol IDelete {}
public protocol IPatch {}

public protocol IHasSessionId {
    var sessionId: String? { get set }
}
public protocol IHasBearerToken {
    var bearerToken: String? { get set }
}
public protocol IMeta {
    var meta: [String: String] { get set }
}
public protocol IHasVersion {
    var version: Int? { get set }
}

public class ResponseStatus: Dto {
    public var errorCode: String?
    public var message: String?
    public var stackTrace: String?
    public var errors: [ResponseError] = []
    public var meta: [String: String] = [:]

    public required init() {}
}

public class ResponseError: Dto {
    public var errorCode: String?
    public var fieldName: String?
    public var message: String?
    public var meta: [String: String] = [:]

    public required init() {}
}

public class ErrorResponse: Dto {
    public var responseStatus: ResponseStatus?
    public required init() {}
}

public class EmptyResponse : Codable
{
    public var responseStatus:ResponseStatus?
    required public init(){}
}

public class GetAccessToken : IReturn, IPost, Codable
{
    public typealias Return = GetAccessTokenResponse
    public var refreshToken:String?
    public var useTokenCookie:Bool?
    public var meta:[String:String] = [:]

    required public init(){}
}
public class GetAccessTokenResponse : Codable
{
    public var accessToken:String?
    public var meta:[String:String] = [:]
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class NavItem: Dto {
    public var label: String?
    public var href: String?
    public var exact: Bool?
    public var id: String?
    public var className: String?
    public var iconHtml: String?
    public var show: String?
    public var hide: String?
    public var children: [NavItem] = []
    public var meta: [String: String] = [:]
    public required init() {}
}

public class GetNavItems: Codable {
    public required init() {}
}

public class GetNavItemsResponse: Codable {
    public var baseUrl: String?
    public var results: [NavItem] = []
    public var navItemsMap: [String: [NavItem]] = [:]
    public var meta: [String: String] = [:]
    public var responseStatus: ResponseStatus?
    public required init() {}
}

open class List<T: Codable>: Codable, Instantiable {
    public required init() {}

    open func encode(to encoder: Encoder) throws {
    }
}

public class ReturnVoid: Dto, IReturnVoid {
    public required init() {}
    public static let void = ReturnVoid()
}

public class HttpWebResponse {
    public required init() {}
}

extension Double {
    public static func fromString(_ str: String) -> Double? {
        return str.hasPrefix("P")
            ? TimeInterval.fromTimeIntervalString(str)
            : (str as NSString).doubleValue
    }

    public static func fromObject(_ any: Any) -> Double? {
        switch any {
        case let d as Double: return d
        case let f as Float: return Double(f)
        case let i as Int: return Double(i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

@propertyWrapper
public struct TimeSpan {
    public var wrappedValue: TimeInterval? = 0
    public init(wrappedValue: TimeInterval?) {
        self.wrappedValue = wrappedValue
    }
    public static func parse(_ timeSpan:String) -> TimeInterval? {
        return TimeInterval.fromString(timeSpan)
    }
}

extension TimeSpan : Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if container.decodeNil() {
            self.wrappedValue = nil
        } else {
            let encoded = try container.decode(String.self)
            self.wrappedValue = TimeInterval.fromString(encoded)
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        guard let string = self.wrappedValue?.toXsdDuration() else {
            try container.encodeNil()
            return
        }
        try container.encode(string)
    }
}

//class Example: Codable {
//    @TimeSpan var time: TimeInterval
//}

public class TimeIntervalConveter : StringConvertible {
    public func fromString<T>(_ type: T.Type, _ string: String) -> T? {
        return TimeInterval.fromString(string) as? T
    }
    public func toString<T>(instance: T) -> String? {
        return (instance as! TimeInterval).toXsdDuration()
    }
}

public protocol StringConvertible {
    func fromString<T>(_ type: T.Type, _ string:String) -> T?
    func toString<T>(instance:T) -> String?
}
public class StringConverter<C> : StringConvertible where C: LosslessStringConvertible {
    var from: ((String) -> C?)
    var to: ((C) -> String?)
    
    public init(_ type: C.Type) {
        from = { (s:String) in
            type.init(s)
        }
        to = { (t:C) in
            t.description            
        }
    }

    public func fromString<T>(_ type: T.Type, _ string: String) -> T? {
        return from(string) as! T?
    }

    public func toString<T>(instance: T) -> String? {
        return to(instance as! C)
    }
}

//func example() {
//    Converters.register(TimeIntervalConveter.self, forType: Reflect<TimeInterval>.typeName)
//    Converters.register(TimeIntervalConveter.self)
//    Converters.register(TimeInterval.self)
//}

public class Converters {
    
    static var map: [String:StringConvertible] = {
        let to = [Reflect<TimeInterval>.typeName: TimeIntervalConveter()]
        return to
    }()
    
    public static func registerConvertible<T>(_ convertible:T, forType:String) where T: StringConvertible {
        map[forType] = convertible
    }

    public static func register<T>(_ type: T.Type, forType:String) where T: LosslessStringConvertible {
        map[forType] = StringConverter(type.self)
    }

    public static func register<T>(_ type: T.Type) where T: LosslessStringConvertible {
        let typeName = Reflect<T>.typeName
        register(type, forType: typeName)
    }
    
    public static func get<T>(_ type:T.Type) -> StringConvertible? {
        let typeName = String(describing: T.self)
        let converter = map[typeName]
        return converter
    }
}

//Example: https://stablekernel.com/article/understanding-extending-swift-4-codable/
extension KeyedDecodingContainer {
    public func convertIfPresent<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T? where T : Decodable {
        if let string = try self.decodeIfPresent(String.self, forKey: key),
           let converter = Converters.get(type),
           let ret:T = converter.fromString(T.self, string) {
            return ret
        }
        return nil
    }
    
    public func decode(_ type: TimeSpan.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> TimeSpan {
        return try decodeIfPresent(type, forKey: key) ?? TimeSpan(wrappedValue: nil)
    }
    
    public func decode<Key,Val>(_ type: Dictionary<Key,Val>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Dictionary<Key,Val> where Key : Decodable & Hashable, Val : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? [:]
    }
    
    public func decode<Val>(_ type: Array<Val>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Array<Val> where Val : Decodable {
        return try decodeIfPresent(type, forKey: key) ?? []
    }
}

extension TimeInterval {
    public static let ticksPerSecond: Double = 10_000_000

    public func toXsdDuration() -> String {
        var sb = "P"

        let totalSeconds: Double = self
        let wholeSeconds = Int(totalSeconds)
        var seconds = wholeSeconds
        let sec = (seconds >= 60 ? seconds % 60 : seconds)
        seconds = (seconds / 60)
        let min = seconds >= 60 ? seconds % 60 : seconds
        seconds = (seconds / 60)
        let hours = seconds >= 24 ? seconds % 24 : seconds
        let days = seconds / 24
        let remainingSecs: Double = Double(sec) + (totalSeconds - Double(wholeSeconds))

        if days > 0 {
            sb += "\(days)D"
        }

        if days == 0 || Double(hours + min + sec) + remainingSecs > 0 {
            sb += "T"
            if hours > 0 {
                sb += "\(hours)H"
            }
            if min > 0 {
                sb += "\(min)M"
            }

            if remainingSecs > 0 {
                var secFmt = String(format: "%.7f", remainingSecs)
                secFmt = secFmt.trimEnd("0").trimEnd(".")
                sb += "\(secFmt)S"
            } else if sb.count == 2 { // PT
                sb += "0S"
            }
        }

        return sb
    }

    public static func fromXsdDuration(_ xsdString: String) -> TimeInterval? {
        return TimeInterval.fromTimeIntervalString(xsdString)
    }

    public static func fromTimeIntervalString(_ string: String) -> TimeInterval? {
        var days = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        var ms = 0.0

        let t = string[1 ..< string.count].splitOn(first: "T") // strip P

        let hasTime = t.count == 2

        let d = t[0].splitOn(first: "D")
        if d.count == 2 {
            if let day = Int(d[0]) {
                days = day
            }
        }

        if hasTime {
            let h = t[1].splitOn(first: "H")
            if h.count == 2 {
                if let hour = Int(h[0]) {
                    hours = hour
                }
            }

            let m = h.last!.splitOn(first: "M")
            if m.count == 2 {
                if let min = Int(m[0]) {
                    minutes = min
                }
            }

            let s = m.last!.splitOn(first: "S")
            if s.count == 2 {
                ms = s[0].toDouble()
            }

            seconds = Int(ms)
            ms -= Double(seconds)
        }

        let totalSecs = 0
            + (days * 24 * 60 * 60)
            + (hours * 60 * 60)
            + (minutes * 60)
            + seconds

        let interval = Double(totalSecs) + ms

        return interval
    }

    public static func fromTimeIntervalObject(_ any: AnyObject) -> TimeInterval? {
        switch any {
        case let s as String: return fromTimeIntervalString(s)
        case let t as TimeInterval: return t
        default: return nil
        }
    }
}

public class Guid {
    public static func parse(_ guid:String) -> String? {
        return guid
    }
}


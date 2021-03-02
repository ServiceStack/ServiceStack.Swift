//
//  Utils.swift
//  ServiceStack
//
//  Created by Demis Bellot on 2/19/21.
//  Copyright © 2021 ServiceStack. All rights reserved.
//

import Foundation

public class Factory<T: Decodable> {
    public static func create() -> T {
        return try! T(from: EmptyDecoder.instance)
    }
}

public class Reflect<T> {
    public static var typeName: String {
        return String(describing: T.self)
    }
}

open class Logger {
    func log(_ level:LogLevel, _ msg:String, error:Error? = nil) {
    }
}
public class ConsoleLogger : Logger {
    override func log(_ level: LogLevel, _ msg: String, error:Error? = nil) {
        print("\(level): \(msg)")
    }
}
public enum LogLevel : String {
    case Debug, Info, Warn, Error
}
public class Log {
    public static var levels:[LogLevel] = [.Warn, .Error]
    public static var logger:Logger = ConsoleLogger()

    public static func debug(_ msg:String) {
        if levels.contains(.Debug) {
            logger.log(.Debug, msg)
        }
    }
    public static func info(_ msg:String) {
        if levels.contains(.Info) {
            logger.log(.Info, msg)
        }
    }
    public static func warn(_ msg:String) {
        if levels.contains(.Warn) {
            logger.log(.Warn, msg)
        }
    }
    public static func error(_ msg:String) {
        if levels.contains(.Error) {
            logger.log(.Error, msg)
        }
    }
    public static func error(_ msg:String, error:Error) {
        if levels.contains(.Error) {
            logger.log(.Error, msg, error:error)
        }
    }
}

public func unwrap<T>(_ any: T) -> Any {
    if let enc = any as? AnyEncodable {
        return unwrap(enc.value)
    }
    let mirror = Mirror(reflecting: any)
    guard mirror.displayStyle == .optional, let first = mirror.children.first else {
        return any
    }
    return first.value
}

public extension Encodable {
    fileprivate func encode(to container: inout SingleValueEncodingContainer) throws {
        try container.encode(self)
    }
}

public func isNull(_ instance:Any) -> Bool {
    if case Optional<Any>.none = instance {
        return true
    }
    let valueMirror = Mirror(reflecting: instance)
    if let prop = valueMirror.children.first(where: { $0.label == "wrappedValue" }) {
        return isNull(prop.value)
    }
    return false
}

public struct AnyEncodable: Encodable {
    public var value: Encodable
    public init(_ value: Encodable) {
        self.value = value
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try value.encode(to: &container)
    }

    public static func properties(_ instance: Any) -> [String: AnyEncodable] {
        let mirror = Mirror(reflecting: instance)
        var allMirrors = [Mirror]()
        var current: Mirror? = mirror
        while current != nil {
            allMirrors.append(current!)
            current = current!.superclassMirror
        }
        let subMirrors = allMirrors.reversed()
        var props: [String: AnyEncodable] = [:]
        for m in subMirrors {
            for prop in m.children {
                guard var label = prop.label else { continue }
                if label.first == "_" {
                    let propValueMirror = Mirror(reflecting: prop.value)
                    if propValueMirror.children.contains(where: { $0.label == "wrappedValue" }) {
                        label = String(label.dropFirst())
                    }
                }
                if let enc = asEncodable(prop.value) {
                    props[label] = enc
                }
            }
        }
        return props
    }

    public static func asEncodable(_ instance: Any) -> AnyEncodable? {
        if isNull(instance) {
            return nil
        }
        let propValue = unwrap(instance)
        if let enc = propValue as? Encodable {
            return AnyEncodable(enc)
        }
        //NSString, et al
        switch propValue {
        case is NSNull:
            return nil
        case let s as String:
            return AnyEncodable(s)
        case let i as Int8:
            return AnyEncodable(i)
        case let i as Int16:
            return AnyEncodable(i)
        case let i as Int32:
            return AnyEncodable(i)
        case let i as Int64:
            return AnyEncodable(i)
        case let i as UInt8:
            return AnyEncodable(i)
        case let i as UInt16:
            return AnyEncodable(i)
        case let i as UInt32:
            return AnyEncodable(i)
        case let i as UInt64:
            return AnyEncodable(i)
        case let i as Double:
            return AnyEncodable(i)
        case let i as Float:
            return AnyEncodable(i)
        case let i as Bool:
            return AnyEncodable(i)
        case let c as CustomStringConvertible:
            return AnyEncodable(c.description)
        default:
            Log.warn("'\(propValue)' is not Encodable")
            return nil
        }
    }
}

func hasJsvEscapeChars(_ s: String) -> Bool {
    return s.indexOf("\"") >= 0 || s.indexOf(",") >= 0 || s.indexOf("\r") >= 0 || s.indexOf("\n") >= 0
}

public func toJsv<T>(_ instance: T) throws -> String? where T: Encodable {
    let o: Any = unwrap(instance)
    switch o {
    case is Int8, is Int16, is Int32, is Int64, is UInt8, is UInt16, is UInt32, is UInt64, is Double, is Float, is Bool:
        return "\(o)"
    case let s as String:
        if hasJsvEscapeChars(s) {
            return "\"" + s.replace("\"", withString: "\\\"") + "\""
        }
        return s
    case let d as Date:
        return d.jsonDate
    case let t as TimeInterval:
        return t.toXsdDuration()
    default:
        if let data = toJsonData(instance) {
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            switch jsonObj {
            case let string as String:
                return string
            case let array as [Any]:
                var sb = ""
                for item in array {
                    if let enc = AnyEncodable.asEncodable(item) {
                        if sb.count > 0 {
                            sb += ","
                        }
                        sb += try toJsv(enc)!
                    }
                }
                return "[\(sb)]"
            case let map as [String: Any]:
                var sb = ""
                for kvp in map {
                    if let enc = AnyEncodable.asEncodable(kvp.value) {
                        if sb.count > 0 {
                            sb += ","
                        }
                        sb += kvp.key + ":"
                        sb += try toJsv(enc)!
                    }
                }
                return "{\(sb)}"
            case is Int8, is Int16, is Int32, is Int64, is UInt8, is UInt16, is UInt32, is UInt64, is Double, is Float, is Bool:
                return "\(jsonObj)"
            case is NSNull:
                return nil
            default:
                Log.error("toJsv(): Could not serialize unknown '\(jsonObj)'")
                return nil
            }
        }
        Log.warn("toJsv(): Could not serialize unknown '\(instance)'")
        return nil
    }
}

public class JsonConfig {
    
    public static var encoderFilter: ((JSONEncoder) -> Void)?
    public static var decoderFilter: ((JSONDecoder) -> Void)?

    public static func createEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom({ date, encoder in
            var container = encoder.singleValueContainer()
            try container.encode(date.jsonDate)
        })
        if let filter = encoderFilter {
            filter(encoder)
        }
        return encoder
    }
    
    public static var keywords = [
        "class", "deinit", "description", "enum", "extension", "func", "import", "init", "let", "protocol", "static",
        "struct", "subscript", "typealias", "associatedtype", "var", "break", "case", "continue", "default", "do",
        "else", "fallthrough", "if", "in", "for", "return", "switch", "where", "while", "dynamicType", "is", "new",
        "super", "self", "didSet", "get", "infix", "inout", "left", "mutating", "none", "nonmutating", "operator",
        "override", "postfix", "precedence", "prefix", "private", "public", "right", "set", "unowned", "weak", "willSet"]

    public static func createDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        //https://martiancraft.com/blog/2018/08/Implementing-custom-key-strategy-for-coding-types/
        decoder.keyDecodingStrategy = .custom { keys in
            let lastKey = keys.last! // If only there was a non-empty array type...
            if lastKey.intValue != nil {
                return lastKey // It's an array key, we don't need to change anything
            }
            //remove _ prefix from @propertyWrapper properties
            let keyString = lastKey.stringValue
            if keyString.starts(with: "_") {
                return AnyKey(stringValue: String(keyString.dropFirst())) ?? lastKey
            }
            if keywords.contains(keyString) {
                let useKey = keyString.prefix(1).uppercased() + keyString.dropFirst()
                return AnyKey(stringValue:useKey) ?? lastKey
            }
            return lastKey
        }
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let string = try decoder.singleValueContainer().decode(String.self)
            return Date.fromString(string) ?? Date()
        })
        if let filter = decoderFilter {
            filter(decoder)
        }
        return decoder
    }

}

//from: https://stackoverflow.com/a/54698077/85785
struct AnyKey : CodingKey {
    var stringValue: String
    var intValue: Int?
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}

public func toJson<T>(_ instance: T) -> String? where T: Encodable {
    if let data = toJsonData(instance) {
        return String(data: data, encoding: .utf8)
    }
    return nil
}

public func toJsonData<T>(_ instance: T) -> Data? where T: Encodable {
    do {
        let json = try JsonConfig.createEncoder().encode(instance)
        return json
    } catch let e {
        Log.error("toJsonData(): \(e)", error: e)
    }
    return nil
}

public func fromJson<T>(_ type: T.Type, _ json: String) -> T? where T: Decodable {
    return fromJsonData(type, json.data(using: .utf8)!)
}

public func fromJsonData<T>(_ type: T.Type, _ json: Data) -> T? where T: Decodable {
    do {
        let to = try fromJsonDataThrows(type, json)
        return to
    } catch let e {
        Log.error("fromJsonData(): \(e)\n\(String(data:json, encoding:.utf8)!)", error: e)
    }
    return nil
}

public func fromJsonDataThrows<T>(_ type: T.Type, _ json: Data) throws -> T where T: Decodable {
    do {
        let to = try JsonConfig.createDecoder().decode(type, from: json)
        return to
    } catch let e {
        Log.error("fromJsonDataThrows(): \(e)\n\(String(data:json, encoding:.utf8)!)", error: e)
        throw e
    }
}

public func parseJson(_ json: String) -> Any? {
    do {
        return try parseJsonThrows(json)
    } catch _ {
        return nil
    }
}

public func parseJsonThrows(_ json: String) throws -> Any {
    let data = json.data(using: String.Encoding.utf8)!
    return try parseJsonBytesThrows(data)
}

public func parseJsonBytes(_ bytes: Data) -> Any? {
    do {
        return try parseJsonBytesThrows(bytes)
    } catch _ {
        return nil
    }
}

public func parseJsonBytesThrows(_ bytes: Data) throws -> Any {
    var error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
    let parsedObject: Any?
    do {
        parsedObject = try JSONSerialization.jsonObject(
            with: bytes, options: JSONSerialization.ReadingOptions.allowFragments
        )
    } catch let error1 as NSError {
        error = error1
        parsedObject = nil
    }
    if let value = parsedObject {
        return value
    }
    throw error
}

public func urlCookies(_ url:URL) -> [String:String] {
    let cookieStorage = HTTPCookieStorage.shared
    let cookies = cookieStorage.cookies(for: url) ?? []
    var to = [String:String]()
    for cookie in cookies {
        to[cookie.name] = cookie.value
    }
    return to
}

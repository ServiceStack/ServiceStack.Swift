//
//  Json.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 1/17/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public class JObject
{
    var sb : String
    
    init(string : String? = nil) {
        sb = string ?? String()
    }
    
    func append(name: String, json: String?) {
        if sb.length > 0 {
            sb += ","
        }
        if let s = json {
            sb += "\"\(name)\":\(s)"
        }
        else {
            sb += "\"\(name)\":null"
        }
    }
    
    func toJson() -> String {
        return "{\(sb)}"
    }
    
    class func toJson<K : Hashable, V : JsonSerializable where K : StringSerializable>(map:[K:V]) -> String? {
        let jb = JObject()
        
        for (k,v) in map {
            jb.append(k.toString(), json: v.toJson())
        }
        
        return jb.toJson()
    }
}

public class JArray
{
    var sb : String
    
    init(string : String? = nil) {
        sb = string ?? String()
    }
    
    func append(json:String?) {
        if sb.characters.count > 0 {
            sb += ","
        }
        sb += json != nil ? "\(json!)" : "null"
    }
    
    func toJson() -> String {
        return "[\(sb)]"
    }
}

public class JValue
{
    static func unwrap(any:Any) -> Any {
        
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .Optional {
            return any
        }
        
        if mi.children.count == 0 { return NSNull() }
        let (_, some) = mi.children.first!
        return some
    }
}

func parseJson(json:String) -> AnyObject? {
    do {
        return try parseJsonThrows(json)
    } catch _ {
        return nil
    }
}

func parseJsonThrows(json:String) throws -> AnyObject {
    let data = json.dataUsingEncoding(NSUTF8StringEncoding)!
    return try parseJsonBytesThrows(data)
}

func parseJsonBytes(bytes:NSData) -> AnyObject? {
    do {
        return try parseJsonBytesThrows(bytes)
    } catch _ {
        return nil
    }
}

func parseJsonBytesThrows(bytes:NSData) throws -> AnyObject {
    var error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
    let parsedObject: AnyObject?
    do {
        parsedObject = try NSJSONSerialization.JSONObjectWithData(bytes,
                options: NSJSONReadingOptions.AllowFragments)
    } catch let error1 as NSError {
        error = error1
        parsedObject = nil
    }
    if let value = parsedObject {
        return value
    }
    throw error
}

extension NSString : JsonSerializable
{
    public static var typeName:String { return "NSString" }
    
    public static var metadata:Metadata = Metadata.create([])
    
    public func toString() -> String {
        return self as String
    }
    
    public func toJson() -> String {
        return jsonString(self as String)
    }
    
    public static func fromJson(json:String) -> NSString? {
        return parseJson(json) as? NSString
    }
    
    public static func fromString(string: String) -> NSString? {
        return string
    }
    
    public static func fromObject(any:AnyObject) -> NSString?
    {
        switch any {
        case let s as NSString: return s
        default:return nil
        }
    }
}

public class ReturnVoid {
    public required init(){}
}

extension ReturnVoid : JsonSerializable
{
    public static let void = ReturnVoid()
    
    public static var typeName:String { return "ReturnVoid" }
    
    public static var metadata:Metadata = Metadata.create([])
    
    public func toString() -> String {
        return ""
    }
    
    public func toJson() -> String {
        return ""
    }
    
    public static func fromJson(json:String) -> NSString? {
        return nil
    }
    
    public static func fromString(string: String) -> NSString? {
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> NSString?
    {
        return nil
    }
}

extension String : StringSerializable
{
    public static var typeName:String { return "String" }
    
    public func toString() -> String {
        return self
    }
    
    public func toJson() -> String {
        return jsonString(self)
    }
    
    public static func fromString(string: String) -> String? {
        return string
    }
    
    public static func fromObject(any:AnyObject) -> String?
    {
        switch any {
        case let s as String: return s
        default:return nil
        }
    }
}

extension String : JsonSerializable
{
    public static var metadata:Metadata = Metadata.create([])
    
    public static func fromJson(json:String) -> String? {
        return parseJson(json) as? String
    }
}

extension Character : StringSerializable
{
    public static var typeName:String { return "Character" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return jsonString(toString())
    }
    
    public static func fromString(string: String) -> Character? {
        return string.length > 0 ? string[0] : nil
    }
    
    public static func fromObject(any:AnyObject) -> Character?
    {
        switch any {
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension NSDate : StringSerializable
{
    public class var typeName:String { return "NSDate" }
    
    public func toString() -> String {
        return self.dateAndTimeString
    }
    
    public func toJson() -> String {
        return jsonString(self.isoDateString)
    }
    
    public class func fromString(string: String) -> NSDate? {
        let str = string.hasPrefix("\\")
            ? string[1..<string.length]
            : string
        let wcfJsonPrefix = "/Date("
        if str.hasPrefix(wcfJsonPrefix) {
            let body = str.splitOnFirst("(")[1].splitOnLast(")")[0]
            let unixTime = (
                body
                    .splitOnFirst("-", startIndex:1)[0]
                    .splitOnFirst("+", startIndex:1)[0] as NSString
            ).doubleValue
            return NSDate(timeIntervalSince1970: unixTime / 1000) //ms -> secs
        }
        
        return NSDate.fromIsoDateString(string)
    }
    
    public class func fromObject(any:AnyObject) -> NSDate?
    {
        switch any {
        case let s as String: return fromString(s)
        case let d as NSDate: return d
        default:return nil
        }
    }
}

extension Double : StringSerializable
{
    public static var typeName:String { return "Double" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> Double? {
        return str.hasPrefix("P")
            ? NSTimeInterval.fromTimeIntervalString(str)
            : (str as NSString).doubleValue
    }
    
    public static func fromObject(any:AnyObject) -> Double?
    {
        switch any {
        case let d as Double: return d
        case let i as Int: return Double(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension NSTimeInterval
{
    public static let ticksPerSecond:Double = 10000000;
    
    public func toXsdDuration() -> String {
        var sb = "P"
        
        let totalSeconds:Double = self
        let wholeSeconds = Int(totalSeconds)
        var seconds = wholeSeconds
        let sec = (seconds >= 60 ? seconds % 60 : seconds)
        seconds = (seconds / 60)
        let min = seconds >= 60 ? seconds % 60 : seconds
        seconds = (seconds / 60)
        let hours = seconds >= 24 ? seconds % 24 : seconds
        let days = seconds / 24
        let remainingSecs:Double = Double(sec) + (totalSeconds - Double(wholeSeconds))
        
        if days > 0 {
            sb += "\(days)D"
        }
        
        if days == 0 || Double(hours + min + sec) + remainingSecs > 0 {

            sb += "T"
            if hours > 0 {
                sb += "\(hours)H";
            }
            if min > 0 {
                sb += "\(min)M";
            }
            
            if remainingSecs > 0 {
                var secFmt = String(format:"%.7f", remainingSecs)
                secFmt = secFmt.trimEnd("0").trimEnd(".")
                sb += "\(secFmt)S"
            }
            else if sb.length == 2 { //PT
                sb += "0S"
            }
        }
        
        return sb
    }
    
    public func toTimeIntervalJson() -> String {
        return jsonString(toString())
    }
    
    public static func fromXsdDuration(xsdString:String) -> NSTimeInterval?  {
        return NSTimeInterval.fromTimeIntervalString(xsdString)
    }
    
    public static func fromTimeIntervalString(string:String) -> NSTimeInterval? {
        var days = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        var ms = 0.0
  
        let t = string[1..<string.length].splitOnFirst("T") //strip P
        
        let hasTime = t.count == 2
        
        let d = t[0].splitOnFirst("D")
        if d.count == 2 {
            if let day = Int(d[0]) {
                days = day
            }
        }

        if hasTime {
            let h = t[1].splitOnFirst("H")
            if h.count == 2 {
                if let hour = Int(h[0]) {
                    hours = hour
                }
            }
            
            let m = h.last!.splitOnFirst("M")
            if m.count == 2 {
                if let min = Int(m[0]) {
                    minutes = min
                }
            }
            
            let s = m.last!.splitOnFirst("S")
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
            + (seconds)
        
        let interval = Double(totalSecs) + ms
        
        return interval
    }
    
    public static func fromTimeIntervalObject(any:AnyObject) -> NSTimeInterval?
    {
        switch any {
        case let s as String: return fromTimeIntervalString(s)
        case let t as NSTimeInterval: return t
        default:return nil
        }
    }
}

extension Int : StringSerializable
{
    public static var typeName:String { return "Int" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> Int? {
        return Int(str)
    }
    
    public static func fromObject(any:AnyObject) -> Int?
    {
        switch any {
        case let i as Int: return i
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Int8 : StringSerializable
{
    public static var typeName:String { return "Int8" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> Int8? {
        if let int = Int(str) {
            return Int8(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> Int8?
    {
        switch any {
        case let i as Int: return Int8(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Int16 : StringSerializable
{
    public static var typeName:String { return "Int16" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> Int16? {
        if let int = Int(str) {
            return Int16(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> Int16?
    {
        switch any {
        case let i as Int: return Int16(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Int32 : StringSerializable
{
    public static var typeName:String { return "Int32" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> Int32? {
        if let int = Int(str) {
            return Int32(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> Int32?
    {
        switch any {
        case let i as Int: return Int32(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Int64 : StringSerializable
{
    public static var typeName:String { return "Int64" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> Int64? {
        return (str as NSString).longLongValue
    }
    
    public static func fromObject(any:AnyObject) -> Int64?
    {
        switch any {
        case let i as Int: return Int64(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension UInt8 : StringSerializable
{
    public static var typeName:String { return "UInt8" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> UInt8? {
        if let int = Int(str) {
            return UInt8(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> UInt8?
    {
        switch any {
        case let i as Int: return UInt8(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension UInt16 : StringSerializable
{
    public static var typeName:String { return "UInt16" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> UInt16? {
        if let int = Int(str) {
            return UInt16(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> UInt16?
    {
        switch any {
        case let i as Int: return UInt16(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension UInt32 : StringSerializable
{
    public static var typeName:String { return "UInt32" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> UInt32? {
        if let int = Int(str) {
            return UInt32(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> UInt32?
    {
        switch any {
        case let i as Int: return UInt32(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension UInt64 : StringSerializable
{
    public static var typeName:String { return "UInt64" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> UInt64? {
        return UInt64((str as NSString).longLongValue)
    }
    
    public static func fromObject(any:AnyObject) -> UInt64?
    {
        switch any {
        case let i as Int: return UInt64(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Float : StringSerializable
{
    public static var typeName:String { return "Float" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> Float? {
        return (str as NSString).floatValue
    }
    
    public static func fromObject(any:AnyObject) -> Float?
    {
        switch any {
        case let f as Float: return f
        case let i as Int: return Float(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Bool : StringSerializable
{
    public static var typeName:String { return "Bool" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> Bool? {
        return str.lowercaseString == "true"
    }
    
    public static func fromObject(any:AnyObject) -> Bool?
    {
        switch any {
        case let b as Bool: return b
        case let i as Int: return i != 0
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

public class ResponseStatus
{
    required public init(){}
    public var errorCode:String?
    public var message:String?
    public var stackTrace:String?
    public var errors:[ResponseError] = []
    public var meta:[String:String] = [:]
}

extension ResponseStatus : JsonSerializable
{
    public static var typeName:String { return "ResponseStatus" }
    public static var metadata = Metadata.create([
        Type<ResponseStatus>.optionalProperty("errorCode", get: { $0.errorCode }, set: { $0.errorCode = $1 }),
        Type<ResponseStatus>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
        Type<ResponseStatus>.optionalProperty("stackTrace", get: { $0.stackTrace }, set: { $0.stackTrace = $1 }),
        Type<ResponseStatus>.arrayProperty("errors", get: { $0.errors }, set: { $0.errors = $1 }),
        Type<ResponseStatus>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

public class ResponseError
{
    required public init(){}
    public var errorCode:String?
    public var fieldName:String?
    public var message:String?
    public var meta:[String:String] = [:]
}

extension ResponseError : JsonSerializable
{
    public static var typeName:String { return "ResponseError" }
    public static var metadata = Metadata.create([
        Type<ResponseError>.optionalProperty("errorCode", get: { $0.errorCode }, set: { $0.errorCode = $1 }),
        Type<ResponseError>.optionalProperty("fieldName", get: { $0.fieldName }, set: { $0.fieldName = $1 }),
        Type<ResponseError>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
        Type<ResponseError>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

public class ErrorResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

extension ErrorResponse : JsonSerializable
{
    public static var typeName:String { return "ResponseError" }
    public static var metadata = Metadata.create([
        Type<ErrorResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}



public class List<T>
{
    required public init(){}
}

public protocol HasMetadata {
    static var typeName:String { get }
    static var metadata:Metadata { get }
    init()
}

public protocol Convertible {
    typealias T
    static var typeName:String { get }
    static func fromObject(any:AnyObject) -> T?
}

public protocol JsonSerializable : HasMetadata, StringSerializable {
    func toJson() -> String
    static func fromJson(json:String) -> T?
}
			
public protocol StringSerializable : Convertible {
    func toJson() -> String
    func toString() -> String
    static func fromString(string:String) -> T?
}


public func populate<T : HasMetadata>(instance:T, map:NSDictionary, propertiesMap:[String:PropertyType]) -> T {
    for (key, obj) in map {
        if let p = propertiesMap[key.lowercaseString] {
            p.setValueAny(instance as! AnyObject, value: obj)
        }
    }
    return instance
}

public func populateFromDictionary<T : JsonSerializable>(instance:T, map:[NSObject : AnyObject], propertiesMap:[String:PropertyType]) -> T {
    for (key, obj) in map {
        if let strKey = key as? String {
            if let p = propertiesMap[strKey.lowercaseString] {
                p.setValueAny(instance as! AnyObject, value: obj)
            }
        }
    }
    return instance
}

public class Metadata {
    public var properties:[PropertyType] = []
    public var propertyMap:[String:PropertyType] = [:]
   
    public init(properties:[PropertyType]) {
        self.properties = properties
        for p in properties {
            propertyMap[p.name.lowercaseString] = p
        }
    }
    
    static func create(properties:[PropertyType]) -> Metadata {
        return Metadata(properties: properties)
    }
}

extension HasMetadata
{
    public static var properties:[PropertyType] {
        return Self.metadata.properties
    }
    
    public static var propertyMap:[String:PropertyType] {
        return Self.metadata.propertyMap
    }
    
    public func toJson() -> String {
        let jb = JObject()
        for p in Self.properties {
            if let value = p.jsonValueAny(self) {
                jb.append(p.name, json: value)
            } else {
                jb.append(p.name, json: "null")
            }
        }
        return jb.toJson()
    }

    public static func fromJson(json:String) -> Self? {
//        if self is NSString || self is String {
//            if let value = json as? Self {
//                return value
//            }
//        }
        if let map = parseJson(json) as? NSDictionary {
            return populate(Self(), map: map, propertiesMap: Self.propertyMap)
        }
        return nil
    }

    public static func fromObject(any:AnyObject) -> Self? {
        switch any {
        case let s as String: return fromJson(s)
        case let map as NSDictionary: return populate(Self(), map: map, propertiesMap: Self.propertyMap)
        default: return nil
        }
    }

    public func toString() -> String {
        return toJson()
    }

    public static func fromString(string:String) -> Self? {
        return fromJson(string)
    }
}

public class TypeAccessor {}

public class Type<T : HasMetadata> : TypeAccessor
{
    var properties: [PropertyType]
    var propertiesMap = [String:PropertyType]()
    
    init(properties:[PropertyType])
    {
        self.properties = properties
        
        for p in properties {
            propertiesMap[p.name.lowercaseString] = p
        }
    }
    
    static public func toJson(instance:T) -> String {
        let jb = JObject()
        for p in T.properties {
            if let value = p.jsonValueAny(instance) {
                jb.append(p.name, json: value)
            } else {
                jb.append(p.name, json: "null")
            }
        }
        return jb.toJson()
    }
    
    static public func toString(instance:T) -> String {
        return toJson(instance)
    }
    
    static func fromJson<T : JsonSerializable>(json:String) -> T? {
        return fromJson(T(), json: json)
    }
    
    static func fromString<T : JsonSerializable>(instance:T, string:String) -> T? {
        return fromJson(instance, json: string)
    }
    
    static func fromObject<T : JsonSerializable>(instance:T, any:AnyObject) -> T? {
        switch any {
        case let s as String: return fromJson(instance, json: s)
        case let map as NSDictionary: return Type<T>.fromDictionary(instance, map: map)
        default: return nil
        }
    }
    
    static func fromJson<T : JsonSerializable>(instance:T, json:String) -> T? {
        if instance is NSString || instance is String {
            if let value = json as? T {
                return value
            }
        }
        if let map = parseJson(json) as? NSDictionary {
            return populate(instance, map: map, propertiesMap: T.propertyMap)
        }
        return nil
    }
    
    static func fromDictionary<T : HasMetadata>(instance:T, map:NSDictionary) -> T {
        return populate(instance, map: map, propertiesMap: T.propertyMap)
    }
    
    public class func property<P : StringSerializable>(name:String, get:(T) -> P, set:(T,P) -> Void) -> PropertyType
    {
        return JProperty(name: name, get:get, set:set)
    }
    
    public class func optionalProperty<P : StringSerializable>(name:String, get:(T) -> P?, set:(T,P?) -> Void) -> PropertyType
    {
        return JOptionalProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<P : JsonSerializable>(name:String, get:(T) -> P, set:(T,P) -> Void) -> PropertyType
    {
        return JObjectProperty(name: name, get:get, set:set)
    }
    
    public class func optionalObjectProperty<P : JsonSerializable>(name:String, get:(T) -> P?, set:(T,P?) -> Void) -> PropertyType
    {
        return JOptionalObjectProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : StringSerializable where K : StringSerializable>(name:String, get:(T) -> [K:P], set:(T,[K:P]) -> Void) -> PropertyType
    {
        return JDictionaryProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : StringSerializable where K : StringSerializable, K == K.T>(name:String, get:(T) -> [K:[P]], set:(T,[K:[P]]) -> Void) -> PropertyType
    {
        return JDictionaryArrayProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : JsonSerializable where K : StringSerializable>(name:String, get:(T) -> [K:[K:P]], set:(T,[K:[K:P]]) -> Void) -> PropertyType
    {
        return JDictionaryArrayDictionaryObjectProperty(name: name, get:get, set:set)
    }
    
    public class func arrayProperty<P : StringSerializable>(name:String, get:(T) -> [P], set:(T,[P]) -> Void) -> PropertyType
    {
        return JArrayProperty(name: name, get:get, set:set)
    }
    
    public class func optionalArrayProperty<P : StringSerializable>(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void) -> PropertyType
    {
        return JOptionalArrayProperty(name: name, get:get, set:set)
    }
    
    public class func arrayProperty<P : JsonSerializable>(name:String, get:(T) -> [P], set:(T,[P]) -> Void) -> PropertyType
    {
        return JArrayObjectProperty(name: name, get:get, set:set)
    }
    
    public class func optionalArrayProperty<P : JsonSerializable>(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void) -> PropertyType
    {
        return JOptionalArrayObjectProperty(name: name, get:get, set:set)
    }
}

public class PropertyType {
    public var name:String

    init(name:String) {
        self.name = name
    }
    
    public func jsonValueAny(instance:Any) -> String? {
        return nil
    }
    
    public func setValueAny(instance:Any, value:AnyObject) {
    }
    
    public func getValueAny(instance:Any) -> Any? {
        return nil
    }
    
    public func stringValueAny(instance:Any) -> String? {
        return nil
    }
    
    public func getName() -> String {
        return self.name
    }
}

public class PropertyBase<T : HasMetadata> : PropertyType {

    override init(name:String) {
        super.init(name: name)
    }
    
    public override func jsonValueAny(instance:Any) -> String? {
        return jsonValue(instance as! T)
    }
    
    public func jsonValue(instance:T) -> String? {
        return nil
    }
    
    public override func setValueAny(instance:Any, value:AnyObject) {
        if let t = instance as? T {
            setValue(t, value: value)
        }
    }
    
    public func setValue(instance:T, value:AnyObject) {
    }
    
    public override func getValueAny(instance:Any) -> Any? {
        return getValue(instance as! T)
    }
    
    public func getValue(instance:T) -> Any? {
        return nil
    }
    
    public override func stringValueAny(instance:Any) -> String? {
        return stringValue(instance as! T)
    }
    
    public func stringValue(instance:T) -> String? {
        return nil
    }
}

public class JProperty<T : HasMetadata, P : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> P
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P, set:(T,P) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return get(instance).toString()
    }
    
    public override func jsonValue(instance:T) -> String? {
        return get(instance).toJson()
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}

public class JOptionalProperty<T : HasMetadata, P : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> P?
    public var set:(T,P?) -> Void
    
    init(name:String, get:(T) -> P?, set:(T,P?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func stringValue(instance:T) -> String? {
        if let p = get(instance) {
            return p.toString()
        }
        return super.jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        if let p = get(instance) {
            return p.toJson()
        }
        return super.jsonValue(instance)
    }
    
    public override func getValue(instance:T) -> Any? {
        if let p = get(instance) {
            return p
        }
        return nil
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}


public class JObjectProperty<T : HasMetadata, P : JsonSerializable> : PropertyBase<T>
{
    public var get:(T) -> P
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P, set:(T,P) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return get(instance).toString()
    }
    
    public override func jsonValue(instance:T) -> String? {
        return get(instance).toJson()
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}

public class JOptionalObjectProperty<T : HasMetadata, P : JsonSerializable where P : HasMetadata> : PropertyBase<T>
{
    public var get:(T) -> P?
    public var set:(T,P?) -> Void
    
    init(name:String, get:(T) -> P?, set:(T,P?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func jsonValue(instance:T) -> String? {
        if let propValue = get(instance) {
            let strValue = propValue.toJson()
            return strValue
        }
        return super.jsonValue(instance)
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let map = value as? NSDictionary {
            let p = Type<P>.fromDictionary(P(), map: map)
            set(instance, p)
        }
    }
}

public class JDictionaryProperty<T : HasMetadata, K : Hashable, P : StringSerializable where K : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> [K:P]
    public var set:(T,[K:P]) -> Void
    
    init(name:String, get:(T) -> [K:P], set:(T,[K:P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let map = get(instance)
        
        let jb = JObject()
        for (key, value) in map {
            jb.append(key.toString(), json:value.toJson())
        }
        return jb.toJson()
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let map = value as? NSDictionary {
            var to = [K:P]()
            for (key, obj) in map {
                if let keyK = K.fromObject(key) as? K {
                    if let valueP = P.fromObject(obj) as? P {
                        to[keyK] = valueP
                    }
                }
            }
            set(instance, to)
        }
    }
}

public class JDictionaryArrayProperty<T : HasMetadata, K : Hashable, P : StringSerializable where K : StringSerializable, K == K.T> : PropertyBase<T>
{
    public var get:(T) -> [K:[P]]
    public var set:(T,[K:[P]]) -> Void
    
    init(name:String, get:(T) -> [K:[P]], set:(T,[K:[P]]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let map = get(instance)

        let jb = JObject()
        for (key, values) in map {
            let ja = JArray()
            for v in values {
                ja.append(v.toJson())
            }
            jb.append(key.toString(), json:ja.toJson())
        }
        return jb.toJson()
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let map = value as? NSDictionary {
            var to = [K:[P]]()
            for (key, obj) in map {
                if let keyK = K.fromObject(key) {
                    var valuesP = to[keyK] ?? [P]()
                    if let valuesArray = obj as? NSArray {
                        for item in valuesArray {
                            if let valueP = P.fromObject(item) as? P {
                                valuesP.append(valueP)
                            }
                        }
                    }
                    to[keyK] = valuesP
                }
            }
            set(instance, to)
        }
    }
}

public class JDictionaryArrayDictionaryObjectProperty<T : HasMetadata, K : Hashable, P : JsonSerializable where K : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> [K:[K:P]]
    public var set:(T,[K:[K:P]]) -> Void
    
    init(name:String, get:(T) -> [K:[K:P]], set:(T,[K:[K:P]]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let map = get(instance)
        
        let jb = JObject()
        for (key, values) in map {
            jb.append(key.toString(), json:JObject.toJson(values))
        }
        return jb.toJson()
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let map = value as? NSDictionary {
            var to = [K:[K:P]]()
            for (k,vArray) in map {
                var values = [K:P]()
                if let array = vArray as? NSArray {
                    for item in array {
                        if let map = item as? NSDictionary {
                            for (subK, subV) in map {
                                values[K.fromObject(subK)! as! K] = P.fromObject(subV) as? P
                            }
                        }
                    }
                }
                to[K.fromObject(k) as! K] = values
            }
            set(instance,to)
        }
    }
}

public class JArrayProperty<T : HasMetadata, P : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> [P]
    public var set:(T,[P]) -> Void
    
    init(name:String, get:(T) -> [P], set:(T,[P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValues = get(instance)
        
        var sb = ""
        
        for item in propValues {
            if sb.length > 0 {
                sb += ","
            }
            var str:String = "null"
            str = item.toJson()
            
            sb += str
        }

        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let array = value as? NSArray {
            if array.count == 0 {
                return
            }
            var to = [P]()
            for item in array {
                if let pValue = P.fromObject(item) as? P {
                    to.append(pValue)
                }
            }
            set(instance, to)
        }
    }
}

public class JOptionalArrayProperty<T : HasMetadata, P : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> [P]?
    public var set:(T,[P]?) -> Void
    
    init(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        var sb = ""
        if let propValues = get(instance) {
            for item in propValues {
                if sb.length > 0 {
                    sb += ","
                }
                var str:String = "null"
                str = item.toJson()
                
                sb += str
            }
        } else {
            return "null"
        }
        
        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let array = value as? NSArray {
            if array.count == 0 {
                return
            }
            var to = [P]()
            for item in array {
                if let pValue = P.fromObject(item) as? P {
                    to.append(pValue)
                }
            }
            set(instance, to)
        }
    }
}

public class JArrayObjectProperty<T : HasMetadata, P : JsonSerializable> : PropertyBase<T>
{
    public var get:(T) -> [P]
    public var set:(T,[P]) -> Void
    
    init(name:String, get:(T) -> [P], set:(T,[P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValues = get(instance)
        
        var sb = ""
        
        for item in propValues {
            if sb.length > 0 {
                sb += ","
            }
            var str:String = "null"
            str = item.toJson()
            
            sb += str
        }
        
        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let array = value as? NSArray {
            if array.count == 0 {
                return
            }
            var to = [P]()
            for item in array {
                if let pValue = P.fromObject(item) as? P {
                    to.append(pValue)
                }
            }
            set(instance, to)
        }
    }
}

public class JOptionalArrayObjectProperty<T : HasMetadata, P : JsonSerializable> : PropertyBase<T>
{
    public var get:(T) -> [P]?
    public var set:(T,[P]?) -> Void
    
    init(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        var sb = ""
        
        if let propValues = get(instance) {
            for item in propValues {
                if sb.length > 0 {
                    sb += ","
                }
                var str:String = "null"
                str = item.toJson()
                
                sb += str
            }
        } else {
            return "null"
        }
        
        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let array = value as? NSArray {
            if array.count == 0 {
                return
            }
            var to = [P]()
            for item in array {
                if let pValue = P.fromObject(item) as? P {
                    to.append(pValue)
                }
            }
            set(instance, to)
        }
    }
}

class TypeConfig
{
    struct Config {
        static var types = Dictionary<String, TypeAccessor>()
    }
    
    class func configure<T : Convertible>(typeConfig:Type<T>) -> Type<T> {
        Config.types[T.typeName] = typeConfig
        return typeConfig
    }
    
    class func config<T : Convertible>() -> Type<T>? {
        if let typeInfo = Config.types[T.typeName] {
            return typeInfo as? Type<T>
        }
        return nil
    }
}

func jsonStringRaw(str:String?) -> String {
    if let s = str {
        return "\"\(s)\""
    }
    else {
        return "null"
    }
}

class Utils
{
    class func escapeChars() -> NSCharacterSet {
        return NSCharacterSet(charactersInString: "\"\n\r\t\\")
    }
}

func jsonString(str:String?) -> String {
    if let s = str {
        if let _ = s.rangeOfCharacterFromSet(Utils.escapeChars()) {
            do {
                let encodedData = try NSJSONSerialization.dataWithJSONObject([s], options:NSJSONWritingOptions())
                if let encodedJson = encodedData.toUtf8String() {
                    return encodedJson[1..<encodedJson.length-1] //strip []
                }
            } catch { }
        }        
        return "\"\(s)\""
    }
    else {
        return "null"
    }
}


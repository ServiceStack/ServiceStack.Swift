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
        if sb.count > 0 {
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
        var jb = JObject()
        
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
        if countElements(sb) > 0 {
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
    class func unwrap(any:Any) -> Any? {
        let mi:MirrorType = reflect(any)
        if mi.disposition != .Optional {
            return any
        }
        if mi.count == 0 { return nil } // Optional.None
        let (name,some) = mi[0]
        return some.value
    }
}

func parseJson(json:String) -> AnyObject? {
    var error: NSError?
    return parseJson(json, &error)
}

func parseJson(json:String, error:NSErrorPointer) -> AnyObject? {
    let data = json.dataUsingEncoding(NSUTF8StringEncoding)!
    return parseJsonBytes(data, error)
}

func parseJsonBytes(bytes:NSData) -> AnyObject? {
    var error: NSError?
    return parseJsonBytes(bytes, &error)
}

func parseJsonBytes(bytes:NSData, error:NSErrorPointer) -> AnyObject? {
    let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(bytes,
        options: NSJSONReadingOptions.AllowFragments,
        error:error)
    return parsedObject
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
        return string.count > 0 ? string[0] : nil
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
        var str = string.hasPrefix("\\")
            ? string[1..<string.count]
            : string
        let wcfJsonPrefix = "/Date("
        if str.hasPrefix(wcfJsonPrefix) {
            let unixTime = (str.splitOnFirst("(")[1].splitOnLast(")")[0].splitOnFirst("-")[0].splitOnFirst("+")[0] as NSString).doubleValue
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
    /*
    public String toXsdDuration() {
    StringBuilder sb = new StringBuilder("P");
    
    double d = getTotalSeconds();
    
    long totalSeconds = (long) (d);
    long remainingMs = (long)((d - totalSeconds) * 1000);
    long sec = (totalSeconds >= 60 ? totalSeconds % 60 : totalSeconds);
    long min = (totalSeconds = (totalSeconds / 60)) >= 60 ? totalSeconds % 60 : totalSeconds;
    long hours = (totalSeconds = (totalSeconds / 60)) >= 24 ? totalSeconds % 24 : totalSeconds;
    long days = (totalSeconds = (totalSeconds / 24)) >= 30 ? totalSeconds % 30 : totalSeconds;
    
    if (days > 0) {
    sb.append(days + "D");
    }
    
    if (hours + min + sec + remainingMs > 0) {
    sb.append("T");
    if (hours > 0) {
    sb.append(hours + "H");
    }
    if (min > 0) {
    sb.append(min + "M");
    }
    
    if (remainingMs > 0) {
    sb.append(sec + "." + String.format("%03d", remainingMs) + "S");
    }
    else if (sec > 0) {
    sb.append(sec + "S");
    }
    }
    
    String xsdDuration = sb.toString();
    return xsdDuration;
    }    */
    
    public func toXsdDuration() -> String {
        var sb = "P"
        
        let d = self
        var totalSeconds = Int(d)
        let remainingMs = Int((d - Double(totalSeconds)) * 1000)
        let sec = (totalSeconds >= 60 ? totalSeconds % 60 : totalSeconds)
        totalSeconds = (totalSeconds / 60)
        let min = totalSeconds >= 60 ? totalSeconds % 60 : totalSeconds
        totalSeconds = (totalSeconds / 60)
        let hours = totalSeconds >= 24 ? totalSeconds % 24 : totalSeconds
        totalSeconds = (totalSeconds / 24)
        let days = totalSeconds >= 30 ? totalSeconds % 30 : totalSeconds
        
        if (days > 0) {
            sb += "\(days)D"
        }
        
        if (hours + min + sec + remainingMs > 0) {
            sb += "T"

            if (hours > 0) {
                sb += "\(hours)H";
            }
            if (min > 0) {
                sb += "\(min)M";
            }
            
            if (remainingMs > 0) {
                let padMs = String(format:"%03d", remainingMs)
                sb += "\(sec).\(padMs)S"
            }
            else if (sec > 0) {
                sb += "\(sec)S"
            }
        }
        
        return sb
    }
    
    public func toTimeIntervalJson() -> String {
        return jsonString(toString())
    }
    
    public static func fromTimeIntervalString(string:String) -> NSTimeInterval? {
        var days = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        var ms = 0.0
  
        let t = string[1..<string.count].splitOnFirst("T") //strip P
        
        let hasTime = t.count == 2
        
        let d = t[0].splitOnFirst("D")
        if d.count == 2 {
            if let day = d[0].toInt() {
                days = day
            }
        }

        if hasTime {
            let h = t[1].splitOnFirst("H")
            if h.count == 2 {
                if let hour = h[0].toInt() {
                    hours = hour
                }
            }
            
            let m = h.last!.splitOnFirst("M")
            if m.count == 2 {
                if let min = m[0].toInt() {
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
        return str.toInt()
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
        if let int = str.toInt() {
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
        if let int = str.toInt() {
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
        if let int = str.toInt() {
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
        if let int = str.toInt() {
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
        if let int = str.toInt() {
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
        if let int = str.toInt() {
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


public class List<T>
{
    required public init(){}
}

public protocol HasReflect {
    typealias T : HasReflect
    class func reflect() -> Type<T>
    init()
}

public protocol Convertible {
    typealias T
    class var typeName:String { get }
    class func fromObject(any:AnyObject) -> T?
}

public protocol JsonSerializable : HasReflect, StringSerializable {
    func toJson() -> String
    class func fromJson(json:String) -> T?
}
			
public protocol StringSerializable : Convertible {
    func toJson() -> String
    func toString() -> String
    class func fromString(string:String) -> T?
}


public func populate<T>(instance:T, map:NSDictionary, propertiesMap:[String:PropertyType]) -> T {
    for (key, obj) in map {
        if let p = propertiesMap[key.lowercaseString] {
            //insanely this prevents a EXC_BAD_INSTRUCTION when accessing parent.doubleOptional! with a value!
            //"\(obj)"
            p.setValue(instance, value: obj)
        }
    }
    return instance
}

public func populateFromDictionary<T : JsonSerializable>(instance:T, map:[NSObject : AnyObject], propertiesMap:[String:PropertyType]) -> T {
    for (key, obj) in map {
        if let strKey = key as? String {
            if let p = propertiesMap[strKey.lowercaseString] {
                p.setValue(instance, value: obj)
            }
        }
    }
    return instance
}

public class TypeAccessor {}

public class Type<T : HasReflect> : TypeAccessor
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
    
    public func toJson<T>(instance:T) -> String {
        var jb = JObject()
        for p in properties {
            if let value = p.jsonValue(instance) {
                jb.append(p.name, json: value)
            } else {
                jb.append(p.name, json: "null")
            }
        }
        return jb.toJson()
    }
    
    public func toString<T>(instance:T) -> String {
        return toJson(instance)
    }
    
    func fromJson<T : JsonSerializable>(json:String) -> T? {
        return fromJson(T(), json: json)
    }
    
    func fromJson<T>(instance:T, json:String, error:NSErrorPointer) -> T? {
        if let map = parseJson(json,error) as? NSDictionary {
            return populate(instance, map, propertiesMap)
        }
        return nil
    }
    
    func fromJson<T>(instance:T, json:String) -> T? {
        if let map = parseJson(json, nil) as? NSDictionary {
            return populate(instance, map, propertiesMap)
        }
        return nil
    }
    
    func fromString(instance:T, string:String) -> T? {
        return fromJson(instance, json: string)
    }
    
    func fromObject(instance:T, any:AnyObject) -> T? {
        switch any {
        case let s as String: return fromJson(instance, json: s)
        case let map as NSDictionary: return Type<T>.fromDictionary(instance, map: map)
        default: return nil
        }
    }
    
    class func fromDictionary(instance:T, map:NSDictionary) -> T {
        return populate(instance, map, T.reflect().propertiesMap)
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
    
    public func jsonValue<T>(instance:T) -> String? {
        return nil
    }
    
    public func setValue<T>(instance:T, value:AnyObject) {
    }
    
    public func getValue<T>(instance:T) -> Any? {
        return nil
    }
    
    public func stringValue<T>(instance:T) -> String? {
        return nil
    }
}

public class JProperty<T : HasReflect, P : StringSerializable> : PropertyType
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

public class JOptionalProperty<T : HasReflect, P : StringSerializable> : PropertyType
{
    public var get:(T) -> P?
    public var set:(T,P) -> Void
    
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
    
    public override func setValue(instance:T, value:AnyObject) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}


public class JObjectProperty<T : HasReflect, P : JsonSerializable> : PropertyType
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

public class JOptionalObjectProperty<T : HasReflect, P : JsonSerializable where P : HasReflect> : PropertyType
{
    public var get:(T) -> P?
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P?, set:(T,P?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func jsonValue(instance:T) -> String? {
        if let propValue = get(instance) {
            var strValue = propValue.toJson()
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

public class JDictionaryProperty<T : HasReflect, K : Hashable, P : StringSerializable where K : StringSerializable> : PropertyType
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
        
        var jb = JObject()
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

public class JDictionaryArrayProperty<T : HasReflect, K : Hashable, P : StringSerializable where K : StringSerializable, K == K.T> : PropertyType
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

        var jb = JObject()
        for (key, values) in map {
            var ja = JArray()
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

public class JDictionaryArrayDictionaryObjectProperty<T : HasReflect, K : Hashable, P : JsonSerializable where K : StringSerializable> : PropertyType
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
        
        var jb = JObject()
        for (key, values:[K:P]) in map {
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
                                values[K.fromObject(subK)! as K] = P.fromObject(subV) as? P
                            }
                        }
                    }
                }
                to[K.fromObject(k) as K] = values
            }
            set(instance,to)
        }
    }
}

public class JArrayProperty<T : HasReflect, P : StringSerializable> : PropertyType
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
            if sb.count > 0 {
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

public class JOptionalArrayProperty<T : HasReflect, P : StringSerializable> : PropertyType
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
                if sb.count > 0 {
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

public class JArrayObjectProperty<T : HasReflect, P : JsonSerializable> : PropertyType
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
            if sb.count > 0 {
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

public class JOptionalArrayObjectProperty<T : HasReflect, P : JsonSerializable> : PropertyType
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
        let propValues = get(instance)
        
        var sb = ""
        
        if let propValues = get(instance) {
            for item in propValues {
                if sb.count > 0 {
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
        if let stringWithEscapeChars = s.rangeOfCharacterFromSet(Utils.escapeChars()) {
            //TODO: rewrite to encode manually to avoid unnecessary conversions
            var error:NSError?
            if let encodedData = NSJSONSerialization.dataWithJSONObject([s], options:NSJSONWritingOptions.allZeros, error:&error) {
                if let encodedJson = encodedData.toUtf8String() {
                    return encodedJson[1..<encodedJson.count-1] //strip []
                }
            }
        }        
        return "\"\(s)\""
    }
    else {
        return "null"
    }
}


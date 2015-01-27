//
//  Json.swift
//  SerializationUtils
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
    
    func append(name: String, value: Any) {
        if name == "super" { return }
        
        var str:String = "null"
        if let val = JValue.unwrap(value) {
            str = JValue.toJson(val)
        }
        
        if countElements(sb) > 0 {
            sb += ","
        }
        
        sb += "\"\(name)\":\(str)"
    }
    
    func append(name: String, json: String?) {
        if countElements(sb) > 0 {
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

    class func toJson(value:Any) -> String {
        return toJson(value, mirrorType:reflect(value))
    }
    
    class func toJson(value:Any, mirrorType mi:MirrorType) -> String {
        var jb = JObject()
        
        for i in 0 ..< mi.count {
            let (name, pi) = mi[i]
            jb.append(name, value: pi.value)
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

    func append(value:Any) {
        append(value, mirrorType:reflect(value))
    }
    
    func append(value:Any, mirrorType mi:MirrorType) {
        if countElements(sb) > 0 {
            sb += ","
        }
        var str:String = "null"
        if let val = JValue.unwrap(value) {
            str = JValue.toJson(val)
        }
        sb += "\(str)"
    }
    
    func toJson() -> String {
        return "[\(sb)]"
    }

    class func toJson(any:Any) -> String {
        return toJson(any, mirrorType: reflect(any))
    }
    
    class func toJson(any:Any, mirrorType mi:MirrorType) -> String {
        var jb = JArray()
        
        for i in 0..<mi.count {
            let (name,pi) = mi[i]
            jb.append(pi.value, mirrorType:pi)
        }
        
        return jb.toJson()
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

    class func toJson(any:Any) -> String {
        return toJson(any, mirrorType:reflect(any))
    }
    
    class func toJson(any:Any, mirrorType mi:MirrorType) -> String {
        switch any {
        case let int as Int:
            return "\(int)"
        case let double as Double:
            return "\(double)"
        case let bool as Bool:
            return "\(bool)"
        case let str as String:
            return "\"\(str)\""
        default:
            switch mi.disposition {
            case .IndexContainer:
                return JArray.toJson(any, mirrorType:mi)
            case .Class:
                return JObject.toJson(any, mirrorType:mi)
            default:
                return "\(any)"
            }
        }
    }
}

public protocol JsType {
}

public protocol JsConverter {
}

class JsKey<T>
{
    class func type() -> String {
        return typestring(T)
    }
}

class TypeString : Printable
{
    let name:String
    
    init(name:String){
        self.name = name
    }
    
    var description: String {
        return name
    }
}

func parseJson(json:String) -> AnyObject? {
    let data = json.dataUsingEncoding(NSUTF8StringEncoding)!
    var parseError: NSError?
    let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
        options: NSJSONReadingOptions.AllowFragments,
        error:&parseError)
    return parsedObject
}

extension String : StringSerializable
{
    public func toString() -> String {
        return self
    }

    public func toJson() -> String {
        return jsonString(self)
    }
    
    public static func fromString(str: String) -> String? {
        return str
    }

    public static func fromObject(any:AnyObject) -> String?
    {
        switch any {
        case let s as String: return s
        default:return nil
        }
    }
}

extension Int : StringSerializable
{
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

extension Double : StringSerializable
{
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(str: String) -> Double? {
        return (str as NSString).doubleValue
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

extension Float : StringSerializable
{
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



public protocol IReturn
{
    typealias Return
}

public class List<T>
{
    required public init(){}
}

public class QueryBase<T>
{
    required public init(){}
    public var skip:Int?
    public var take:Int?
    public var orderBy:String?
    public var orderByDesc:String?
}

public class QueryResponse<T>
{
    required public init(){}
    public var offset:Int?
    public var total:Int?
    public var results:[String] = []
    public var meta:[String:String] = [:]
    public var responseStatus:ResponseStatus?
}

public class AuthUserSession
{
    required public init(){}
    public var referrerUrl:String?
    public var id:String?
    public var userAuthId:String?
    public var userAuthName:String?
    public var userName:String?
    public var twitterUserId:String?
    public var twitterScreenName:String?
    public var facebookUserId:String?
    public var facebookUserName:String?
    public var firstName:String?
    public var lastName:String?
    public var displayName:String?
    public var company:String?
    public var email:String?
    public var primaryEmail:String?
    public var phoneNumber:String?
    public var birthDate:String?
    public var birthDateRaw:String?
    public var address:String?
    public var address2:String?
    public var city:String?
    public var state:String?
    public var country:String?
    public var culture:String?
    public var fullName:String?
    public var gender:String?
    public var language:String?
    public var mailAddress:String?
    public var nickname:String?
    public var postalCode:String?
    public var timeZone:String?
    public var requestTokenSecret:String?
    public var createdAt:String?
    public var lastModified:String?
    public var providerOAuthAccess:[AuthTokens] = [AuthTokens]()
    public var roles:[String] = []
    public var permissions:[String] = []
    public var isAuthenticated:Bool?
    public var sequence:String?
    public var tag:Int64?
}

public class AuthTokens
{
    public var provider:String?
    public var userId:String?
    public var accessToken:String?
    public var accessTokenSecret:String?
    public var refreshToken:String?
    public var refreshTokenExpiry:String?
    public var requestToken:String?
    public var requestTokenSecret:String?
    public var items:[String:String] = [:]
}

public class ResponseStatus
{
    required public init(){}
    public var errorCode:String?
    public var message:String?
    public var stackTrace:String?
    public var errors:[ResponseError] = []
}

public class ResponseError
{
    required public init(){}
    public var errorCode:String?
    public var fieldName:String?
    public var message:String?
}



public protocol HasReflect {
    typealias T : HasReflect
    class func reflect() -> Type<T>
    init()
}

public protocol Convertible {
    typealias T
    class func fromObject(any:AnyObject) -> T?
}

public protocol JsonSerializable : HasReflect, StringSerializable {
    func toJson() -> String
    class func fromJson(json:String) -> T
}

public protocol StringSerializable : Convertible {
    typealias T
    func toJson() -> String
    func toString() -> String
    class func fromString(str:String) -> T?
}


public class TypeAccessor
{
    
}

public class Type<T : HasReflect> : TypeAccessor
{
    var name:String
    var properties: [PropertyType]
    
    init(name:String, properties:[PropertyType])
    {
        self.name = name
        self.properties = properties
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
    
    func fromJson<T>(instance:T, json:String) -> T {
        if let map = parseJson(json) as? NSDictionary {
            for p in properties {
                if let x: AnyObject = map[p.name] {
                    //insanely this prevents a EXC_BAD_INSTRUCTION when accessing parent.doubleOptional! with a value!
                    "\(x)"
                    p.setValue(instance, value: x)
                }
            }
        }
        return instance
    }
    
    func fromString<T>(instance:T, json:String) -> T {
        return fromJson(instance, json: json)
    }
    
    func fromObject(instance:T, any:AnyObject) -> T? {
        switch any {
        case let s as String: return fromJson(instance, json: s)
        case let map as NSDictionary: return Type<T>.fromDictionary(instance, map: map)
        default: return nil
        }
    }
    
    class func fromDictionary(instance:T, map:NSDictionary) -> T {
        for p in T.reflect().properties {
            if let c: AnyObject = map[p.name] {
                p.setValue(instance, value: c)
            }
        }
        return instance
    }
    
    public class func property<P : StringSerializable>(name:String, get:(T) -> P, set:(T,P) -> Void) -> PropertyType
    {
        return Property(name: name, get:get, set:set)
    }
    
    public class func optionalProperty<P : StringSerializable>(name:String, get:(T) -> P?, set:(T,P?) -> Void) -> PropertyType
    {
        return OptionalProperty(name: name, get:get, set:set)
    }
    
    public class func property<P : JsonSerializable>(name:String, get:(T) -> P, set:(T,P) -> Void) -> PropertyType
    {
        return ObjectProperty(name: name, get:get, set:set)
    }
    
    public class func optionalProperty<P : JsonSerializable>(name:String, get:(T) -> P?, set:(T,P?) -> Void) -> PropertyType
    {
        return OptionalObjectProperty(name: name, get:get, set:set)
    }
    
    public class func arrayProperty<P : StringSerializable>(name:String, get:(T) -> [P], set:(T,[P]) -> Void) -> PropertyType
    {
        return ArrayProperty(name: name, get:get, set:set)
    }
    
    public class func optionalArrayProperty<P : StringSerializable>(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void) -> PropertyType
    {
        return OptionalArrayProperty(name: name, get:get, set:set)
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
}

public class Property<T : HasReflect, P : StringSerializable> : PropertyType
{
    public var get:(T) -> P
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P, set:(T,P) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValue = get(instance)
        var strValue = propValue.toJson()
        return strValue
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

public class OptionalProperty<T : HasReflect, P : StringSerializable> : PropertyType
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
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}


public class ObjectProperty<T : HasReflect, P : JsonSerializable> : PropertyType
{
    public var get:(T) -> P
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P, set:(T,P) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValue = get(instance)
        var strValue = propValue.toJson()
        return strValue
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

public class OptionalObjectProperty<T : HasReflect, P : JsonSerializable where P : HasReflect> : PropertyType
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


public class ArrayProperty<T : HasReflect, P : StringSerializable> : PropertyType
{
    public var get:(T) -> [P]
    public var set:(T,[P]) -> Void
    
    init(name:String, get:(T) -> [P], set:(T,[P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValues = get(instance)
        
        var sb = ""
        
        for item in propValues {
            if countElements(sb) > 0 {
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

public class OptionalArrayProperty<T : HasReflect, P : StringSerializable> : PropertyType
{
    public var get:(T) -> [P]?
    public var set:(T,[P]?) -> Void
    
    init(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func jsonValue(instance:T) -> String? {
        
        var sb = ""

        if let propValues = get(instance) {
            for item in propValues {
                if countElements(sb) > 0 {
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
    
    class func configure<T>(typeConfig:Type<T>) -> Type<T> {
        Config.types[JsKey<T>.type()] = typeConfig
        return typeConfig
    }
    
    class func config<T>() -> Type<T>? {
        return Config.types[JsKey<T>.type()] as? Type<T>
    }
    
    class func convertFromKey(from:Any, to:Any) -> String {
        var key = typestring(from) + " > " + typestring(to)
        println(">>  key: \(key)")
        return key
    }
}

func jsonString(str:String?) -> String {
    if let s = str {
        return "\"\(s)\""
    }
    else {
        return "null"
    }
}


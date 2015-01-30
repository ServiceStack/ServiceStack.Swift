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
    var error: NSError?
    return parseJson(json, &error)
}

func parseJson(json:String, error:NSErrorPointer) -> AnyObject? {
    let data = json.dataUsingEncoding(NSUTF8StringEncoding)!
    let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
        options: NSJSONReadingOptions.AllowFragments,
        error:error)
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


func populate<T>(instance:T, map:NSDictionary, propertiesMap:[String:PropertyType]) -> T {
    for (key, obj) in map {
        if let p = propertiesMap[key.lowercaseString] {
            //insanely this prevents a EXC_BAD_INSTRUCTION when accessing parent.doubleOptional! with a value!
            //"\(obj)"
            p.setValue(instance, value: obj)
        }
    }
    return instance
}

public class TypeAccessor {}

public class Type<T : HasReflect> : TypeAccessor
{
    var name:String
    var properties: [PropertyType]
    var propertiesMap = [String:PropertyType]()
    
    init(name:String, properties:[PropertyType])
    {
        self.name = name
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
        if let map = parseJson(json, error) as? NSDictionary {
            return populate(instance, map, propertiesMap)
        }
        return nil
    }
    
    func fromJson<T>(instance:T, json:String) -> T? {
        if let map = parseJson(json) as? NSDictionary {
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
        return Property(name: name, get:get, set:set)
    }
    
    public class func optionalProperty<P : StringSerializable>(name:String, get:(T) -> P?, set:(T,P?) -> Void) -> PropertyType
    {
        return OptionalProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<P : JsonSerializable>(name:String, get:(T) -> P, set:(T,P) -> Void) -> PropertyType
    {
        return ObjectProperty(name: name, get:get, set:set)
    }
    
    public class func optionalObjectProperty<P : JsonSerializable>(name:String, get:(T) -> P?, set:(T,P?) -> Void) -> PropertyType
    {
        return OptionalObjectProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : StringSerializable where K : StringSerializable>(name:String, get:(T) -> [K:P], set:(T,[K:P]) -> Void) -> PropertyType
    {
        return DictionaryProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : StringSerializable where K : StringSerializable, K == K.T>(name:String, get:(T) -> [K:[P]], set:(T,[K:[P]]) -> Void) -> PropertyType
    {
        return DictionaryArrayProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : JsonSerializable where K : StringSerializable>(name:String, get:(T) -> [K:[K:P]], set:(T,[K:[K:P]]) -> Void) -> PropertyType
    {
        return DictionaryArrayDictionaryObjectProperty(name: name, get:get, set:set)
    }
    
    public class func arrayProperty<P : StringSerializable>(name:String, get:(T) -> [P], set:(T,[P]) -> Void) -> PropertyType
    {
        return ArrayProperty(name: name, get:get, set:set)
    }
    
    public class func optionalArrayProperty<P : StringSerializable>(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void) -> PropertyType
    {
        return OptionalArrayProperty(name: name, get:get, set:set)
    }
    
    public class func arrayProperty<P : JsonSerializable>(name:String, get:(T) -> [P], set:(T,[P]) -> Void) -> PropertyType
    {
        return ArrayObjectProperty(name: name, get:get, set:set)
    }
    
    public class func optionalArrayProperty<P : JsonSerializable>(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void) -> PropertyType
    {
        return OptionalArrayObjectProperty(name: name, get:get, set:set)
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

public class DictionaryProperty<T : HasReflect, K : Hashable, P : StringSerializable where K : StringSerializable> : PropertyType
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

public class DictionaryArrayProperty<T : HasReflect, K : Hashable, P : StringSerializable where K : StringSerializable, K == K.T> : PropertyType
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

public class DictionaryArrayDictionaryObjectProperty<T : HasReflect, K : Hashable, P : JsonSerializable where K : StringSerializable> : PropertyType
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

public class ArrayObjectProperty<T : HasReflect, P : JsonSerializable> : PropertyType
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

public class OptionalArrayObjectProperty<T : HasReflect, P : JsonSerializable> : PropertyType
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
    
    class func configure<T>(typeConfig:Type<T>) -> Type<T> {
        Config.types[JsKey<T>.type()] = typeConfig
        return typeConfig
    }
    
    class func config<T>() -> Type<T>? {
        return Config.types[JsKey<T>.type()] as? Type<T>
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

func jsonString(str:String?) -> String {
    if let s = str {
        return "\"\(s)\""
    }
    else {
        return "null"
    }
}


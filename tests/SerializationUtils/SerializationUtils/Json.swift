//
//  Json.swift
//  SerializationUtils
//
//  Created by Demis Bellot on 1/17/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

class JObject
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

class JArray
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

class JValue
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

func setValue<T>(inout prop:T, from:NSDictionary, key:String) {
    if let any:AnyObject = from[key] {
        switch any {
        case let t as T:
            prop = t
        default:
//            println("from: \(typestring(any.dynamicType.self)) to: \(typestring(T.self))")
            if let fn:(AnyObject) -> Any? = JsConfig.converter(any.dynamicType.self, to: T.self) {
                if let to = fn(any) {
                    prop = to as T //never gets here yet
                }
            }
        }
    }
}

func setOptionalValue<T>(inout prop:T?, from:NSDictionary, key:String) {
    if let any:AnyObject = from[key] {
        switch any {
        case let t as T:
            prop = t
        default:
            if let fn:(AnyObject) -> Any? = JsConfig.converterForOptional(any.dynamicType.self, to: T.self) {
                if let to = fn(any) {
                    prop = to as? T //never gets here yet
                }
            }
        }
    }
}

func setValue<T : JsonSerializable>(inout prop:T, from:NSDictionary, key:String) {
    if let map = from[key] as? NSDictionary {
        let t = T.fromDictionary(map)
        prop = t as T
    }
}
func setOptionalValue<T : JsonSerializable>(inout prop:T?, from:NSDictionary, key:String) {
    if let map = from[key] as? NSDictionary {
        let t = T.fromDictionary(map)
        prop = t as? T
    }
}

func setValue<T : JsonSerializable>(inout prop:[T], from:NSDictionary, key:String) {
    prop = parseArray(from, key)
}
func setOptionalValue<T : JsonSerializable>(inout prop:[T]?, from:NSDictionary, key:String) {
    prop = parseArray(from, key)
}

func parseArray<T : JsonSerializable>(from:NSDictionary, key:String) -> [T] {
    var to = [T]()
    if let arr = from[key] as? NSArray {
        for item in arr {
            if let map = item as? NSDictionary {
                let t = T.fromDictionary(map)
                to.append(t as T)
            }
        }
    }
    return to
}

func getValue<T>(val:T) -> Any {
    return val as Any
}

func getValue<T : JsonSerializable>(val:T) -> Any {
    return val as Any
}

func getOptionalValue<T>(val:T?) -> Any {
    return val as Any
}

func getOptionalValue<T : JsonSerializable>(val:T?) -> Any {
    return val as Any
}

func getValue<T>(val:[T]) -> Any {
    return val as Any
}

func getValue<Key,Value>(val:Dictionary<Key,Value>) -> Any {
    return val as Any
}

protocol JsType {
}

protocol JsConverter {
}

class JsConfigConverter : JsConverter {
    var converter: (AnyObject) -> Any?
    init(converter: (AnyObject) -> Any?) {
        self.converter = converter
    }
}

class JsKey<T>
{
    class func type() -> String {
        return typestring(T)
    }
}

class JsConfigType<T> : JsType
{
    var writers: [(String,(T,NSDictionary) -> Void)]
    var readers: [(String,(T) -> Any)]
    
    init(writers:[(String,(T,NSDictionary) -> Void)],
         readers:[(String,(T) -> Any)])
    {
        self.writers = writers
        self.readers = readers
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

struct SetProperty
{
    let key:String
    let fn:(AnyObject,NSDictionary) -> Void
    
    init(key:String, fn:(AnyObject,NSDictionary) -> Void) {
        self.key = key
        self.fn = fn
    }
}

class JsConfig
{
    struct Config {
        static var types = Dictionary<String, JsType>()
        static var converters = JsConfig.builtInConverters()
    }
    
    class func builtInConverters() -> Dictionary<String, JsConverter>  {
        
        let cfstring:CFString = ""
        
        return [
            convertFromKey(NSNumber.self,to:Int.self): JsConfigConverter({ (x:AnyObject) in Int(x as NSNumber) }),
            convertFromKey(cfstring,to:String.self): JsConfigConverter({ (x:AnyObject) in String(x as NSString) }),
            convertFromKey(NSString.self,to:String.self): JsConfigConverter({ (x:AnyObject) in String(x as NSString) }),
        ]
    }
    
    class func configure<T>(typeConfig:JsConfigType<T>) -> JsConfigType<T> {
        Config.types[JsKey<T>.type()] = typeConfig
        return typeConfig
    }
    
    class func typeConfig<T>() -> JsConfigType<T>? {
        return Config.types[JsKey<T>.type()] as? JsConfigType<T>
    }
    
    class func convertFromKey(from:Any, to:Any) -> String {
        var key = typestring(from) + " > " + typestring(to)
        println(">>  key: \(key)")
        return key
    }

    class func setConverter<From,To>(converter:(From) -> To?) {
        var key = convertFromKey(From.self, to:To.self)
        Config.converters[key] = JsConfigConverter({(from:AnyObject) in converter(from as From)})
    }
    
    class func converter(from:Any, to:Any) -> ((AnyObject) -> Any)? {
        let key = convertFromKey(from, to:to)
        if let wrapper = Config.converters[key] as? JsConfigConverter {
            return wrapper.converter
        }
        return nil
    }
    
    class func converterForOptional(from:Any, to:Any) -> ((AnyObject) -> Any)? {
        var key = convertFromKey(from, to:to)
        key = key.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString:"?"))
        if let wrapper = Config.converters[key] as? JsConfigConverter {
            return wrapper.converter
        }
        return nil
    }
}

func convertNSSNumber(value:NSNumber) -> Int? {
    return Int(value)
}

func convertNSString(value:NSString) -> String? {
    let ret = value as String
    return ret
}

func convertBool(value:Boolean) -> Bool? {
    return nil
}

func serializeToJson<T>(instance:T) -> String? {
    if let typeConfig:JsConfigType<T> = JsConfig.typeConfig() {
        return serializeToJson(instance, typeConfig)
    }
    return nil
}

func serializeToJson<T>(instance:T, typeConfig:JsConfigType<T>) -> String {
    var jb = JObject()
    for (name,reader) in typeConfig.readers {
        jb.append(name, value: reader(instance))
    }
    return jb.toJson()
}

func populate<T>(instance:T, json:String) -> T {
    if let typeConfig:JsConfigType<T> = JsConfig.typeConfig() {
        if let map = parseJson(json) as? NSDictionary {
            return populate(instance, map, typeConfig)
        }
    }
    return instance
}

func populate<T>(instance:T, map:NSDictionary) -> T {
    if let typeConfig:JsConfigType<T> = JsConfig.typeConfig() {
        return populate(instance, map, typeConfig)
    }
    return instance
}

func populate<T>(instance:T, json:String, typeConfig:JsConfigType<T>) -> T {
    if let map = parseJson(json) as? NSDictionary {
        return populate(instance, map, typeConfig)
    }
    return instance
}

func populate<T>(instance:T, map:NSDictionary, typeConfig:JsConfigType<T>) -> T {
    for (name,fn) in typeConfig.writers {
        if let x:AnyObject = map[name] {
            fn(instance, map)
        }
    }
    return instance
}

func parseJson(json:String) -> AnyObject? {
    let data = json.dataUsingEncoding(NSUTF8StringEncoding)!
    var parseError: NSError?
    let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data,
        options: NSJSONReadingOptions.AllowFragments,
        error:&parseError)
    return parsedObject
}

protocol Serializable {
    typealias T
    class func typeConfig() -> JsConfigType<T>
    init()
}

protocol JsonSerializable : Serializable {
    func toJson() -> String
    class func fromDictionary(map:NSDictionary) -> T
    class func fromJson(json:String) -> T
}






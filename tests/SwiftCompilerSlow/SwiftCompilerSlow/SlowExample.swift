#if false
import Foundation

class JsConfigType<T> {
    var writers: [(String,(T,NSDictionary) -> Void)]
    var readers: [(String,(T) -> Any)]
    init(writers:[(String,(T,NSDictionary) -> Void)], readers:[(String,(T) -> Any)]) {
        self.writers = writers
        self.readers = readers
    }}

func set<T>(inout prop:T, from:NSDictionary, key:String) {
    if let any:AnyObject = from[key] {
        switch any {
        case let t as T:
            prop = t
        default: break
        }}}

class A {
    required init(){}
    var id:Int?
    var idO:Int?
    var byte:Int8?
    var short:Int16?
    var int:Int?
    var long:Int64?
    var uShort:UInt16?
    var uInt:UInt32?
    var uLong:UInt64?
    var float:Float?
    var double:Double?
    var decimal:Double?
    var string:String?
    var date:String?
    var sl:[String] = []
    var sa:[String] = []
    var sm:[String:String] = [:]
    var ism:[Int:String] = [:]
}

extension A : JsonSerializable {
    class func typeConfig() -> JsConfigType<A> {
        return JsConfigType<A>(
            writers: [
                ("id", { (x:A, map:NSDictionary) in set(&x.id, map, "id") }),
                ("idO", { (x:A, map:NSDictionary) in set(&x.idO, map, "idO") }),
                ("byte", { (x:A, map:NSDictionary) in set(&x.byte, map, "byte") }),
                ("short", { (x:A, map:NSDictionary) in set(&x.short, map, "short") }),
                ("int", { (x:A, map:NSDictionary) in set(&x.int, map, "int") }),
                ("long", { (x:A, map:NSDictionary) in set(&x.long, map, "long") }),
                ("uShort", { (x:A, map:NSDictionary) in set(&x.uShort, map, "uShort") }),
                ("uInt", { (x:A, map:NSDictionary) in set(&x.uInt, map, "uInt") }),
                ("uLong", { (x:A, map:NSDictionary) in set(&x.uLong, map, "uLong") }),
                ("float", { (x:A, map:NSDictionary) in set(&x.float, map, "float") }),
                ("double", { (x:A, map:NSDictionary) in set(&x.double, map, "double") }),
                ("decimal", { (x:A, map:NSDictionary) in set(&x.decimal, map, "decimal") }),
                ("string", { (x:A, map:NSDictionary) in set(&x.string, map, "string") }),
                ("date", { (x:A, map:NSDictionary) in set(&x.date, map, "date") }),
                ("sl", { (x:A, map:NSDictionary) in set(&x.sl, map, "sl") }),
                ("sa", { (x:A, map:NSDictionary) in set(&x.sa, map, "sa") }),
                ("sm", { (x:A, map:NSDictionary) in set(&x.sm, map, "sm") }),
                ("ism", { (x:A, map:NSDictionary) in set(&x.ism, map, "ism") }),
            ],
            readers: [
                ("id", { (x:A) in x.id as Any }),
                ("idO", { (x:A) in x.idO as Any }),
                ("byte", { (x:A) in x.byte as Any }),
                ("short", { (x:A) in x.short as Any }),
                ("int", { (x:A) in x.int as Any }),
                ("long", { (x:A) in x.long as Any }),
                ("uShort", { (x:A) in x.uShort as Any }),
                ("uInt", { (x:A) in x.uInt as Any }),
                ("uLong", { (x:A) in x.uLong as Any }),
                ("float", { (x:A) in x.float as Any }),
                ("double", { (x:A) in x.double as Any }),
                ("decimal", { (x:A) in x.decimal as Any }),
                ("string", { (x:A) in x.string as Any }),
                ("date", { (x:A) in x.date as Any }),
                ("sl", { (x:A) in x.sl as Any }),
                ("sa", { (x:A) in x.sa as Any }),
                ("sm", { (x:A) in x.sm as Any }),
                ("ism", { (x:A) in x.ism as Any }),
            ])}}
#endif



import Foundation

public class JsConfigType<T> {
    var writers: [(String,(T,NSDictionary) -> Void)]
    var readers: [(String,(T) -> Any)]
    
    init(writers:[(String,(T,NSDictionary) -> Void)], readers:[(String,(T) -> Any)]) {
        self.writers = writers
        self.readers = readers
    }
}

func set<T>(inout prop:T, from:NSDictionary, key:String) {
    if let any:AnyObject = from[key] {
        switch any {
        case let t as T:
            prop = t
        default: break
        }
    }
}

public protocol Serializable {
    typealias T
    class func typeConfig() -> JsConfigType<T>
    init()
}

class B {
    required init(){}
    var id:Int = 0
}

class C : B {
    required init(){}
    var name:String?
}

extension B : Serializable {
    class func typeConfig() -> JsConfigType<B> {
        return JsConfigType<B>(
            writers: [
                ("id", { (x:B, map:NSDictionary) in set(&x.id, map, "id") }),
            ],
            readers: [
                ("id", { (x:B) in x.id as Any }),
            ]
        )
    }
}

extension C : Serializable {
    class func typeConfig() -> JsConfigType<C> {
        return JsConfigType<C>(
            writers: [
                ("name", { (x:C, map:NSDictionary) in set(&x.name, map, "name") }),
            ],
            readers: [
                ("name", { (x:C) in x.name as Any }),
            ]
        )
    }
}

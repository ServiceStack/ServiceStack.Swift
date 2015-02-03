#if false
//
//  File1.swift
//  SwiftCompilerErrors
//
//  Created by Demis Bellot on 1/31/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public protocol HasName {
    class var name:String { get }
}

public protocol HasTypeInfo : HasName {
    typealias T : HasTypeInfo
    class func typeInfo() -> Type<T>
    init()
}

public class TypeAccessor {}

public class Type<T : HasTypeInfo> : TypeAccessor
{
    var properties: [PropertyType]
    init(properties:[PropertyType])
    {
        self.properties = properties
    }
    
    public class func optionalProperty<P : HasName>(name:String, get:(T) -> P?, set:(T,P?) -> Void) -> PropertyType
    {
        return OptionalProperty(name: name, get, set)
    }
}

public class OptionalProperty<T : HasTypeInfo, P : HasName> : PropertyType
{
    public var name:String
    public var get:(T) -> P?
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P?, set:(T,P?) -> Void)
    {
        self.name = name
        self.get = get
        self.set = set
        //        super.init(name: name)
    }
}


//public class PropertyType {
//    public var name:String
//    init(name:String){
//        self.name = name
//    }
//}

//public class Property<T : HasTypeInfo, P : HasName> : PropertyType
//{
//    public var get:(T) -> P
//    public var set:(T,P) -> Void
//    
//    init(name:String, get:(T) -> P, set:(T,P) -> Void)
//    {
//        self.get = get
//        self.set = set
//        super.init(name: name)
//    }
//}


public class C {
    public var id:Int?
    public required init(){}
}
//public class HasC
//{
//    public required init(){}
//    public var c:C?
//}
//
//extension Int : HasName {
//    public static var name:String { return "Int" }
//}
//
extension C : HasTypeInfo {
    public class var name:String { return "C" }
    
    public class func typeInfo() -> Type<C> {
        return Type<C>(properties: [Type<C>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 })])
    }
}

//extension HasC : HasTypeInfo {
//    public class var name:String { return "HasC" }
//    
//    public class func typeInfo() -> Type<HasC> {
//        return Type<HasC>(properties: [
//            Type<HasC>.optionalProperty("c", get: { $0.c }, set: { $0.c = $1 }),
//        ])
//    }
//}

//public class HasCFile2
//{
//    required public init(){}
//    var c:C?
//}

//extension HasCFile2 : HasTypeInfo {
//    public class var name:String { return "HasCFile2" }
//    
//    public class func typeInfo() -> Type<HasCFile2> {
//        return Type<HasCFile2>(properties: [
//            Type<HasCFile2>.optionalProperty("c", get: { $0.c }, set: { $0.c = $1 }),
//        ])
//    }
//}


#endif


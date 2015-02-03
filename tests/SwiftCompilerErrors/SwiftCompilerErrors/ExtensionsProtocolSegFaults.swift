//#if true
//
//  ExtensionsProtocolSegFaults.swift
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

//public protocol Wrapper : HasTypeInfo {
//}

public class TypeAccessor {}

public class Type<T> : TypeAccessor
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

public class PropertyType{}

public class OptionalProperty<T, P : HasName> : PropertyType
{
    public var name:String
    public var get:(T) -> P?
    public var set:(T,P?) -> Void
    
    init(name:String, get:(T) -> P?, set:(T,P?) -> Void)
    {
        self.name = name
        self.get = get
        self.set = set
    }
}

public class C {
    public var id:Int?
    public required init(){}
}

extension Int : HasName {
    public static var name:String { return "Int" }
}

extension C : HasTypeInfo {
    public class var name:String { return "C" }
    
    public class func typeInfo() -> Type<C> {
        return Type<C>(properties: [
            Type<C>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 })
        ])
    }
}

public class HasC
{
    public required init(){}
    public var c:C?
}
extension HasC : HasTypeInfo {
    public class var name:String { return "HasC" }

    public class func typeInfo() -> Type<HasC> {
        return Type<HasC>(properties: [
            Type<HasC>.optionalProperty("c", get: { $0.c }, set: { $0.c = $1 }),
        ])
    }
}


//#endif

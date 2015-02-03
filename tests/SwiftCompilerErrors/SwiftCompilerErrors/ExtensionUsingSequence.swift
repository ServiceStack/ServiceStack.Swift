#if false
//
//  ExtensionUsingSequence.swift
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
        return PropertyType()
    }
}

public class PropertyType{}

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

//            Type<C>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 })

#endif

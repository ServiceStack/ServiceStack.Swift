//
//  JsonTest.swift
//  JsonTest
//
//  Created by Demis Bellot on 9/20/15.
//  Copyright © 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public protocol StringSerializable {
    func toString() -> String
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

public class JProperty<T : HasMetadata, P : StringSerializable> : PropertyType
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
    
    public override func setValue(instance:T, value:AnyObject) {
        if let p = value as? P {
            set(instance, p)
        }
    }
}



public protocol HasMetadata
{
    static var properties:[String:PropertyType] { get }
}
extension HasMetadata
{
    public func toString() -> String {
        return "\(self)"
    }
}

public class Metadata {
    static func map(properties:[PropertyType]) -> [String:PropertyType] {
        var to = [String:PropertyType]()
        for p in properties {
            to[p.name] = p
        }
        return to
    }
}


public class Type<T : HasMetadata, P : StringSerializable>
{
    public class func property(name:String, get:(T) -> P, set:(T,P) -> Void) -> PropertyType
    {
        return JProperty(name: name, get:get, set:set)
    }
}

extension Int : StringSerializable
{
    public func toString() -> String {
        return "\(self)"
    }
}


public class Test
{
    required public init() {}
    required public init(id:Int) {
        self.id = id
    }
    
    public var id:Int = 0
}

extension Test : HasMetadata
{
    public static var properties:[String:PropertyType] = Metadata.map([
        Type<Test, Int>.property("id", get: { $0.id }, set: { $0.id = $1 })
    ])
}

func main() {
    print(Test.properties["id"]!.getValue(Test(id: 1)))
}

//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

public protocol HasReflect {
    static func reflect() -> TypeAccessor
    init()
}

public protocol TypeAccessor {
    
}

public class Type<T : HasReflect> : TypeAccessor
{
    
}

public class TestType
{
    required public init(){}
}

extension TestType : HasReflect
{
    public static func reflect() -> TypeAccessor {
        return Type<TestType>()
    }
}

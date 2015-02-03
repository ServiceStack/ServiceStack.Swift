//
//  File2.swift
//  SwiftCompilerErrors
//
//  Created by Demis Bellot on 1/31/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

public class HasCFile2
{
    required public init(){}
    var c:C?
}

extension HasCFile2 : HasTypeInfo {
    public class var name:String { return "HasCFile2" }
    
    public class func typeInfo() -> Type<HasCFile2> {
        return Type<HasCFile2>(properties: [
            Type<HasCFile2>.optionalProperty("c", get: { $0.c }, set: { $0.c = $1 }),
            ])
    }
}


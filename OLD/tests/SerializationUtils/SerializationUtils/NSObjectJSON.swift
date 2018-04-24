//
//  NSObjectJSON.swift
//  SerializationUtils
//
//  Created by Demis Bellot on 1/22/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

//Use reflection in Obj-C NSObject to use reflection to populate models. Requires models inherit NSObject

extension NSObject
{
    class func fromDictionary(map: NSDictionary) -> Self {
        var object = self()
        (object as NSObject).populateWith(map)
        return object
    }

    func populateWith(map: NSDictionary) {
        for (key, value) in map {
            let keyName = key as String
            if (respondsToSelector(NSSelectorFromString(keyName))) {
                setValue(value, forKey: keyName)
            }
        }
    }

    func propertyNames() -> [String] {
        var names: [String] = []
        var count: UInt32 = 0
        var properties = class_copyPropertyList(classForCoder, &count)
        for var i = 0; i < Int(count); ++i {
            let property: objc_property_t = properties[i]
            let name: String = String.fromCString(property_getName(property))!
            names.append(name)
        }
        free(properties)
        return names
    }

    func toDictionary() -> NSDictionary {
        var json:Dictionary<String, AnyObject> = [:]

        for name in propertyNames() {
            if let value:AnyObject = valueForKey(name) {
                json[name] = value
            }
        }

        return json
    }
}


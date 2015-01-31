#if false
//
//  Template.swift
//  ServiceStackClientTests
//
//  Created by Demis Bellot on 1/28/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation


// @DataContract
public class Option
{
    required public init(){}
    // @DataMember(Name="name")
    public var name:String?

    // @DataMember(Name="title")
    public var title:String?

    public var value:TechnologyTier?
}

extension Option : JsonSerializable
{
    public class var typeName:String { return "UInt32" }

    public class func reflect() -> Type<Option> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Option>(
            properties: [
                Type<Option>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<Option>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
                Type<Option>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Option.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Option? {
        return Option.reflect().fromJson(Option(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Option? {
        return Option.reflect().fromObject(Option(), any:any)
    }
    public func toString() -> String {
        return Option.reflect().toString(self)
    }
    public class func fromString(string:String) -> Option? {
        return Option.reflect().fromString(Option(), string: string)
    }
}

public enum TechnologyTier : Int
{
    case ProgrammingLanguage
    case Client
    case Http
    case Server
    case Data
    case SoftwareInfrastructure
    case OperatingSystem
    case HardwareInfrastructure
    case ThirdPartyServices
}
extension TechnologyTier : StringSerializable
{
    public static var typeName:String { return "TechnologyTier" }
    
    public func toJson() -> String {
        return jsonString(toString())
    }
    public func toString() -> String {
        switch self {
        case .ProgrammingLanguage: return "ProgrammingLanguage"
        case .Client: return "Client"
        case .Http: return "Http"
        case .Server: return "Server"
        case .Data: return "Data"
        case .SoftwareInfrastructure: return "SoftwareInfrastructure"
        case .OperatingSystem: return "OperatingSystem"
        case .HardwareInfrastructure: return "HardwareInfrastructure"
        case .ThirdPartyServices: return "ThirdPartyServices"
        }
    }
    public static func fromString(strValue:String) -> TechnologyTier? {
        switch strValue {
        case "ProgrammingLanguage": return .ProgrammingLanguage
        case "Client": return .Client
        case "Http": return .Http
        case "Server": return .Server
        case "Data": return .Data
        case "SoftwareInfrastructure": return .SoftwareInfrastructure
        case "OperatingSystem": return .OperatingSystem
        case "HardwareInfrastructure": return .HardwareInfrastructure
        case "ThirdPartyServices": return .ThirdPartyServices
        default: return nil
        }
    }
    public static func fromObject(any:AnyObject) -> TechnologyTier? {
        switch any {
        case let i as Int: return TechnologyTier(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

#endif

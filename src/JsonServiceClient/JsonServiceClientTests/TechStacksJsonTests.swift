//
//  TechStacksJsonTests.swift
//  JsonServiceClient
//
//  Created by Demis Bellot on 1/26/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import XCTest

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
    public class func reflect() -> Type<Option> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Option>(
            name: "Option",
            properties: [
                Type<Option>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<Option>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
                Type<Option>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Option.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Option {
        return Option.reflect().fromJson(Option(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Option? {
        return Option.reflect().fromObject(Option(), any:any)
    }
    public func toString() -> String {
        return Option.reflect().toString(self)
    }
    public class func fromString(json:String) -> Option? {
        return Option.reflect().fromString(Option(), json: json)
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


class TechStacksJsonTests: XCTestCase
{
    func test_Can_serialize_Empty_Option() {
        var dto = Option()
        
        var json = Option.reflect().toJson(dto)
        
        println(json)
        
        XCTAssertEqual(json,
            "{\"name\":null,\"title\":null,\"value\":null}")
    }
    
    func test_Can_deserialize_Empty_Option() {
        let json = "{\"name\":null,\"title\":null,\"value\":null}"
        
        var dto = Option.fromJson(json)
        
        XCTAssertNil(dto.name)
        XCTAssertNil(dto.title)
        //        XCTAssertEqual(dto.name)
    }
    
    
    func test_Can_deserialize_Full_Option() {
        let json = "{\"name\":\"name\",\"title\":\"title\",\"value\":\"ProgrammingLanguage\"}"
        
        var dto = Option.fromJson(json)
        
        XCTAssertEqual(dto.name!, "name")
        XCTAssertEqual(dto.title!, "title")
        XCTAssertEqual(dto.value!, TechnologyTier.ProgrammingLanguage)
    }
    
    func test_Can_serialize_Full_Option() {
        var dto = Option()
        dto.name = "name"
        dto.title = "title"
        dto.value = TechnologyTier.ProgrammingLanguage
        
        var json = Option.reflect().toJson(dto)
        
        println(json)
        
        XCTAssertEqual(json,
            "{\"name\":\"name\",\"title\":\"title\",\"value\":\"ProgrammingLanguage\"}")
    }
    
//    func test_Can_serialize_Empty_Technology() {
//        var dto = Technology()
//        
//        var json = dto.toJson()
//        
//        println(json)
//        
//        XCTAssertEqual(json,
//            "{\"id\":null,\"name\":null,\"vendorName\":null,\"vendorUrl\":null,\"productUrl\":null,\"logoUrl\":null,\"description\":null,\"created\":null,\"createdBy\":null,\"lastModified\":null,\"lastModifiedBy\":null,\"ownerId\":null,\"slug\":null,\"logoApproved\":null,\"isLocked\":null,\"tier\":null,\"lastStatusUpdate\":null}")
//    }
//    
//    func test_Can_serialize_Full_Technology() {
//        var dto = Technology()
//        dto.id = 1
//        dto.name = "name"
//        dto.vendorName = "vendorName"
//        dto.vendorUrl = "vendorUrl"
//        dto.productUrl = "productUrl"
//        dto.logoUrl = "logoUrl"
//        dto.description = "description"
//        dto.created = "created"
//        dto.createdBy = "createdBy"
//        dto.lastModified = "lastModified"
//        dto.lastModifiedBy = "lastModifiedBy"
//        dto.ownerId = "ownerId"
//        dto.slug = "slug"
//        dto.logoApproved = true
//        dto.isLocked = false
//        dto.tier = TechnologyTier.ProgrammingLanguage
//        dto.lastStatusUpdate = "lastStatusUpdate"
//        
//        
//        var json = dto.toJson()
//        
//        println(json)
//        
//        XCTAssertEqual(json,
//            "{\"id\":1,\"name\":\"name\",\"vendorName\":\"vendorName\",\"vendorUrl\":\"vendorUrl\",\"productUrl\":\"productUrl\",\"logoUrl\":\"logoUrl\",\"description\":\"description\",\"created\":\"created\",\"createdBy\":\"createdBy\",\"lastModified\":\"lastModified\",\"lastModifiedBy\":\"lastModifiedBy\",\"ownerId\":\"ownerId\",\"slug\":\"slug\",\"logoApproved\":true,\"isLocked\":false,\"tier\":\"ProgrammingLanguage\",\"lastStatusUpdate\":\"lastStatusUpdate\"}")
//        
//    }
    
}

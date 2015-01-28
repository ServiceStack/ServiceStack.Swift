/* Options:
Date: 2015-01-28 11:15:16
Version: 1
BaseUrl: http://techstacks.io

//AddResponseStatus: False
//AddModelExtensions: True
//AddServiceStackTypes: True
//FlattenAbstractTypes: True
//InitializeCollections: True
//AddImplicitVersion:
//IncludeTypes:
//ExcludeTypes:
//DefaultNamespaces: Foundation
*/

import Foundation

public class Technology : TechnologyBase
{
    required public init(){}
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

// @DataContract
public class ResponseStatus
{
    required public init(){}
    // @DataMember(Order=1)
    public var errorCode:String?
    
    // @DataMember(Order=2)
    public var message:String?
    
    // @DataMember(Order=3)
    public var stackTrace:String?
    
    // @DataMember(Order=4)
    public var errors:[ResponseError] = []
}

public class TechnologyStack : TechnologyStackBase
{
    required public init(){}
}

public class TechnologyHistory : TechnologyBase
{
    required public init(){}
    public var technologyId:Int64?
    public var operation:String?
}

public class QueryBase_1<T : JsonSerializable> : QueryBase
{
    required public init(){}
}

public class TechStackDetails : TechnologyStackBase
{
    required public init(){}
    public var detailsHtml:String?
    public var technologyChoices:[TechnologyInStack] = []
}

public class TechnologyStackHistory : TechnologyStackBase
{
    required public init(){}
    public var technologyStackId:Int64?
    public var operation:String?
    public var technologyIds:[Int64] = []
}

// @DataContract
public class Option
{
    required public init(){}
    // @DataMember(Name="name")
    public var name:String?
    
    // @DataMember(Name="title")
    public var title:String?
    
    // @DataMember(Name="value")
    public var value:TechnologyTier?
}

public class UserInfo
{
    required public init(){}
    public var userName:String?
    public var avatarUrl:String?
    public var stacksCount:Int?
}

public class TechnologyInfo
{
    required public init(){}
    public var tier:TechnologyTier?
    public var slug:String?
    public var name:String?
    public var logoUrl:String?
    public var stacksCount:Int?
}

public class TechnologyBase
{
    required public init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var description:String?
    public var created:String?
    public var createdBy:String?
    public var lastModified:String?
    public var lastModifiedBy:String?
    public var ownerId:String?
    public var slug:String?
    public var logoApproved:Bool?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
    public var lastStatusUpdate:String?
}

// @DataContract
public class ResponseError
{
    required public init(){}
    // @DataMember(Order=1, EmitDefaultValue=false)
    public var errorCode:String?
    
    // @DataMember(Order=2, EmitDefaultValue=false)
    public var fieldName:String?
    
    // @DataMember(Order=3, EmitDefaultValue=false)
    public var message:String?
}

public class TechnologyStackBase
{
    required public init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var description:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var created:String?
    public var createdBy:String?
    public var lastModified:String?
    public var lastModifiedBy:String?
    public var isLocked:Bool?
    public var ownerId:String?
    public var slug:String?
    public var details:String?
    public var lastStatusUpdate:String?
}

public class QueryBase
{
    required public init(){}
    // @DataMember(Order=1)
    public var skip:Int?
    
    // @DataMember(Order=2)
    public var take:Int?
    
    // @DataMember(Order=3)
    public var orderBy:String?
    
    // @DataMember(Order=4)
    public var orderByDesc:String?
}

public class TechnologyInStack : TechnologyBase
{
    required public init(){}
    public var technologyId:Int64?
    public var technologyStackId:Int64?
    public var justification:String?
}

public class LogoUrlApprovalResponse
{
    required public init(){}
    public var result:Technology?
}

public class LockStackResponse
{
    required public init(){}
}

public class CreateTechnologyResponse
{
    required public init(){}
    public var result:Technology?
    public var responseStatus:ResponseStatus?
}

public class UpdateTechnologyResponse
{
    required public init(){}
    public var result:Technology?
    public var responseStatus:ResponseStatus?
}

public class DeleteTechnologyResponse
{
    required public init(){}
    public var result:Technology?
    public var responseStatus:ResponseStatus?
}

public class GetTechnologyResponse
{
    required public init(){}
    public var created:String?
    public var technology:Technology?
    public var technologyStacks:[TechnologyStack] = []
    public var responseStatus:ResponseStatus?
}

public class GetTechnologyPreviousVersionsResponse
{
    required public init(){}
    public var results:[TechnologyHistory] = []
}

public class GetTechnologyFavoriteDetailsResponse
{
    required public init(){}
    public var users:[String] = []
    public var favoriteCount:Int?
}

public class GetAllTechnologiesResponse
{
    required public init(){}
    public var results:[Technology] = []
}

// @DataContract
public class QueryResponse<Technology : JsonSerializable>
{
    required public init(){}
    // @DataMember(Order=1)
    public var offset:Int?
    
    // @DataMember(Order=2)
    public var total:Int?
    
    // @DataMember(Order=3)
    public var results:[Technology] = []
    
    // @DataMember(Order=4)
    public var meta:[String:String] = [:]
    
    // @DataMember(Order=5)
    public var responseStatus:ResponseStatus?
}

public class CreateTechnologyStackResponse
{
    required public init(){}
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?
}

public class UpdateTechnologyStackResponse
{
    required public init(){}
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?
}

public class DeleteTechnologyStackResponse
{
    required public init(){}
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?
}

public class GetAllTechnologyStacksResponse
{
    required public init(){}
    public var results:[TechnologyStack] = []
}

public class GetTechnologyStackResponse
{
    required public init(){}
    public var created:String?
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?
}

public class GetTechnologyStackPreviousVersionsResponse
{
    required public init(){}
    public var results:[TechnologyStackHistory] = []
}

public class GetTechnologyStackFavoriteDetailsResponse
{
    required public init(){}
    public var users:[String] = []
    public var favoriteCount:Int?
}

public class GetConfigResponse
{
    required public init(){}
    public var allTiers:[Option] = []
}

public class OverviewResponse
{
    required public init(){}
    public var created:String?
    public var topUsers:[UserInfo] = []
    public var topTechnologies:[TechnologyInfo] = []
    public var latestTechStacks:[TechStackDetails] = []
    public var topTechnologiesByTier:[TechnologyTier:[TechnologyInfo]] = [:]
    public var responseStatus:ResponseStatus?
}

public class GetFavoriteTechStackResponse
{
    required public init(){}
    public var results:[TechnologyStack] = []
}

public class FavoriteTechStackResponse
{
    required public init(){}
    public var result:TechnologyStack?
}

public class GetFavoriteTechnologiesResponse
{
    required public init(){}
    public var results:[Technology] = []
}

public class FavoriteTechnologyResponse
{
    required public init(){}
    public var result:Technology?
}

public class GetUserFeedResponse
{
    required public init(){}
    public var results:[TechStackDetails] = []
}

public class GetUserInfoResponse
{
    required public init(){}
    public var userName:String?
    public var created:String?
    public var avatarUrl:String?
    public var techStacks:[TechnologyStack] = []
    public var favoriteTechStacks:[TechnologyStack] = []
    public var favoriteTechnologies:[Technology] = []
}

// @DataContract
public class AuthenticateResponse
{
    required public init(){}
    // @DataMember(Order=1)
    public var userId:String?
    
    // @DataMember(Order=2)
    public var sessionId:String?
    
    // @DataMember(Order=3)
    public var userName:String?
    
    // @DataMember(Order=4)
    public var displayName:String?
    
    // @DataMember(Order=5)
    public var referrerUrl:String?
    
    // @DataMember(Order=6)
    public var responseStatus:ResponseStatus?
    
    // @DataMember(Order=7)
    public var meta:[String:String] = [:]
}

public class AssignRolesResponse
{
    required public init(){}
    public var allRoles:[String] = []
    public var allPermissions:[String] = []
    public var responseStatus:ResponseStatus?
}

public class UnAssignRolesResponse
{
    required public init(){}
    public var allRoles:[String] = []
    public var allPermissions:[String] = []
    public var responseStatus:ResponseStatus?
}

// @Route("/admin/technology/{TechnologyId}/logo")
public class LogoUrlApproval : IReturn
{
    typealias Return = LogoUrlApprovalResponse
    
    required public init(){}
    public var technologyId:Int64?
    public var approved:Bool?
}

// @Route("/admin/techstacks/{TechnologyStackId}/lock")
public class LockTechStack : IReturn
{
    typealias Return = LockStackResponse
    
    required public init(){}
    public var technologyStackId:Int64?
    public var isLocked:Bool?
}

// @Route("/admin/technology/{TechnologyId}/lock")
public class LockTech : IReturn
{
    typealias Return = LockStackResponse
    
    required public init(){}
    public var technologyId:Int64?
    public var isLocked:Bool?
}

// @Route("/ping")
public class Ping
{
    required public init(){}
}

// @Route("/{PathInfo*}")
public class FallbackForClientRoutes
{
    required public init(){}
    public var pathInfo:String?
}

// @Route("/stacks")
public class ClientAllTechnologyStacks
{
    required public init(){}
}

// @Route("/tech")
public class ClientAllTechnologies
{
    required public init(){}
}

// @Route("/tech/{Slug}")
public class ClientTechnology
{
    required public init(){}
    public var slug:String?
}

// @Route("/users/{UserName}")
public class ClientUser
{
    required public init(){}
    public var userName:String?
}

// @Route("/my-session")
public class SessionInfo
{
    required public init(){}
}

// @Route("/technology", "POST")
public class CreateTechnology : IReturn
{
    typealias Return = CreateTechnologyResponse
    
    required public init(){}
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var description:String?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
}

// @Route("/technology/{Id}", "PUT")
public class UpdateTechnology : IReturn
{
    typealias Return = UpdateTechnologyResponse
    
    required public init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var description:String?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
}

// @Route("/technology/{Id}", "DELETE")
public class DeleteTechnology : IReturn
{
    typealias Return = DeleteTechnologyResponse
    
    required public init(){}
    public var id:Int64?
}

// @Route("/technology/{Slug}")
public class GetTechnology : IReturn
{
    typealias Return = GetTechnologyResponse
    
    required public init(){}
    public var reload:Bool?
    public var slug:String?
}

// @Route("/technology/{Slug}/previous-versions", "GET")
public class GetTechnologyPreviousVersions : IReturn
{
    typealias Return = GetTechnologyPreviousVersionsResponse
    
    required public init(){}
    public var slug:String?
}

// @Route("/technology/{Slug}/favorites")
public class GetTechnologyFavoriteDetails : IReturn
{
    typealias Return = GetTechnologyFavoriteDetailsResponse
    
    required public init(){}
    public var slug:String?
    public var reload:Bool?
}

// @Route("/technology", "GET")
public class GetAllTechnologies : IReturn
{
    typealias Return = GetAllTechnologiesResponse
    
    required public init(){}
}

// @Route("/technology/search")
public class FindTechnologies<Technology : JsonSerializable> : QueryBase_1<Technology>, IReturn
{
    typealias Return = QueryResponse<Technology>
    
    required public init(){}
    public var reload:Bool?
}

// @Route("/techstacks", "POST")
public class CreateTechnologyStack : IReturn
{
    typealias Return = CreateTechnologyStackResponse
    
    required public init(){}
    public var name:String?
    public var vendorName:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var description:String?
    public var details:String?
    public var isLocked:Bool?
    public var technologyIds:[Int64] = []
}

// @Route("/techstacks/{Id}", "PUT")
public class UpdateTechnologyStack : IReturn
{
    typealias Return = UpdateTechnologyStackResponse
    
    required public init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var description:String?
    public var details:String?
    public var isLocked:Bool?
    public var technologyIds:[Int64] = []
}

// @Route("/techstacks/{Id}", "DELETE")
public class DeleteTechnologyStack : IReturn
{
    typealias Return = DeleteTechnologyStackResponse
    
    required public init(){}
    public var id:Int64?
}

// @Route("/techstacks", "GET")
public class GetAllTechnologyStacks : IReturn
{
    typealias Return = GetAllTechnologyStacksResponse
    
    required public init(){}
}

// @Route("/techstacks/{Slug}", "GET")
public class GetTechnologyStack : IReturn
{
    typealias Return = GetTechnologyStackResponse
    
    required public init(){}
    public var reload:Bool?
    public var slug:String?
}

// @Route("/techstacks/{Slug}/previous-versions", "GET")
public class GetTechnologyStackPreviousVersions : IReturn
{
    typealias Return = GetTechnologyStackPreviousVersionsResponse
    
    required public init(){}
    public var slug:String?
}

// @Route("/techstacks/{Slug}/favorites")
public class GetTechnologyStackFavoriteDetails : IReturn
{
    typealias Return = GetTechnologyStackFavoriteDetailsResponse
    
    required public init(){}
    public var slug:String?
    public var reload:Bool?
}

// @Route("/config")
public class GetConfig : IReturn
{
    typealias Return = GetConfigResponse
    
    required public init(){}
}

// @Route("/overview")
public class Overview : IReturn
{
    typealias Return = OverviewResponse
    
    required public init(){}
    public var reload:Bool?
}

// @Route("/techstacks/search")
public class FindTechStacks<TechnologyStack : JsonSerializable> : QueryBase_1<TechnologyStack>, IReturn
{
    typealias Return = QueryResponse<TechnologyStack>
    
    required public init(){}
    public var reload:Bool?
}

// @Route("/favorites/techtacks", "GET")
public class GetFavoriteTechStack : IReturn
{
    typealias Return = GetFavoriteTechStackResponse
    
    required public init(){}
    public var technologyStackId:Int?
}

// @Route("/favorites/techtacks/{TechnologyStackId}", "PUT")
public class AddFavoriteTechStack : IReturn
{
    typealias Return = FavoriteTechStackResponse
    
    required public init(){}
    public var technologyStackId:Int?
}

// @Route("/favorites/techtacks/{TechnologyStackId}", "DELETE")
public class RemoveFavoriteTechStack : IReturn
{
    typealias Return = FavoriteTechStackResponse
    
    required public init(){}
    public var technologyStackId:Int?
}

// @Route("/favorites/technology", "GET")
public class GetFavoriteTechnologies : IReturn
{
    typealias Return = GetFavoriteTechnologiesResponse
    
    required public init(){}
    public var technologyId:Int?
}

// @Route("/favorites/technology/{TechnologyId}", "PUT")
public class AddFavoriteTechnology : IReturn
{
    typealias Return = FavoriteTechnologyResponse
    
    required public init(){}
    public var technologyId:Int?
}

// @Route("/favorites/technology/{TechnologyId}", "DELETE")
public class RemoveFavoriteTechnology : IReturn
{
    typealias Return = FavoriteTechnologyResponse
    
    required public init(){}
    public var technologyId:Int?
}

// @Route("/my-feed")
public class GetUserFeed : IReturn
{
    typealias Return = GetUserFeed
    
    required public init(){}
}

// @Route("/userinfo/{UserName}")
public class GetUserInfo : IReturn
{
    typealias Return = GetUserInfo
    
    required public init(){}
    public var reload:Bool?
    public var userName:String?
}

// @Route("/auth")
// @Route("/auth/{provider}")
// @Route("/authenticate")
// @Route("/authenticate/{provider}")
// @DataContract
public class Authenticate : IReturn
{
    typealias Return = AuthenticateResponse
    
    required public init(){}
    // @DataMember(Order=1)
    public var provider:String?
    
    // @DataMember(Order=2)
    public var state:String?
    
    // @DataMember(Order=3)
    public var oauth_token:String?
    
    // @DataMember(Order=4)
    public var oauth_verifier:String?
    
    // @DataMember(Order=5)
    public var userName:String?
    
    // @DataMember(Order=6)
    public var password:String?
    
    // @DataMember(Order=7)
    public var rememberMe:Bool?
    
    // @DataMember(Order=8)
    public var Continue:String?
    
    // @DataMember(Order=9)
    public var nonce:String?
    
    // @DataMember(Order=10)
    public var uri:String?
    
    // @DataMember(Order=11)
    public var response:String?
    
    // @DataMember(Order=12)
    public var qop:String?
    
    // @DataMember(Order=13)
    public var nc:String?
    
    // @DataMember(Order=14)
    public var cnonce:String?
    
    // @DataMember(Order=15)
    public var meta:[String:String] = [:]
}

// @Route("/assignroles")
public class AssignRoles : IReturn
{
    typealias Return = AssignRolesResponse
    
    required public init(){}
    public var userName:String?
    public var permissions:[String] = []
    public var roles:[String] = []
}

// @Route("/unassignroles")
public class UnAssignRoles : IReturn
{
    typealias Return = UnAssignRolesResponse
    
    required public init(){}
    public var userName:String?
    public var permissions:[String] = []
    public var roles:[String] = []
}


extension Technology : JsonSerializable
{
    public class func reflect() -> Type<Technology> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Technology>(
            name: "Technology",
            properties: [
                Type<Technology>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<Technology>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<Technology>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<Technology>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
                Type<Technology>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
                Type<Technology>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
                Type<Technology>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<Technology>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<Technology>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
                Type<Technology>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
                Type<Technology>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
                Type<Technology>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
                Type<Technology>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
                Type<Technology>.optionalProperty("logoApproved", get: { $0.logoApproved }, set: { $0.logoApproved = $1 }),
                Type<Technology>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<Technology>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
                Type<Technology>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Technology.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Technology? {
        return Technology.reflect().fromJson(Technology(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Technology? {
        return Technology.reflect().fromObject(Technology(), any:any)
    }
    public func toString() -> String {
        return Technology.reflect().toString(self)
    }
    public class func fromString(string:String) -> Technology? {
        return Technology.reflect().fromString(Technology(), string: string)
    }
}

extension TechnologyTier : StringSerializable
{
    public func toJson() -> String {
        return jsonStringRaw(toString())
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

extension ResponseStatus : JsonSerializable
{
    public class func reflect() -> Type<ResponseStatus> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ResponseStatus>(
            name: "ResponseStatus",
            properties: [
                Type<ResponseStatus>.optionalProperty("errorCode", get: { $0.errorCode }, set: { $0.errorCode = $1 }),
                Type<ResponseStatus>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
                Type<ResponseStatus>.optionalProperty("stackTrace", get: { $0.stackTrace }, set: { $0.stackTrace = $1 }),
                Type<ResponseStatus>.arrayProperty("errors", get: { $0.errors }, set: { $0.errors = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ResponseStatus.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ResponseStatus? {
        return ResponseStatus.reflect().fromJson(ResponseStatus(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ResponseStatus? {
        return ResponseStatus.reflect().fromObject(ResponseStatus(), any:any)
    }
    public func toString() -> String {
        return ResponseStatus.reflect().toString(self)
    }
    public class func fromString(string:String) -> ResponseStatus? {
        return ResponseStatus.reflect().fromString(ResponseStatus(), string: string)
    }
}

extension TechnologyStack : JsonSerializable
{
    public class func reflect() -> Type<TechnologyStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TechnologyStack>(
            name: "TechnologyStack",
            properties: [
                Type<TechnologyStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<TechnologyStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<TechnologyStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<TechnologyStack>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<TechnologyStack>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
                Type<TechnologyStack>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
                Type<TechnologyStack>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<TechnologyStack>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
                Type<TechnologyStack>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
                Type<TechnologyStack>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
                Type<TechnologyStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<TechnologyStack>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
                Type<TechnologyStack>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
                Type<TechnologyStack>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
                Type<TechnologyStack>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
            ]))
    }
    public func toJson() -> String {
        return TechnologyStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TechnologyStack? {
        return TechnologyStack.reflect().fromJson(TechnologyStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TechnologyStack? {
        return TechnologyStack.reflect().fromObject(TechnologyStack(), any:any)
    }
    public func toString() -> String {
        return TechnologyStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> TechnologyStack? {
        return TechnologyStack.reflect().fromString(TechnologyStack(), string: string)
    }
}

extension TechnologyHistory : JsonSerializable
{
    public class func reflect() -> Type<TechnologyHistory> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TechnologyHistory>(
            name: "TechnologyHistory",
            properties: [
                Type<TechnologyHistory>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<TechnologyHistory>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<TechnologyHistory>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<TechnologyHistory>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
                Type<TechnologyHistory>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
                Type<TechnologyHistory>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
                Type<TechnologyHistory>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<TechnologyHistory>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<TechnologyHistory>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
                Type<TechnologyHistory>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
                Type<TechnologyHistory>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
                Type<TechnologyHistory>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
                Type<TechnologyHistory>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
                Type<TechnologyHistory>.optionalProperty("logoApproved", get: { $0.logoApproved }, set: { $0.logoApproved = $1 }),
                Type<TechnologyHistory>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<TechnologyHistory>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
                Type<TechnologyHistory>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
                Type<TechnologyHistory>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
                Type<TechnologyHistory>.optionalProperty("operation", get: { $0.operation }, set: { $0.operation = $1 }),
            ]))
    }
    public func toJson() -> String {
        return TechnologyHistory.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TechnologyHistory? {
        return TechnologyHistory.reflect().fromJson(TechnologyHistory(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TechnologyHistory? {
        return TechnologyHistory.reflect().fromObject(TechnologyHistory(), any:any)
    }
    public func toString() -> String {
        return TechnologyHistory.reflect().toString(self)
    }
    public class func fromString(string:String) -> TechnologyHistory? {
        return TechnologyHistory.reflect().fromString(TechnologyHistory(), string: string)
    }
}

extension TechStackDetails : JsonSerializable
{
    public class func reflect() -> Type<TechStackDetails> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TechStackDetails>(
            name: "TechStackDetails",
            properties: [
                Type<TechStackDetails>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<TechStackDetails>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<TechStackDetails>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<TechStackDetails>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<TechStackDetails>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
                Type<TechStackDetails>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
                Type<TechStackDetails>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<TechStackDetails>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
                Type<TechStackDetails>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
                Type<TechStackDetails>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
                Type<TechStackDetails>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<TechStackDetails>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
                Type<TechStackDetails>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
                Type<TechStackDetails>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
                Type<TechStackDetails>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
                Type<TechStackDetails>.optionalProperty("detailsHtml", get: { $0.detailsHtml }, set: { $0.detailsHtml = $1 }),
                Type<TechStackDetails>.arrayProperty("technologyChoices", get: { $0.technologyChoices }, set: { $0.technologyChoices = $1 }),
            ]))
    }
    public func toJson() -> String {
        return TechStackDetails.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TechStackDetails? {
        return TechStackDetails.reflect().fromJson(TechStackDetails(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TechStackDetails? {
        return TechStackDetails.reflect().fromObject(TechStackDetails(), any:any)
    }
    public func toString() -> String {
        return TechStackDetails.reflect().toString(self)
    }
    public class func fromString(string:String) -> TechStackDetails? {
        return TechStackDetails.reflect().fromString(TechStackDetails(), string: string)
    }
}

extension TechnologyStackHistory : JsonSerializable
{
    public class func reflect() -> Type<TechnologyStackHistory> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TechnologyStackHistory>(
            name: "TechnologyStackHistory",
            properties: [
                Type<TechnologyStackHistory>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
                Type<TechnologyStackHistory>.optionalProperty("operation", get: { $0.operation }, set: { $0.operation = $1 }),
                Type<TechnologyStackHistory>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
            ]))
    }
    public func toJson() -> String {
        return TechnologyStackHistory.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TechnologyStackHistory? {
        return TechnologyStackHistory.reflect().fromJson(TechnologyStackHistory(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TechnologyStackHistory? {
        return TechnologyStackHistory.reflect().fromObject(TechnologyStackHistory(), any:any)
    }
    public func toString() -> String {
        return TechnologyStackHistory.reflect().toString(self)
    }
    public class func fromString(string:String) -> TechnologyStackHistory? {
        return TechnologyStackHistory.reflect().fromString(TechnologyStackHistory(), string: string)
    }
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

extension UserInfo : JsonSerializable
{
    public class func reflect() -> Type<UserInfo> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UserInfo>(
            name: "UserInfo",
            properties: [
                Type<UserInfo>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
                Type<UserInfo>.optionalProperty("avatarUrl", get: { $0.avatarUrl }, set: { $0.avatarUrl = $1 }),
                Type<UserInfo>.optionalProperty("stacksCount", get: { $0.stacksCount }, set: { $0.stacksCount = $1 }),
            ]))
    }
    public func toJson() -> String {
        return UserInfo.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> UserInfo? {
        return UserInfo.reflect().fromJson(UserInfo(), json: json)
    }
    public class func fromObject(any:AnyObject) -> UserInfo? {
        return UserInfo.reflect().fromObject(UserInfo(), any:any)
    }
    public func toString() -> String {
        return UserInfo.reflect().toString(self)
    }
    public class func fromString(string:String) -> UserInfo? {
        return UserInfo.reflect().fromString(UserInfo(), string: string)
    }
}

extension TechnologyInfo : JsonSerializable
{
    public class func reflect() -> Type<TechnologyInfo> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TechnologyInfo>(
            name: "TechnologyInfo",
            properties: [
                Type<TechnologyInfo>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
                Type<TechnologyInfo>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
                Type<TechnologyInfo>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<TechnologyInfo>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
                Type<TechnologyInfo>.optionalProperty("stacksCount", get: { $0.stacksCount }, set: { $0.stacksCount = $1 }),
            ]))
    }
    public func toJson() -> String {
        return TechnologyInfo.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TechnologyInfo? {
        return TechnologyInfo.reflect().fromJson(TechnologyInfo(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TechnologyInfo? {
        return TechnologyInfo.reflect().fromObject(TechnologyInfo(), any:any)
    }
    public func toString() -> String {
        return TechnologyInfo.reflect().toString(self)
    }
    public class func fromString(string:String) -> TechnologyInfo? {
        return TechnologyInfo.reflect().fromString(TechnologyInfo(), string: string)
    }
}

extension ResponseError : JsonSerializable
{
    public class func reflect() -> Type<ResponseError> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ResponseError>(
            name: "ResponseError",
            properties: [
                Type<ResponseError>.optionalProperty("errorCode", get: { $0.errorCode }, set: { $0.errorCode = $1 }),
                Type<ResponseError>.optionalProperty("fieldName", get: { $0.fieldName }, set: { $0.fieldName = $1 }),
                Type<ResponseError>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ResponseError.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ResponseError? {
        return ResponseError.reflect().fromJson(ResponseError(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ResponseError? {
        return ResponseError.reflect().fromObject(ResponseError(), any:any)
    }
    public func toString() -> String {
        return ResponseError.reflect().toString(self)
    }
    public class func fromString(string:String) -> ResponseError? {
        return ResponseError.reflect().fromString(ResponseError(), string: string)
    }
}

extension TechnologyInStack : JsonSerializable
{
    public class func reflect() -> Type<TechnologyInStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TechnologyInStack>(
            name: "TechnologyInStack",
            properties: [
                Type<TechnologyInStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<TechnologyInStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<TechnologyInStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<TechnologyInStack>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
                Type<TechnologyInStack>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
                Type<TechnologyInStack>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
                Type<TechnologyInStack>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<TechnologyInStack>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<TechnologyInStack>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
                Type<TechnologyInStack>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
                Type<TechnologyInStack>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
                Type<TechnologyInStack>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
                Type<TechnologyInStack>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
                Type<TechnologyInStack>.optionalProperty("logoApproved", get: { $0.logoApproved }, set: { $0.logoApproved = $1 }),
                Type<TechnologyInStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<TechnologyInStack>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
                Type<TechnologyInStack>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
                Type<TechnologyInStack>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
                Type<TechnologyInStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
                Type<TechnologyInStack>.optionalProperty("justification", get: { $0.justification }, set: { $0.justification = $1 }),
            ]))
    }
    public func toJson() -> String {
        return TechnologyInStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TechnologyInStack? {
        return TechnologyInStack.reflect().fromJson(TechnologyInStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TechnologyInStack? {
        return TechnologyInStack.reflect().fromObject(TechnologyInStack(), any:any)
    }
    public func toString() -> String {
        return TechnologyInStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> TechnologyInStack? {
        return TechnologyInStack.reflect().fromString(TechnologyInStack(), string: string)
    }
}

extension LogoUrlApprovalResponse : JsonSerializable
{
    public class func reflect() -> Type<LogoUrlApprovalResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<LogoUrlApprovalResponse>(
            name: "LogoUrlApprovalResponse",
            properties: [
                Type<LogoUrlApprovalResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return LogoUrlApprovalResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> LogoUrlApprovalResponse? {
        return LogoUrlApprovalResponse.reflect().fromJson(LogoUrlApprovalResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> LogoUrlApprovalResponse? {
        return LogoUrlApprovalResponse.reflect().fromObject(LogoUrlApprovalResponse(), any:any)
    }
    public func toString() -> String {
        return LogoUrlApprovalResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> LogoUrlApprovalResponse? {
        return LogoUrlApprovalResponse.reflect().fromString(LogoUrlApprovalResponse(), string: string)
    }
}

extension LockStackResponse : JsonSerializable
{
    public class func reflect() -> Type<LockStackResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<LockStackResponse>(
            name: "LockStackResponse",
            properties: [
            ]))
    }
    public func toJson() -> String {
        return LockStackResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> LockStackResponse? {
        return LockStackResponse.reflect().fromJson(LockStackResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> LockStackResponse? {
        return LockStackResponse.reflect().fromObject(LockStackResponse(), any:any)
    }
    public func toString() -> String {
        return LockStackResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> LockStackResponse? {
        return LockStackResponse.reflect().fromString(LockStackResponse(), string: string)
    }
}

extension CreateTechnologyResponse : JsonSerializable
{
    public class func reflect() -> Type<CreateTechnologyResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<CreateTechnologyResponse>(
            name: "CreateTechnologyResponse",
            properties: [
                Type<CreateTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<CreateTechnologyResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return CreateTechnologyResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> CreateTechnologyResponse? {
        return CreateTechnologyResponse.reflect().fromJson(CreateTechnologyResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> CreateTechnologyResponse? {
        return CreateTechnologyResponse.reflect().fromObject(CreateTechnologyResponse(), any:any)
    }
    public func toString() -> String {
        return CreateTechnologyResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> CreateTechnologyResponse? {
        return CreateTechnologyResponse.reflect().fromString(CreateTechnologyResponse(), string: string)
    }
}

extension UpdateTechnologyResponse : JsonSerializable
{
    public class func reflect() -> Type<UpdateTechnologyResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UpdateTechnologyResponse>(
            name: "UpdateTechnologyResponse",
            properties: [
                Type<UpdateTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<UpdateTechnologyResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return UpdateTechnologyResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> UpdateTechnologyResponse? {
        return UpdateTechnologyResponse.reflect().fromJson(UpdateTechnologyResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> UpdateTechnologyResponse? {
        return UpdateTechnologyResponse.reflect().fromObject(UpdateTechnologyResponse(), any:any)
    }
    public func toString() -> String {
        return UpdateTechnologyResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> UpdateTechnologyResponse? {
        return UpdateTechnologyResponse.reflect().fromString(UpdateTechnologyResponse(), string: string)
    }
}

extension DeleteTechnologyResponse : JsonSerializable
{
    public class func reflect() -> Type<DeleteTechnologyResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<DeleteTechnologyResponse>(
            name: "DeleteTechnologyResponse",
            properties: [
                Type<DeleteTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<DeleteTechnologyResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return DeleteTechnologyResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> DeleteTechnologyResponse? {
        return DeleteTechnologyResponse.reflect().fromJson(DeleteTechnologyResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> DeleteTechnologyResponse? {
        return DeleteTechnologyResponse.reflect().fromObject(DeleteTechnologyResponse(), any:any)
    }
    public func toString() -> String {
        return DeleteTechnologyResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> DeleteTechnologyResponse? {
        return DeleteTechnologyResponse.reflect().fromString(DeleteTechnologyResponse(), string: string)
    }
}

extension GetTechnologyResponse : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyResponse>(
            name: "GetTechnologyResponse",
            properties: [
                Type<GetTechnologyResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<GetTechnologyResponse>.optionalObjectProperty("technology", get: { $0.technology }, set: { $0.technology = $1 }),
                Type<GetTechnologyResponse>.arrayProperty("technologyStacks", get: { $0.technologyStacks }, set: { $0.technologyStacks = $1 }),
                Type<GetTechnologyResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyResponse? {
        return GetTechnologyResponse.reflect().fromJson(GetTechnologyResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyResponse? {
        return GetTechnologyResponse.reflect().fromObject(GetTechnologyResponse(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyResponse? {
        return GetTechnologyResponse.reflect().fromString(GetTechnologyResponse(), string: string)
    }
}

extension GetTechnologyPreviousVersionsResponse : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyPreviousVersionsResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyPreviousVersionsResponse>(
            name: "GetTechnologyPreviousVersionsResponse",
            properties: [
                Type<GetTechnologyPreviousVersionsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyPreviousVersionsResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyPreviousVersionsResponse? {
        return GetTechnologyPreviousVersionsResponse.reflect().fromJson(GetTechnologyPreviousVersionsResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyPreviousVersionsResponse? {
        return GetTechnologyPreviousVersionsResponse.reflect().fromObject(GetTechnologyPreviousVersionsResponse(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyPreviousVersionsResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyPreviousVersionsResponse? {
        return GetTechnologyPreviousVersionsResponse.reflect().fromString(GetTechnologyPreviousVersionsResponse(), string: string)
    }
}

extension GetTechnologyFavoriteDetailsResponse : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyFavoriteDetailsResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyFavoriteDetailsResponse>(
            name: "GetTechnologyFavoriteDetailsResponse",
            properties: [
                Type<GetTechnologyFavoriteDetailsResponse>.arrayProperty("users", get: { $0.users }, set: { $0.users = $1 }),
                Type<GetTechnologyFavoriteDetailsResponse>.optionalProperty("favoriteCount", get: { $0.favoriteCount }, set: { $0.favoriteCount = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyFavoriteDetailsResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyFavoriteDetailsResponse? {
        return GetTechnologyFavoriteDetailsResponse.reflect().fromJson(GetTechnologyFavoriteDetailsResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyFavoriteDetailsResponse? {
        return GetTechnologyFavoriteDetailsResponse.reflect().fromObject(GetTechnologyFavoriteDetailsResponse(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyFavoriteDetailsResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyFavoriteDetailsResponse? {
        return GetTechnologyFavoriteDetailsResponse.reflect().fromString(GetTechnologyFavoriteDetailsResponse(), string: string)
    }
}

extension GetAllTechnologiesResponse : JsonSerializable
{
    public class func reflect() -> Type<GetAllTechnologiesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetAllTechnologiesResponse>(
            name: "GetAllTechnologiesResponse",
            properties: [
                Type<GetAllTechnologiesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetAllTechnologiesResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetAllTechnologiesResponse? {
        return GetAllTechnologiesResponse.reflect().fromJson(GetAllTechnologiesResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetAllTechnologiesResponse? {
        return GetAllTechnologiesResponse.reflect().fromObject(GetAllTechnologiesResponse(), any:any)
    }
    public func toString() -> String {
        return GetAllTechnologiesResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetAllTechnologiesResponse? {
        return GetAllTechnologiesResponse.reflect().fromString(GetAllTechnologiesResponse(), string: string)
    }
}

extension QueryResponse : JsonSerializable
{
    public class func reflect() -> Type<QueryResponse<Technology>> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<QueryResponse<Technology>>(
            name: "QueryResponse<Technology>",
            properties: [
                Type<QueryResponse<Technology>>.optionalProperty("offset", get: { $0.offset }, set: { $0.offset = $1 }),
                Type<QueryResponse<Technology>>.optionalProperty("total", get: { $0.total }, set: { $0.total = $1 }),
                Type<QueryResponse<Technology>>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
                Type<QueryResponse<Technology>>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
                Type<QueryResponse<Technology>>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return QueryResponse<Technology>.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> QueryResponse<Technology>? {
        return QueryResponse<Technology>.reflect().fromJson(QueryResponse<Technology>(), json: json)
    }
    public class func fromObject(any:AnyObject) -> QueryResponse<Technology>? {
        return QueryResponse<Technology>.reflect().fromObject(QueryResponse<Technology>(), any:any)
    }
    public func toString() -> String {
        return QueryResponse<Technology>.reflect().toString(self)
    }
    public class func fromString(string:String) -> QueryResponse<Technology>? {
        return QueryResponse<Technology>.reflect().fromString(QueryResponse<Technology>(), string: string)
    }
}

extension CreateTechnologyStackResponse : JsonSerializable
{
    public class func reflect() -> Type<CreateTechnologyStackResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<CreateTechnologyStackResponse>(
            name: "CreateTechnologyStackResponse",
            properties: [
                Type<CreateTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<CreateTechnologyStackResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return CreateTechnologyStackResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> CreateTechnologyStackResponse? {
        return CreateTechnologyStackResponse.reflect().fromJson(CreateTechnologyStackResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> CreateTechnologyStackResponse? {
        return CreateTechnologyStackResponse.reflect().fromObject(CreateTechnologyStackResponse(), any:any)
    }
    public func toString() -> String {
        return CreateTechnologyStackResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> CreateTechnologyStackResponse? {
        return CreateTechnologyStackResponse.reflect().fromString(CreateTechnologyStackResponse(), string: string)
    }
}

extension UpdateTechnologyStackResponse : JsonSerializable
{
    public class func reflect() -> Type<UpdateTechnologyStackResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UpdateTechnologyStackResponse>(
            name: "UpdateTechnologyStackResponse",
            properties: [
                Type<UpdateTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<UpdateTechnologyStackResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return UpdateTechnologyStackResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> UpdateTechnologyStackResponse? {
        return UpdateTechnologyStackResponse.reflect().fromJson(UpdateTechnologyStackResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> UpdateTechnologyStackResponse? {
        return UpdateTechnologyStackResponse.reflect().fromObject(UpdateTechnologyStackResponse(), any:any)
    }
    public func toString() -> String {
        return UpdateTechnologyStackResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> UpdateTechnologyStackResponse? {
        return UpdateTechnologyStackResponse.reflect().fromString(UpdateTechnologyStackResponse(), string: string)
    }
}

extension DeleteTechnologyStackResponse : JsonSerializable
{
    public class func reflect() -> Type<DeleteTechnologyStackResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<DeleteTechnologyStackResponse>(
            name: "DeleteTechnologyStackResponse",
            properties: [
                Type<DeleteTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<DeleteTechnologyStackResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return DeleteTechnologyStackResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> DeleteTechnologyStackResponse? {
        return DeleteTechnologyStackResponse.reflect().fromJson(DeleteTechnologyStackResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> DeleteTechnologyStackResponse? {
        return DeleteTechnologyStackResponse.reflect().fromObject(DeleteTechnologyStackResponse(), any:any)
    }
    public func toString() -> String {
        return DeleteTechnologyStackResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> DeleteTechnologyStackResponse? {
        return DeleteTechnologyStackResponse.reflect().fromString(DeleteTechnologyStackResponse(), string: string)
    }
}

extension GetAllTechnologyStacksResponse : JsonSerializable
{
    public class func reflect() -> Type<GetAllTechnologyStacksResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetAllTechnologyStacksResponse>(
            name: "GetAllTechnologyStacksResponse",
            properties: [
                Type<GetAllTechnologyStacksResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetAllTechnologyStacksResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetAllTechnologyStacksResponse? {
        return GetAllTechnologyStacksResponse.reflect().fromJson(GetAllTechnologyStacksResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetAllTechnologyStacksResponse? {
        return GetAllTechnologyStacksResponse.reflect().fromObject(GetAllTechnologyStacksResponse(), any:any)
    }
    public func toString() -> String {
        return GetAllTechnologyStacksResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetAllTechnologyStacksResponse? {
        return GetAllTechnologyStacksResponse.reflect().fromString(GetAllTechnologyStacksResponse(), string: string)
    }
}

extension GetTechnologyStackResponse : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyStackResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyStackResponse>(
            name: "GetTechnologyStackResponse",
            properties: [
                Type<GetTechnologyStackResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<GetTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<GetTechnologyStackResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyStackResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyStackResponse? {
        return GetTechnologyStackResponse.reflect().fromJson(GetTechnologyStackResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyStackResponse? {
        return GetTechnologyStackResponse.reflect().fromObject(GetTechnologyStackResponse(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyStackResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyStackResponse? {
        return GetTechnologyStackResponse.reflect().fromString(GetTechnologyStackResponse(), string: string)
    }
}

extension GetTechnologyStackPreviousVersionsResponse : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyStackPreviousVersionsResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyStackPreviousVersionsResponse>(
            name: "GetTechnologyStackPreviousVersionsResponse",
            properties: [
                Type<GetTechnologyStackPreviousVersionsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyStackPreviousVersionsResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyStackPreviousVersionsResponse? {
        return GetTechnologyStackPreviousVersionsResponse.reflect().fromJson(GetTechnologyStackPreviousVersionsResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyStackPreviousVersionsResponse? {
        return GetTechnologyStackPreviousVersionsResponse.reflect().fromObject(GetTechnologyStackPreviousVersionsResponse(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyStackPreviousVersionsResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyStackPreviousVersionsResponse? {
        return GetTechnologyStackPreviousVersionsResponse.reflect().fromString(GetTechnologyStackPreviousVersionsResponse(), string: string)
    }
}

extension GetTechnologyStackFavoriteDetailsResponse : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyStackFavoriteDetailsResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyStackFavoriteDetailsResponse>(
            name: "GetTechnologyStackFavoriteDetailsResponse",
            properties: [
                Type<GetTechnologyStackFavoriteDetailsResponse>.arrayProperty("users", get: { $0.users }, set: { $0.users = $1 }),
                Type<GetTechnologyStackFavoriteDetailsResponse>.optionalProperty("favoriteCount", get: { $0.favoriteCount }, set: { $0.favoriteCount = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyStackFavoriteDetailsResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyStackFavoriteDetailsResponse? {
        return GetTechnologyStackFavoriteDetailsResponse.reflect().fromJson(GetTechnologyStackFavoriteDetailsResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyStackFavoriteDetailsResponse? {
        return GetTechnologyStackFavoriteDetailsResponse.reflect().fromObject(GetTechnologyStackFavoriteDetailsResponse(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyStackFavoriteDetailsResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyStackFavoriteDetailsResponse? {
        return GetTechnologyStackFavoriteDetailsResponse.reflect().fromString(GetTechnologyStackFavoriteDetailsResponse(), string: string)
    }
}

extension GetConfigResponse : JsonSerializable
{
    public class func reflect() -> Type<GetConfigResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetConfigResponse>(
            name: "GetConfigResponse",
            properties: [
                Type<GetConfigResponse>.arrayProperty("allTiers", get: { $0.allTiers }, set: { $0.allTiers = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetConfigResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetConfigResponse? {
        return GetConfigResponse.reflect().fromJson(GetConfigResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetConfigResponse? {
        return GetConfigResponse.reflect().fromObject(GetConfigResponse(), any:any)
    }
    public func toString() -> String {
        return GetConfigResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetConfigResponse? {
        return GetConfigResponse.reflect().fromString(GetConfigResponse(), string: string)
    }
}

extension OverviewResponse : JsonSerializable
{
    public class func reflect() -> Type<OverviewResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<OverviewResponse>(
            name: "OverviewResponse",
            properties: [
                Type<OverviewResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<OverviewResponse>.arrayProperty("topUsers", get: { $0.topUsers }, set: { $0.topUsers = $1 }),
                Type<OverviewResponse>.arrayProperty("topTechnologies", get: { $0.topTechnologies }, set: { $0.topTechnologies = $1 }),
                Type<OverviewResponse>.arrayProperty("latestTechStacks", get: { $0.latestTechStacks }, set: { $0.latestTechStacks = $1 }),
                Type<OverviewResponse>.objectProperty("topTechnologiesByTier", get: { $0.topTechnologiesByTier }, set: { $0.topTechnologiesByTier = $1 }),
                Type<OverviewResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return OverviewResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> OverviewResponse? {
        return OverviewResponse.reflect().fromJson(OverviewResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> OverviewResponse? {
        return OverviewResponse.reflect().fromObject(OverviewResponse(), any:any)
    }
    public func toString() -> String {
        return OverviewResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> OverviewResponse? {
        return OverviewResponse.reflect().fromString(OverviewResponse(), string: string)
    }
}

extension GetFavoriteTechStackResponse : JsonSerializable
{
    public class func reflect() -> Type<GetFavoriteTechStackResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetFavoriteTechStackResponse>(
            name: "GetFavoriteTechStackResponse",
            properties: [
                Type<GetFavoriteTechStackResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetFavoriteTechStackResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetFavoriteTechStackResponse? {
        return GetFavoriteTechStackResponse.reflect().fromJson(GetFavoriteTechStackResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetFavoriteTechStackResponse? {
        return GetFavoriteTechStackResponse.reflect().fromObject(GetFavoriteTechStackResponse(), any:any)
    }
    public func toString() -> String {
        return GetFavoriteTechStackResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetFavoriteTechStackResponse? {
        return GetFavoriteTechStackResponse.reflect().fromString(GetFavoriteTechStackResponse(), string: string)
    }
}

extension FavoriteTechStackResponse : JsonSerializable
{
    public class func reflect() -> Type<FavoriteTechStackResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<FavoriteTechStackResponse>(
            name: "FavoriteTechStackResponse",
            properties: [
                Type<FavoriteTechStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return FavoriteTechStackResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> FavoriteTechStackResponse? {
        return FavoriteTechStackResponse.reflect().fromJson(FavoriteTechStackResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> FavoriteTechStackResponse? {
        return FavoriteTechStackResponse.reflect().fromObject(FavoriteTechStackResponse(), any:any)
    }
    public func toString() -> String {
        return FavoriteTechStackResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> FavoriteTechStackResponse? {
        return FavoriteTechStackResponse.reflect().fromString(FavoriteTechStackResponse(), string: string)
    }
}

extension GetFavoriteTechnologiesResponse : JsonSerializable
{
    public class func reflect() -> Type<GetFavoriteTechnologiesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetFavoriteTechnologiesResponse>(
            name: "GetFavoriteTechnologiesResponse",
            properties: [
                Type<GetFavoriteTechnologiesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetFavoriteTechnologiesResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetFavoriteTechnologiesResponse? {
        return GetFavoriteTechnologiesResponse.reflect().fromJson(GetFavoriteTechnologiesResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetFavoriteTechnologiesResponse? {
        return GetFavoriteTechnologiesResponse.reflect().fromObject(GetFavoriteTechnologiesResponse(), any:any)
    }
    public func toString() -> String {
        return GetFavoriteTechnologiesResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetFavoriteTechnologiesResponse? {
        return GetFavoriteTechnologiesResponse.reflect().fromString(GetFavoriteTechnologiesResponse(), string: string)
    }
}

extension FavoriteTechnologyResponse : JsonSerializable
{
    public class func reflect() -> Type<FavoriteTechnologyResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<FavoriteTechnologyResponse>(
            name: "FavoriteTechnologyResponse",
            properties: [
                Type<FavoriteTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return FavoriteTechnologyResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> FavoriteTechnologyResponse? {
        return FavoriteTechnologyResponse.reflect().fromJson(FavoriteTechnologyResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> FavoriteTechnologyResponse? {
        return FavoriteTechnologyResponse.reflect().fromObject(FavoriteTechnologyResponse(), any:any)
    }
    public func toString() -> String {
        return FavoriteTechnologyResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> FavoriteTechnologyResponse? {
        return FavoriteTechnologyResponse.reflect().fromString(FavoriteTechnologyResponse(), string: string)
    }
}

extension GetUserFeedResponse : JsonSerializable
{
    public class func reflect() -> Type<GetUserFeedResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetUserFeedResponse>(
            name: "GetUserFeedResponse",
            properties: [
                Type<GetUserFeedResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetUserFeedResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetUserFeedResponse? {
        return GetUserFeedResponse.reflect().fromJson(GetUserFeedResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetUserFeedResponse? {
        return GetUserFeedResponse.reflect().fromObject(GetUserFeedResponse(), any:any)
    }
    public func toString() -> String {
        return GetUserFeedResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetUserFeedResponse? {
        return GetUserFeedResponse.reflect().fromString(GetUserFeedResponse(), string: string)
    }
}

extension GetUserInfoResponse : JsonSerializable
{
    public class func reflect() -> Type<GetUserInfoResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetUserInfoResponse>(
            name: "GetUserInfoResponse",
            properties: [
                Type<GetUserInfoResponse>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
                Type<GetUserInfoResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<GetUserInfoResponse>.optionalProperty("avatarUrl", get: { $0.avatarUrl }, set: { $0.avatarUrl = $1 }),
                Type<GetUserInfoResponse>.arrayProperty("techStacks", get: { $0.techStacks }, set: { $0.techStacks = $1 }),
                Type<GetUserInfoResponse>.arrayProperty("favoriteTechStacks", get: { $0.favoriteTechStacks }, set: { $0.favoriteTechStacks = $1 }),
                Type<GetUserInfoResponse>.arrayProperty("favoriteTechnologies", get: { $0.favoriteTechnologies }, set: { $0.favoriteTechnologies = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetUserInfoResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetUserInfoResponse? {
        return GetUserInfoResponse.reflect().fromJson(GetUserInfoResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetUserInfoResponse? {
        return GetUserInfoResponse.reflect().fromObject(GetUserInfoResponse(), any:any)
    }
    public func toString() -> String {
        return GetUserInfoResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetUserInfoResponse? {
        return GetUserInfoResponse.reflect().fromString(GetUserInfoResponse(), string: string)
    }
}

extension AuthenticateResponse : JsonSerializable
{
    public class func reflect() -> Type<AuthenticateResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AuthenticateResponse>(
            name: "AuthenticateResponse",
            properties: [
                Type<AuthenticateResponse>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
                Type<AuthenticateResponse>.optionalProperty("sessionId", get: { $0.sessionId }, set: { $0.sessionId = $1 }),
                Type<AuthenticateResponse>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
                Type<AuthenticateResponse>.optionalProperty("displayName", get: { $0.displayName }, set: { $0.displayName = $1 }),
                Type<AuthenticateResponse>.optionalProperty("referrerUrl", get: { $0.referrerUrl }, set: { $0.referrerUrl = $1 }),
                Type<AuthenticateResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
                Type<AuthenticateResponse>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AuthenticateResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AuthenticateResponse? {
        return AuthenticateResponse.reflect().fromJson(AuthenticateResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AuthenticateResponse? {
        return AuthenticateResponse.reflect().fromObject(AuthenticateResponse(), any:any)
    }
    public func toString() -> String {
        return AuthenticateResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> AuthenticateResponse? {
        return AuthenticateResponse.reflect().fromString(AuthenticateResponse(), string: string)
    }
}

extension AssignRolesResponse : JsonSerializable
{
    public class func reflect() -> Type<AssignRolesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AssignRolesResponse>(
            name: "AssignRolesResponse",
            properties: [
                Type<AssignRolesResponse>.arrayProperty("allRoles", get: { $0.allRoles }, set: { $0.allRoles = $1 }),
                Type<AssignRolesResponse>.arrayProperty("allPermissions", get: { $0.allPermissions }, set: { $0.allPermissions = $1 }),
                Type<AssignRolesResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AssignRolesResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AssignRolesResponse? {
        return AssignRolesResponse.reflect().fromJson(AssignRolesResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AssignRolesResponse? {
        return AssignRolesResponse.reflect().fromObject(AssignRolesResponse(), any:any)
    }
    public func toString() -> String {
        return AssignRolesResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> AssignRolesResponse? {
        return AssignRolesResponse.reflect().fromString(AssignRolesResponse(), string: string)
    }
}

extension UnAssignRolesResponse : JsonSerializable
{
    public class func reflect() -> Type<UnAssignRolesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UnAssignRolesResponse>(
            name: "UnAssignRolesResponse",
            properties: [
                Type<UnAssignRolesResponse>.arrayProperty("allRoles", get: { $0.allRoles }, set: { $0.allRoles = $1 }),
                Type<UnAssignRolesResponse>.arrayProperty("allPermissions", get: { $0.allPermissions }, set: { $0.allPermissions = $1 }),
                Type<UnAssignRolesResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return UnAssignRolesResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> UnAssignRolesResponse? {
        return UnAssignRolesResponse.reflect().fromJson(UnAssignRolesResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> UnAssignRolesResponse? {
        return UnAssignRolesResponse.reflect().fromObject(UnAssignRolesResponse(), any:any)
    }
    public func toString() -> String {
        return UnAssignRolesResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> UnAssignRolesResponse? {
        return UnAssignRolesResponse.reflect().fromString(UnAssignRolesResponse(), string: string)
    }
}

extension LogoUrlApproval : JsonSerializable
{
    public class func reflect() -> Type<LogoUrlApproval> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<LogoUrlApproval>(
            name: "LogoUrlApproval",
            properties: [
                Type<LogoUrlApproval>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
                Type<LogoUrlApproval>.optionalProperty("approved", get: { $0.approved }, set: { $0.approved = $1 }),
            ]))
    }
    public func toJson() -> String {
        return LogoUrlApproval.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> LogoUrlApproval? {
        return LogoUrlApproval.reflect().fromJson(LogoUrlApproval(), json: json)
    }
    public class func fromObject(any:AnyObject) -> LogoUrlApproval? {
        return LogoUrlApproval.reflect().fromObject(LogoUrlApproval(), any:any)
    }
    public func toString() -> String {
        return LogoUrlApproval.reflect().toString(self)
    }
    public class func fromString(string:String) -> LogoUrlApproval? {
        return LogoUrlApproval.reflect().fromString(LogoUrlApproval(), string: string)
    }
}

extension LockTechStack : JsonSerializable
{
    public class func reflect() -> Type<LockTechStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<LockTechStack>(
            name: "LockTechStack",
            properties: [
                Type<LockTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
                Type<LockTechStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
            ]))
    }
    public func toJson() -> String {
        return LockTechStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> LockTechStack? {
        return LockTechStack.reflect().fromJson(LockTechStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> LockTechStack? {
        return LockTechStack.reflect().fromObject(LockTechStack(), any:any)
    }
    public func toString() -> String {
        return LockTechStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> LockTechStack? {
        return LockTechStack.reflect().fromString(LockTechStack(), string: string)
    }
}

extension LockTech : JsonSerializable
{
    public class func reflect() -> Type<LockTech> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<LockTech>(
            name: "LockTech",
            properties: [
                Type<LockTech>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
                Type<LockTech>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
            ]))
    }
    public func toJson() -> String {
        return LockTech.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> LockTech? {
        return LockTech.reflect().fromJson(LockTech(), json: json)
    }
    public class func fromObject(any:AnyObject) -> LockTech? {
        return LockTech.reflect().fromObject(LockTech(), any:any)
    }
    public func toString() -> String {
        return LockTech.reflect().toString(self)
    }
    public class func fromString(string:String) -> LockTech? {
        return LockTech.reflect().fromString(LockTech(), string: string)
    }
}

extension Ping : JsonSerializable
{
    public class func reflect() -> Type<Ping> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Ping>(
            name: "Ping",
            properties: [
            ]))
    }
    public func toJson() -> String {
        return Ping.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Ping? {
        return Ping.reflect().fromJson(Ping(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Ping? {
        return Ping.reflect().fromObject(Ping(), any:any)
    }
    public func toString() -> String {
        return Ping.reflect().toString(self)
    }
    public class func fromString(string:String) -> Ping? {
        return Ping.reflect().fromString(Ping(), string: string)
    }
}

extension FallbackForClientRoutes : JsonSerializable
{
    public class func reflect() -> Type<FallbackForClientRoutes> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<FallbackForClientRoutes>(
            name: "FallbackForClientRoutes",
            properties: [
                Type<FallbackForClientRoutes>.optionalProperty("pathInfo", get: { $0.pathInfo }, set: { $0.pathInfo = $1 }),
            ]))
    }
    public func toJson() -> String {
        return FallbackForClientRoutes.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> FallbackForClientRoutes? {
        return FallbackForClientRoutes.reflect().fromJson(FallbackForClientRoutes(), json: json)
    }
    public class func fromObject(any:AnyObject) -> FallbackForClientRoutes? {
        return FallbackForClientRoutes.reflect().fromObject(FallbackForClientRoutes(), any:any)
    }
    public func toString() -> String {
        return FallbackForClientRoutes.reflect().toString(self)
    }
    public class func fromString(string:String) -> FallbackForClientRoutes? {
        return FallbackForClientRoutes.reflect().fromString(FallbackForClientRoutes(), string: string)
    }
}

extension ClientAllTechnologyStacks : JsonSerializable
{
    public class func reflect() -> Type<ClientAllTechnologyStacks> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ClientAllTechnologyStacks>(
            name: "ClientAllTechnologyStacks",
            properties: [
            ]))
    }
    public func toJson() -> String {
        return ClientAllTechnologyStacks.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ClientAllTechnologyStacks? {
        return ClientAllTechnologyStacks.reflect().fromJson(ClientAllTechnologyStacks(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ClientAllTechnologyStacks? {
        return ClientAllTechnologyStacks.reflect().fromObject(ClientAllTechnologyStacks(), any:any)
    }
    public func toString() -> String {
        return ClientAllTechnologyStacks.reflect().toString(self)
    }
    public class func fromString(string:String) -> ClientAllTechnologyStacks? {
        return ClientAllTechnologyStacks.reflect().fromString(ClientAllTechnologyStacks(), string: string)
    }
}

extension ClientAllTechnologies : JsonSerializable
{
    public class func reflect() -> Type<ClientAllTechnologies> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ClientAllTechnologies>(
            name: "ClientAllTechnologies",
            properties: [
            ]))
    }
    public func toJson() -> String {
        return ClientAllTechnologies.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ClientAllTechnologies? {
        return ClientAllTechnologies.reflect().fromJson(ClientAllTechnologies(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ClientAllTechnologies? {
        return ClientAllTechnologies.reflect().fromObject(ClientAllTechnologies(), any:any)
    }
    public func toString() -> String {
        return ClientAllTechnologies.reflect().toString(self)
    }
    public class func fromString(string:String) -> ClientAllTechnologies? {
        return ClientAllTechnologies.reflect().fromString(ClientAllTechnologies(), string: string)
    }
}

extension ClientTechnology : JsonSerializable
{
    public class func reflect() -> Type<ClientTechnology> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ClientTechnology>(
            name: "ClientTechnology",
            properties: [
                Type<ClientTechnology>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ClientTechnology.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ClientTechnology? {
        return ClientTechnology.reflect().fromJson(ClientTechnology(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ClientTechnology? {
        return ClientTechnology.reflect().fromObject(ClientTechnology(), any:any)
    }
    public func toString() -> String {
        return ClientTechnology.reflect().toString(self)
    }
    public class func fromString(string:String) -> ClientTechnology? {
        return ClientTechnology.reflect().fromString(ClientTechnology(), string: string)
    }
}

extension ClientUser : JsonSerializable
{
    public class func reflect() -> Type<ClientUser> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ClientUser>(
            name: "ClientUser",
            properties: [
                Type<ClientUser>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ClientUser.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ClientUser? {
        return ClientUser.reflect().fromJson(ClientUser(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ClientUser? {
        return ClientUser.reflect().fromObject(ClientUser(), any:any)
    }
    public func toString() -> String {
        return ClientUser.reflect().toString(self)
    }
    public class func fromString(string:String) -> ClientUser? {
        return ClientUser.reflect().fromString(ClientUser(), string: string)
    }
}

extension SessionInfo : JsonSerializable
{
    public class func reflect() -> Type<SessionInfo> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<SessionInfo>(
            name: "SessionInfo",
            properties: [
            ]))
    }
    public func toJson() -> String {
        return SessionInfo.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> SessionInfo? {
        return SessionInfo.reflect().fromJson(SessionInfo(), json: json)
    }
    public class func fromObject(any:AnyObject) -> SessionInfo? {
        return SessionInfo.reflect().fromObject(SessionInfo(), any:any)
    }
    public func toString() -> String {
        return SessionInfo.reflect().toString(self)
    }
    public class func fromString(string:String) -> SessionInfo? {
        return SessionInfo.reflect().fromString(SessionInfo(), string: string)
    }
}

extension CreateTechnology : JsonSerializable
{
    public class func reflect() -> Type<CreateTechnology> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<CreateTechnology>(
            name: "CreateTechnology",
            properties: [
                Type<CreateTechnology>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<CreateTechnology>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<CreateTechnology>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
                Type<CreateTechnology>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
                Type<CreateTechnology>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
                Type<CreateTechnology>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<CreateTechnology>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<CreateTechnology>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
            ]))
    }
    public func toJson() -> String {
        return CreateTechnology.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> CreateTechnology? {
        return CreateTechnology.reflect().fromJson(CreateTechnology(), json: json)
    }
    public class func fromObject(any:AnyObject) -> CreateTechnology? {
        return CreateTechnology.reflect().fromObject(CreateTechnology(), any:any)
    }
    public func toString() -> String {
        return CreateTechnology.reflect().toString(self)
    }
    public class func fromString(string:String) -> CreateTechnology? {
        return CreateTechnology.reflect().fromString(CreateTechnology(), string: string)
    }
}

extension UpdateTechnology : JsonSerializable
{
    public class func reflect() -> Type<UpdateTechnology> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UpdateTechnology>(
            name: "UpdateTechnology",
            properties: [
                Type<UpdateTechnology>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<UpdateTechnology>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<UpdateTechnology>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<UpdateTechnology>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
                Type<UpdateTechnology>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
                Type<UpdateTechnology>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
                Type<UpdateTechnology>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<UpdateTechnology>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<UpdateTechnology>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
            ]))
    }
    public func toJson() -> String {
        return UpdateTechnology.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> UpdateTechnology? {
        return UpdateTechnology.reflect().fromJson(UpdateTechnology(), json: json)
    }
    public class func fromObject(any:AnyObject) -> UpdateTechnology? {
        return UpdateTechnology.reflect().fromObject(UpdateTechnology(), any:any)
    }
    public func toString() -> String {
        return UpdateTechnology.reflect().toString(self)
    }
    public class func fromString(string:String) -> UpdateTechnology? {
        return UpdateTechnology.reflect().fromString(UpdateTechnology(), string: string)
    }
}

extension DeleteTechnology : JsonSerializable
{
    public class func reflect() -> Type<DeleteTechnology> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<DeleteTechnology>(
            name: "DeleteTechnology",
            properties: [
                Type<DeleteTechnology>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            ]))
    }
    public func toJson() -> String {
        return DeleteTechnology.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> DeleteTechnology? {
        return DeleteTechnology.reflect().fromJson(DeleteTechnology(), json: json)
    }
    public class func fromObject(any:AnyObject) -> DeleteTechnology? {
        return DeleteTechnology.reflect().fromObject(DeleteTechnology(), any:any)
    }
    public func toString() -> String {
        return DeleteTechnology.reflect().toString(self)
    }
    public class func fromString(string:String) -> DeleteTechnology? {
        return DeleteTechnology.reflect().fromString(DeleteTechnology(), string: string)
    }
}

extension GetTechnology : JsonSerializable
{
    public class func reflect() -> Type<GetTechnology> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnology>(
            name: "GetTechnology",
            properties: [
                Type<GetTechnology>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
                Type<GetTechnology>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnology.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnology? {
        return GetTechnology.reflect().fromJson(GetTechnology(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnology? {
        return GetTechnology.reflect().fromObject(GetTechnology(), any:any)
    }
    public func toString() -> String {
        return GetTechnology.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnology? {
        return GetTechnology.reflect().fromString(GetTechnology(), string: string)
    }
}

extension GetTechnologyPreviousVersions : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyPreviousVersions> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyPreviousVersions>(
            name: "GetTechnologyPreviousVersions",
            properties: [
                Type<GetTechnologyPreviousVersions>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyPreviousVersions.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyPreviousVersions? {
        return GetTechnologyPreviousVersions.reflect().fromJson(GetTechnologyPreviousVersions(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyPreviousVersions? {
        return GetTechnologyPreviousVersions.reflect().fromObject(GetTechnologyPreviousVersions(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyPreviousVersions.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyPreviousVersions? {
        return GetTechnologyPreviousVersions.reflect().fromString(GetTechnologyPreviousVersions(), string: string)
    }
}

extension GetTechnologyFavoriteDetails : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyFavoriteDetails> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyFavoriteDetails>(
            name: "GetTechnologyFavoriteDetails",
            properties: [
                Type<GetTechnologyFavoriteDetails>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
                Type<GetTechnologyFavoriteDetails>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyFavoriteDetails.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyFavoriteDetails? {
        return GetTechnologyFavoriteDetails.reflect().fromJson(GetTechnologyFavoriteDetails(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyFavoriteDetails? {
        return GetTechnologyFavoriteDetails.reflect().fromObject(GetTechnologyFavoriteDetails(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyFavoriteDetails.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyFavoriteDetails? {
        return GetTechnologyFavoriteDetails.reflect().fromString(GetTechnologyFavoriteDetails(), string: string)
    }
}

extension GetAllTechnologies : JsonSerializable
{
    public class func reflect() -> Type<GetAllTechnologies> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetAllTechnologies>(
            name: "GetAllTechnologies",
            properties: [
            ]))
    }
    public func toJson() -> String {
        return GetAllTechnologies.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetAllTechnologies? {
        return GetAllTechnologies.reflect().fromJson(GetAllTechnologies(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetAllTechnologies? {
        return GetAllTechnologies.reflect().fromObject(GetAllTechnologies(), any:any)
    }
    public func toString() -> String {
        return GetAllTechnologies.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetAllTechnologies? {
        return GetAllTechnologies.reflect().fromString(GetAllTechnologies(), string: string)
    }
}

extension FindTechnologies : JsonSerializable
{
    public class func reflect() -> Type<FindTechnologies> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<FindTechnologies>(
            name: "FindTechnologies",
            properties: [
                Type<FindTechnologies>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
            ]))
    }
    public func toJson() -> String {
        return FindTechnologies.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> FindTechnologies? {
        return FindTechnologies.reflect().fromJson(FindTechnologies(), json: json)
    }
    public class func fromObject(any:AnyObject) -> FindTechnologies? {
        return FindTechnologies.reflect().fromObject(FindTechnologies(), any:any)
    }
    public func toString() -> String {
        return FindTechnologies.reflect().toString(self)
    }
    public class func fromString(string:String) -> FindTechnologies? {
        return FindTechnologies.reflect().fromString(FindTechnologies(), string: string)
    }
}

extension CreateTechnologyStack : JsonSerializable
{
    public class func reflect() -> Type<CreateTechnologyStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<CreateTechnologyStack>(
            name: "CreateTechnologyStack",
            properties: [
                Type<CreateTechnologyStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<CreateTechnologyStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<CreateTechnologyStack>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
                Type<CreateTechnologyStack>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
                Type<CreateTechnologyStack>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<CreateTechnologyStack>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
                Type<CreateTechnologyStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<CreateTechnologyStack>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
            ]))
    }
    public func toJson() -> String {
        return CreateTechnologyStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> CreateTechnologyStack? {
        return CreateTechnologyStack.reflect().fromJson(CreateTechnologyStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> CreateTechnologyStack? {
        return CreateTechnologyStack.reflect().fromObject(CreateTechnologyStack(), any:any)
    }
    public func toString() -> String {
        return CreateTechnologyStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> CreateTechnologyStack? {
        return CreateTechnologyStack.reflect().fromString(CreateTechnologyStack(), string: string)
    }
}

extension UpdateTechnologyStack : JsonSerializable
{
    public class func reflect() -> Type<UpdateTechnologyStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UpdateTechnologyStack>(
            name: "UpdateTechnologyStack",
            properties: [
                Type<UpdateTechnologyStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<UpdateTechnologyStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<UpdateTechnologyStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
                Type<UpdateTechnologyStack>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
                Type<UpdateTechnologyStack>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
                Type<UpdateTechnologyStack>.optionalProperty("description", get: { $0.description }, set: { $0.description = $1 }),
                Type<UpdateTechnologyStack>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
                Type<UpdateTechnologyStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
                Type<UpdateTechnologyStack>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
            ]))
    }
    public func toJson() -> String {
        return UpdateTechnologyStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> UpdateTechnologyStack? {
        return UpdateTechnologyStack.reflect().fromJson(UpdateTechnologyStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> UpdateTechnologyStack? {
        return UpdateTechnologyStack.reflect().fromObject(UpdateTechnologyStack(), any:any)
    }
    public func toString() -> String {
        return UpdateTechnologyStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> UpdateTechnologyStack? {
        return UpdateTechnologyStack.reflect().fromString(UpdateTechnologyStack(), string: string)
    }
}

extension DeleteTechnologyStack : JsonSerializable
{
    public class func reflect() -> Type<DeleteTechnologyStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<DeleteTechnologyStack>(
            name: "DeleteTechnologyStack",
            properties: [
                Type<DeleteTechnologyStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            ]))
    }
    public func toJson() -> String {
        return DeleteTechnologyStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> DeleteTechnologyStack? {
        return DeleteTechnologyStack.reflect().fromJson(DeleteTechnologyStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> DeleteTechnologyStack? {
        return DeleteTechnologyStack.reflect().fromObject(DeleteTechnologyStack(), any:any)
    }
    public func toString() -> String {
        return DeleteTechnologyStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> DeleteTechnologyStack? {
        return DeleteTechnologyStack.reflect().fromString(DeleteTechnologyStack(), string: string)
    }
}

extension GetAllTechnologyStacks : JsonSerializable
{
    public class func reflect() -> Type<GetAllTechnologyStacks> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetAllTechnologyStacks>(
            name: "GetAllTechnologyStacks",
            properties: [
            ]))
    }
    public func toJson() -> String {
        return GetAllTechnologyStacks.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetAllTechnologyStacks? {
        return GetAllTechnologyStacks.reflect().fromJson(GetAllTechnologyStacks(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetAllTechnologyStacks? {
        return GetAllTechnologyStacks.reflect().fromObject(GetAllTechnologyStacks(), any:any)
    }
    public func toString() -> String {
        return GetAllTechnologyStacks.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetAllTechnologyStacks? {
        return GetAllTechnologyStacks.reflect().fromString(GetAllTechnologyStacks(), string: string)
    }
}

extension GetTechnologyStack : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyStack>(
            name: "GetTechnologyStack",
            properties: [
                Type<GetTechnologyStack>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
                Type<GetTechnologyStack>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyStack? {
        return GetTechnologyStack.reflect().fromJson(GetTechnologyStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyStack? {
        return GetTechnologyStack.reflect().fromObject(GetTechnologyStack(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyStack? {
        return GetTechnologyStack.reflect().fromString(GetTechnologyStack(), string: string)
    }
}

extension GetTechnologyStackPreviousVersions : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyStackPreviousVersions> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyStackPreviousVersions>(
            name: "GetTechnologyStackPreviousVersions",
            properties: [
                Type<GetTechnologyStackPreviousVersions>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyStackPreviousVersions.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyStackPreviousVersions? {
        return GetTechnologyStackPreviousVersions.reflect().fromJson(GetTechnologyStackPreviousVersions(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyStackPreviousVersions? {
        return GetTechnologyStackPreviousVersions.reflect().fromObject(GetTechnologyStackPreviousVersions(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyStackPreviousVersions.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyStackPreviousVersions? {
        return GetTechnologyStackPreviousVersions.reflect().fromString(GetTechnologyStackPreviousVersions(), string: string)
    }
}

extension GetTechnologyStackFavoriteDetails : JsonSerializable
{
    public class func reflect() -> Type<GetTechnologyStackFavoriteDetails> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetTechnologyStackFavoriteDetails>(
            name: "GetTechnologyStackFavoriteDetails",
            properties: [
                Type<GetTechnologyStackFavoriteDetails>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
                Type<GetTechnologyStackFavoriteDetails>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetTechnologyStackFavoriteDetails.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetTechnologyStackFavoriteDetails? {
        return GetTechnologyStackFavoriteDetails.reflect().fromJson(GetTechnologyStackFavoriteDetails(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetTechnologyStackFavoriteDetails? {
        return GetTechnologyStackFavoriteDetails.reflect().fromObject(GetTechnologyStackFavoriteDetails(), any:any)
    }
    public func toString() -> String {
        return GetTechnologyStackFavoriteDetails.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetTechnologyStackFavoriteDetails? {
        return GetTechnologyStackFavoriteDetails.reflect().fromString(GetTechnologyStackFavoriteDetails(), string: string)
    }
}

extension GetConfig : JsonSerializable
{
    public class func reflect() -> Type<GetConfig> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetConfig>(
            name: "GetConfig",
            properties: [
            ]))
    }
    public func toJson() -> String {
        return GetConfig.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetConfig? {
        return GetConfig.reflect().fromJson(GetConfig(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetConfig? {
        return GetConfig.reflect().fromObject(GetConfig(), any:any)
    }
    public func toString() -> String {
        return GetConfig.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetConfig? {
        return GetConfig.reflect().fromString(GetConfig(), string: string)
    }
}

extension Overview : JsonSerializable
{
    public class func reflect() -> Type<Overview> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Overview>(
            name: "Overview",
            properties: [
                Type<Overview>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Overview.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Overview? {
        return Overview.reflect().fromJson(Overview(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Overview? {
        return Overview.reflect().fromObject(Overview(), any:any)
    }
    public func toString() -> String {
        return Overview.reflect().toString(self)
    }
    public class func fromString(string:String) -> Overview? {
        return Overview.reflect().fromString(Overview(), string: string)
    }
}

extension FindTechStacks : JsonSerializable
{
    public class func reflect() -> Type<FindTechStacks> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<FindTechStacks>(
            name: "FindTechStacks",
            properties: [
                Type<FindTechStacks>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
            ]))
    }
    public func toJson() -> String {
        return FindTechStacks.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> FindTechStacks? {
        return FindTechStacks.reflect().fromJson(FindTechStacks(), json: json)
    }
    public class func fromObject(any:AnyObject) -> FindTechStacks? {
        return FindTechStacks.reflect().fromObject(FindTechStacks(), any:any)
    }
    public func toString() -> String {
        return FindTechStacks.reflect().toString(self)
    }
    public class func fromString(string:String) -> FindTechStacks? {
        return FindTechStacks.reflect().fromString(FindTechStacks(), string: string)
    }
}

extension GetFavoriteTechStack : JsonSerializable
{
    public class func reflect() -> Type<GetFavoriteTechStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetFavoriteTechStack>(
            name: "GetFavoriteTechStack",
            properties: [
                Type<GetFavoriteTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetFavoriteTechStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetFavoriteTechStack? {
        return GetFavoriteTechStack.reflect().fromJson(GetFavoriteTechStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetFavoriteTechStack? {
        return GetFavoriteTechStack.reflect().fromObject(GetFavoriteTechStack(), any:any)
    }
    public func toString() -> String {
        return GetFavoriteTechStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetFavoriteTechStack? {
        return GetFavoriteTechStack.reflect().fromString(GetFavoriteTechStack(), string: string)
    }
}

extension AddFavoriteTechStack : JsonSerializable
{
    public class func reflect() -> Type<AddFavoriteTechStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AddFavoriteTechStack>(
            name: "AddFavoriteTechStack",
            properties: [
                Type<AddFavoriteTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AddFavoriteTechStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AddFavoriteTechStack? {
        return AddFavoriteTechStack.reflect().fromJson(AddFavoriteTechStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AddFavoriteTechStack? {
        return AddFavoriteTechStack.reflect().fromObject(AddFavoriteTechStack(), any:any)
    }
    public func toString() -> String {
        return AddFavoriteTechStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> AddFavoriteTechStack? {
        return AddFavoriteTechStack.reflect().fromString(AddFavoriteTechStack(), string: string)
    }
}

extension RemoveFavoriteTechStack : JsonSerializable
{
    public class func reflect() -> Type<RemoveFavoriteTechStack> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RemoveFavoriteTechStack>(
            name: "RemoveFavoriteTechStack",
            properties: [
                Type<RemoveFavoriteTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
            ]))
    }
    public func toJson() -> String {
        return RemoveFavoriteTechStack.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RemoveFavoriteTechStack? {
        return RemoveFavoriteTechStack.reflect().fromJson(RemoveFavoriteTechStack(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RemoveFavoriteTechStack? {
        return RemoveFavoriteTechStack.reflect().fromObject(RemoveFavoriteTechStack(), any:any)
    }
    public func toString() -> String {
        return RemoveFavoriteTechStack.reflect().toString(self)
    }
    public class func fromString(string:String) -> RemoveFavoriteTechStack? {
        return RemoveFavoriteTechStack.reflect().fromString(RemoveFavoriteTechStack(), string: string)
    }
}

extension GetFavoriteTechnologies : JsonSerializable
{
    public class func reflect() -> Type<GetFavoriteTechnologies> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetFavoriteTechnologies>(
            name: "GetFavoriteTechnologies",
            properties: [
                Type<GetFavoriteTechnologies>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetFavoriteTechnologies.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetFavoriteTechnologies? {
        return GetFavoriteTechnologies.reflect().fromJson(GetFavoriteTechnologies(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetFavoriteTechnologies? {
        return GetFavoriteTechnologies.reflect().fromObject(GetFavoriteTechnologies(), any:any)
    }
    public func toString() -> String {
        return GetFavoriteTechnologies.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetFavoriteTechnologies? {
        return GetFavoriteTechnologies.reflect().fromString(GetFavoriteTechnologies(), string: string)
    }
}

extension AddFavoriteTechnology : JsonSerializable
{
    public class func reflect() -> Type<AddFavoriteTechnology> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AddFavoriteTechnology>(
            name: "AddFavoriteTechnology",
            properties: [
                Type<AddFavoriteTechnology>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AddFavoriteTechnology.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AddFavoriteTechnology? {
        return AddFavoriteTechnology.reflect().fromJson(AddFavoriteTechnology(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AddFavoriteTechnology? {
        return AddFavoriteTechnology.reflect().fromObject(AddFavoriteTechnology(), any:any)
    }
    public func toString() -> String {
        return AddFavoriteTechnology.reflect().toString(self)
    }
    public class func fromString(string:String) -> AddFavoriteTechnology? {
        return AddFavoriteTechnology.reflect().fromString(AddFavoriteTechnology(), string: string)
    }
}

extension RemoveFavoriteTechnology : JsonSerializable
{
    public class func reflect() -> Type<RemoveFavoriteTechnology> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RemoveFavoriteTechnology>(
            name: "RemoveFavoriteTechnology",
            properties: [
                Type<RemoveFavoriteTechnology>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
            ]))
    }
    public func toJson() -> String {
        return RemoveFavoriteTechnology.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RemoveFavoriteTechnology? {
        return RemoveFavoriteTechnology.reflect().fromJson(RemoveFavoriteTechnology(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RemoveFavoriteTechnology? {
        return RemoveFavoriteTechnology.reflect().fromObject(RemoveFavoriteTechnology(), any:any)
    }
    public func toString() -> String {
        return RemoveFavoriteTechnology.reflect().toString(self)
    }
    public class func fromString(string:String) -> RemoveFavoriteTechnology? {
        return RemoveFavoriteTechnology.reflect().fromString(RemoveFavoriteTechnology(), string: string)
    }
}

extension GetUserFeed : JsonSerializable
{
    public class func reflect() -> Type<GetUserFeed> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetUserFeed>(
            name: "GetUserFeed",
            properties: [
            ]))
    }
    public func toJson() -> String {
        return GetUserFeed.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetUserFeed? {
        return GetUserFeed.reflect().fromJson(GetUserFeed(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetUserFeed? {
        return GetUserFeed.reflect().fromObject(GetUserFeed(), any:any)
    }
    public func toString() -> String {
        return GetUserFeed.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetUserFeed? {
        return GetUserFeed.reflect().fromString(GetUserFeed(), string: string)
    }
}

extension GetUserInfo : JsonSerializable
{
    public class func reflect() -> Type<GetUserInfo> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetUserInfo>(
            name: "GetUserInfo",
            properties: [
                Type<GetUserInfo>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
                Type<GetUserInfo>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetUserInfo.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetUserInfo? {
        return GetUserInfo.reflect().fromJson(GetUserInfo(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetUserInfo? {
        return GetUserInfo.reflect().fromObject(GetUserInfo(), any:any)
    }
    public func toString() -> String {
        return GetUserInfo.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetUserInfo? {
        return GetUserInfo.reflect().fromString(GetUserInfo(), string: string)
    }
}

extension Authenticate : JsonSerializable
{
    public class func reflect() -> Type<Authenticate> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Authenticate>(
            name: "Authenticate",
            properties: [
                Type<Authenticate>.optionalProperty("provider", get: { $0.provider }, set: { $0.provider = $1 }),
                Type<Authenticate>.optionalProperty("state", get: { $0.state }, set: { $0.state = $1 }),
                Type<Authenticate>.optionalProperty("oauth_token", get: { $0.oauth_token }, set: { $0.oauth_token = $1 }),
                Type<Authenticate>.optionalProperty("oauth_verifier", get: { $0.oauth_verifier }, set: { $0.oauth_verifier = $1 }),
                Type<Authenticate>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
                Type<Authenticate>.optionalProperty("password", get: { $0.password }, set: { $0.password = $1 }),
                Type<Authenticate>.optionalProperty("rememberMe", get: { $0.rememberMe }, set: { $0.rememberMe = $1 }),
                Type<Authenticate>.optionalProperty("Continue", get: { $0.Continue }, set: { $0.Continue = $1 }),
                Type<Authenticate>.optionalProperty("nonce", get: { $0.nonce }, set: { $0.nonce = $1 }),
                Type<Authenticate>.optionalProperty("uri", get: { $0.uri }, set: { $0.uri = $1 }),
                Type<Authenticate>.optionalProperty("response", get: { $0.response }, set: { $0.response = $1 }),
                Type<Authenticate>.optionalProperty("qop", get: { $0.qop }, set: { $0.qop = $1 }),
                Type<Authenticate>.optionalProperty("nc", get: { $0.nc }, set: { $0.nc = $1 }),
                Type<Authenticate>.optionalProperty("cnonce", get: { $0.cnonce }, set: { $0.cnonce = $1 }),
                Type<Authenticate>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Authenticate.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Authenticate? {
        return Authenticate.reflect().fromJson(Authenticate(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Authenticate? {
        return Authenticate.reflect().fromObject(Authenticate(), any:any)
    }
    public func toString() -> String {
        return Authenticate.reflect().toString(self)
    }
    public class func fromString(string:String) -> Authenticate? {
        return Authenticate.reflect().fromString(Authenticate(), string: string)
    }
}

extension AssignRoles : JsonSerializable
{
    public class func reflect() -> Type<AssignRoles> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AssignRoles>(
            name: "AssignRoles",
            properties: [
                Type<AssignRoles>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
                Type<AssignRoles>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
                Type<AssignRoles>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AssignRoles.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AssignRoles? {
        return AssignRoles.reflect().fromJson(AssignRoles(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AssignRoles? {
        return AssignRoles.reflect().fromObject(AssignRoles(), any:any)
    }
    public func toString() -> String {
        return AssignRoles.reflect().toString(self)
    }
    public class func fromString(string:String) -> AssignRoles? {
        return AssignRoles.reflect().fromString(AssignRoles(), string: string)
    }
}

extension UnAssignRoles : JsonSerializable
{
    public class func reflect() -> Type<UnAssignRoles> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UnAssignRoles>(
            name: "UnAssignRoles",
            properties: [
                Type<UnAssignRoles>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
                Type<UnAssignRoles>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
                Type<UnAssignRoles>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
            ]))
    }
    public func toJson() -> String {
        return UnAssignRoles.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> UnAssignRoles? {
        return UnAssignRoles.reflect().fromJson(UnAssignRoles(), json: json)
    }
    public class func fromObject(any:AnyObject) -> UnAssignRoles? {
        return UnAssignRoles.reflect().fromObject(UnAssignRoles(), any:any)
    }
    public func toString() -> String {
        return UnAssignRoles.reflect().toString(self)
    }
    public class func fromString(string:String) -> UnAssignRoles? {
        return UnAssignRoles.reflect().fromString(UnAssignRoles(), string: string)
    }
}

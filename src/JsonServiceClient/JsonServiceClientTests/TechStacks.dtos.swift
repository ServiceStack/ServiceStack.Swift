#if false
/* Options:
Date: 2015-01-26 08:48:50
Version: 1
BaseUrl: http://techstacks.io

//AddResponseStatus: False
//AddModelExtensions: True
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
    public var id:Int64?
}

// @Route("/technology/{Slug}/previous-versions", "GET")
public class GetTechnologyPreviousVersions : IReturn
{
    typealias Return = GetTechnologyPreviousVersionsResponse

    required public init(){}
    public var slug:String?
    // @IgnoreDataMember()
    public var id:Int64?
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
public class FindTechnologies<Technology> : QueryBase<Technology>, IReturn
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
    // @IgnoreDataMember()
    public var id:Int64?
}

// @Route("/techstacks/{Slug}/previous-versions", "GET")
public class GetTechnologyStackPreviousVersions : IReturn
{
    typealias Return = GetTechnologyStackPreviousVersionsResponse

    required public init(){}
    public var slug:String?
    // @IgnoreDataMember()
    public var id:Int64?
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
public class FindTechStacks<TechnologyStack> : QueryBase<TechnologyStack>, IReturn
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


extension Technology : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<Technology>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Technology>(
            writers: [
                ("id", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("vendorUrl", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.vendorUrl, map, "vendorUrl") }),
                ("productUrl", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.productUrl, map, "productUrl") }),
                ("logoUrl", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.logoUrl, map, "logoUrl") }),
                ("description", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("created", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("createdBy", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.createdBy, map, "createdBy") }),
                ("lastModified", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.lastModified, map, "lastModified") }),
                ("lastModifiedBy", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.lastModifiedBy, map, "lastModifiedBy") }),
                ("ownerId", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.ownerId, map, "ownerId") }),
                ("slug", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("logoApproved", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.logoApproved, map, "logoApproved") }),
                ("isLocked", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("tier", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.tier, map, "tier") }),
                ("lastStatusUpdate", { (x:Technology, map:NSDictionary) in setOptionalValue(&x.lastStatusUpdate, map, "lastStatusUpdate") }),
            ],
            readers: [
                ("id", Type<Technology>.value { $0.id }),
                ("name", Type<Technology>.value { $0.name }),
                ("vendorName", Type<Technology>.value { $0.vendorName }),
                ("vendorUrl", Type<Technology>.value { $0.vendorUrl }),
                ("productUrl", Type<Technology>.value { $0.productUrl }),
                ("logoUrl", Type<Technology>.value { $0.logoUrl }),
                ("description", Type<Technology>.value { $0.description }),
                ("created", Type<Technology>.value { $0.created }),
                ("createdBy", Type<Technology>.value { $0.createdBy }),
                ("lastModified", Type<Technology>.value { $0.lastModified }),
                ("lastModifiedBy", Type<Technology>.value { $0.lastModifiedBy }),
                ("ownerId", Type<Technology>.value { $0.ownerId }),
                ("slug", Type<Technology>.value { $0.slug }),
                ("logoApproved", Type<Technology>.value { $0.logoApproved }),
                ("isLocked", Type<Technology>.value { $0.isLocked }),
                ("tier", Type<Technology>.value { $0.tier }),
                ("lastStatusUpdate", Type<Technology>.value { $0.lastStatusUpdate }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, Technology.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> Technology
    {
        return populate(Technology(), map, Technology.typeConfig())
    }

    public class func fromJson(json:String) -> Technology
    {
        return populate(Technology(), json, Technology.typeConfig())
    }
}

extension TechnologyTier : StringSerializable
{
    public func toString() -> String
    {
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

    public static func fromString(strValue:String) -> TechnologyTier?
    {
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
}

extension TechnologyStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<TechnologyStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<TechnologyStack>(
            writers: [
                ("id", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("description", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("appUrl", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.appUrl, map, "appUrl") }),
                ("screenshotUrl", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.screenshotUrl, map, "screenshotUrl") }),
                ("created", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("createdBy", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.createdBy, map, "createdBy") }),
                ("lastModified", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.lastModified, map, "lastModified") }),
                ("lastModifiedBy", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.lastModifiedBy, map, "lastModifiedBy") }),
                ("isLocked", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("ownerId", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.ownerId, map, "ownerId") }),
                ("slug", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("details", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.details, map, "details") }),
                ("lastStatusUpdate", { (x:TechnologyStack, map:NSDictionary) in setOptionalValue(&x.lastStatusUpdate, map, "lastStatusUpdate") }),
            ],
            readers: [
                ("id", Type<TechnologyStack>.value { $0.id }),
                ("name", Type<TechnologyStack>.value { $0.name }),
                ("vendorName", Type<TechnologyStack>.value { $0.vendorName }),
                ("description", Type<TechnologyStack>.value { $0.description }),
                ("appUrl", Type<TechnologyStack>.value { $0.appUrl }),
                ("screenshotUrl", Type<TechnologyStack>.value { $0.screenshotUrl }),
                ("created", Type<TechnologyStack>.value { $0.created }),
                ("createdBy", Type<TechnologyStack>.value { $0.createdBy }),
                ("lastModified", Type<TechnologyStack>.value { $0.lastModified }),
                ("lastModifiedBy", Type<TechnologyStack>.value { $0.lastModifiedBy }),
                ("isLocked", Type<TechnologyStack>.value { $0.isLocked }),
                ("ownerId", Type<TechnologyStack>.value { $0.ownerId }),
                ("slug", Type<TechnologyStack>.value { $0.slug }),
                ("details", Type<TechnologyStack>.value { $0.details }),
                ("lastStatusUpdate", Type<TechnologyStack>.value { $0.lastStatusUpdate }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, TechnologyStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> TechnologyStack
    {
        return populate(TechnologyStack(), map, TechnologyStack.typeConfig())
    }

    public class func fromJson(json:String) -> TechnologyStack
    {
        return populate(TechnologyStack(), json, TechnologyStack.typeConfig())
    }
}

extension TechnologyHistory : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<TechnologyHistory>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<TechnologyHistory>(
            writers: [
                ("id", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("vendorUrl", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.vendorUrl, map, "vendorUrl") }),
                ("productUrl", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.productUrl, map, "productUrl") }),
                ("logoUrl", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.logoUrl, map, "logoUrl") }),
                ("description", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("created", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("createdBy", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.createdBy, map, "createdBy") }),
                ("lastModified", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.lastModified, map, "lastModified") }),
                ("lastModifiedBy", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.lastModifiedBy, map, "lastModifiedBy") }),
                ("ownerId", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.ownerId, map, "ownerId") }),
                ("slug", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("logoApproved", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.logoApproved, map, "logoApproved") }),
                ("isLocked", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("tier", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.tier, map, "tier") }),
                ("lastStatusUpdate", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.lastStatusUpdate, map, "lastStatusUpdate") }),
                ("technologyId", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.technologyId, map, "technologyId") }),
                ("operation", { (x:TechnologyHistory, map:NSDictionary) in setOptionalValue(&x.operation, map, "operation") }),
            ],
            readers: [
                ("id", Type<TechnologyHistory>.value { $0.id }),
                ("name", Type<TechnologyHistory>.value { $0.name }),
                ("vendorName", Type<TechnologyHistory>.value { $0.vendorName }),
                ("vendorUrl", Type<TechnologyHistory>.value { $0.vendorUrl }),
                ("productUrl", Type<TechnologyHistory>.value { $0.productUrl }),
                ("logoUrl", Type<TechnologyHistory>.value { $0.logoUrl }),
                ("description", Type<TechnologyHistory>.value { $0.description }),
                ("created", Type<TechnologyHistory>.value { $0.created }),
                ("createdBy", Type<TechnologyHistory>.value { $0.createdBy }),
                ("lastModified", Type<TechnologyHistory>.value { $0.lastModified }),
                ("lastModifiedBy", Type<TechnologyHistory>.value { $0.lastModifiedBy }),
                ("ownerId", Type<TechnologyHistory>.value { $0.ownerId }),
                ("slug", Type<TechnologyHistory>.value { $0.slug }),
                ("logoApproved", Type<TechnologyHistory>.value { $0.logoApproved }),
                ("isLocked", Type<TechnologyHistory>.value { $0.isLocked }),
                ("tier", Type<TechnologyHistory>.value { $0.tier }),
                ("lastStatusUpdate", Type<TechnologyHistory>.value { $0.lastStatusUpdate }),
                ("technologyId", Type<TechnologyHistory>.value { $0.technologyId }),
                ("operation", Type<TechnologyHistory>.value { $0.operation }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, TechnologyHistory.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> TechnologyHistory
    {
        return populate(TechnologyHistory(), map, TechnologyHistory.typeConfig())
    }

    public class func fromJson(json:String) -> TechnologyHistory
    {
        return populate(TechnologyHistory(), json, TechnologyHistory.typeConfig())
    }
}

extension TechStackDetails : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<TechStackDetails>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<TechStackDetails>(
            writers: [
                ("id", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("description", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("appUrl", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.appUrl, map, "appUrl") }),
                ("screenshotUrl", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.screenshotUrl, map, "screenshotUrl") }),
                ("created", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("createdBy", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.createdBy, map, "createdBy") }),
                ("lastModified", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.lastModified, map, "lastModified") }),
                ("lastModifiedBy", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.lastModifiedBy, map, "lastModifiedBy") }),
                ("isLocked", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("ownerId", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.ownerId, map, "ownerId") }),
                ("slug", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("details", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.details, map, "details") }),
                ("lastStatusUpdate", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.lastStatusUpdate, map, "lastStatusUpdate") }),
                ("detailsHtml", { (x:TechStackDetails, map:NSDictionary) in setOptionalValue(&x.detailsHtml, map, "detailsHtml") }),
                ("technologyChoices", { (x:TechStackDetails, map:NSDictionary) in setValue(&x.technologyChoices, map, "technologyChoices") }),
            ],
            readers: [
                ("id", Type<TechStackDetails>.value { $0.id }),
                ("name", Type<TechStackDetails>.value { $0.name }),
                ("vendorName", Type<TechStackDetails>.value { $0.vendorName }),
                ("description", Type<TechStackDetails>.value { $0.description }),
                ("appUrl", Type<TechStackDetails>.value { $0.appUrl }),
                ("screenshotUrl", Type<TechStackDetails>.value { $0.screenshotUrl }),
                ("created", Type<TechStackDetails>.value { $0.created }),
                ("createdBy", Type<TechStackDetails>.value { $0.createdBy }),
                ("lastModified", Type<TechStackDetails>.value { $0.lastModified }),
                ("lastModifiedBy", Type<TechStackDetails>.value { $0.lastModifiedBy }),
                ("isLocked", Type<TechStackDetails>.value { $0.isLocked }),
                ("ownerId", Type<TechStackDetails>.value { $0.ownerId }),
                ("slug", Type<TechStackDetails>.value { $0.slug }),
                ("details", Type<TechStackDetails>.value { $0.details }),
                ("lastStatusUpdate", Type<TechStackDetails>.value { $0.lastStatusUpdate }),
                ("detailsHtml", Type<TechStackDetails>.value { $0.detailsHtml }),
                ("technologyChoices", Type<TechStackDetails>.value { $0.technologyChoices }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, TechStackDetails.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> TechStackDetails
    {
        return populate(TechStackDetails(), map, TechStackDetails.typeConfig())
    }

    public class func fromJson(json:String) -> TechStackDetails
    {
        return populate(TechStackDetails(), json, TechStackDetails.typeConfig())
    }
}

extension TechnologyStackHistory : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<TechnologyStackHistory>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<TechnologyStackHistory>(
            writers: [
                ("id", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("description", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("appUrl", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.appUrl, map, "appUrl") }),
                ("screenshotUrl", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.screenshotUrl, map, "screenshotUrl") }),
                ("created", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("createdBy", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.createdBy, map, "createdBy") }),
                ("lastModified", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.lastModified, map, "lastModified") }),
                ("lastModifiedBy", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.lastModifiedBy, map, "lastModifiedBy") }),
                ("isLocked", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("ownerId", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.ownerId, map, "ownerId") }),
                ("slug", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("details", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.details, map, "details") }),
                ("lastStatusUpdate", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.lastStatusUpdate, map, "lastStatusUpdate") }),
                ("technologyStackId", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.technologyStackId, map, "technologyStackId") }),
                ("operation", { (x:TechnologyStackHistory, map:NSDictionary) in setOptionalValue(&x.operation, map, "operation") }),
                ("technologyIds", { (x:TechnologyStackHistory, map:NSDictionary) in setValue(&x.technologyIds, map, "technologyIds") }),
            ],
            readers: [
                ("id", Type<TechnologyStackHistory>.value { $0.id }),
                ("name", Type<TechnologyStackHistory>.value { $0.name }),
                ("vendorName", Type<TechnologyStackHistory>.value { $0.vendorName }),
                ("description", Type<TechnologyStackHistory>.value { $0.description }),
                ("appUrl", Type<TechnologyStackHistory>.value { $0.appUrl }),
                ("screenshotUrl", Type<TechnologyStackHistory>.value { $0.screenshotUrl }),
                ("created", Type<TechnologyStackHistory>.value { $0.created }),
                ("createdBy", Type<TechnologyStackHistory>.value { $0.createdBy }),
                ("lastModified", Type<TechnologyStackHistory>.value { $0.lastModified }),
                ("lastModifiedBy", Type<TechnologyStackHistory>.value { $0.lastModifiedBy }),
                ("isLocked", Type<TechnologyStackHistory>.value { $0.isLocked }),
                ("ownerId", Type<TechnologyStackHistory>.value { $0.ownerId }),
                ("slug", Type<TechnologyStackHistory>.value { $0.slug }),
                ("details", Type<TechnologyStackHistory>.value { $0.details }),
                ("lastStatusUpdate", Type<TechnologyStackHistory>.value { $0.lastStatusUpdate }),
                ("technologyStackId", Type<TechnologyStackHistory>.value { $0.technologyStackId }),
                ("operation", Type<TechnologyStackHistory>.value { $0.operation }),
                ("technologyIds", Type<TechnologyStackHistory>.value { $0.technologyIds }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, TechnologyStackHistory.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> TechnologyStackHistory
    {
        return populate(TechnologyStackHistory(), map, TechnologyStackHistory.typeConfig())
    }

    public class func fromJson(json:String) -> TechnologyStackHistory
    {
        return populate(TechnologyStackHistory(), json, TechnologyStackHistory.typeConfig())
    }
}

extension Option : JsonSerializable, StringSerializable
{
    public class func typeConfig() -> JsConfigType<Option>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Option>(
            writers: [
                ("name", { (x:Option, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("title", { (x:Option, map:NSDictionary) in setOptionalValue(&x.title, map, "title") }),
                ("value", { (x:Option, map:NSDictionary) in setOptionalValue(&x.value, map, "value") }),
            ],
            readers: [
                ("name", Type<Option>.value { $0.name }),
                ("title", Type<Option>.value { $0.title }),
                ("value", Type<Option>.value {
                    $0.value
                }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, Option.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> Option
    {
        return populate(Option(), map, Option.typeConfig())
    }

    public class func fromJson(json:String) -> Option
    {
        return populate(Option(), json, Option.typeConfig())
    }
    
    public func toString() -> String
    {
        return serializeToJson(self, Option.typeConfig())
    }
    
    public class func fromString(json:String) -> Option?
    {
        return populate(Option(), json, Option.typeConfig())
    }
}

extension UserInfo : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<UserInfo>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<UserInfo>(
            writers: [
                ("userName", { (x:UserInfo, map:NSDictionary) in setOptionalValue(&x.userName, map, "userName") }),
                ("avatarUrl", { (x:UserInfo, map:NSDictionary) in setOptionalValue(&x.avatarUrl, map, "avatarUrl") }),
                ("stacksCount", { (x:UserInfo, map:NSDictionary) in setOptionalValue(&x.stacksCount, map, "stacksCount") }),
            ],
            readers: [
                ("userName", Type<UserInfo>.value { $0.userName }),
                ("avatarUrl", Type<UserInfo>.value { $0.avatarUrl }),
                ("stacksCount", Type<UserInfo>.value { $0.stacksCount }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, UserInfo.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> UserInfo
    {
        return populate(UserInfo(), map, UserInfo.typeConfig())
    }

    public class func fromJson(json:String) -> UserInfo
    {
        return populate(UserInfo(), json, UserInfo.typeConfig())
    }
}

extension TechnologyInfo : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<TechnologyInfo>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<TechnologyInfo>(
            writers: [
                ("tier", { (x:TechnologyInfo, map:NSDictionary) in setOptionalValue(&x.tier, map, "tier") }),
                ("slug", { (x:TechnologyInfo, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("name", { (x:TechnologyInfo, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("logoUrl", { (x:TechnologyInfo, map:NSDictionary) in setOptionalValue(&x.logoUrl, map, "logoUrl") }),
                ("stacksCount", { (x:TechnologyInfo, map:NSDictionary) in setOptionalValue(&x.stacksCount, map, "stacksCount") }),
            ],
            readers: [
                ("tier", Type<TechnologyInfo>.value { $0.tier }),
                ("slug", Type<TechnologyInfo>.value { $0.slug }),
                ("name", Type<TechnologyInfo>.value { $0.name }),
                ("logoUrl", Type<TechnologyInfo>.value { $0.logoUrl }),
                ("stacksCount", Type<TechnologyInfo>.value { $0.stacksCount }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, TechnologyInfo.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> TechnologyInfo
    {
        return populate(TechnologyInfo(), map, TechnologyInfo.typeConfig())
    }

    public class func fromJson(json:String) -> TechnologyInfo
    {
        return populate(TechnologyInfo(), json, TechnologyInfo.typeConfig())
    }
}

extension TechnologyInStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<TechnologyInStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<TechnologyInStack>(
            writers: [
                ("id", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("vendorUrl", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.vendorUrl, map, "vendorUrl") }),
                ("productUrl", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.productUrl, map, "productUrl") }),
                ("logoUrl", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.logoUrl, map, "logoUrl") }),
                ("description", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("created", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("createdBy", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.createdBy, map, "createdBy") }),
                ("lastModified", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.lastModified, map, "lastModified") }),
                ("lastModifiedBy", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.lastModifiedBy, map, "lastModifiedBy") }),
                ("ownerId", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.ownerId, map, "ownerId") }),
                ("slug", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("logoApproved", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.logoApproved, map, "logoApproved") }),
                ("isLocked", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("tier", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.tier, map, "tier") }),
                ("lastStatusUpdate", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.lastStatusUpdate, map, "lastStatusUpdate") }),
                ("technologyId", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.technologyId, map, "technologyId") }),
                ("technologyStackId", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.technologyStackId, map, "technologyStackId") }),
                ("justification", { (x:TechnologyInStack, map:NSDictionary) in setOptionalValue(&x.justification, map, "justification") }),
            ],
            readers: [
                ("id", Type<TechnologyInStack>.value { $0.id }),
                ("name", Type<TechnologyInStack>.value { $0.name }),
                ("vendorName", Type<TechnologyInStack>.value { $0.vendorName }),
                ("vendorUrl", Type<TechnologyInStack>.value { $0.vendorUrl }),
                ("productUrl", Type<TechnologyInStack>.value { $0.productUrl }),
                ("logoUrl", Type<TechnologyInStack>.value { $0.logoUrl }),
                ("description", Type<TechnologyInStack>.value { $0.description }),
                ("created", Type<TechnologyInStack>.value { $0.created }),
                ("createdBy", Type<TechnologyInStack>.value { $0.createdBy }),
                ("lastModified", Type<TechnologyInStack>.value { $0.lastModified }),
                ("lastModifiedBy", Type<TechnologyInStack>.value { $0.lastModifiedBy }),
                ("ownerId", Type<TechnologyInStack>.value { $0.ownerId }),
                ("slug", Type<TechnologyInStack>.value { $0.slug }),
                ("logoApproved", Type<TechnologyInStack>.value { $0.logoApproved }),
                ("isLocked", Type<TechnologyInStack>.value { $0.isLocked }),
                ("tier", Type<TechnologyInStack>.value { $0.tier }),
                ("lastStatusUpdate", Type<TechnologyInStack>.value { $0.lastStatusUpdate }),
                ("technologyId", Type<TechnologyInStack>.value { $0.technologyId }),
                ("technologyStackId", Type<TechnologyInStack>.value { $0.technologyStackId }),
                ("justification", Type<TechnologyInStack>.value { $0.justification }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, TechnologyInStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> TechnologyInStack
    {
        return populate(TechnologyInStack(), map, TechnologyInStack.typeConfig())
    }

    public class func fromJson(json:String) -> TechnologyInStack
    {
        return populate(TechnologyInStack(), json, TechnologyInStack.typeConfig())
    }
}

extension LogoUrlApprovalResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<LogoUrlApprovalResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<LogoUrlApprovalResponse>(
            writers: [
                ("result", { (x:LogoUrlApprovalResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<LogoUrlApprovalResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, LogoUrlApprovalResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> LogoUrlApprovalResponse
    {
        return populate(LogoUrlApprovalResponse(), map, LogoUrlApprovalResponse.typeConfig())
    }

    public class func fromJson(json:String) -> LogoUrlApprovalResponse
    {
        return populate(LogoUrlApprovalResponse(), json, LogoUrlApprovalResponse.typeConfig())
    }
}

extension LockStackResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<LockStackResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<LockStackResponse>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, LockStackResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> LockStackResponse
    {
        return populate(LockStackResponse(), map, LockStackResponse.typeConfig())
    }

    public class func fromJson(json:String) -> LockStackResponse
    {
        return populate(LockStackResponse(), json, LockStackResponse.typeConfig())
    }
}

extension CreateTechnologyResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<CreateTechnologyResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<CreateTechnologyResponse>(
            writers: [
                ("result", { (x:CreateTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("responseStatus", { (x:CreateTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("result", Type<CreateTechnologyResponse>.value { $0.result }),
                ("responseStatus", Type<CreateTechnologyResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, CreateTechnologyResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> CreateTechnologyResponse
    {
        return populate(CreateTechnologyResponse(), map, CreateTechnologyResponse.typeConfig())
    }

    public class func fromJson(json:String) -> CreateTechnologyResponse
    {
        return populate(CreateTechnologyResponse(), json, CreateTechnologyResponse.typeConfig())
    }
}

extension UpdateTechnologyResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<UpdateTechnologyResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<UpdateTechnologyResponse>(
            writers: [
                ("result", { (x:UpdateTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("responseStatus", { (x:UpdateTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("result", Type<UpdateTechnologyResponse>.value { $0.result }),
                ("responseStatus", Type<UpdateTechnologyResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, UpdateTechnologyResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> UpdateTechnologyResponse
    {
        return populate(UpdateTechnologyResponse(), map, UpdateTechnologyResponse.typeConfig())
    }

    public class func fromJson(json:String) -> UpdateTechnologyResponse
    {
        return populate(UpdateTechnologyResponse(), json, UpdateTechnologyResponse.typeConfig())
    }
}

extension DeleteTechnologyResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<DeleteTechnologyResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<DeleteTechnologyResponse>(
            writers: [
                ("result", { (x:DeleteTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("responseStatus", { (x:DeleteTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("result", Type<DeleteTechnologyResponse>.value { $0.result }),
                ("responseStatus", Type<DeleteTechnologyResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, DeleteTechnologyResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> DeleteTechnologyResponse
    {
        return populate(DeleteTechnologyResponse(), map, DeleteTechnologyResponse.typeConfig())
    }

    public class func fromJson(json:String) -> DeleteTechnologyResponse
    {
        return populate(DeleteTechnologyResponse(), json, DeleteTechnologyResponse.typeConfig())
    }
}

extension GetTechnologyResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyResponse>(
            writers: [
                ("created", { (x:GetTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("technology", { (x:GetTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.technology, map, "technology") }),
                ("technologyStacks", { (x:GetTechnologyResponse, map:NSDictionary) in setValue(&x.technologyStacks, map, "technologyStacks") }),
                ("responseStatus", { (x:GetTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("created", Type<GetTechnologyResponse>.value { $0.created }),
                ("technology", Type<GetTechnologyResponse>.value { $0.technology }),
                ("technologyStacks", Type<GetTechnologyResponse>.value { $0.technologyStacks }),
                ("responseStatus", Type<GetTechnologyResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyResponse
    {
        return populate(GetTechnologyResponse(), map, GetTechnologyResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyResponse
    {
        return populate(GetTechnologyResponse(), json, GetTechnologyResponse.typeConfig())
    }
}

extension GetTechnologyPreviousVersionsResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyPreviousVersionsResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyPreviousVersionsResponse>(
            writers: [
                ("results", { (x:GetTechnologyPreviousVersionsResponse, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("results", Type<GetTechnologyPreviousVersionsResponse>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyPreviousVersionsResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyPreviousVersionsResponse
    {
        return populate(GetTechnologyPreviousVersionsResponse(), map, GetTechnologyPreviousVersionsResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyPreviousVersionsResponse
    {
        return populate(GetTechnologyPreviousVersionsResponse(), json, GetTechnologyPreviousVersionsResponse.typeConfig())
    }
}

extension GetTechnologyFavoriteDetailsResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyFavoriteDetailsResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyFavoriteDetailsResponse>(
            writers: [
                ("users", { (x:GetTechnologyFavoriteDetailsResponse, map:NSDictionary) in setValue(&x.users, map, "users") }),
                ("favoriteCount", { (x:GetTechnologyFavoriteDetailsResponse, map:NSDictionary) in setOptionalValue(&x.favoriteCount, map, "favoriteCount") }),
            ],
            readers: [
                ("users", Type<GetTechnologyFavoriteDetailsResponse>.value { $0.users }),
                ("favoriteCount", Type<GetTechnologyFavoriteDetailsResponse>.value { $0.favoriteCount }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyFavoriteDetailsResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyFavoriteDetailsResponse
    {
        return populate(GetTechnologyFavoriteDetailsResponse(), map, GetTechnologyFavoriteDetailsResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyFavoriteDetailsResponse
    {
        return populate(GetTechnologyFavoriteDetailsResponse(), json, GetTechnologyFavoriteDetailsResponse.typeConfig())
    }
}

extension GetAllTechnologiesResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetAllTechnologiesResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetAllTechnologiesResponse>(
            writers: [
                ("results", { (x:GetAllTechnologiesResponse, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("results", Type<GetAllTechnologiesResponse>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetAllTechnologiesResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetAllTechnologiesResponse
    {
        return populate(GetAllTechnologiesResponse(), map, GetAllTechnologiesResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetAllTechnologiesResponse
    {
        return populate(GetAllTechnologiesResponse(), json, GetAllTechnologiesResponse.typeConfig())
    }
}

extension CreateTechnologyStackResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<CreateTechnologyStackResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<CreateTechnologyStackResponse>(
            writers: [
                ("result", { (x:CreateTechnologyStackResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("responseStatus", { (x:CreateTechnologyStackResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("result", Type<CreateTechnologyStackResponse>.value { $0.result }),
                ("responseStatus", Type<CreateTechnologyStackResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, CreateTechnologyStackResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> CreateTechnologyStackResponse
    {
        return populate(CreateTechnologyStackResponse(), map, CreateTechnologyStackResponse.typeConfig())
    }

    public class func fromJson(json:String) -> CreateTechnologyStackResponse
    {
        return populate(CreateTechnologyStackResponse(), json, CreateTechnologyStackResponse.typeConfig())
    }
}

extension UpdateTechnologyStackResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<UpdateTechnologyStackResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<UpdateTechnologyStackResponse>(
            writers: [
                ("result", { (x:UpdateTechnologyStackResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("responseStatus", { (x:UpdateTechnologyStackResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("result", Type<UpdateTechnologyStackResponse>.value { $0.result }),
                ("responseStatus", Type<UpdateTechnologyStackResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, UpdateTechnologyStackResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> UpdateTechnologyStackResponse
    {
        return populate(UpdateTechnologyStackResponse(), map, UpdateTechnologyStackResponse.typeConfig())
    }

    public class func fromJson(json:String) -> UpdateTechnologyStackResponse
    {
        return populate(UpdateTechnologyStackResponse(), json, UpdateTechnologyStackResponse.typeConfig())
    }
}

extension DeleteTechnologyStackResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<DeleteTechnologyStackResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<DeleteTechnologyStackResponse>(
            writers: [
                ("result", { (x:DeleteTechnologyStackResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("responseStatus", { (x:DeleteTechnologyStackResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("result", Type<DeleteTechnologyStackResponse>.value { $0.result }),
                ("responseStatus", Type<DeleteTechnologyStackResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, DeleteTechnologyStackResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> DeleteTechnologyStackResponse
    {
        return populate(DeleteTechnologyStackResponse(), map, DeleteTechnologyStackResponse.typeConfig())
    }

    public class func fromJson(json:String) -> DeleteTechnologyStackResponse
    {
        return populate(DeleteTechnologyStackResponse(), json, DeleteTechnologyStackResponse.typeConfig())
    }
}

extension GetAllTechnologyStacksResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetAllTechnologyStacksResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetAllTechnologyStacksResponse>(
            writers: [
                ("results", { (x:GetAllTechnologyStacksResponse, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("results", Type<GetAllTechnologyStacksResponse>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetAllTechnologyStacksResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetAllTechnologyStacksResponse
    {
        return populate(GetAllTechnologyStacksResponse(), map, GetAllTechnologyStacksResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetAllTechnologyStacksResponse
    {
        return populate(GetAllTechnologyStacksResponse(), json, GetAllTechnologyStacksResponse.typeConfig())
    }
}

extension GetTechnologyStackResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyStackResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyStackResponse>(
            writers: [
                ("created", { (x:GetTechnologyStackResponse, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("result", { (x:GetTechnologyStackResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("responseStatus", { (x:GetTechnologyStackResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("created", Type<GetTechnologyStackResponse>.value { $0.created }),
                ("result", Type<GetTechnologyStackResponse>.value { $0.result }),
                ("responseStatus", Type<GetTechnologyStackResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyStackResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyStackResponse
    {
        return populate(GetTechnologyStackResponse(), map, GetTechnologyStackResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyStackResponse
    {
        return populate(GetTechnologyStackResponse(), json, GetTechnologyStackResponse.typeConfig())
    }
}

extension GetTechnologyStackPreviousVersionsResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyStackPreviousVersionsResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyStackPreviousVersionsResponse>(
            writers: [
                ("results", { (x:GetTechnologyStackPreviousVersionsResponse, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("results", Type<GetTechnologyStackPreviousVersionsResponse>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyStackPreviousVersionsResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyStackPreviousVersionsResponse
    {
        return populate(GetTechnologyStackPreviousVersionsResponse(), map, GetTechnologyStackPreviousVersionsResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyStackPreviousVersionsResponse
    {
        return populate(GetTechnologyStackPreviousVersionsResponse(), json, GetTechnologyStackPreviousVersionsResponse.typeConfig())
    }
}

extension GetTechnologyStackFavoriteDetailsResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyStackFavoriteDetailsResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyStackFavoriteDetailsResponse>(
            writers: [
                ("users", { (x:GetTechnologyStackFavoriteDetailsResponse, map:NSDictionary) in setValue(&x.users, map, "users") }),
                ("favoriteCount", { (x:GetTechnologyStackFavoriteDetailsResponse, map:NSDictionary) in setOptionalValue(&x.favoriteCount, map, "favoriteCount") }),
            ],
            readers: [
                ("users", Type<GetTechnologyStackFavoriteDetailsResponse>.value { $0.users }),
                ("favoriteCount", Type<GetTechnologyStackFavoriteDetailsResponse>.value { $0.favoriteCount }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyStackFavoriteDetailsResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyStackFavoriteDetailsResponse
    {
        return populate(GetTechnologyStackFavoriteDetailsResponse(), map, GetTechnologyStackFavoriteDetailsResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyStackFavoriteDetailsResponse
    {
        return populate(GetTechnologyStackFavoriteDetailsResponse(), json, GetTechnologyStackFavoriteDetailsResponse.typeConfig())
    }
}

extension GetConfigResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetConfigResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetConfigResponse>(
            writers: [
                ("allTiers", { (x:GetConfigResponse, map:NSDictionary) in setValue(&x.allTiers, map, "allTiers") }),
            ],
            readers: [
                ("allTiers", Type<GetConfigResponse>.value { $0.allTiers }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetConfigResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetConfigResponse
    {
        return populate(GetConfigResponse(), map, GetConfigResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetConfigResponse
    {
        return populate(GetConfigResponse(), json, GetConfigResponse.typeConfig())
    }
}

extension OverviewResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<OverviewResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<OverviewResponse>(
            writers: [
                ("created", { (x:OverviewResponse, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("topUsers", { (x:OverviewResponse, map:NSDictionary) in setValue(&x.topUsers, map, "topUsers") }),
                ("topTechnologies", { (x:OverviewResponse, map:NSDictionary) in setValue(&x.topTechnologies, map, "topTechnologies") }),
                ("latestTechStacks", { (x:OverviewResponse, map:NSDictionary) in setValue(&x.latestTechStacks, map, "latestTechStacks") }),
                ("topTechnologiesByTier", { (x:OverviewResponse, map:NSDictionary) in setValue(&x.topTechnologiesByTier, map, "topTechnologiesByTier") }),
                ("responseStatus", { (x:OverviewResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("created", Type<OverviewResponse>.value { $0.created }),
                ("topUsers", Type<OverviewResponse>.value { $0.topUsers }),
                ("topTechnologies", Type<OverviewResponse>.value { $0.topTechnologies }),
                ("latestTechStacks", Type<OverviewResponse>.value { $0.latestTechStacks }),
                ("topTechnologiesByTier", Type<OverviewResponse>.value { $0.topTechnologiesByTier }),
                ("responseStatus", Type<OverviewResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, OverviewResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> OverviewResponse
    {
        return populate(OverviewResponse(), map, OverviewResponse.typeConfig())
    }

    public class func fromJson(json:String) -> OverviewResponse
    {
        return populate(OverviewResponse(), json, OverviewResponse.typeConfig())
    }
}

extension GetFavoriteTechStackResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetFavoriteTechStackResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetFavoriteTechStackResponse>(
            writers: [
                ("results", { (x:GetFavoriteTechStackResponse, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("results", Type<GetFavoriteTechStackResponse>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetFavoriteTechStackResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetFavoriteTechStackResponse
    {
        return populate(GetFavoriteTechStackResponse(), map, GetFavoriteTechStackResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetFavoriteTechStackResponse
    {
        return populate(GetFavoriteTechStackResponse(), json, GetFavoriteTechStackResponse.typeConfig())
    }
}

extension FavoriteTechStackResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<FavoriteTechStackResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<FavoriteTechStackResponse>(
            writers: [
                ("result", { (x:FavoriteTechStackResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<FavoriteTechStackResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, FavoriteTechStackResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> FavoriteTechStackResponse
    {
        return populate(FavoriteTechStackResponse(), map, FavoriteTechStackResponse.typeConfig())
    }

    public class func fromJson(json:String) -> FavoriteTechStackResponse
    {
        return populate(FavoriteTechStackResponse(), json, FavoriteTechStackResponse.typeConfig())
    }
}

extension GetFavoriteTechnologiesResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetFavoriteTechnologiesResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetFavoriteTechnologiesResponse>(
            writers: [
                ("results", { (x:GetFavoriteTechnologiesResponse, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("results", Type<GetFavoriteTechnologiesResponse>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetFavoriteTechnologiesResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetFavoriteTechnologiesResponse
    {
        return populate(GetFavoriteTechnologiesResponse(), map, GetFavoriteTechnologiesResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetFavoriteTechnologiesResponse
    {
        return populate(GetFavoriteTechnologiesResponse(), json, GetFavoriteTechnologiesResponse.typeConfig())
    }
}

extension FavoriteTechnologyResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<FavoriteTechnologyResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<FavoriteTechnologyResponse>(
            writers: [
                ("result", { (x:FavoriteTechnologyResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<FavoriteTechnologyResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, FavoriteTechnologyResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> FavoriteTechnologyResponse
    {
        return populate(FavoriteTechnologyResponse(), map, FavoriteTechnologyResponse.typeConfig())
    }

    public class func fromJson(json:String) -> FavoriteTechnologyResponse
    {
        return populate(FavoriteTechnologyResponse(), json, FavoriteTechnologyResponse.typeConfig())
    }
}

extension GetUserFeedResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetUserFeedResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetUserFeedResponse>(
            writers: [
                ("results", { (x:GetUserFeedResponse, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("results", Type<GetUserFeedResponse>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetUserFeedResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetUserFeedResponse
    {
        return populate(GetUserFeedResponse(), map, GetUserFeedResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetUserFeedResponse
    {
        return populate(GetUserFeedResponse(), json, GetUserFeedResponse.typeConfig())
    }
}

extension GetUserInfoResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetUserInfoResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetUserInfoResponse>(
            writers: [
                ("userName", { (x:GetUserInfoResponse, map:NSDictionary) in setOptionalValue(&x.userName, map, "userName") }),
                ("created", { (x:GetUserInfoResponse, map:NSDictionary) in setOptionalValue(&x.created, map, "created") }),
                ("avatarUrl", { (x:GetUserInfoResponse, map:NSDictionary) in setOptionalValue(&x.avatarUrl, map, "avatarUrl") }),
                ("techStacks", { (x:GetUserInfoResponse, map:NSDictionary) in setValue(&x.techStacks, map, "techStacks") }),
                ("favoriteTechStacks", { (x:GetUserInfoResponse, map:NSDictionary) in setValue(&x.favoriteTechStacks, map, "favoriteTechStacks") }),
                ("favoriteTechnologies", { (x:GetUserInfoResponse, map:NSDictionary) in setValue(&x.favoriteTechnologies, map, "favoriteTechnologies") }),
            ],
            readers: [
                ("userName", Type<GetUserInfoResponse>.value { $0.userName }),
                ("created", Type<GetUserInfoResponse>.value { $0.created }),
                ("avatarUrl", Type<GetUserInfoResponse>.value { $0.avatarUrl }),
                ("techStacks", Type<GetUserInfoResponse>.value { $0.techStacks }),
                ("favoriteTechStacks", Type<GetUserInfoResponse>.value { $0.favoriteTechStacks }),
                ("favoriteTechnologies", Type<GetUserInfoResponse>.value { $0.favoriteTechnologies }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetUserInfoResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetUserInfoResponse
    {
        return populate(GetUserInfoResponse(), map, GetUserInfoResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetUserInfoResponse
    {
        return populate(GetUserInfoResponse(), json, GetUserInfoResponse.typeConfig())
    }
}

extension LogoUrlApproval : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<LogoUrlApproval>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<LogoUrlApproval>(
            writers: [
                ("technologyId", { (x:LogoUrlApproval, map:NSDictionary) in setOptionalValue(&x.technologyId, map, "technologyId") }),
                ("approved", { (x:LogoUrlApproval, map:NSDictionary) in setOptionalValue(&x.approved, map, "approved") }),
            ],
            readers: [
                ("technologyId", Type<LogoUrlApproval>.value { $0.technologyId }),
                ("approved", Type<LogoUrlApproval>.value { $0.approved }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, LogoUrlApproval.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> LogoUrlApproval
    {
        return populate(LogoUrlApproval(), map, LogoUrlApproval.typeConfig())
    }

    public class func fromJson(json:String) -> LogoUrlApproval
    {
        return populate(LogoUrlApproval(), json, LogoUrlApproval.typeConfig())
    }
}

extension LockTechStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<LockTechStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<LockTechStack>(
            writers: [
                ("technologyStackId", { (x:LockTechStack, map:NSDictionary) in setOptionalValue(&x.technologyStackId, map, "technologyStackId") }),
                ("isLocked", { (x:LockTechStack, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
            ],
            readers: [
                ("technologyStackId", Type<LockTechStack>.value { $0.technologyStackId }),
                ("isLocked", Type<LockTechStack>.value { $0.isLocked }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, LockTechStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> LockTechStack
    {
        return populate(LockTechStack(), map, LockTechStack.typeConfig())
    }

    public class func fromJson(json:String) -> LockTechStack
    {
        return populate(LockTechStack(), json, LockTechStack.typeConfig())
    }
}

extension LockTech : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<LockTech>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<LockTech>(
            writers: [
                ("technologyId", { (x:LockTech, map:NSDictionary) in setOptionalValue(&x.technologyId, map, "technologyId") }),
                ("isLocked", { (x:LockTech, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
            ],
            readers: [
                ("technologyId", Type<LockTech>.value { $0.technologyId }),
                ("isLocked", Type<LockTech>.value { $0.isLocked }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, LockTech.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> LockTech
    {
        return populate(LockTech(), map, LockTech.typeConfig())
    }

    public class func fromJson(json:String) -> LockTech
    {
        return populate(LockTech(), json, LockTech.typeConfig())
    }
}

extension Ping : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<Ping>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Ping>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, Ping.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> Ping
    {
        return populate(Ping(), map, Ping.typeConfig())
    }

    public class func fromJson(json:String) -> Ping
    {
        return populate(Ping(), json, Ping.typeConfig())
    }
}

extension FallbackForClientRoutes : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<FallbackForClientRoutes>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<FallbackForClientRoutes>(
            writers: [
                ("pathInfo", { (x:FallbackForClientRoutes, map:NSDictionary) in setOptionalValue(&x.pathInfo, map, "pathInfo") }),
            ],
            readers: [
                ("pathInfo", Type<FallbackForClientRoutes>.value { $0.pathInfo }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, FallbackForClientRoutes.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> FallbackForClientRoutes
    {
        return populate(FallbackForClientRoutes(), map, FallbackForClientRoutes.typeConfig())
    }

    public class func fromJson(json:String) -> FallbackForClientRoutes
    {
        return populate(FallbackForClientRoutes(), json, FallbackForClientRoutes.typeConfig())
    }
}

extension ClientAllTechnologyStacks : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ClientAllTechnologyStacks>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ClientAllTechnologyStacks>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ClientAllTechnologyStacks.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ClientAllTechnologyStacks
    {
        return populate(ClientAllTechnologyStacks(), map, ClientAllTechnologyStacks.typeConfig())
    }

    public class func fromJson(json:String) -> ClientAllTechnologyStacks
    {
        return populate(ClientAllTechnologyStacks(), json, ClientAllTechnologyStacks.typeConfig())
    }
}

extension ClientAllTechnologies : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ClientAllTechnologies>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ClientAllTechnologies>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ClientAllTechnologies.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ClientAllTechnologies
    {
        return populate(ClientAllTechnologies(), map, ClientAllTechnologies.typeConfig())
    }

    public class func fromJson(json:String) -> ClientAllTechnologies
    {
        return populate(ClientAllTechnologies(), json, ClientAllTechnologies.typeConfig())
    }
}

extension ClientTechnology : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ClientTechnology>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ClientTechnology>(
            writers: [
                ("slug", { (x:ClientTechnology, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
            ],
            readers: [
                ("slug", Type<ClientTechnology>.value { $0.slug }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ClientTechnology.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ClientTechnology
    {
        return populate(ClientTechnology(), map, ClientTechnology.typeConfig())
    }

    public class func fromJson(json:String) -> ClientTechnology
    {
        return populate(ClientTechnology(), json, ClientTechnology.typeConfig())
    }
}

extension ClientUser : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ClientUser>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ClientUser>(
            writers: [
                ("userName", { (x:ClientUser, map:NSDictionary) in setOptionalValue(&x.userName, map, "userName") }),
            ],
            readers: [
                ("userName", Type<ClientUser>.value { $0.userName }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ClientUser.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ClientUser
    {
        return populate(ClientUser(), map, ClientUser.typeConfig())
    }

    public class func fromJson(json:String) -> ClientUser
    {
        return populate(ClientUser(), json, ClientUser.typeConfig())
    }
}

extension SessionInfo : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<SessionInfo>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<SessionInfo>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, SessionInfo.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> SessionInfo
    {
        return populate(SessionInfo(), map, SessionInfo.typeConfig())
    }

    public class func fromJson(json:String) -> SessionInfo
    {
        return populate(SessionInfo(), json, SessionInfo.typeConfig())
    }
}

extension CreateTechnology : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<CreateTechnology>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<CreateTechnology>(
            writers: [
                ("name", { (x:CreateTechnology, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:CreateTechnology, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("vendorUrl", { (x:CreateTechnology, map:NSDictionary) in setOptionalValue(&x.vendorUrl, map, "vendorUrl") }),
                ("productUrl", { (x:CreateTechnology, map:NSDictionary) in setOptionalValue(&x.productUrl, map, "productUrl") }),
                ("logoUrl", { (x:CreateTechnology, map:NSDictionary) in setOptionalValue(&x.logoUrl, map, "logoUrl") }),
                ("description", { (x:CreateTechnology, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("isLocked", { (x:CreateTechnology, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("tier", { (x:CreateTechnology, map:NSDictionary) in setOptionalValue(&x.tier, map, "tier") }),
            ],
            readers: [
                ("name", Type<CreateTechnology>.value { $0.name }),
                ("vendorName", Type<CreateTechnology>.value { $0.vendorName }),
                ("vendorUrl", Type<CreateTechnology>.value { $0.vendorUrl }),
                ("productUrl", Type<CreateTechnology>.value { $0.productUrl }),
                ("logoUrl", Type<CreateTechnology>.value { $0.logoUrl }),
                ("description", Type<CreateTechnology>.value { $0.description }),
                ("isLocked", Type<CreateTechnology>.value { $0.isLocked }),
                ("tier", Type<CreateTechnology>.value { $0.tier }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, CreateTechnology.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> CreateTechnology
    {
        return populate(CreateTechnology(), map, CreateTechnology.typeConfig())
    }

    public class func fromJson(json:String) -> CreateTechnology
    {
        return populate(CreateTechnology(), json, CreateTechnology.typeConfig())
    }
}

extension UpdateTechnology : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<UpdateTechnology>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<UpdateTechnology>(
            writers: [
                ("id", { (x:UpdateTechnology, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:UpdateTechnology, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:UpdateTechnology, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("vendorUrl", { (x:UpdateTechnology, map:NSDictionary) in setOptionalValue(&x.vendorUrl, map, "vendorUrl") }),
                ("productUrl", { (x:UpdateTechnology, map:NSDictionary) in setOptionalValue(&x.productUrl, map, "productUrl") }),
                ("logoUrl", { (x:UpdateTechnology, map:NSDictionary) in setOptionalValue(&x.logoUrl, map, "logoUrl") }),
                ("description", { (x:UpdateTechnology, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("isLocked", { (x:UpdateTechnology, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("tier", { (x:UpdateTechnology, map:NSDictionary) in setOptionalValue(&x.tier, map, "tier") }),
            ],
            readers: [
                ("id", Type<UpdateTechnology>.value { $0.id }),
                ("name", Type<UpdateTechnology>.value { $0.name }),
                ("vendorName", Type<UpdateTechnology>.value { $0.vendorName }),
                ("vendorUrl", Type<UpdateTechnology>.value { $0.vendorUrl }),
                ("productUrl", Type<UpdateTechnology>.value { $0.productUrl }),
                ("logoUrl", Type<UpdateTechnology>.value { $0.logoUrl }),
                ("description", Type<UpdateTechnology>.value { $0.description }),
                ("isLocked", Type<UpdateTechnology>.value { $0.isLocked }),
                ("tier", Type<UpdateTechnology>.value { $0.tier }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, UpdateTechnology.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> UpdateTechnology
    {
        return populate(UpdateTechnology(), map, UpdateTechnology.typeConfig())
    }

    public class func fromJson(json:String) -> UpdateTechnology
    {
        return populate(UpdateTechnology(), json, UpdateTechnology.typeConfig())
    }
}

extension DeleteTechnology : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<DeleteTechnology>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<DeleteTechnology>(
            writers: [
                ("id", { (x:DeleteTechnology, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("id", Type<DeleteTechnology>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, DeleteTechnology.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> DeleteTechnology
    {
        return populate(DeleteTechnology(), map, DeleteTechnology.typeConfig())
    }

    public class func fromJson(json:String) -> DeleteTechnology
    {
        return populate(DeleteTechnology(), json, DeleteTechnology.typeConfig())
    }
}

extension GetTechnology : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnology>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnology>(
            writers: [
                ("reload", { (x:GetTechnology, map:NSDictionary) in setOptionalValue(&x.reload, map, "reload") }),
                ("slug", { (x:GetTechnology, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("id", { (x:GetTechnology, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("reload", Type<GetTechnology>.value { $0.reload }),
                ("slug", Type<GetTechnology>.value { $0.slug }),
                ("id", Type<GetTechnology>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnology.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnology
    {
        return populate(GetTechnology(), map, GetTechnology.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnology
    {
        return populate(GetTechnology(), json, GetTechnology.typeConfig())
    }
}

extension GetTechnologyPreviousVersions : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyPreviousVersions>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyPreviousVersions>(
            writers: [
                ("slug", { (x:GetTechnologyPreviousVersions, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("id", { (x:GetTechnologyPreviousVersions, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("slug", Type<GetTechnologyPreviousVersions>.value { $0.slug }),
                ("id", Type<GetTechnologyPreviousVersions>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyPreviousVersions.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyPreviousVersions
    {
        return populate(GetTechnologyPreviousVersions(), map, GetTechnologyPreviousVersions.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyPreviousVersions
    {
        return populate(GetTechnologyPreviousVersions(), json, GetTechnologyPreviousVersions.typeConfig())
    }
}

extension GetTechnologyFavoriteDetails : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyFavoriteDetails>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyFavoriteDetails>(
            writers: [
                ("slug", { (x:GetTechnologyFavoriteDetails, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("reload", { (x:GetTechnologyFavoriteDetails, map:NSDictionary) in setOptionalValue(&x.reload, map, "reload") }),
            ],
            readers: [
                ("slug", Type<GetTechnologyFavoriteDetails>.value { $0.slug }),
                ("reload", Type<GetTechnologyFavoriteDetails>.value { $0.reload }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyFavoriteDetails.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyFavoriteDetails
    {
        return populate(GetTechnologyFavoriteDetails(), map, GetTechnologyFavoriteDetails.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyFavoriteDetails
    {
        return populate(GetTechnologyFavoriteDetails(), json, GetTechnologyFavoriteDetails.typeConfig())
    }
}

extension GetAllTechnologies : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetAllTechnologies>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetAllTechnologies>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetAllTechnologies.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetAllTechnologies
    {
        return populate(GetAllTechnologies(), map, GetAllTechnologies.typeConfig())
    }

    public class func fromJson(json:String) -> GetAllTechnologies
    {
        return populate(GetAllTechnologies(), json, GetAllTechnologies.typeConfig())
    }
}

extension FindTechnologies : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<FindTechnologies>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<FindTechnologies>(
            writers: [
                ("skip", { (x:FindTechnologies, map:NSDictionary) in setOptionalValue(&x.skip, map, "skip") }),
                ("take", { (x:FindTechnologies, map:NSDictionary) in setOptionalValue(&x.take, map, "take") }),
                ("orderBy", { (x:FindTechnologies, map:NSDictionary) in setOptionalValue(&x.orderBy, map, "orderBy") }),
                ("orderByDesc", { (x:FindTechnologies, map:NSDictionary) in setOptionalValue(&x.orderByDesc, map, "orderByDesc") }),
                ("reload", { (x:FindTechnologies, map:NSDictionary) in setOptionalValue(&x.reload, map, "reload") }),
            ],
            readers: [
                ("skip", Type<FindTechnologies>.value { $0.skip }),
                ("take", Type<FindTechnologies>.value { $0.take }),
                ("orderBy", Type<FindTechnologies>.value { $0.orderBy }),
                ("orderByDesc", Type<FindTechnologies>.value { $0.orderByDesc }),
                ("reload", Type<FindTechnologies>.value { $0.reload }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, FindTechnologies.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> FindTechnologies
    {
        return populate(FindTechnologies(), map, FindTechnologies.typeConfig())
    }

    public class func fromJson(json:String) -> FindTechnologies
    {
        return populate(FindTechnologies(), json, FindTechnologies.typeConfig())
    }
}

extension CreateTechnologyStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<CreateTechnologyStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<CreateTechnologyStack>(
            writers: [
                ("name", { (x:CreateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:CreateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("appUrl", { (x:CreateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.appUrl, map, "appUrl") }),
                ("screenshotUrl", { (x:CreateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.screenshotUrl, map, "screenshotUrl") }),
                ("description", { (x:CreateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("details", { (x:CreateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.details, map, "details") }),
                ("isLocked", { (x:CreateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("technologyIds", { (x:CreateTechnologyStack, map:NSDictionary) in setValue(&x.technologyIds, map, "technologyIds") }),
            ],
            readers: [
                ("name", Type<CreateTechnologyStack>.value { $0.name }),
                ("vendorName", Type<CreateTechnologyStack>.value { $0.vendorName }),
                ("appUrl", Type<CreateTechnologyStack>.value { $0.appUrl }),
                ("screenshotUrl", Type<CreateTechnologyStack>.value { $0.screenshotUrl }),
                ("description", Type<CreateTechnologyStack>.value { $0.description }),
                ("details", Type<CreateTechnologyStack>.value { $0.details }),
                ("isLocked", Type<CreateTechnologyStack>.value { $0.isLocked }),
                ("technologyIds", Type<CreateTechnologyStack>.value { $0.technologyIds }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, CreateTechnologyStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> CreateTechnologyStack
    {
        return populate(CreateTechnologyStack(), map, CreateTechnologyStack.typeConfig())
    }

    public class func fromJson(json:String) -> CreateTechnologyStack
    {
        return populate(CreateTechnologyStack(), json, CreateTechnologyStack.typeConfig())
    }
}

extension UpdateTechnologyStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<UpdateTechnologyStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<UpdateTechnologyStack>(
            writers: [
                ("id", { (x:UpdateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:UpdateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("vendorName", { (x:UpdateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.vendorName, map, "vendorName") }),
                ("appUrl", { (x:UpdateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.appUrl, map, "appUrl") }),
                ("screenshotUrl", { (x:UpdateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.screenshotUrl, map, "screenshotUrl") }),
                ("description", { (x:UpdateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.description, map, "description") }),
                ("details", { (x:UpdateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.details, map, "details") }),
                ("isLocked", { (x:UpdateTechnologyStack, map:NSDictionary) in setOptionalValue(&x.isLocked, map, "isLocked") }),
                ("technologyIds", { (x:UpdateTechnologyStack, map:NSDictionary) in setValue(&x.technologyIds, map, "technologyIds") }),
            ],
            readers: [
                ("id", Type<UpdateTechnologyStack>.value { $0.id }),
                ("name", Type<UpdateTechnologyStack>.value { $0.name }),
                ("vendorName", Type<UpdateTechnologyStack>.value { $0.vendorName }),
                ("appUrl", Type<UpdateTechnologyStack>.value { $0.appUrl }),
                ("screenshotUrl", Type<UpdateTechnologyStack>.value { $0.screenshotUrl }),
                ("description", Type<UpdateTechnologyStack>.value { $0.description }),
                ("details", Type<UpdateTechnologyStack>.value { $0.details }),
                ("isLocked", Type<UpdateTechnologyStack>.value { $0.isLocked }),
                ("technologyIds", Type<UpdateTechnologyStack>.value { $0.technologyIds }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, UpdateTechnologyStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> UpdateTechnologyStack
    {
        return populate(UpdateTechnologyStack(), map, UpdateTechnologyStack.typeConfig())
    }

    public class func fromJson(json:String) -> UpdateTechnologyStack
    {
        return populate(UpdateTechnologyStack(), json, UpdateTechnologyStack.typeConfig())
    }
}

extension DeleteTechnologyStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<DeleteTechnologyStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<DeleteTechnologyStack>(
            writers: [
                ("id", { (x:DeleteTechnologyStack, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("id", Type<DeleteTechnologyStack>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, DeleteTechnologyStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> DeleteTechnologyStack
    {
        return populate(DeleteTechnologyStack(), map, DeleteTechnologyStack.typeConfig())
    }

    public class func fromJson(json:String) -> DeleteTechnologyStack
    {
        return populate(DeleteTechnologyStack(), json, DeleteTechnologyStack.typeConfig())
    }
}

extension GetAllTechnologyStacks : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetAllTechnologyStacks>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetAllTechnologyStacks>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetAllTechnologyStacks.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetAllTechnologyStacks
    {
        return populate(GetAllTechnologyStacks(), map, GetAllTechnologyStacks.typeConfig())
    }

    public class func fromJson(json:String) -> GetAllTechnologyStacks
    {
        return populate(GetAllTechnologyStacks(), json, GetAllTechnologyStacks.typeConfig())
    }
}

extension GetTechnologyStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyStack>(
            writers: [
                ("reload", { (x:GetTechnologyStack, map:NSDictionary) in setOptionalValue(&x.reload, map, "reload") }),
                ("slug", { (x:GetTechnologyStack, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("id", { (x:GetTechnologyStack, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("reload", Type<GetTechnologyStack>.value { $0.reload }),
                ("slug", Type<GetTechnologyStack>.value { $0.slug }),
                ("id", Type<GetTechnologyStack>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyStack
    {
        return populate(GetTechnologyStack(), map, GetTechnologyStack.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyStack
    {
        return populate(GetTechnologyStack(), json, GetTechnologyStack.typeConfig())
    }
}

extension GetTechnologyStackPreviousVersions : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyStackPreviousVersions>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyStackPreviousVersions>(
            writers: [
                ("slug", { (x:GetTechnologyStackPreviousVersions, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("id", { (x:GetTechnologyStackPreviousVersions, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("slug", Type<GetTechnologyStackPreviousVersions>.value { $0.slug }),
                ("id", Type<GetTechnologyStackPreviousVersions>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyStackPreviousVersions.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyStackPreviousVersions
    {
        return populate(GetTechnologyStackPreviousVersions(), map, GetTechnologyStackPreviousVersions.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyStackPreviousVersions
    {
        return populate(GetTechnologyStackPreviousVersions(), json, GetTechnologyStackPreviousVersions.typeConfig())
    }
}

extension GetTechnologyStackFavoriteDetails : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetTechnologyStackFavoriteDetails>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetTechnologyStackFavoriteDetails>(
            writers: [
                ("slug", { (x:GetTechnologyStackFavoriteDetails, map:NSDictionary) in setOptionalValue(&x.slug, map, "slug") }),
                ("reload", { (x:GetTechnologyStackFavoriteDetails, map:NSDictionary) in setOptionalValue(&x.reload, map, "reload") }),
            ],
            readers: [
                ("slug", Type<GetTechnologyStackFavoriteDetails>.value { $0.slug }),
                ("reload", Type<GetTechnologyStackFavoriteDetails>.value { $0.reload }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetTechnologyStackFavoriteDetails.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetTechnologyStackFavoriteDetails
    {
        return populate(GetTechnologyStackFavoriteDetails(), map, GetTechnologyStackFavoriteDetails.typeConfig())
    }

    public class func fromJson(json:String) -> GetTechnologyStackFavoriteDetails
    {
        return populate(GetTechnologyStackFavoriteDetails(), json, GetTechnologyStackFavoriteDetails.typeConfig())
    }
}

extension GetConfig : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetConfig>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetConfig>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetConfig.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetConfig
    {
        return populate(GetConfig(), map, GetConfig.typeConfig())
    }

    public class func fromJson(json:String) -> GetConfig
    {
        return populate(GetConfig(), json, GetConfig.typeConfig())
    }
}

extension Overview : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<Overview>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Overview>(
            writers: [
                ("reload", { (x:Overview, map:NSDictionary) in setOptionalValue(&x.reload, map, "reload") }),
            ],
            readers: [
                ("reload", Type<Overview>.value { $0.reload }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, Overview.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> Overview
    {
        return populate(Overview(), map, Overview.typeConfig())
    }

    public class func fromJson(json:String) -> Overview
    {
        return populate(Overview(), json, Overview.typeConfig())
    }
}

extension FindTechStacks : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<FindTechStacks>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<FindTechStacks>(
            writers: [
                ("skip", { (x:FindTechStacks, map:NSDictionary) in setOptionalValue(&x.skip, map, "skip") }),
                ("take", { (x:FindTechStacks, map:NSDictionary) in setOptionalValue(&x.take, map, "take") }),
                ("orderBy", { (x:FindTechStacks, map:NSDictionary) in setOptionalValue(&x.orderBy, map, "orderBy") }),
                ("orderByDesc", { (x:FindTechStacks, map:NSDictionary) in setOptionalValue(&x.orderByDesc, map, "orderByDesc") }),
                ("reload", { (x:FindTechStacks, map:NSDictionary) in setOptionalValue(&x.reload, map, "reload") }),
            ],
            readers: [
                ("skip", Type<FindTechStacks>.value { $0.skip }),
                ("take", Type<FindTechStacks>.value { $0.take }),
                ("orderBy", Type<FindTechStacks>.value { $0.orderBy }),
                ("orderByDesc", Type<FindTechStacks>.value { $0.orderByDesc }),
                ("reload", Type<FindTechStacks>.value { $0.reload }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, FindTechStacks.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> FindTechStacks
    {
        return populate(FindTechStacks(), map, FindTechStacks.typeConfig())
    }

    public class func fromJson(json:String) -> FindTechStacks
    {
        return populate(FindTechStacks(), json, FindTechStacks.typeConfig())
    }
}

extension GetFavoriteTechStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetFavoriteTechStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetFavoriteTechStack>(
            writers: [
                ("technologyStackId", { (x:GetFavoriteTechStack, map:NSDictionary) in setOptionalValue(&x.technologyStackId, map, "technologyStackId") }),
            ],
            readers: [
                ("technologyStackId", Type<GetFavoriteTechStack>.value { $0.technologyStackId }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetFavoriteTechStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetFavoriteTechStack
    {
        return populate(GetFavoriteTechStack(), map, GetFavoriteTechStack.typeConfig())
    }

    public class func fromJson(json:String) -> GetFavoriteTechStack
    {
        return populate(GetFavoriteTechStack(), json, GetFavoriteTechStack.typeConfig())
    }
}

extension AddFavoriteTechStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<AddFavoriteTechStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<AddFavoriteTechStack>(
            writers: [
                ("technologyStackId", { (x:AddFavoriteTechStack, map:NSDictionary) in setOptionalValue(&x.technologyStackId, map, "technologyStackId") }),
            ],
            readers: [
                ("technologyStackId", Type<AddFavoriteTechStack>.value { $0.technologyStackId }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, AddFavoriteTechStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> AddFavoriteTechStack
    {
        return populate(AddFavoriteTechStack(), map, AddFavoriteTechStack.typeConfig())
    }

    public class func fromJson(json:String) -> AddFavoriteTechStack
    {
        return populate(AddFavoriteTechStack(), json, AddFavoriteTechStack.typeConfig())
    }
}

extension RemoveFavoriteTechStack : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<RemoveFavoriteTechStack>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<RemoveFavoriteTechStack>(
            writers: [
                ("technologyStackId", { (x:RemoveFavoriteTechStack, map:NSDictionary) in setOptionalValue(&x.technologyStackId, map, "technologyStackId") }),
            ],
            readers: [
                ("technologyStackId", Type<RemoveFavoriteTechStack>.value { $0.technologyStackId }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, RemoveFavoriteTechStack.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> RemoveFavoriteTechStack
    {
        return populate(RemoveFavoriteTechStack(), map, RemoveFavoriteTechStack.typeConfig())
    }

    public class func fromJson(json:String) -> RemoveFavoriteTechStack
    {
        return populate(RemoveFavoriteTechStack(), json, RemoveFavoriteTechStack.typeConfig())
    }
}

extension GetFavoriteTechnologies : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetFavoriteTechnologies>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetFavoriteTechnologies>(
            writers: [
                ("technologyId", { (x:GetFavoriteTechnologies, map:NSDictionary) in setOptionalValue(&x.technologyId, map, "technologyId") }),
            ],
            readers: [
                ("technologyId", Type<GetFavoriteTechnologies>.value { $0.technologyId }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetFavoriteTechnologies.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetFavoriteTechnologies
    {
        return populate(GetFavoriteTechnologies(), map, GetFavoriteTechnologies.typeConfig())
    }

    public class func fromJson(json:String) -> GetFavoriteTechnologies
    {
        return populate(GetFavoriteTechnologies(), json, GetFavoriteTechnologies.typeConfig())
    }
}

extension AddFavoriteTechnology : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<AddFavoriteTechnology>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<AddFavoriteTechnology>(
            writers: [
                ("technologyId", { (x:AddFavoriteTechnology, map:NSDictionary) in setOptionalValue(&x.technologyId, map, "technologyId") }),
            ],
            readers: [
                ("technologyId", Type<AddFavoriteTechnology>.value { $0.technologyId }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, AddFavoriteTechnology.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> AddFavoriteTechnology
    {
        return populate(AddFavoriteTechnology(), map, AddFavoriteTechnology.typeConfig())
    }

    public class func fromJson(json:String) -> AddFavoriteTechnology
    {
        return populate(AddFavoriteTechnology(), json, AddFavoriteTechnology.typeConfig())
    }
}

extension RemoveFavoriteTechnology : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<RemoveFavoriteTechnology>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<RemoveFavoriteTechnology>(
            writers: [
                ("technologyId", { (x:RemoveFavoriteTechnology, map:NSDictionary) in setOptionalValue(&x.technologyId, map, "technologyId") }),
            ],
            readers: [
                ("technologyId", Type<RemoveFavoriteTechnology>.value { $0.technologyId }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, RemoveFavoriteTechnology.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> RemoveFavoriteTechnology
    {
        return populate(RemoveFavoriteTechnology(), map, RemoveFavoriteTechnology.typeConfig())
    }

    public class func fromJson(json:String) -> RemoveFavoriteTechnology
    {
        return populate(RemoveFavoriteTechnology(), json, RemoveFavoriteTechnology.typeConfig())
    }
}

extension GetUserFeed : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetUserFeed>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetUserFeed>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetUserFeed.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetUserFeed
    {
        return populate(GetUserFeed(), map, GetUserFeed.typeConfig())
    }

    public class func fromJson(json:String) -> GetUserFeed
    {
        return populate(GetUserFeed(), json, GetUserFeed.typeConfig())
    }
}

extension GetUserInfo : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetUserInfo>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetUserInfo>(
            writers: [
                ("reload", { (x:GetUserInfo, map:NSDictionary) in setOptionalValue(&x.reload, map, "reload") }),
                ("userName", { (x:GetUserInfo, map:NSDictionary) in setOptionalValue(&x.userName, map, "userName") }),
            ],
            readers: [
                ("reload", Type<GetUserInfo>.value { $0.reload }),
                ("userName", Type<GetUserInfo>.value { $0.userName }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetUserInfo.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetUserInfo
    {
        return populate(GetUserInfo(), map, GetUserInfo.typeConfig())
    }

    public class func fromJson(json:String) -> GetUserInfo
    {
        return populate(GetUserInfo(), json, GetUserInfo.typeConfig())
    }
}
    
#endif

/* Options:
Date: 2024-11-23 07:25:42
SwiftVersion: 5.0
Version: 8.41
Tip: To override a DTO option, remove "//" prefix before updating
BaseUrl: https://techstacks.io

//BaseClass: 
//AddModelExtensions: True
//AddServiceStackTypes: True
//MakePropertiesOptional: True
//IncludeTypes: 
ExcludeTypes: Hello,HelloResponse,Authenticate,AuthenticateResponse,AssignRoles,AssignRolesResponse,UnAssignRoles,UnAssignRolesResponse,Ping,ConvertSessionToToken,GetAccessToken
//ExcludeGenericBaseTypes: False
//AddResponseStatus: False
//AddImplicitVersion: 
//AddDescriptionAsComments: True
//InitializeCollections: True
//TreatTypesAsStrings: 
//DefaultImports: Foundation,ServiceStack
*/

import Foundation
import ServiceStack

// @Route("/orgs/{Id}", "GET")
public class GetOrganization : IReturn, IGet, Codable
{
    public typealias Return = GetOrganizationResponse

    public var id:Int?

    required public init(){}
}

// @Route("/organizations/{Slug}", "GET")
public class GetOrganizationBySlug : IReturn, IGet, Codable
{
    public typealias Return = GetOrganizationResponse

    public var slug:String?

    required public init(){}
}

// @Route("/orgs/{Id}/members", "GET")
public class GetOrganizationMembers : IReturn, IGet, Codable
{
    public typealias Return = GetOrganizationMembersResponse

    public var id:Int?

    required public init(){}
}

// @Route("/orgs/{Id}/admin", "GET")
public class GetOrganizationAdmin : IReturn, IGet, Codable
{
    public typealias Return = GetOrganizationAdminResponse

    public var id:Int?

    required public init(){}
}

// @Route("/orgs/posts/new", "POST")
public class CreateOrganizationForTechnology : IReturn, IPost, Codable
{
    public typealias Return = CreateOrganizationForTechnologyResponse

    public var technologyId:Int?
    public var techStackId:Int?

    required public init(){}
}

// @Route("/orgs", "POST")
public class CreateOrganization : IReturn, IPost, Codable
{
    public typealias Return = CreateOrganizationResponse

    public var name:String?
    public var slug:String?
    public var Description:String?
    public var refId:Int?
    public var refSource:String?
    public var refUrn:String?

    required public init(){}
}

// @Route("/orgs/{Id}", "PUT")
public class UpdateOrganization : IReturn, IPut, Codable
{
    public typealias Return = UpdateOrganizationResponse

    public var id:Int?
    public var slug:String?
    public var name:String?
    public var Description:String?
    public var color:String?
    public var textColor:String?
    public var linkColor:String?
    public var backgroundColor:String?
    public var backgroundUrl:String?
    public var logoUrl:String?
    public var heroUrl:String?
    public var lang:String?
    public var deletePostsWithReportCount:Int?
    public var disableInvites:Bool?
    public var defaultPostType:String?
    public var defaultSubscriptionPostTypes:[String] = []
    public var postTypes:[String] = []
    public var moderatorPostTypes:[String] = []
    public var technologyIds:[Int] = []

    required public init(){}
}

// @Route("/orgs/{Id}", "DELETE")
public class DeleteOrganization : IReturnVoid, IDelete, Codable
{
    public var id:Int?

    required public init(){}
}

// @Route("/orgs/{Id}/lock", "PUT")
public class LockOrganization : IReturnVoid, IPut, Codable
{
    public var id:Int?
    public var lock:Bool?
    public var reason:String?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/labels", "POST")
public class AddOrganizationLabel : IReturn, IPost, Codable
{
    public typealias Return = OrganizationLabelResponse

    public var organizationId:Int?
    public var slug:String?
    public var Description:String?
    public var color:String?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/members/{Slug}", "PUT")
public class UpdateOrganizationLabel : IReturn, IPut, Codable
{
    public typealias Return = OrganizationLabelResponse

    public var organizationId:Int?
    public var slug:String?
    public var Description:String?
    public var color:String?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/labels/{Slug}", "DELETE")
public class RemoveOrganizationLabel : IReturnVoid, IDelete, Codable
{
    public var organizationId:Int?
    public var slug:String?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/categories", "POST")
public class AddOrganizationCategory : IReturn, IPost, Codable
{
    public typealias Return = AddOrganizationCategoryResponse

    public var organizationId:Int?
    public var slug:String?
    public var name:String?
    public var Description:String?
    public var technologyIds:[Int] = []

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/categories/{Id}", "PUT")
public class UpdateOrganizationCategory : IReturn, IPut, Codable
{
    public typealias Return = UpdateOrganizationCategoryResponse

    public var organizationId:Int?
    public var id:Int?
    public var name:String?
    public var slug:String?
    public var Description:String?
    public var technologyIds:[Int] = []

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/categories/{Id}", "DELETE")
public class DeleteOrganizationCategory : IReturnVoid, IDelete, Codable
{
    public var organizationId:Int?
    public var id:Int?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/members", "POST")
public class AddOrganizationMember : IReturn, IPost, Codable
{
    public typealias Return = AddOrganizationMemberResponse

    public var organizationId:Int?
    public var userName:String?
    public var isOwner:Bool?
    public var isModerator:Bool?
    public var denyPosts:Bool?
    public var denyComments:Bool?
    public var denyAll:Bool?
    public var notes:String?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/members/{Id}", "PUT")
public class UpdateOrganizationMember : IReturn, IPut, Codable
{
    public typealias Return = UpdateOrganizationMemberResponse

    public var organizationId:Int?
    public var userId:Int?
    public var isOwner:Bool?
    public var isModerator:Bool?
    public var denyPosts:Bool?
    public var denyComments:Bool?
    public var denyAll:Bool?
    public var notes:String?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/members/{UserId}", "DELETE")
public class RemoveOrganizationMember : IReturnVoid, IDelete, Codable
{
    public var organizationId:Int?
    public var userId:Int?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/members/set", "POST")
public class SetOrganizationMembers : IReturn, IPost, Codable
{
    public typealias Return = SetOrganizationMembersResponse

    public var organizationId:Int?
    public var githubUserNames:[String] = []
    public var twitterUserNames:[String] = []
    public var emails:[String] = []
    public var removeUnspecifiedMembers:Bool?
    public var isOwner:Bool?
    public var isModerator:Bool?
    public var denyPosts:Bool?
    public var denyComments:Bool?
    public var denyAll:Bool?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/invites", "GET")
public class GetOrganizationMemberInvites : IReturn, IGet, Codable
{
    public typealias Return = GetOrganizationMemberInvitesResponse

    public var organizationId:Int?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/invites", "POST")
public class RequestOrganizationMemberInvite : IReturn, IPost, Codable
{
    public typealias Return = RequestOrganizationMemberInviteResponse

    public var organizationId:Int?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/invites/{UserId}", "PUT")
public class UpdateOrganizationMemberInvite : IReturn, IPut, Codable
{
    public typealias Return = UpdateOrganizationMemberInviteResponse

    public var organizationId:Int?
    public var userName:String?
    public var approve:Bool?
    public var dismiss:Bool?

    required public init(){}
}

// @Route("/posts", "GET")
public class QueryPosts : QueryDb<Post>, IReturn
{
    public typealias Return = QueryResponse<Post>

    public var ids:[Int] = []
    public var organizationId:Int?
    public var organizationIds:[Int]?
    public var types:[String]?
    public var anyTechnologyIds:[Int]?
    public var `is`:[String] = []

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case ids
        case organizationId
        case organizationIds
        case types
        case anyTechnologyIds
        case `is`
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ids = try container.decodeIfPresent([Int].self, forKey: .ids) ?? []
        organizationId = try container.decodeIfPresent(Int.self, forKey: .organizationId)
        organizationIds = try container.decodeIfPresent([Int].self, forKey: .organizationIds) ?? []
        types = try container.decodeIfPresent([String].self, forKey: .types) ?? []
        anyTechnologyIds = try container.decodeIfPresent([Int].self, forKey: .anyTechnologyIds) ?? []
        `is` = try container.decodeIfPresent([String].self, forKey: .`is`) ?? []
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if ids.count > 0 { try container.encode(ids, forKey: .ids) }
        if organizationId != nil { try container.encode(organizationId, forKey: .organizationId) }
        if organizationIds != nil && organizationIds!.count > 0 { try container.encode(organizationIds, forKey: .organizationIds) }
        if types != nil && types!.count > 0 { try container.encode(types, forKey: .types) }
        if anyTechnologyIds != nil && anyTechnologyIds!.count > 0 { try container.encode(anyTechnologyIds, forKey: .anyTechnologyIds) }
        if `is`.count > 0 { try container.encode(`is`, forKey: .`is`) }
    }
}

// @Route("/posts/{Id}", "GET")
public class GetPost : IReturn, IGet, Codable
{
    public typealias Return = GetPostResponse

    public var id:Int?
    public var include:String?

    required public init(){}
}

// @Route("/posts", "POST")
public class CreatePost : IReturn, IPost, Codable
{
    public typealias Return = CreatePostResponse

    public var organizationId:Int?
    public var type:PostType?
    public var categoryId:Int?
    public var title:String?
    public var url:String?
    public var imageUrl:String?
    public var content:String?
    public var lock:Bool?
    public var technologyIds:[Int] = []
    public var labels:[String] = []
    public var fromDate:Date?
    public var toDate:Date?
    public var metaType:String?
    public var meta:String?
    public var refId:Int?
    public var refSource:String?
    public var refUrn:String?

    required public init(){}
}

// @Route("/posts/{Id}", "PUT")
public class UpdatePost : IReturn, IPut, Codable
{
    public typealias Return = UpdatePostResponse

    public var id:Int?
    public var organizationId:Int?
    public var type:PostType?
    public var categoryId:Int?
    public var title:String?
    public var url:String?
    public var imageUrl:String?
    public var content:String?
    public var lock:Bool?
    public var technologyIds:[Int] = []
    public var labels:[String] = []
    public var fromDate:Date?
    public var toDate:Date?
    public var metaType:String?
    public var meta:String?

    required public init(){}
}

// @Route("/posts/{Id}", "DELETE")
public class DeletePost : IReturn, IDelete, Codable
{
    public typealias Return = DeletePostResponse

    public var id:Int?

    required public init(){}
}

// @Route("/posts/{Id}/lock", "PUT")
public class LockPost : IReturnVoid, IPut, Codable
{
    public var id:Int?
    public var lock:Bool?
    public var reason:String?

    required public init(){}
}

// @Route("/posts/{Id}/hide", "PUT")
public class HidePost : IReturnVoid, IPut, Codable
{
    public var id:Int?
    public var hide:Bool?
    public var reason:String?

    required public init(){}
}

// @Route("/posts/{Id}/status/{Status}", "PUT")
public class ChangeStatusPost : IReturnVoid, IPut, Codable
{
    public var id:Int?
    public var status:String?
    public var reason:String?

    required public init(){}
}

// @Route("/posts/{PostId}/report/{Id}", "POST")
public class ActionPostReport : IReturnVoid, IPost, Codable
{
    public var postId:Int?
    public var id:Int?
    public var reportAction:ReportAction?

    required public init(){}
}

// @Route("/posts/{PostId}/comments", "POST")
public class CreatePostComment : IReturn, IPost, Codable
{
    public typealias Return = CreatePostCommentResponse

    public var postId:Int?
    public var replyId:Int?
    public var content:String?

    required public init(){}
}

// @Route("/posts/{PostId}/comments/{Id}", "PUT")
public class UpdatePostComment : IReturn, IPut, Codable
{
    public typealias Return = UpdatePostCommentResponse

    public var id:Int?
    public var postId:Int?
    public var content:String?

    required public init(){}
}

// @Route("/posts/{PostId}/comments/{Id}", "DELETE")
public class DeletePostComment : IReturn, IDelete, Codable
{
    public typealias Return = DeletePostCommentResponse

    public var id:Int?
    public var postId:Int?

    required public init(){}
}

// @Route("/posts/{PostId}/comments/{PostCommentId}/report/{Id}", "POST")
public class ActionPostCommentReport : IReturnVoid, IPost, Codable
{
    public var id:Int?
    public var postCommentId:Int?
    public var postId:Int?
    public var reportAction:ReportAction?

    required public init(){}
}

// @Route("/user/comments/votes")
public class GetUserPostCommentVotes : IReturn, IGet, Codable
{
    public typealias Return = GetUserPostCommentVotesResponse

    public var postId:Int?

    required public init(){}
}

// @Route("/posts/{PostId}/comments/{Id}/pin", "PUT")
public class PinPostComment : IReturn, IPut, Codable
{
    public typealias Return = PinPostCommentResponse

    public var id:Int?
    public var postId:Int?
    public var pin:Bool?

    required public init(){}
}

// @Route("/users/by-email")
public class GetUsersByEmails : IReturn, IGet, Codable
{
    public typealias Return = GetUsersByEmailsResponse

    public var emails:[String] = []

    required public init(){}
}

// @Route("/user/posts/activity")
public class GetUserPostActivity : IReturn, IGet, Codable
{
    public typealias Return = GetUserPostActivityResponse

    required public init(){}
}

// @Route("/user/organizations")
public class GetUserOrganizations : IReturn, IGet, Codable
{
    public typealias Return = GetUserOrganizationsResponse

    required public init(){}
}

// @Route("/posts/{Id}/vote", "PUT")
public class UserPostVote : IReturn, IPut, Codable
{
    public typealias Return = UserPostVoteResponse

    public var id:Int?
    public var weight:Int?

    required public init(){}
}

// @Route("/posts/{Id}/favorite", "PUT")
public class UserPostFavorite : IReturn, IPut, Codable
{
    public typealias Return = UserPostFavoriteResponse

    public var id:Int?

    required public init(){}
}

// @Route("/posts/{Id}/report", "PUT")
public class UserPostReport : IReturn, IPut, Codable
{
    public typealias Return = UserPostReportResponse

    public var id:Int?
    public var flagType:FlagType?
    public var reportNotes:String?

    required public init(){}
}

// @Route("/posts/{PostId}/comments/{Id}", "GET")
public class UserPostCommentVote : IReturn, IGet, Codable
{
    public typealias Return = UserPostCommentVoteResponse

    public var id:Int?
    public var postId:Int?
    public var weight:Int?

    required public init(){}
}

// @Route("/posts/{PostId}/comments/{Id}/report", "PUT")
public class UserPostCommentReport : IReturn, IPut, Codable
{
    public typealias Return = UserPostCommentReportResponse

    public var id:Int?
    public var postId:Int?
    public var flagType:FlagType?
    public var reportNotes:String?

    required public init(){}
}

// @Route("/prerender/{**Path}", "PUT")
public class StorePreRender : IReturnVoid, IPut, Codable
{
    public var path:String?
    public var requestStream:Data?

    required public init(){}
}

// @Route("/prerender/{**Path}", "GET")
public class GetPreRender : IReturn, IGet, Codable
{
    public typealias Return = String

    public var path:String?

    required public init(){}
}

// @Route("/my-session")
// @ValidateRequest(Validator="IsAuthenticated")
public class SessionInfo : IReturn, IGet, Codable
{
    public typealias Return = SessionInfoResponse

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/subscribe", "PUT")
public class SubscribeToOrganization : IReturnVoid, IPut, Codable
{
    public var organizationId:Int?
    public var postTypes:[PostType] = []
    public var frequency:Frequency?

    required public init(){}
}

// @Route("/posts/{PostId}/subscribe", "PUT")
public class SubscribeToPost : IReturnVoid, IPut, Codable
{
    public var postId:Int?

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/subscribe", "DELETE")
public class DeleteOrganizationSubscription : IReturnVoid, IDelete, Codable
{
    public var organizationId:Int?

    required public init(){}
}

// @Route("/posts/{PostId}/subscribe", "DELETE")
public class DeletePostSubscription : IReturnVoid, IDelete, Codable
{
    public var postId:Int?

    required public init(){}
}

// @Route("/technology/{Slug}/previous-versions", "GET")
public class GetTechnologyPreviousVersions : IReturn, IGet, Codable
{
    public typealias Return = GetTechnologyPreviousVersionsResponse

    public var slug:String?

    required public init(){}
}

// @Route("/technology", "GET")
public class GetAllTechnologies : IReturn, IGet, Codable
{
    public typealias Return = GetAllTechnologiesResponse

    required public init(){}
}

// @Route("/technology/search")
// @AutoQueryViewer(DefaultSearchField="Tier", DefaultSearchText="Data", DefaultSearchType="=", Description="Explore different Technologies", IconUrl="octicon:database", Title="Find Technologies")
public class FindTechnologies : QueryDb2<Technology, TechnologyView>, IReturn
{
    public typealias Return = QueryResponse<TechnologyView>

    public var ids:[Int]?
    public var name:String?
    public var vendorName:String?
    public var nameContains:String?
    public var vendorNameContains:String?
    public var descriptionContains:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case ids
        case name
        case vendorName
        case nameContains
        case vendorNameContains
        case descriptionContains
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ids = try container.decodeIfPresent([Int].self, forKey: .ids) ?? []
        name = try container.decodeIfPresent(String.self, forKey: .name)
        vendorName = try container.decodeIfPresent(String.self, forKey: .vendorName)
        nameContains = try container.decodeIfPresent(String.self, forKey: .nameContains)
        vendorNameContains = try container.decodeIfPresent(String.self, forKey: .vendorNameContains)
        descriptionContains = try container.decodeIfPresent(String.self, forKey: .descriptionContains)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if ids != nil && ids!.count > 0 { try container.encode(ids, forKey: .ids) }
        if name != nil { try container.encode(name, forKey: .name) }
        if vendorName != nil { try container.encode(vendorName, forKey: .vendorName) }
        if nameContains != nil { try container.encode(nameContains, forKey: .nameContains) }
        if vendorNameContains != nil { try container.encode(vendorNameContains, forKey: .vendorNameContains) }
        if descriptionContains != nil { try container.encode(descriptionContains, forKey: .descriptionContains) }
    }
}

// @Route("/technology/query")
public class QueryTechnology : QueryDb2<Technology, TechnologyView>, IReturn
{
    public typealias Return = QueryResponse<TechnologyView>

    public var ids:[Int]?
    public var name:String?
    public var vendorName:String?
    public var nameContains:String?
    public var vendorNameContains:String?
    public var descriptionContains:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case ids
        case name
        case vendorName
        case nameContains
        case vendorNameContains
        case descriptionContains
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ids = try container.decodeIfPresent([Int].self, forKey: .ids) ?? []
        name = try container.decodeIfPresent(String.self, forKey: .name)
        vendorName = try container.decodeIfPresent(String.self, forKey: .vendorName)
        nameContains = try container.decodeIfPresent(String.self, forKey: .nameContains)
        vendorNameContains = try container.decodeIfPresent(String.self, forKey: .vendorNameContains)
        descriptionContains = try container.decodeIfPresent(String.self, forKey: .descriptionContains)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if ids != nil && ids!.count > 0 { try container.encode(ids, forKey: .ids) }
        if name != nil { try container.encode(name, forKey: .name) }
        if vendorName != nil { try container.encode(vendorName, forKey: .vendorName) }
        if nameContains != nil { try container.encode(nameContains, forKey: .nameContains) }
        if vendorNameContains != nil { try container.encode(vendorNameContains, forKey: .vendorNameContains) }
        if descriptionContains != nil { try container.encode(descriptionContains, forKey: .descriptionContains) }
    }
}

// @Route("/technology/{Slug}")
public class GetTechnology : IReturn, IRegisterStats, IGet, Codable
{
    public typealias Return = GetTechnologyResponse

    public var slug:String?

    required public init(){}
}

// @Route("/technology/{Slug}/favorites")
public class GetTechnologyFavoriteDetails : IReturn, IGet, Codable
{
    public typealias Return = GetTechnologyFavoriteDetailsResponse

    public var slug:String?

    required public init(){}
}

// @Route("/technology", "POST")
public class CreateTechnology : IReturn, IPost, Codable
{
    public typealias Return = CreateTechnologyResponse

    public var name:String?
    public var slug:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var Description:String?
    public var isLocked:Bool?
    public var tier:TechnologyTier?

    required public init(){}
}

// @Route("/technology/{Id}", "PUT")
public class UpdateTechnology : IReturn, IPut, Codable
{
    public typealias Return = UpdateTechnologyResponse

    public var id:Int?
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var Description:String?
    public var isLocked:Bool?
    public var tier:TechnologyTier?

    required public init(){}
}

// @Route("/technology/{Id}", "DELETE")
public class DeleteTechnology : IReturn, IDelete, Codable
{
    public typealias Return = DeleteTechnologyResponse

    public var id:Int?

    required public init(){}
}

// @Route("/techstacks/{Slug}/previous-versions", "GET")
public class GetTechnologyStackPreviousVersions : IReturn, IGet, Codable
{
    public typealias Return = GetTechnologyStackPreviousVersionsResponse

    public var slug:String?

    required public init(){}
}

// @Route("/pagestats/{Type}/{Slug}")
public class GetPageStats : IReturn, IGet, Codable
{
    public typealias Return = GetPageStatsResponse

    public var type:String?
    public var slug:String?
    public var id:Int?

    required public init(){}
}

// @Route("/techstacks/search")
// @AutoQueryViewer(DefaultSearchField="Description", DefaultSearchText="ServiceStack", DefaultSearchType="Contains", Description="Explore different Technology Stacks", IconUrl="material-icons:cloud", Title="Find Technology Stacks")
public class FindTechStacks : QueryDb2<TechnologyStack, TechnologyStackView>, IReturn
{
    public typealias Return = QueryResponse<TechnologyStackView>

    public var ids:[Int]?
    public var name:String?
    public var vendorName:String?
    public var nameContains:String?
    public var vendorNameContains:String?
    public var descriptionContains:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case ids
        case name
        case vendorName
        case nameContains
        case vendorNameContains
        case descriptionContains
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ids = try container.decodeIfPresent([Int].self, forKey: .ids) ?? []
        name = try container.decodeIfPresent(String.self, forKey: .name)
        vendorName = try container.decodeIfPresent(String.self, forKey: .vendorName)
        nameContains = try container.decodeIfPresent(String.self, forKey: .nameContains)
        vendorNameContains = try container.decodeIfPresent(String.self, forKey: .vendorNameContains)
        descriptionContains = try container.decodeIfPresent(String.self, forKey: .descriptionContains)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if ids != nil && ids!.count > 0 { try container.encode(ids, forKey: .ids) }
        if name != nil { try container.encode(name, forKey: .name) }
        if vendorName != nil { try container.encode(vendorName, forKey: .vendorName) }
        if nameContains != nil { try container.encode(nameContains, forKey: .nameContains) }
        if vendorNameContains != nil { try container.encode(vendorNameContains, forKey: .vendorNameContains) }
        if descriptionContains != nil { try container.encode(descriptionContains, forKey: .descriptionContains) }
    }
}

// @Route("/techstacks/query")
public class QueryTechStacks : QueryDb2<TechnologyStack, TechnologyStackView>, IReturn
{
    public typealias Return = QueryResponse<TechnologyStackView>

    public var ids:[Int]?
    public var name:String?
    public var vendorName:String?
    public var nameContains:String?
    public var vendorNameContains:String?
    public var descriptionContains:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case ids
        case name
        case vendorName
        case nameContains
        case vendorNameContains
        case descriptionContains
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        ids = try container.decodeIfPresent([Int].self, forKey: .ids) ?? []
        name = try container.decodeIfPresent(String.self, forKey: .name)
        vendorName = try container.decodeIfPresent(String.self, forKey: .vendorName)
        nameContains = try container.decodeIfPresent(String.self, forKey: .nameContains)
        vendorNameContains = try container.decodeIfPresent(String.self, forKey: .vendorNameContains)
        descriptionContains = try container.decodeIfPresent(String.self, forKey: .descriptionContains)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if ids != nil && ids!.count > 0 { try container.encode(ids, forKey: .ids) }
        if name != nil { try container.encode(name, forKey: .name) }
        if vendorName != nil { try container.encode(vendorName, forKey: .vendorName) }
        if nameContains != nil { try container.encode(nameContains, forKey: .nameContains) }
        if vendorNameContains != nil { try container.encode(vendorNameContains, forKey: .vendorNameContains) }
        if descriptionContains != nil { try container.encode(descriptionContains, forKey: .descriptionContains) }
    }
}

// @Route("/overview")
public class Overview : IReturn, IGet, Codable
{
    public typealias Return = OverviewResponse

    public var reload:Bool?

    required public init(){}
}

// @Route("/app-overview")
public class AppOverview : IReturn, IGet, Codable
{
    public typealias Return = AppOverviewResponse

    public var reload:Bool?

    required public init(){}
}

// @Route("/techstacks", "GET")
public class GetAllTechnologyStacks : IReturn, IGet, Codable
{
    public typealias Return = GetAllTechnologyStacksResponse

    required public init(){}
}

// @Route("/techstacks/{Slug}", "GET")
public class GetTechnologyStack : IReturn, IRegisterStats, IGet, Codable
{
    public typealias Return = GetTechnologyStackResponse

    public var slug:String?

    required public init(){}
}

// @Route("/techstacks/{Slug}/favorites")
public class GetTechnologyStackFavoriteDetails : IReturn, IGet, Codable
{
    public typealias Return = GetTechnologyStackFavoriteDetailsResponse

    public var slug:String?

    required public init(){}
}

// @Route("/config")
public class GetConfig : IReturn, IGet, Codable
{
    public typealias Return = GetConfigResponse

    required public init(){}
}

// @Route("/techstacks", "POST")
public class CreateTechnologyStack : IReturn, IPost, Codable
{
    public typealias Return = CreateTechnologyStackResponse

    public var name:String?
    public var slug:String?
    public var vendorName:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var Description:String?
    public var details:String?
    public var isLocked:Bool?
    public var technologyIds:[Int] = []

    required public init(){}
}

// @Route("/techstacks/{Id}", "PUT")
public class UpdateTechnologyStack : IReturn, IPut, Codable
{
    public typealias Return = UpdateTechnologyStackResponse

    public var id:Int?
    public var name:String?
    public var vendorName:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var Description:String?
    public var details:String?
    public var isLocked:Bool?
    public var technologyIds:[Int] = []

    required public init(){}
}

// @Route("/techstacks/{Id}", "DELETE")
public class DeleteTechnologyStack : IReturn, IDelete, Codable
{
    public typealias Return = DeleteTechnologyStackResponse

    public var id:Int?

    required public init(){}
}

// @Route("/favorites/techtacks", "GET")
public class GetFavoriteTechStack : IReturn, IGet, Codable
{
    public typealias Return = GetFavoriteTechStackResponse

    public var technologyStackId:Int?

    required public init(){}
}

// @Route("/favorites/techtacks/{TechnologyStackId}", "PUT")
public class AddFavoriteTechStack : IReturn, IPut, Codable
{
    public typealias Return = FavoriteTechStackResponse

    public var technologyStackId:Int?

    required public init(){}
}

// @Route("/favorites/techtacks/{TechnologyStackId}", "DELETE")
public class RemoveFavoriteTechStack : IReturn, IDelete, Codable
{
    public typealias Return = FavoriteTechStackResponse

    public var technologyStackId:Int?

    required public init(){}
}

// @Route("/favorites/technology", "GET")
public class GetFavoriteTechnologies : IReturn, IGet, Codable
{
    public typealias Return = GetFavoriteTechnologiesResponse

    public var technologyId:Int?

    required public init(){}
}

// @Route("/favorites/technology/{TechnologyId}", "PUT")
public class AddFavoriteTechnology : IReturn, IPut, Codable
{
    public typealias Return = FavoriteTechnologyResponse

    public var technologyId:Int?

    required public init(){}
}

// @Route("/favorites/technology/{TechnologyId}", "DELETE")
public class RemoveFavoriteTechnology : IReturn, IDelete, Codable
{
    public typealias Return = FavoriteTechnologyResponse

    public var technologyId:Int?

    required public init(){}
}

// @Route("/my-feed")
// @ValidateRequest(Validator="IsAuthenticated")
public class GetUserFeed : IReturn, IGet, Codable
{
    public typealias Return = GetUserFeedResponse

    required public init(){}
}

// @Route("/users/karma", "GET")
public class GetUsersKarma : IReturn, IGet, Codable
{
    public typealias Return = GetUsersKarmaResponse

    public var userIds:[Int] = []

    required public init(){}
}

// @Route("/userinfo/{Id}")
public class GetUserInfo : IReturn, IGet, Codable
{
    public typealias Return = GetUserInfoResponse

    public var id:Int?
    public var userName:String?

    required public init(){}
}

// @Route("/users/{UserId}/avatar", "GET")
public class UserAvatar : IGet, Codable
{
    public var userId:Int?

    required public init(){}
}

// @Route("/mq/start")
public class MqStart : IReturn, Codable
{
    public typealias Return = String

    required public init(){}
}

// @Route("/mq/stop")
public class MqStop : IReturn, Codable
{
    public typealias Return = String

    required public init(){}
}

// @Route("/mq/stats")
public class MqStats : IReturn, Codable
{
    public typealias Return = String

    required public init(){}
}

// @Route("/mq/status")
public class MqStatus : IReturn, Codable
{
    public typealias Return = String

    required public init(){}
}

// @Route("/admin/technology/{TechnologyId}/logo")
public class LogoUrlApproval : IReturn, IPut, Codable
{
    public typealias Return = LogoUrlApprovalResponse

    public var technologyId:Int?
    public var approved:Bool?

    required public init(){}
}

/**
* Limit updates to TechStack to Owner or Admin users
*/
// @Route("/admin/techstacks/{TechnologyStackId}/lock")
public class LockTechStack : IReturn, IPut, Codable
{
    public typealias Return = LockStackResponse

    // @Validate(Validator="GreaterThan(0)")
    public var technologyStackId:Int?

    public var isLocked:Bool?

    required public init(){}
}

/**
* Limit updates to Technology to Owner or Admin users
*/
// @Route("/admin/technology/{TechnologyId}/lock")
// @Api(Description="Limit updates to Technology to Owner or Admin users")
public class LockTech : IReturn, IPut, Codable
{
    public typealias Return = LockStackResponse

    // @Validate(Validator="GreaterThan(0)")
    public var technologyId:Int?

    public var isLocked:Bool?

    required public init(){}
}

public class DummyTypes : Codable
{
    public var post:[Post] = []

    required public init(){}
}

// @Route("/email/post/{PostId}")
// @ValidateRequest(Validator="IsAdmin")
public class EmailTest : IReturn, Codable
{
    public typealias Return = EmailTestResponse

    public var postId:Int?

    required public init(){}
}

// @Route("/posts/comment", "GET")
public class QueryPostComments : QueryDb<PostComment>, IReturn
{
    public typealias Return = QueryResponse<PostComment>

    public var id:Int?
    public var userId:Int?
    public var postId:Int?
    public var contentContains:String?
    public var upVotesAbove:Int?
    public var upVotesBelow:Int?
    public var downVotesAbove:Int?
    public var downVotes:Int?
    public var favoritesAbove:Int?
    public var favoritesBelow:Int?
    public var wordCountAbove:Int?
    public var wordCountBelow:Int?
    public var reportCountAbove:Int?
    public var reportCountBelow:Int?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case id
        case userId
        case postId
        case contentContains
        case upVotesAbove
        case upVotesBelow
        case downVotesAbove
        case downVotes
        case favoritesAbove
        case favoritesBelow
        case wordCountAbove
        case wordCountBelow
        case reportCountAbove
        case reportCountBelow
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        postId = try container.decodeIfPresent(Int.self, forKey: .postId)
        contentContains = try container.decodeIfPresent(String.self, forKey: .contentContains)
        upVotesAbove = try container.decodeIfPresent(Int.self, forKey: .upVotesAbove)
        upVotesBelow = try container.decodeIfPresent(Int.self, forKey: .upVotesBelow)
        downVotesAbove = try container.decodeIfPresent(Int.self, forKey: .downVotesAbove)
        downVotes = try container.decodeIfPresent(Int.self, forKey: .downVotes)
        favoritesAbove = try container.decodeIfPresent(Int.self, forKey: .favoritesAbove)
        favoritesBelow = try container.decodeIfPresent(Int.self, forKey: .favoritesBelow)
        wordCountAbove = try container.decodeIfPresent(Int.self, forKey: .wordCountAbove)
        wordCountBelow = try container.decodeIfPresent(Int.self, forKey: .wordCountBelow)
        reportCountAbove = try container.decodeIfPresent(Int.self, forKey: .reportCountAbove)
        reportCountBelow = try container.decodeIfPresent(Int.self, forKey: .reportCountBelow)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try container.encode(id, forKey: .id) }
        if userId != nil { try container.encode(userId, forKey: .userId) }
        if postId != nil { try container.encode(postId, forKey: .postId) }
        if contentContains != nil { try container.encode(contentContains, forKey: .contentContains) }
        if upVotesAbove != nil { try container.encode(upVotesAbove, forKey: .upVotesAbove) }
        if upVotesBelow != nil { try container.encode(upVotesBelow, forKey: .upVotesBelow) }
        if downVotesAbove != nil { try container.encode(downVotesAbove, forKey: .downVotesAbove) }
        if downVotes != nil { try container.encode(downVotes, forKey: .downVotes) }
        if favoritesAbove != nil { try container.encode(favoritesAbove, forKey: .favoritesAbove) }
        if favoritesBelow != nil { try container.encode(favoritesBelow, forKey: .favoritesBelow) }
        if wordCountAbove != nil { try container.encode(wordCountAbove, forKey: .wordCountAbove) }
        if wordCountBelow != nil { try container.encode(wordCountBelow, forKey: .wordCountBelow) }
        if reportCountAbove != nil { try container.encode(reportCountAbove, forKey: .reportCountAbove) }
        if reportCountBelow != nil { try container.encode(reportCountBelow, forKey: .reportCountBelow) }
    }
}

public class GetOrganizationResponse : Codable
{
    public var cache:Int?
    public var id:Int?
    public var slug:String?
    public var organization:Organization?
    public var labels:[OrganizationLabel] = []
    public var categories:[Category] = []
    public var owners:[OrganizationMember] = []
    public var moderators:[OrganizationMember] = []
    public var membersCount:Int?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetOrganizationMembersResponse : Codable
{
    public var organizationId:Int?
    public var results:[OrganizationMember] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetOrganizationAdminResponse : Codable
{
    public var labels:[OrganizationLabel] = []
    public var members:[OrganizationMember] = []
    public var memberInvites:[OrganizationMemberInvite] = []
    public var reportedPosts:[PostReportInfo] = []
    public var reportedPostComments:[PostCommentReportInfo] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class CreateOrganizationForTechnologyResponse : Codable
{
    public var organizationId:Int?
    public var organizationSlug:String?
    public var commentsPostId:Int?
    public var commentsPostSlug:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class CreateOrganizationResponse : Codable
{
    public var id:Int?
    public var slug:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UpdateOrganizationResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class OrganizationLabelResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class AddOrganizationCategoryResponse : Codable
{
    public var id:Int?
    public var slug:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UpdateOrganizationCategoryResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class AddOrganizationMemberResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UpdateOrganizationMemberResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class SetOrganizationMembersResponse : Codable
{
    public var userIdsAdded:[Int] = []
    public var userIdsRemoved:[Int] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetOrganizationMemberInvitesResponse : Codable
{
    public var results:[OrganizationMemberInvite] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class RequestOrganizationMemberInviteResponse : Codable
{
    public var organizationId:Int?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UpdateOrganizationMemberInviteResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetPostResponse : Codable
{
    public var cache:Int?
    public var post:Post?
    public var comments:[PostComment] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class CreatePostResponse : Codable
{
    public var id:Int?
    public var slug:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UpdatePostResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class DeletePostResponse : Codable
{
    public var id:Int?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class CreatePostCommentResponse : Codable
{
    public var id:Int?
    public var postId:Int?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UpdatePostCommentResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class DeletePostCommentResponse : Codable
{
    public var id:Int?
    public var postId:Int?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetUserPostCommentVotesResponse : Codable
{
    public var postId:Int?
    public var upVotedCommentIds:[Int] = []
    public var downVotedCommentIds:[Int] = []

    required public init(){}
}

public class PinPostCommentResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetUsersByEmailsResponse : Codable
{
    public var results:[UserRef] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetUserPostActivityResponse : Codable
{
    public var upVotedPostIds:[Int] = []
    public var downVotedPostIds:[Int] = []
    public var favoritePostIds:[Int] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetUserOrganizationsResponse : Codable
{
    public var members:[OrganizationMember] = []
    public var memberInvites:[OrganizationMemberInvite] = []
    public var subscriptions:[OrganizationSubscription] = []

    required public init(){}
}

public class UserPostVoteResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UserPostFavoriteResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UserPostReportResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UserPostCommentVoteResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UserPostCommentReportResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class SessionInfoResponse : Codable
{
    public var created:Date?
    public var id:String?
    public var referrerUrl:String?
    public var userAuthId:String?
    public var userAuthName:String?
    public var userName:String?
    public var displayName:String?
    public var firstName:String?
    public var lastName:String?
    public var email:String?
    public var createdAt:Date?
    public var lastModified:Date?
    public var roles:[String] = []
    public var permissions:[String] = []
    public var isAuthenticated:Bool?
    public var authProvider:String?
    public var profileUrl:String?
    public var githubProfileUrl:String?
    public var twitterProfileUrl:String?
    public var accessToken:String?
    public var avatarUrl:String?
    public var techStacks:[TechnologyStack] = []
    public var favoriteTechStacks:[TechnologyStack] = []
    public var favoriteTechnologies:[Technology] = []
    public var userActivity:UserActivity?
    public var members:[OrganizationMember] = []
    public var memberInvites:[OrganizationMemberInvite] = []
    public var subscriptions:[OrganizationSubscription] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetTechnologyPreviousVersionsResponse : Codable
{
    public var results:[TechnologyHistory] = []

    required public init(){}
}

public class GetAllTechnologiesResponse : Codable
{
    public var results:[Technology] = []
    public var total:Int?

    required public init(){}
}

public class GetTechnologyResponse : Codable
{
    public var created:Date?
    public var technology:Technology?
    public var technologyStacks:[TechnologyStack] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetTechnologyFavoriteDetailsResponse : Codable
{
    public var users:[String] = []
    public var favoriteCount:Int?

    required public init(){}
}

public class CreateTechnologyResponse : Codable
{
    public var result:Technology?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UpdateTechnologyResponse : Codable
{
    public var result:Technology?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class DeleteTechnologyResponse : Codable
{
    public var result:Technology?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetTechnologyStackPreviousVersionsResponse : Codable
{
    public var results:[TechnologyStackHistory] = []

    required public init(){}
}

public class GetPageStatsResponse : Codable
{
    public var type:String?
    public var slug:String?
    public var viewCount:Int?
    public var favCount:Int?

    required public init(){}
}

public class OverviewResponse : Codable
{
    public var created:Date?
    public var topUsers:[UserInfo] = []
    public var topTechnologies:[TechnologyInfo] = []
    public var latestTechStacks:[TechStackDetails] = []
    public var popularTechStacks:[TechnologyStack] = []
    public var allOrganizations:[OrganizationInfo] = []
    public var topTechnologiesByTier:[String:[TechnologyInfo]] = [:]
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class AppOverviewResponse : Codable
{
    public var created:Date?
    public var allTiers:[Option] = []
    public var topTechnologies:[TechnologyInfo] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetAllTechnologyStacksResponse : Codable
{
    public var results:[TechnologyStack] = []
    public var total:Int?

    required public init(){}
}

public class GetTechnologyStackResponse : Codable
{
    public var created:Date?
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetTechnologyStackFavoriteDetailsResponse : Codable
{
    public var users:[String] = []
    public var favoriteCount:Int?

    required public init(){}
}

public class GetConfigResponse : Codable
{
    public var allTiers:[Option] = []
    public var allPostTypes:[Option] = []
    public var allFlagTypes:[Option] = []

    required public init(){}
}

public class CreateTechnologyStackResponse : Codable
{
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class UpdateTechnologyStackResponse : Codable
{
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class DeleteTechnologyStackResponse : Codable
{
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetFavoriteTechStackResponse : Codable
{
    public var results:[TechnologyStack] = []

    required public init(){}
}

public class FavoriteTechStackResponse : Codable
{
    public var result:TechnologyStack?

    required public init(){}
}

public class GetFavoriteTechnologiesResponse : Codable
{
    public var results:[Technology] = []

    required public init(){}
}

public class FavoriteTechnologyResponse : Codable
{
    public var result:Technology?

    required public init(){}
}

public class GetUserFeedResponse : Codable
{
    public var results:[TechStackDetails] = []

    required public init(){}
}

public class GetUsersKarmaResponse : Codable
{
    public var results:[Int:Int] = [:]
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetUserInfoResponse : Codable
{
    public var id:Int?
    public var userName:String?
    public var created:Date?
    public var avatarUrl:String?
    public var techStacks:[TechnologyStack] = []
    public var favoriteTechStacks:[TechnologyStack] = []
    public var favoriteTechnologies:[Technology] = []
    public var userActivity:UserActivity?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class LogoUrlApprovalResponse : Codable
{
    public var result:Technology?

    required public init(){}
}

public class LockStackResponse : Codable
{
    required public init(){}
}

public class EmailTestResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class Post : Codable
{
    public var id:Int?
    public var organizationId:Int?
    public var userId:Int?
    public var type:PostType?
    public var categoryId:Int?
    public var title:String?
    public var slug:String?
    public var url:String?
    public var imageUrl:String?
    // @StringLength(Int32.max)
    public var content:String?

    // @StringLength(Int32.max)
    public var contentHtml:String?

    public var pinCommentId:Int?
    public var technologyIds:[Int] = []
    public var fromDate:Date?
    public var toDate:Date?
    public var location:String?
    public var metaType:String?
    public var meta:String?
    public var approved:Bool?
    public var upVotes:Int?
    public var downVotes:Int?
    public var points:Int?
    public var views:Int?
    public var favorites:Int?
    public var subscribers:Int?
    public var replyCount:Int?
    public var commentsCount:Int?
    public var wordCount:Int?
    public var reportCount:Int?
    public var linksCount:Int?
    public var linkedToCount:Int?
    public var score:Int?
    public var rank:Int?
    public var labels:[String] = []
    public var refUserIds:[Int] = []
    public var refLinks:[String] = []
    public var muteUserIds:[Int] = []
    public var lastCommentDate:Date?
    public var lastCommentId:Int?
    public var lastCommentUserId:Int?
    public var deleted:Date?
    public var deletedBy:String?
    public var locked:Date?
    public var lockedBy:String?
    public var hidden:Date?
    public var hiddenBy:String?
    public var status:String?
    public var statusDate:Date?
    public var statusBy:String?
    public var archived:Bool?
    public var bumped:Date?
    public var created:Date?
    public var createdBy:String?
    public var modified:Date?
    public var modifiedBy:String?
    public var refId:Int?
    public var refSource:String?
    public var refUrn:String?

    required public init(){}
}

public enum PostType : String, Codable
{
    case Announcement
    case Post
    case Showcase
    case Question
    case Request
}

public enum ReportAction : String, Codable
{
    case Dismiss
    case Delete
}

public enum FlagType : String, Codable
{
    case Violation
    case Spam
    case Abusive
    case Confidential
    case OffTopic
    case Other
}

public enum Frequency : Int, Codable
{
    case Daily = 1
    case Weekly = 7
    case Monthly = 30
    case Quarterly = 90
}

public class Technology : TechnologyBase
{
    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class TechnologyView : Codable
{
    public var id:Int?
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var Description:String?
    public var created:Date?
    public var createdBy:String?
    public var lastModified:Date?
    public var lastModifiedBy:String?
    public var ownerId:String?
    public var slug:String?
    public var logoApproved:Bool?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
    public var lastStatusUpdate:Date?
    public var organizationId:Int?
    public var commentsPostId:Int?
    public var viewCount:Int?
    public var favCount:Int?

    required public init(){}
}

public protocol IRegisterStats
{
}

public enum TechnologyTier : String, Codable
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
    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class TechnologyStackView : Codable
{
    public var id:Int?
    public var name:String?
    public var vendorName:String?
    public var Description:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var created:Date?
    public var createdBy:String?
    public var lastModified:Date?
    public var lastModifiedBy:String?
    public var isLocked:Bool?
    public var ownerId:String?
    public var slug:String?
    public var details:String?
    public var detailsHtml:String?
    public var lastStatusUpdate:Date?
    public var organizationId:Int?
    public var commentsPostId:Int?
    public var viewCount:Int?
    public var favCount:Int?

    required public init(){}
}

public class PostComment : Codable
{
    public var id:Int?
    public var postId:Int?
    public var userId:Int?
    public var replyId:Int?
    // @StringLength(Int32.max)
    public var content:String?

    // @StringLength(Int32.max)
    public var contentHtml:String?

    public var score:Int?
    public var rank:Int?
    public var upVotes:Int?
    public var downVotes:Int?
    public var favorites:Int?
    public var wordCount:Int?
    public var reportCount:Int?
    public var deleted:Date?
    public var hidden:Date?
    public var modified:Date?
    public var created:Date?
    public var createdBy:String?
    public var refId:Int?
    public var refSource:String?
    public var refUrn:String?

    required public init(){}
}

public class Organization : Codable
{
    public var id:Int?
    public var name:String?
    public var slug:String?
    public var Description:String?
    public var descriptionHtml:String?
    public var color:String?
    public var textColor:String?
    public var linkColor:String?
    public var backgroundColor:String?
    public var backgroundUrl:String?
    public var logoUrl:String?
    public var heroUrl:String?
    public var lang:String?
    public var defaultPostType:String?
    public var defaultSubscriptionPostTypes:[String] = []
    public var postTypes:[String] = []
    public var moderatorPostTypes:[String] = []
    public var deletePostsWithReportCount:Int?
    public var disableInvites:Bool?
    public var upVotes:Int?
    public var downVotes:Int?
    public var views:Int?
    public var favorites:Int?
    public var subscribers:Int?
    public var commentsCount:Int?
    public var postsCount:Int?
    public var score:Int?
    public var rank:Int?
    public var refId:Int?
    public var refSource:String?
    public var hidden:Date?
    public var hiddenBy:String?
    public var locked:Date?
    public var lockedBy:String?
    public var deleted:Date?
    public var deletedBy:String?
    public var created:Date?
    public var createdBy:String?
    public var modified:Date?
    public var modifiedBy:String?

    required public init(){}
}

public class OrganizationLabel : Codable
{
    public var slug:String?
    public var organizationId:Int?
    public var Description:String?
    public var color:String?

    required public init(){}
}

public class Category : Codable
{
    public var id:Int?
    public var organizationId:Int?
    public var name:String?
    public var slug:String?
    public var Description:String?
    public var color:String?
    public var technologyIds:[Int] = []
    public var commentsCount:Int?
    public var postsCount:Int?
    public var score:Int?
    public var rank:Int?

    required public init(){}
}

public class OrganizationMember : Codable
{
    public var id:Int?
    public var organizationId:Int?
    public var userId:Int?
    public var userName:String?
    public var isOwner:Bool?
    public var isModerator:Bool?
    public var denyAll:Bool?
    public var denyPosts:Bool?
    public var denyComments:Bool?
    public var notes:String?

    required public init(){}
}

public class OrganizationMemberInvite : Codable
{
    public var id:Int?
    public var organizationId:Int?
    public var userId:Int?
    public var userName:String?
    public var dismissed:Date?

    required public init(){}
}

public class PostReportInfo : Codable
{
    public var id:Int?
    public var organizationId:Int?
    public var postId:Int?
    public var userId:Int?
    public var userName:String?
    public var flagType:FlagType?
    public var reportNotes:String?
    public var created:Date?
    public var acknowledged:Date?
    public var acknowledgedBy:String?
    public var dismissed:Date?
    public var dismissedBy:String?
    public var title:String?
    public var reportCount:Int?
    public var createdBy:String?

    required public init(){}
}

public class PostCommentReportInfo : Codable
{
    public var id:Int?
    public var organizationId:Int?
    public var postId:Int?
    public var postCommentId:Int?
    public var userId:Int?
    public var userName:String?
    public var flagType:FlagType?
    public var reportNotes:String?
    public var created:Date?
    public var acknowledged:Date?
    public var acknowledgedBy:String?
    public var dismissed:Date?
    public var dismissedBy:String?
    public var contentHtml:String?
    public var reportCount:Int?
    public var createdBy:String?

    required public init(){}
}

public class UserRef : Codable
{
    public var id:Int?
    public var userName:String?
    public var email:String?
    public var refId:Int?
    public var refSource:String?
    public var refUrn:String?

    required public init(){}
}

public class OrganizationSubscription : Codable
{
    public var id:Int?
    public var organizationId:Int?
    public var userId:Int?
    public var userName:String?
    public var postTypes:[String] = []
    public var frequencyDays:Int?
    public var lastSyncedId:Int?
    public var lastSynced:Date?
    public var created:Date?

    required public init(){}
}

public class UserActivity : Codable
{
    public var id:Int?
    public var userName:String?
    public var karma:Int?
    public var technologyCount:Int?
    public var techStacksCount:Int?
    public var postsCount:Int?
    public var postUpVotes:Int?
    public var postDownVotes:Int?
    public var commentUpVotes:Int?
    public var commentDownVotes:Int?
    public var postCommentsCount:Int?
    public var pinnedCommentCount:Int?
    public var postReportCount:Int?
    public var postCommentReportCount:Int?
    public var created:Date?
    public var modified:Date?

    required public init(){}
}

public class TechnologyHistory : TechnologyBase
{
    public var technologyId:Int?
    public var operation:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case technologyId
        case operation
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        technologyId = try container.decodeIfPresent(Int.self, forKey: .technologyId)
        operation = try container.decodeIfPresent(String.self, forKey: .operation)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if technologyId != nil { try container.encode(technologyId, forKey: .technologyId) }
        if operation != nil { try container.encode(operation, forKey: .operation) }
    }
}

public class TechnologyStackHistory : TechnologyStackBase
{
    public var technologyStackId:Int?
    public var operation:String?
    public var technologyIds:[Int] = []

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case technologyStackId
        case operation
        case technologyIds
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        technologyStackId = try container.decodeIfPresent(Int.self, forKey: .technologyStackId)
        operation = try container.decodeIfPresent(String.self, forKey: .operation)
        technologyIds = try container.decodeIfPresent([Int].self, forKey: .technologyIds) ?? []
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if technologyStackId != nil { try container.encode(technologyStackId, forKey: .technologyStackId) }
        if operation != nil { try container.encode(operation, forKey: .operation) }
        if technologyIds.count > 0 { try container.encode(technologyIds, forKey: .technologyIds) }
    }
}

public class UserInfo : Codable
{
    public var userName:String?
    public var avatarUrl:String?
    public var stacksCount:Int?

    required public init(){}
}

public class TechnologyInfo : Codable
{
    public var tier:TechnologyTier?
    public var slug:String?
    public var name:String?
    public var logoUrl:String?
    public var stacksCount:Int?

    required public init(){}
}

public class TechStackDetails : TechnologyStackBase
{
    public var technologyChoices:[TechnologyInStack] = []

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case technologyChoices
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        technologyChoices = try container.decodeIfPresent([TechnologyInStack].self, forKey: .technologyChoices) ?? []
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if technologyChoices.count > 0 { try container.encode(technologyChoices, forKey: .technologyChoices) }
    }
}

public class OrganizationInfo : Codable
{
    public var id:Int?
    public var name:String?
    public var slug:String?
    public var refId:Int?
    public var refSource:String?
    public var upVotes:Int?
    public var downVotes:Int?
    public var membersCount:Int?
    public var rank:Int?
    public var disableInvites:Bool?
    public var lang:String?
    public var postTypes:[String] = []
    public var moderatorPostTypes:[String] = []
    public var locked:Date?
    public var labels:[LabelInfo] = []
    public var categories:[CategoryInfo] = []

    required public init(){}
}

// @DataContract
public class Option : Codable
{
    // @DataMember(Name="name")
    public var name:String?

    // @DataMember(Name="title")
    public var title:String?

    // @DataMember(Name="value")
    public var value:TechnologyTier?

    required public init(){}
}

public class TechnologyBase : Codable
{
    public var id:Int?
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var Description:String?
    public var created:Date?
    public var createdBy:String?
    public var lastModified:Date?
    public var lastModifiedBy:String?
    public var ownerId:String?
    public var slug:String?
    public var logoApproved:Bool?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
    public var lastStatusUpdate:Date?
    public var organizationId:Int?
    public var commentsPostId:Int?
    public var viewCount:Int?
    public var favCount:Int?

    required public init(){}
}

public class TechnologyStackBase : Codable
{
    public var id:Int?
    public var name:String?
    public var vendorName:String?
    public var Description:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var created:Date?
    public var createdBy:String?
    public var lastModified:Date?
    public var lastModifiedBy:String?
    public var isLocked:Bool?
    public var ownerId:String?
    public var slug:String?
    // @StringLength(Int32.max)
    public var details:String?

    // @StringLength(Int32.max)
    public var detailsHtml:String?

    public var lastStatusUpdate:Date?
    public var organizationId:Int?
    public var commentsPostId:Int?
    public var viewCount:Int?
    public var favCount:Int?

    required public init(){}
}

public class TechnologyInStack : TechnologyBase
{
    public var technologyId:Int?
    public var technologyStackId:Int?
    public var justification:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case technologyId
        case technologyStackId
        case justification
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        technologyId = try container.decodeIfPresent(Int.self, forKey: .technologyId)
        technologyStackId = try container.decodeIfPresent(Int.self, forKey: .technologyStackId)
        justification = try container.decodeIfPresent(String.self, forKey: .justification)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if technologyId != nil { try container.encode(technologyId, forKey: .technologyId) }
        if technologyStackId != nil { try container.encode(technologyStackId, forKey: .technologyStackId) }
        if justification != nil { try container.encode(justification, forKey: .justification) }
    }
}

public class LabelInfo : Codable
{
    public var slug:String?
    public var color:String?

    required public init(){}
}

public class CategoryInfo : Codable
{
    public var id:Int?
    public var name:String?
    public var slug:String?

    required public init(){}
}



/* Options:
Date: 2018-04-17 05:18:32
SwiftVersion: 3.0
Version: 5.03
Tip: To override a DTO option, remove "//" prefix before updating
BaseUrl: https://www.techstacks.io

//BaseClass: 
//AddModelExtensions: True
//AddServiceStackTypes: True
//IncludeTypes: 
ExcludeTypes: Authenticate,AuthenticateResponse,AssignRoles,AssignRolesResponse,UnAssignRoles,UnAssignRolesResponse,Ping,ConvertSessionToToken,GetAccessToken
//ExcludeGenericBaseTypes: False
//AddResponseStatus: False
//AddImplicitVersion: 
//AddDescriptionAsComments: True
//InitializeCollections: True
//TreatTypesAsStrings: 
//DefaultImports: Foundation
*/

import Foundation;

public class DummyTypes
{
    required public init(){}
    public var post:[Post] = []
}

// @Route("/orgs/{Id}", "GET")
public class GetOrganization : IReturn
{
    public typealias Return = GetOrganizationResponse

    required public init(){}
    public var id:Int?
}

// @Route("/organizations/{Slug}", "GET")
public class GetOrganizationBySlug : IReturn
{
    public typealias Return = GetOrganizationResponse

    required public init(){}
    public var slug:String?
}

// @Route("/orgs/{Id}/members", "GET")
public class GetOrganizationMembers : IReturn
{
    public typealias Return = GetOrganizationMembersResponse

    required public init(){}
    public var id:Int?
}

// @Route("/orgs/{Id}/admin", "GET")
public class GetOrganizationAdmin : IReturn
{
    public typealias Return = GetOrganizationAdminResponse

    required public init(){}
    public var id:Int?
}

// @Route("/orgs/posts/new", "POST")
public class CreateOrganizationForTechnology : IReturn
{
    public typealias Return = CreateOrganizationForTechnologyResponse

    required public init(){}
    public var technologyId:Int64?
    public var techStackId:Int64?
}

// @Route("/orgs", "POST")
public class CreateOrganization : IReturn
{
    public typealias Return = CreateOrganizationResponse

    required public init(){}
    public var name:String?
    public var slug:String?
    public var Description:String?
    public var refId:Int64?
    public var refSource:String?
    public var refUrn:String?
}

// @Route("/orgs/{Id}", "PUT")
public class UpdateOrganization : IReturn
{
    public typealias Return = UpdateOrganizationResponse

    required public init(){}
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
}

// @Route("/orgs/{Id}", "DELETE")
public class DeleteOrganization : IReturnVoid
{
    required public init(){}
    public var id:Int?
}

// @Route("/orgs/{Id}/lock", "PUT")
public class LockOrganization : IReturnVoid
{
    required public init(){}
    public var id:Int?
    public var lock:Bool?
    public var reason:String?
}

// @Route("/orgs/{OrganizationId}/labels", "POST")
public class AddOrganizationLabel : IReturn
{
    public typealias Return = OrganizationLabelResponse

    required public init(){}
    public var organizationId:Int?
    public var slug:String?
    public var Description:String?
    public var color:String?
}

// @Route("/orgs/{OrganizationId}/members/{Slug}", "PUT")
public class UpdateOrganizationLabel : IReturn
{
    public typealias Return = OrganizationLabelResponse

    required public init(){}
    public var organizationId:Int?
    public var slug:String?
    public var Description:String?
    public var color:String?
}

// @Route("/orgs/{OrganizationId}/labels/{Slug}", "DELETE")
public class RemoveOrganizationLabel : IReturnVoid
{
    required public init(){}
    public var organizationId:Int?
    public var slug:String?
}

// @Route("/orgs/{OrganizationId}/categories", "POST")
public class AddOrganizationCategory : IReturn
{
    public typealias Return = AddCategoryResponse

    required public init(){}
    public var organizationId:Int?
    public var slug:String?
    public var name:String?
    public var Description:String?
    public var technologyIds:[Int] = []
}

// @Route("/orgs/{OrganizationId}/categories/{Id}", "PUT")
public class UpdateOrganizationCategory : IReturn
{
    public typealias Return = UpdateCategoryResponse

    required public init(){}
    public var organizationId:Int?
    public var id:Int?
    public var name:String?
    public var slug:String?
    public var Description:String?
    public var technologyIds:[Int] = []
}

// @Route("/orgs/{OrganizationId}/categories/{Id}", "DELETE")
public class DeleteOrganizationCategory : IReturnVoid
{
    required public init(){}
    public var organizationId:Int?
    public var id:Int?
}

// @Route("/orgs/{OrganizationId}/members", "POST")
public class AddOrganizationMember : IReturn
{
    public typealias Return = AddOrganizationMemberResponse

    required public init(){}
    public var organizationId:Int?
    public var userName:String?
    public var isOwner:Bool?
    public var isModerator:Bool?
    public var denyPosts:Bool?
    public var denyComments:Bool?
    public var denyAll:Bool?
    public var notes:String?
}

// @Route("/orgs/{OrganizationId}/members/{Id}", "PUT")
public class UpdateOrganizationMember : IReturn
{
    public typealias Return = UpdateOrganizationMemberResponse

    required public init(){}
    public var organizationId:Int?
    public var userId:Int?
    public var isOwner:Bool?
    public var isModerator:Bool?
    public var denyPosts:Bool?
    public var denyComments:Bool?
    public var denyAll:Bool?
    public var notes:String?
}

// @Route("/orgs/{OrganizationId}/members/{UserId}", "DELETE")
public class RemoveOrganizationMember : IReturnVoid
{
    required public init(){}
    public var organizationId:Int?
    public var userId:Int?
}

// @Route("/orgs/{OrganizationId}/members/set", "POST")
public class SetOrganizationMembers : IReturn
{
    public typealias Return = SetOrganizationMembersResponse

    required public init(){}
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
}

// @Route("/orgs/{OrganizationId}/invites", "GET")
public class GetOrganizationMemberInvites : IReturn
{
    public typealias Return = GetOrganizationMemberInvitesResponse

    required public init(){}
    public var organizationId:Int?
}

// @Route("/orgs/{OrganizationId}/invites", "POST")
public class RequestOrganizationMemberInvite : IReturn
{
    public typealias Return = RequestOrganizationMemberInviteResponse

    required public init(){}
    public var organizationId:Int?
}

// @Route("/orgs/{OrganizationId}/invites/{UserId}", "PUT")
public class UpdateOrganizationMemberInvite : IReturn
{
    public typealias Return = UpdateOrganizationMemberInviteResponse

    required public init(){}
    public var organizationId:Int?
    public var userName:String?
    public var approve:Bool?
    public var dismiss:Bool?
}

// @Route("/posts", "GET")
public class QueryPosts<Post : JsonSerializable> : QueryDb<Post>, IReturn
{
    public typealias Return = QueryResponse<Post>

    required public init(){}
    public var ids:[Int] = []
    public var organizationId:Int?
    public var organizationIds:[Int] = []
    public var types:[String] = []
    public var anyTechnologyIds:[Int] = []
    public var `is`:[String] = []
}

// @Route("/posts/{Id}", "GET")
public class GetPost : IReturn
{
    public typealias Return = GetPostResponse

    required public init(){}
    public var id:Int64?
    public var include:String?
}

// @Route("/posts", "POST")
public class CreatePost : IReturn
{
    public typealias Return = CreatePostResponse

    required public init(){}
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
    public var refId:Int64?
    public var refSource:String?
    public var refUrn:String?
}

// @Route("/posts/{Id}", "PUT")
public class UpdatePost : IReturn
{
    public typealias Return = UpdatePostResponse

    required public init(){}
    public var id:Int64?
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
}

// @Route("/posts/{Id}", "DELETE")
public class DeletePost : IReturn
{
    public typealias Return = DeletePostResponse

    required public init(){}
    public var id:Int64?
}

// @Route("/posts/{Id}/lock", "PUT")
public class LockPost : IReturnVoid
{
    required public init(){}
    public var id:Int64?
    public var lock:Bool?
    public var reason:String?
}

// @Route("/posts/{Id}/hide", "PUT")
public class HidePost : IReturnVoid
{
    required public init(){}
    public var id:Int64?
    public var hide:Bool?
    public var reason:String?
}

// @Route("/posts/{Id}/status/{Status}", "PUT")
public class ChangeStatusPost : IReturnVoid
{
    required public init(){}
    public var id:Int64?
    public var status:String?
    public var reason:String?
}

// @Route("/posts/{PostId}/report/{Id}", "POST")
public class ActionPostReport : IReturnVoid
{
    required public init(){}
    public var postId:Int64?
    public var id:Int64?
    public var reportAction:ReportAction?
}

// @Route("/posts/{PostId}/comments", "POST")
public class CreatePostComment : IReturn
{
    public typealias Return = CreatePostCommentResponse

    required public init(){}
    public var postId:Int64?
    public var replyId:Int64?
    public var content:String?
}

// @Route("/posts/{PostId}/comments/{Id}", "PUT")
public class UpdatePostComment : IReturn
{
    public typealias Return = UpdatePostCommentResponse

    required public init(){}
    public var id:Int64?
    public var postId:Int64?
    public var content:String?
}

// @Route("/posts/{PostId}/comments/{Id}", "DELETE")
public class DeletePostComment : IReturn
{
    public typealias Return = DeletePostCommentResponse

    required public init(){}
    public var id:Int64?
    public var postId:Int64?
}

// @Route("/posts/{PostId}/comments/{PostCommentId}/report/{Id}", "POST")
public class ActionPostCommentReport : IReturnVoid
{
    required public init(){}
    public var id:Int64?
    public var postCommentId:Int64?
    public var postId:Int64?
    public var reportAction:ReportAction?
}

// @Route("/user/comments/votes")
public class GetUserPostCommentVotes : IReturn
{
    public typealias Return = GetUserPostCommentVotesResponse

    required public init(){}
    public var postId:Int64?
}

// @Route("/posts/{PostId}/comments/{Id}/pin", "UPDATE")
public class PinPostComment : IReturn
{
    public typealias Return = PinPostCommentResponse

    required public init(){}
    public var id:Int64?
    public var postId:Int64?
    public var pin:Bool?
}

// @Route("/users/by-email")
public class GetUsersByEmails : IReturn
{
    public typealias Return = GetUsersByEmailsResponse

    required public init(){}
    public var emails:[String] = []
}

// @Route("/user/posts/activity")
public class GetUserPostActivity : IReturn
{
    public typealias Return = GetUserPostActivityResponse

    required public init(){}
}

// @Route("/user/organizations")
public class GetUserOrganizations : IReturn
{
    public typealias Return = GetUserOrganizationsResponse

    required public init(){}
}

// @Route("/posts/{Id}/vote", "PUT")
public class UserPostVote : IReturn
{
    public typealias Return = UserPostVoteResponse

    required public init(){}
    public var id:Int64?
    public var weight:Int?
}

// @Route("/posts/{Id}/favorite", "PUT")
public class UserPostFavorite : IReturn
{
    public typealias Return = UserPostFavoriteResponse

    required public init(){}
    public var id:Int64?
}

// @Route("/posts/{Id}/report", "PUT")
public class UserPostReport : IReturn
{
    public typealias Return = UserPostReportResponse

    required public init(){}
    public var id:Int64?
    public var flagType:FlagType?
    public var reportNotes:String?
}

// @Route("/posts/{PostId}/comments/{Id}", "GET")
public class UserPostCommentVote : IReturn
{
    public typealias Return = UserPostCommentVoteResponse

    required public init(){}
    public var id:Int64?
    public var postId:Int64?
    public var weight:Int?
}

// @Route("/posts/{PostId}/comments/{Id}/report", "PUT")
public class UserPostCommentReport : IReturn
{
    public typealias Return = UserPostCommentReportResponse

    required public init(){}
    public var id:Int64?
    public var postId:Int64?
    public var flagType:FlagType?
    public var reportNotes:String?
}

// @Route("/prerender/{Path*}", "PUT")
public class StorePreRender : IReturnVoid
{
    required public init(){}
    public var path:String?
}

// @Route("/prerender/{Path*}", "GET")
public class GetPreRender : IReturn
{
    public typealias Return = String

    required public init(){}
    public var path:String?
}

// @Route("/my-session")
public class SessionInfo : IReturn
{
    public typealias Return = SessionInfoResponse

    required public init(){}
}

// @Route("/orgs/{OrganizationId}/subscribe", "PUT")
public class SubscribeToOrganization : IReturnVoid
{
    required public init(){}
    public var organizationId:Int?
    public var postTypes:[PostType] = []
    public var frequency:Frequency?
}

// @Route("/posts/{PostId}/subscribe", "PUT")
public class SubscribeToPost : IReturnVoid
{
    required public init(){}
    public var postId:Int64?
}

// @Route("/orgs/{OrganizationId}/subscribe", "DELETE")
public class DeleteOrganizationSubscription : IReturnVoid
{
    required public init(){}
    public var organizationId:Int64?
}

// @Route("/posts/{PostId}/subscribe", "DELETE")
public class DeletePostSubscription : IReturnVoid
{
    required public init(){}
    public var postId:Int64?
}

// @Route("/technology/{Slug}/previous-versions", "GET")
public class GetTechnologyPreviousVersions : IReturn
{
    public typealias Return = GetTechnologyPreviousVersionsResponse

    required public init(){}
    public var slug:String?
}

// @Route("/technology", "GET")
public class GetAllTechnologies : IReturn
{
    public typealias Return = GetAllTechnologiesResponse

    required public init(){}
}

// @Route("/technology/search")
// @AutoQueryViewer(DefaultSearchField="Tier", DefaultSearchText="Data", DefaultSearchType="=", Description="Explore different Technologies", IconUrl="octicon:database", Title="Find Technologies")
public class FindTechnologies<Technology : JsonSerializable> : QueryDb<Technology>, IReturn
{
    public typealias Return = QueryResponse<Technology>

    required public init(){}
    public var name:String?
    public var nameContains:String?
}

// @Route("/technology/query")
public class QueryTechnology<Technology : JsonSerializable> : QueryDb<Technology>, IReturn
{
    public typealias Return = QueryResponse<Technology>

    required public init(){}
}

// @Route("/technology/{Slug}")
public class GetTechnology : IReturn, IRegisterStats
{
    public typealias Return = GetTechnologyResponse

    required public init(){}
    public var slug:String?
}

// @Route("/technology/{Slug}/favorites")
public class GetTechnologyFavoriteDetails : IReturn
{
    public typealias Return = GetTechnologyFavoriteDetailsResponse

    required public init(){}
    public var slug:String?
}

// @Route("/technology", "POST")
public class CreateTechnology : IReturn
{
    public typealias Return = CreateTechnologyResponse

    required public init(){}
    public var name:String?
    public var slug:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var Description:String?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
}

// @Route("/technology/{Id}", "PUT")
public class UpdateTechnology : IReturn
{
    public typealias Return = UpdateTechnologyResponse

    required public init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var Description:String?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
}

// @Route("/technology/{Id}", "DELETE")
public class DeleteTechnology : IReturn
{
    public typealias Return = DeleteTechnologyResponse

    required public init(){}
    public var id:Int64?
}

// @Route("/techstacks/{Slug}/previous-versions", "GET")
public class GetTechnologyStackPreviousVersions : IReturn
{
    public typealias Return = GetTechnologyStackPreviousVersionsResponse

    required public init(){}
    public var slug:String?
}

// @Route("/pagestats/{Type}/{Slug}")
public class GetPageStats : IReturn
{
    public typealias Return = GetPageStatsResponse

    required public init(){}
    public var type:String?
    public var slug:String?
    public var id:Int?
}

// @Route("/cache/clear")
public class ClearCache : IReturn
{
    public typealias Return = String

    required public init(){}
}

// @Route("/tasks/hourly")
public class HourlyTask : IReturn
{
    public typealias Return = HourlyTaskResponse

    required public init(){}
    public var force:Bool?
}

// @Route("/techstacks/search")
// @AutoQueryViewer(DefaultSearchField="Description", DefaultSearchText="ServiceStack", DefaultSearchType="Contains", Description="Explore different Technology Stacks", IconUrl="material-icons:cloud", Title="Find Technology Stacks")
public class FindTechStacks<TechnologyStack : JsonSerializable> : QueryDb<TechnologyStack>, IReturn
{
    public typealias Return = QueryResponse<TechnologyStack>

    required public init(){}
    public var nameContains:String?
}

// @Route("/techstacks/query")
public class QueryTechStacks<TechnologyStack : JsonSerializable> : QueryDb<TechnologyStack>, IReturn
{
    public typealias Return = QueryResponse<TechnologyStack>

    required public init(){}
}

// @Route("/overview")
public class Overview : IReturn
{
    public typealias Return = OverviewResponse

    required public init(){}
    public var reload:Bool?
}

// @Route("/app-overview")
public class AppOverview : IReturn
{
    public typealias Return = AppOverviewResponse

    required public init(){}
    public var reload:Bool?
}

// @Route("/techstacks", "GET")
public class GetAllTechnologyStacks : IReturn
{
    public typealias Return = GetAllTechnologyStacksResponse

    required public init(){}
}

// @Route("/techstacks/{Slug}", "GET")
public class GetTechnologyStack : IReturn, IRegisterStats
{
    public typealias Return = GetTechnologyStackResponse

    required public init(){}
    public var slug:String?
}

// @Route("/techstacks/{Slug}/favorites")
public class GetTechnologyStackFavoriteDetails : IReturn
{
    public typealias Return = GetTechnologyStackFavoriteDetailsResponse

    required public init(){}
    public var slug:String?
}

// @Route("/config")
public class GetConfig : IReturn
{
    public typealias Return = GetConfigResponse

    required public init(){}
}

// @Route("/techstacks", "POST")
public class CreateTechnologyStack : IReturn
{
    public typealias Return = CreateTechnologyStackResponse

    required public init(){}
    public var name:String?
    public var slug:String?
    public var vendorName:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var Description:String?
    public var details:String?
    public var isLocked:Bool?
    public var technologyIds:[Int64] = []
}

// @Route("/techstacks/{Id}", "PUT")
public class UpdateTechnologyStack : IReturn
{
    public typealias Return = UpdateTechnologyStackResponse

    required public init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var Description:String?
    public var details:String?
    public var isLocked:Bool?
    public var technologyIds:[Int64] = []
}

// @Route("/techstacks/{Id}", "DELETE")
public class DeleteTechnologyStack : IReturn
{
    public typealias Return = DeleteTechnologyStackResponse

    required public init(){}
    public var id:Int64?
}

// @Route("/favorites/techtacks", "GET")
public class GetFavoriteTechStack : IReturn
{
    public typealias Return = GetFavoriteTechStackResponse

    required public init(){}
    public var technologyStackId:Int?
}

// @Route("/favorites/techtacks/{TechnologyStackId}", "PUT")
public class AddFavoriteTechStack : IReturn
{
    public typealias Return = FavoriteTechStackResponse

    required public init(){}
    public var technologyStackId:Int?
}

// @Route("/favorites/techtacks/{TechnologyStackId}", "DELETE")
public class RemoveFavoriteTechStack : IReturn
{
    public typealias Return = FavoriteTechStackResponse

    required public init(){}
    public var technologyStackId:Int?
}

// @Route("/favorites/technology", "GET")
public class GetFavoriteTechnologies : IReturn
{
    public typealias Return = GetFavoriteTechnologiesResponse

    required public init(){}
    public var technologyId:Int?
}

// @Route("/favorites/technology/{TechnologyId}", "PUT")
public class AddFavoriteTechnology : IReturn
{
    public typealias Return = FavoriteTechnologyResponse

    required public init(){}
    public var technologyId:Int?
}

// @Route("/favorites/technology/{TechnologyId}", "DELETE")
public class RemoveFavoriteTechnology : IReturn
{
    public typealias Return = FavoriteTechnologyResponse

    required public init(){}
    public var technologyId:Int?
}

// @Route("/my-feed")
public class GetUserFeed : IReturn
{
    public typealias Return = GetUserFeedResponse

    required public init(){}
}

// @Route("/users/karma", "GET")
public class GetUsersKarma : IReturn
{
    public typealias Return = GetUsersKarmaResponse

    required public init(){}
    public var userIds:[Int] = []
}

// @Route("/userinfo/{UserName}")
public class GetUserInfo : IReturn
{
    public typealias Return = GetUserInfoResponse

    required public init(){}
    public var userName:String?
}

// @Route("/users/{UserName}/avatar", "GET")
public class UserAvatar
{
    required public init(){}
    public var userName:String?
}

// @Route("/mq/start")
public class MqStart : IReturn
{
    public typealias Return = String

    required public init(){}
}

// @Route("/mq/stop")
public class MqStop : IReturn
{
    public typealias Return = String

    required public init(){}
}

// @Route("/mq/stats")
public class MqStats : IReturn
{
    public typealias Return = String

    required public init(){}
}

// @Route("/mq/status")
public class MqStatus : IReturn
{
    public typealias Return = String

    required public init(){}
}

// @Route("/sync/discourse/{Site}")
public class SyncDiscourseSite : IReturn
{
    public typealias Return = SyncDiscourseSiteResponse

    required public init(){}
    public var site:String?
}

// @Route("/admin/technology/{TechnologyId}/logo")
public class LogoUrlApproval : IReturn
{
    public typealias Return = LogoUrlApprovalResponse

    required public init(){}
    public var technologyId:Int64?
    public var approved:Bool?
}

// @Route("/admin/techstacks/{TechnologyStackId}/lock")
public class LockTechStack : IReturn
{
    public typealias Return = LockStackResponse

    required public init(){}
    public var technologyStackId:Int64?
    public var isLocked:Bool?
}

// @Route("/admin/technology/{TechnologyId}/lock")
public class LockTech : IReturn
{
    public typealias Return = LockStackResponse

    required public init(){}
    public var technologyId:Int64?
    public var isLocked:Bool?
}

// @Route("/email/post/{PostId}")
public class EmailTest : IReturn
{
    public typealias Return = EmailTestRespoonse

    required public init(){}
    public var postId:Int?
}

public class ImportUser : IReturn
{
    public typealias Return = ImportUserResponse

    required public init(){}
    public var userName:String?
    public var email:String?
    public var firstName:String?
    public var lastName:String?
    public var displayName:String?
    public var company:String?
    public var refSource:String?
    public var refId:Int?
    public var refIdStr:String?
    public var refUrn:String?
    public var defaultProfileUrl:String?
    public var meta:[String:String] = [:]
}

// @Route("/import/uservoice/suggestion")
public class ImportUserVoiceSuggestion : IReturn
{
    public typealias Return = ImportUserVoiceSuggestionResponse

    required public init(){}
    public var organizationId:Int?
    public var url:String?
    public var id:Int?
    public var topicId:Int?
    public var state:String?
    public var title:String?
    public var slug:String?
    public var category:String?
    public var text:String?
    public var formattedText:String?
    public var voteCount:Int?
    public var closedAt:Date?
    public var statusKey:String?
    public var statusHexColor:String?
    public var statusChangedBy:UserVoiceUser?
    public var creator:UserVoiceUser?
    public var response:UserVoiceComment?
    public var createdAt:Date?
    public var updatedAt:Date?
}

// @Route("/posts/comment", "GET")
public class QueryPostComments<PostComment : JsonSerializable> : QueryDb<PostComment>, IReturn
{
    public typealias Return = QueryResponse<PostComment>

    required public init(){}
    public var userId:Int?
    public var postId:Int?
}

// @Route("/admin/technology/search")
// @AutoQueryViewer(DefaultSearchField="Tier", DefaultSearchText="Data", DefaultSearchType="=", Description="Explore different Technologies", IconUrl="octicon:database", Title="Find Technologies Admin")
public class FindTechnologiesAdmin<Technology : JsonSerializable> : QueryDb<Technology>, IReturn
{
    public typealias Return = QueryResponse<Technology>

    required public init(){}
    public var name:String?
}

public class GetOrganizationResponse
{
    required public init(){}
    public var cache:Int64?
    public var id:Int?
    public var slug:String?
    public var organization:Organization?
    public var labels:[OrganizationLabel] = []
    public var categories:[Category] = []
    public var owners:[OrganizationMember] = []
    public var moderators:[OrganizationMember] = []
    public var membersCount:Int64?
    public var responseStatus:ResponseStatus?
}

public class GetOrganizationMembersResponse
{
    required public init(){}
    public var organizationId:Int?
    public var results:[OrganizationMember] = []
    public var responseStatus:ResponseStatus?
}

public class GetOrganizationAdminResponse
{
    required public init(){}
    public var labels:[OrganizationLabel] = []
    public var members:[OrganizationMember] = []
    public var memberInvites:[OrganizationMemberInvite] = []
    public var reportedPosts:[PostReportInfo] = []
    public var reportedPostComments:[PostCommentReportInfo] = []
    public var responseStatus:ResponseStatus?
}

public class CreateOrganizationForTechnologyResponse
{
    required public init(){}
    public var organizationId:Int?
    public var organizationSlug:String?
    public var commentsPostId:Int64?
    public var commentsPostSlug:String?
    public var responseStatus:ResponseStatus?
}

public class CreateOrganizationResponse
{
    required public init(){}
    public var id:Int?
    public var slug:String?
    public var responseStatus:ResponseStatus?
}

public class UpdateOrganizationResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class OrganizationLabelResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class AddCategoryResponse
{
    required public init(){}
    public var id:Int?
    public var slug:String?
    public var responseStatus:ResponseStatus?
}

public class UpdateCategoryResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class AddOrganizationMemberResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class UpdateOrganizationMemberResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class SetOrganizationMembersResponse
{
    required public init(){}
    public var userIdsAdded:[Int] = []
    public var userIdsRemoved:[Int] = []
    public var responseStatus:ResponseStatus?
}

public class GetOrganizationMemberInvitesResponse
{
    required public init(){}
    public var results:[OrganizationMemberInvite] = []
    public var responseStatus:ResponseStatus?
}

public class RequestOrganizationMemberInviteResponse
{
    required public init(){}
    public var organizationId:Int?
    public var responseStatus:ResponseStatus?
}

public class UpdateOrganizationMemberInviteResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

// @DataContract
public class QueryResponse<T : JsonSerializable>
{
    required public init(){}
    // @DataMember(Order=1)
    public var offset:Int?

    // @DataMember(Order=2)
    public var total:Int?

    // @DataMember(Order=3)
    public var results:[T] = []

    // @DataMember(Order=4)
    public var meta:[String:String] = [:]

    // @DataMember(Order=5)
    public var responseStatus:ResponseStatus?
}

public class GetPostResponse
{
    required public init(){}
    public var cache:Int64?
    public var post:Post?
    public var comments:[PostComment] = []
    public var responseStatus:ResponseStatus?
}

public class CreatePostResponse
{
    required public init(){}
    public var id:Int64?
    public var slug:String?
    public var responseStatus:ResponseStatus?
}

public class UpdatePostResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class DeletePostResponse
{
    required public init(){}
    public var id:Int64?
    public var responseStatus:ResponseStatus?
}

public class CreatePostCommentResponse
{
    required public init(){}
    public var id:Int64?
    public var postId:Int64?
    public var responseStatus:ResponseStatus?
}

public class UpdatePostCommentResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class DeletePostCommentResponse
{
    required public init(){}
    public var id:Int64?
    public var postId:Int64?
    public var responseStatus:ResponseStatus?
}

public class GetUserPostCommentVotesResponse
{
    required public init(){}
    public var postId:Int64?
    public var upVotedCommentIds:[Int64] = []
    public var downVotedCommentIds:[Int64] = []
}

public class PinPostCommentResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class GetUsersByEmailsResponse
{
    required public init(){}
    public var results:[UserRef] = []
    public var responseStatus:ResponseStatus?
}

public class GetUserPostActivityResponse
{
    required public init(){}
    public var upVotedPostIds:[Int64] = []
    public var downVotedPostIds:[Int64] = []
    public var favoritePostIds:[Int64] = []
    public var responseStatus:ResponseStatus?
}

public class GetUserOrganizationsResponse
{
    required public init(){}
    public var members:[OrganizationMember] = []
    public var memberInvites:[OrganizationMemberInvite] = []
    public var subscriptions:[OrganizationSubscription] = []
}

public class UserPostVoteResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class UserPostFavoriteResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class UserPostReportResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class UserPostCommentVoteResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class UserPostCommentReportResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class SessionInfoResponse
{
    required public init(){}
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
}

public class GetTechnologyPreviousVersionsResponse
{
    required public init(){}
    public var results:[TechnologyHistory] = []
}

public class GetAllTechnologiesResponse
{
    required public init(){}
    public var results:[Technology] = []
    public var total:Int64?
}

public class GetTechnologyResponse
{
    required public init(){}
    public var created:Date?
    public var technology:Technology?
    public var technologyStacks:[TechnologyStack] = []
    public var responseStatus:ResponseStatus?
}

public class GetTechnologyFavoriteDetailsResponse
{
    required public init(){}
    public var users:[String] = []
    public var favoriteCount:Int?
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

public class GetTechnologyStackPreviousVersionsResponse
{
    required public init(){}
    public var results:[TechnologyStackHistory] = []
}

public class GetPageStatsResponse
{
    required public init(){}
    public var type:String?
    public var slug:String?
    public var viewCount:Int64?
    public var favCount:Int64?
}

public class HourlyTaskResponse
{
    required public init(){}
    public var meta:[String:String] = [:]
    public var responseStatus:ResponseStatus?
}

public class OverviewResponse
{
    required public init(){}
    public var created:Date?
    public var topUsers:[UserInfo] = []
    public var topTechnologies:[TechnologyInfo] = []
    public var latestTechStacks:[TechStackDetails] = []
    public var popularTechStacks:[TechnologyStack] = []
    public var allOrganizations:[OrganizationInfo] = []
    public var topTechnologiesByTier:[String:[TechnologyInfo]] = [:]
    public var responseStatus:ResponseStatus?
}

public class AppOverviewResponse
{
    required public init(){}
    public var created:Date?
    public var allTiers:[Option] = []
    public var topTechnologies:[TechnologyInfo] = []
    public var responseStatus:ResponseStatus?
}

public class GetAllTechnologyStacksResponse
{
    required public init(){}
    public var results:[TechnologyStack] = []
    public var total:Int64?
}

public class GetTechnologyStackResponse
{
    required public init(){}
    public var created:Date?
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?
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
    public var allPostTypes:[Option] = []
    public var allFlagTypes:[Option] = []
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

public class GetUsersKarmaResponse
{
    required public init(){}
    public var results:[Int:Int] = [:]
    public var responseStatus:ResponseStatus?
}

public class GetUserInfoResponse
{
    required public init(){}
    public var id:Int?
    public var userName:String?
    public var created:Date?
    public var avatarUrl:String?
    public var techStacks:[TechnologyStack] = []
    public var favoriteTechStacks:[TechnologyStack] = []
    public var favoriteTechnologies:[Technology] = []
    public var userActivity:UserActivity?
    public var responseStatus:ResponseStatus?
}

public class SyncDiscourseSiteResponse
{
    required public init(){}
    public var timeTaken:String?
    public var userLogs:[String] = []
    public var postsLogs:[String] = []
    public var responseStatus:ResponseStatus?
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

public class EmailTestRespoonse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class ImportUserResponse
{
    required public init(){}
    public var id:Int?
    public var responseStatus:ResponseStatus?
}

public class ImportUserVoiceSuggestionResponse
{
    required public init(){}
    public var postId:Int64?
    public var postSlug:String?
    public var responseStatus:ResponseStatus?
}

public class Post
{
    required public init(){}
    public var id:Int64?
    public var organizationId:Int?
    public var userId:Int?
    public var type:PostType?
    public var categoryId:Int?
    public var title:String?
    public var slug:String?
    public var url:String?
    public var imageUrl:String?
    // @StringLength(2147483647)
    public var content:String?

    // @StringLength(2147483647)
    public var contentHtml:String?

    public var pinCommentId:Int64?
    public var technologyIds:[Int] = []
    public var fromDate:Date?
    public var toDate:Date?
    public var location:String?
    public var metaType:String?
    public var meta:String?
    public var approved:Bool?
    public var upVotes:Int64?
    public var downVotes:Int64?
    public var points:Int64?
    public var views:Int64?
    public var favorites:Int64?
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
    public var lastCommentId:Int64?
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
    public var refId:Int64?
    public var refSource:String?
    public var refUrn:String?
}

public class Organization
{
    required public init(){}
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
    public var upVotes:Int64?
    public var downVotes:Int64?
    public var views:Int64?
    public var favorites:Int64?
    public var subscribers:Int?
    public var commentsCount:Int?
    public var postsCount:Int?
    public var score:Int?
    public var rank:Int?
    public var refId:Int64?
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
}

public class OrganizationLabel
{
    required public init(){}
    public var slug:String?
    public var organizationId:Int?
    public var Description:String?
    public var color:String?
}

public class Category
{
    required public init(){}
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
}

public class OrganizationMember
{
    required public init(){}
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
}

public class OrganizationMemberInvite
{
    required public init(){}
    public var id:Int?
    public var organizationId:Int?
    public var userId:Int?
    public var userName:String?
    public var dismissed:Date?
}

public class PostReportInfo
{
    required public init(){}
    public var id:Int64?
    public var organizationId:Int?
    public var postId:Int64?
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
}

public class PostCommentReportInfo
{
    required public init(){}
    public var id:Int64?
    public var organizationId:Int?
    public var postId:Int64?
    public var postCommentId:Int64?
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
}

public class QueryDb<T : JsonSerializable> : QueryBase
{
    required public init(){}
}

public class PostComment
{
    required public init(){}
    public var id:Int64?
    public var postId:Int64?
    public var userId:Int?
    public var replyId:Int64?
    // @StringLength(2147483647)
    public var content:String?

    // @StringLength(2147483647)
    public var contentHtml:String?

    public var score:Int?
    public var rank:Int?
    public var upVotes:Int64?
    public var downVotes:Int64?
    public var favorites:Int64?
    public var wordCount:Int?
    public var reportCount:Int?
    public var deleted:Date?
    public var hidden:Date?
    public var modified:Date?
    public var created:Date?
    public var createdBy:String?
    public var refId:Int64?
    public var refSource:String?
    public var refUrn:String?
}

public enum PostType : Int
{
    case Announcement
    case Post
    case Showcase
    case Question
    case Request
}

public enum ReportAction : Int
{
    case Dismiss
    case Delete
}

public class UserRef
{
    required public init(){}
    public var id:Int?
    public var userName:String?
    public var email:String?
    public var refId:Int?
    public var refSource:String?
    public var refUrn:String?
}

public class OrganizationSubscription
{
    required public init(){}
    public var id:Int64?
    public var organizationId:Int?
    public var userId:Int?
    public var userName:String?
    public var postTypes:[String] = []
    public var frequencyDays:Int?
    public var lastSyncedId:Int64?
    public var lastSynced:Date?
    public var created:Date?
}

public enum FlagType : Int
{
    case Violation
    case Spam
    case Abusive
    case Confidential
    case OffTopic
    case Other
}

public class TechnologyStack : TechnologyStackBase
{
    required public init(){}
}

public class Technology : TechnologyBase
{
    required public init(){}
}

public class UserActivity
{
    required public init(){}
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
}

public enum Frequency : Int
{
    case Daily = 1
    case Weekly = 7
    case Monthly = 30
    case Quarterly = 90
}

public class TechnologyHistory : TechnologyBase
{
    required public init(){}
    public var technologyId:Int64?
    public var operation:String?
}

public protocol IRegisterStats
{
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

public class TechnologyStackHistory : TechnologyStackBase
{
    required public init(){}
    public var technologyStackId:Int64?
    public var operation:String?
    public var technologyIds:[Int64] = []
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

public class TechStackDetails : TechnologyStackBase
{
    required public init(){}
    public var technologyChoices:[TechnologyInStack] = []
}

public class OrganizationInfo
{
    required public init(){}
    public var id:Int?
    public var name:String?
    public var slug:String?
    public var refId:Int64?
    public var refSource:String?
    public var upVotes:Int64?
    public var downVotes:Int64?
    public var membersCount:Int64?
    public var rank:Int?
    public var disableInvites:Bool?
    public var lang:String?
    public var postTypes:[String] = []
    public var moderatorPostTypes:[String] = []
    public var locked:Date?
    public var labels:[LabelInfo] = []
    public var categories:[CategoryInfo] = []
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

public class UserVoiceUser
{
    required public init(){}
    public var id:Int?
    public var name:String?
    public var email:String?
    public var avatarUrl:String?
    public var createdAt:Date?
    public var updatedAt:Date?
}

public class UserVoiceComment
{
    required public init(){}
    public var text:String?
    public var formattedText:String?
    public var createdAt:Date?
    public var creator:UserVoiceUser?
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

    // @DataMember(Order=5)
    public var include:String?

    // @DataMember(Order=6)
    public var fields:String?

    // @DataMember(Order=7)
    public var meta:[String:String] = [:]
}

public class TechnologyStackBase
{
    required public init(){}
    public var id:Int64?
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
    // @StringLength(2147483647)
    public var details:String?

    // @StringLength(2147483647)
    public var detailsHtml:String?

    public var lastStatusUpdate:Date?
    public var organizationId:Int?
    public var commentsPostId:Int64?
    public var viewCount:Int?
    public var favCount:Int?
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
    public var commentsPostId:Int64?
    public var viewCount:Int?
    public var favCount:Int?
}

public class TechnologyInStack : TechnologyBase
{
    required public init(){}
    public var technologyId:Int64?
    public var technologyStackId:Int64?
    public var justification:String?
}

public class LabelInfo
{
    required public init(){}
    public var slug:String?
    public var color:String?
}

public class CategoryInfo
{
    required public init(){}
    public var id:Int?
    public var name:String?
    public var slug:String?
}


extension DummyTypes : JsonSerializable
{
    public static var typeName:String { return "DummyTypes" }
    public static var metadata = Metadata.create([
            Type<DummyTypes>.arrayProperty("post", get: { $0.post }, set: { $0.post = $1 }),
        ])
}

extension GetOrganization : JsonSerializable
{
    public static var typeName:String { return "GetOrganization" }
    public static var metadata = Metadata.create([
            Type<GetOrganization>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension GetOrganizationBySlug : JsonSerializable
{
    public static var typeName:String { return "GetOrganizationBySlug" }
    public static var metadata = Metadata.create([
            Type<GetOrganizationBySlug>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetOrganizationMembers : JsonSerializable
{
    public static var typeName:String { return "GetOrganizationMembers" }
    public static var metadata = Metadata.create([
            Type<GetOrganizationMembers>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension GetOrganizationAdmin : JsonSerializable
{
    public static var typeName:String { return "GetOrganizationAdmin" }
    public static var metadata = Metadata.create([
            Type<GetOrganizationAdmin>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension CreateOrganizationForTechnology : JsonSerializable
{
    public static var typeName:String { return "CreateOrganizationForTechnology" }
    public static var metadata = Metadata.create([
            Type<CreateOrganizationForTechnology>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
            Type<CreateOrganizationForTechnology>.optionalProperty("techStackId", get: { $0.techStackId }, set: { $0.techStackId = $1 }),
        ])
}

extension CreateOrganization : JsonSerializable
{
    public static var typeName:String { return "CreateOrganization" }
    public static var metadata = Metadata.create([
            Type<CreateOrganization>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<CreateOrganization>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<CreateOrganization>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<CreateOrganization>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
            Type<CreateOrganization>.optionalProperty("refSource", get: { $0.refSource }, set: { $0.refSource = $1 }),
            Type<CreateOrganization>.optionalProperty("refUrn", get: { $0.refUrn }, set: { $0.refUrn = $1 }),
        ])
}

extension UpdateOrganization : JsonSerializable
{
    public static var typeName:String { return "UpdateOrganization" }
    public static var metadata = Metadata.create([
            Type<UpdateOrganization>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UpdateOrganization>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<UpdateOrganization>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<UpdateOrganization>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<UpdateOrganization>.optionalProperty("color", get: { $0.color }, set: { $0.color = $1 }),
            Type<UpdateOrganization>.optionalProperty("textColor", get: { $0.textColor }, set: { $0.textColor = $1 }),
            Type<UpdateOrganization>.optionalProperty("linkColor", get: { $0.linkColor }, set: { $0.linkColor = $1 }),
            Type<UpdateOrganization>.optionalProperty("backgroundColor", get: { $0.backgroundColor }, set: { $0.backgroundColor = $1 }),
            Type<UpdateOrganization>.optionalProperty("backgroundUrl", get: { $0.backgroundUrl }, set: { $0.backgroundUrl = $1 }),
            Type<UpdateOrganization>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
            Type<UpdateOrganization>.optionalProperty("heroUrl", get: { $0.heroUrl }, set: { $0.heroUrl = $1 }),
            Type<UpdateOrganization>.optionalProperty("lang", get: { $0.lang }, set: { $0.lang = $1 }),
            Type<UpdateOrganization>.optionalProperty("deletePostsWithReportCount", get: { $0.deletePostsWithReportCount }, set: { $0.deletePostsWithReportCount = $1 }),
            Type<UpdateOrganization>.optionalProperty("disableInvites", get: { $0.disableInvites }, set: { $0.disableInvites = $1 }),
            Type<UpdateOrganization>.optionalProperty("defaultPostType", get: { $0.defaultPostType }, set: { $0.defaultPostType = $1 }),
            Type<UpdateOrganization>.arrayProperty("defaultSubscriptionPostTypes", get: { $0.defaultSubscriptionPostTypes }, set: { $0.defaultSubscriptionPostTypes = $1 }),
            Type<UpdateOrganization>.arrayProperty("postTypes", get: { $0.postTypes }, set: { $0.postTypes = $1 }),
            Type<UpdateOrganization>.arrayProperty("moderatorPostTypes", get: { $0.moderatorPostTypes }, set: { $0.moderatorPostTypes = $1 }),
            Type<UpdateOrganization>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
        ])
}

extension DeleteOrganization : JsonSerializable
{
    public static var typeName:String { return "DeleteOrganization" }
    public static var metadata = Metadata.create([
            Type<DeleteOrganization>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension LockOrganization : JsonSerializable
{
    public static var typeName:String { return "LockOrganization" }
    public static var metadata = Metadata.create([
            Type<LockOrganization>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<LockOrganization>.optionalProperty("lock", get: { $0.lock }, set: { $0.lock = $1 }),
            Type<LockOrganization>.optionalProperty("reason", get: { $0.reason }, set: { $0.reason = $1 }),
        ])
}

extension AddOrganizationLabel : JsonSerializable
{
    public static var typeName:String { return "AddOrganizationLabel" }
    public static var metadata = Metadata.create([
            Type<AddOrganizationLabel>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<AddOrganizationLabel>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<AddOrganizationLabel>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<AddOrganizationLabel>.optionalProperty("color", get: { $0.color }, set: { $0.color = $1 }),
        ])
}

extension UpdateOrganizationLabel : JsonSerializable
{
    public static var typeName:String { return "UpdateOrganizationLabel" }
    public static var metadata = Metadata.create([
            Type<UpdateOrganizationLabel>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<UpdateOrganizationLabel>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<UpdateOrganizationLabel>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<UpdateOrganizationLabel>.optionalProperty("color", get: { $0.color }, set: { $0.color = $1 }),
        ])
}

extension RemoveOrganizationLabel : JsonSerializable
{
    public static var typeName:String { return "RemoveOrganizationLabel" }
    public static var metadata = Metadata.create([
            Type<RemoveOrganizationLabel>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<RemoveOrganizationLabel>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension AddOrganizationCategory : JsonSerializable
{
    public static var typeName:String { return "AddOrganizationCategory" }
    public static var metadata = Metadata.create([
            Type<AddOrganizationCategory>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<AddOrganizationCategory>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<AddOrganizationCategory>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<AddOrganizationCategory>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<AddOrganizationCategory>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
        ])
}

extension UpdateOrganizationCategory : JsonSerializable
{
    public static var typeName:String { return "UpdateOrganizationCategory" }
    public static var metadata = Metadata.create([
            Type<UpdateOrganizationCategory>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<UpdateOrganizationCategory>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UpdateOrganizationCategory>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<UpdateOrganizationCategory>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<UpdateOrganizationCategory>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<UpdateOrganizationCategory>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
        ])
}

extension DeleteOrganizationCategory : JsonSerializable
{
    public static var typeName:String { return "DeleteOrganizationCategory" }
    public static var metadata = Metadata.create([
            Type<DeleteOrganizationCategory>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<DeleteOrganizationCategory>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension AddOrganizationMember : JsonSerializable
{
    public static var typeName:String { return "AddOrganizationMember" }
    public static var metadata = Metadata.create([
            Type<AddOrganizationMember>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<AddOrganizationMember>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<AddOrganizationMember>.optionalProperty("isOwner", get: { $0.isOwner }, set: { $0.isOwner = $1 }),
            Type<AddOrganizationMember>.optionalProperty("isModerator", get: { $0.isModerator }, set: { $0.isModerator = $1 }),
            Type<AddOrganizationMember>.optionalProperty("denyPosts", get: { $0.denyPosts }, set: { $0.denyPosts = $1 }),
            Type<AddOrganizationMember>.optionalProperty("denyComments", get: { $0.denyComments }, set: { $0.denyComments = $1 }),
            Type<AddOrganizationMember>.optionalProperty("denyAll", get: { $0.denyAll }, set: { $0.denyAll = $1 }),
            Type<AddOrganizationMember>.optionalProperty("notes", get: { $0.notes }, set: { $0.notes = $1 }),
        ])
}

extension UpdateOrganizationMember : JsonSerializable
{
    public static var typeName:String { return "UpdateOrganizationMember" }
    public static var metadata = Metadata.create([
            Type<UpdateOrganizationMember>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<UpdateOrganizationMember>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<UpdateOrganizationMember>.optionalProperty("isOwner", get: { $0.isOwner }, set: { $0.isOwner = $1 }),
            Type<UpdateOrganizationMember>.optionalProperty("isModerator", get: { $0.isModerator }, set: { $0.isModerator = $1 }),
            Type<UpdateOrganizationMember>.optionalProperty("denyPosts", get: { $0.denyPosts }, set: { $0.denyPosts = $1 }),
            Type<UpdateOrganizationMember>.optionalProperty("denyComments", get: { $0.denyComments }, set: { $0.denyComments = $1 }),
            Type<UpdateOrganizationMember>.optionalProperty("denyAll", get: { $0.denyAll }, set: { $0.denyAll = $1 }),
            Type<UpdateOrganizationMember>.optionalProperty("notes", get: { $0.notes }, set: { $0.notes = $1 }),
        ])
}

extension RemoveOrganizationMember : JsonSerializable
{
    public static var typeName:String { return "RemoveOrganizationMember" }
    public static var metadata = Metadata.create([
            Type<RemoveOrganizationMember>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<RemoveOrganizationMember>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
        ])
}

extension SetOrganizationMembers : JsonSerializable
{
    public static var typeName:String { return "SetOrganizationMembers" }
    public static var metadata = Metadata.create([
            Type<SetOrganizationMembers>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<SetOrganizationMembers>.arrayProperty("githubUserNames", get: { $0.githubUserNames }, set: { $0.githubUserNames = $1 }),
            Type<SetOrganizationMembers>.arrayProperty("twitterUserNames", get: { $0.twitterUserNames }, set: { $0.twitterUserNames = $1 }),
            Type<SetOrganizationMembers>.arrayProperty("emails", get: { $0.emails }, set: { $0.emails = $1 }),
            Type<SetOrganizationMembers>.optionalProperty("removeUnspecifiedMembers", get: { $0.removeUnspecifiedMembers }, set: { $0.removeUnspecifiedMembers = $1 }),
            Type<SetOrganizationMembers>.optionalProperty("isOwner", get: { $0.isOwner }, set: { $0.isOwner = $1 }),
            Type<SetOrganizationMembers>.optionalProperty("isModerator", get: { $0.isModerator }, set: { $0.isModerator = $1 }),
            Type<SetOrganizationMembers>.optionalProperty("denyPosts", get: { $0.denyPosts }, set: { $0.denyPosts = $1 }),
            Type<SetOrganizationMembers>.optionalProperty("denyComments", get: { $0.denyComments }, set: { $0.denyComments = $1 }),
            Type<SetOrganizationMembers>.optionalProperty("denyAll", get: { $0.denyAll }, set: { $0.denyAll = $1 }),
        ])
}

extension GetOrganizationMemberInvites : JsonSerializable
{
    public static var typeName:String { return "GetOrganizationMemberInvites" }
    public static var metadata = Metadata.create([
            Type<GetOrganizationMemberInvites>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
        ])
}

extension RequestOrganizationMemberInvite : JsonSerializable
{
    public static var typeName:String { return "RequestOrganizationMemberInvite" }
    public static var metadata = Metadata.create([
            Type<RequestOrganizationMemberInvite>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
        ])
}

extension UpdateOrganizationMemberInvite : JsonSerializable
{
    public static var typeName:String { return "UpdateOrganizationMemberInvite" }
    public static var metadata = Metadata.create([
            Type<UpdateOrganizationMemberInvite>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<UpdateOrganizationMemberInvite>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<UpdateOrganizationMemberInvite>.optionalProperty("approve", get: { $0.approve }, set: { $0.approve = $1 }),
            Type<UpdateOrganizationMemberInvite>.optionalProperty("dismiss", get: { $0.dismiss }, set: { $0.dismiss = $1 }),
        ])
}

extension QueryPosts : JsonSerializable
{
    public static var typeName:String { return "QueryPosts" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<QueryPosts>.arrayProperty("ids", get: { $0.ids }, set: { $0.ids = $1 }),
            Type<QueryPosts>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<QueryPosts>.arrayProperty("organizationIds", get: { $0.organizationIds }, set: { $0.organizationIds = $1 }),
            Type<QueryPosts>.arrayProperty("types", get: { $0.types }, set: { $0.types = $1 }),
            Type<QueryPosts>.arrayProperty("anyTechnologyIds", get: { $0.anyTechnologyIds }, set: { $0.anyTechnologyIds = $1 }),
            Type<QueryPosts>.arrayProperty("is", get: { $0.`is` }, set: { $0.`is` = $1 }),
            Type<QueryPosts>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
            Type<QueryPosts>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
            Type<QueryPosts>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
            Type<QueryPosts>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
            Type<QueryPosts>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
            Type<QueryPosts>.optionalProperty("fields", get: { $0.fields }, set: { $0.fields = $1 }),
            Type<QueryPosts>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
    }
}

extension GetPost : JsonSerializable
{
    public static var typeName:String { return "GetPost" }
    public static var metadata = Metadata.create([
            Type<GetPost>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<GetPost>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
        ])
}

extension CreatePost : JsonSerializable
{
    public static var typeName:String { return "CreatePost" }
    public static var metadata = Metadata.create([
            Type<CreatePost>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<CreatePost>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
            Type<CreatePost>.optionalProperty("categoryId", get: { $0.categoryId }, set: { $0.categoryId = $1 }),
            Type<CreatePost>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
            Type<CreatePost>.optionalProperty("url", get: { $0.url }, set: { $0.url = $1 }),
            Type<CreatePost>.optionalProperty("imageUrl", get: { $0.imageUrl }, set: { $0.imageUrl = $1 }),
            Type<CreatePost>.optionalProperty("content", get: { $0.content }, set: { $0.content = $1 }),
            Type<CreatePost>.optionalProperty("lock", get: { $0.lock }, set: { $0.lock = $1 }),
            Type<CreatePost>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
            Type<CreatePost>.arrayProperty("labels", get: { $0.labels }, set: { $0.labels = $1 }),
            Type<CreatePost>.optionalProperty("fromDate", get: { $0.fromDate }, set: { $0.fromDate = $1 }),
            Type<CreatePost>.optionalProperty("toDate", get: { $0.toDate }, set: { $0.toDate = $1 }),
            Type<CreatePost>.optionalProperty("metaType", get: { $0.metaType }, set: { $0.metaType = $1 }),
            Type<CreatePost>.optionalProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            Type<CreatePost>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
            Type<CreatePost>.optionalProperty("refSource", get: { $0.refSource }, set: { $0.refSource = $1 }),
            Type<CreatePost>.optionalProperty("refUrn", get: { $0.refUrn }, set: { $0.refUrn = $1 }),
        ])
}

extension UpdatePost : JsonSerializable
{
    public static var typeName:String { return "UpdatePost" }
    public static var metadata = Metadata.create([
            Type<UpdatePost>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UpdatePost>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<UpdatePost>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
            Type<UpdatePost>.optionalProperty("categoryId", get: { $0.categoryId }, set: { $0.categoryId = $1 }),
            Type<UpdatePost>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
            Type<UpdatePost>.optionalProperty("url", get: { $0.url }, set: { $0.url = $1 }),
            Type<UpdatePost>.optionalProperty("imageUrl", get: { $0.imageUrl }, set: { $0.imageUrl = $1 }),
            Type<UpdatePost>.optionalProperty("content", get: { $0.content }, set: { $0.content = $1 }),
            Type<UpdatePost>.optionalProperty("lock", get: { $0.lock }, set: { $0.lock = $1 }),
            Type<UpdatePost>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
            Type<UpdatePost>.arrayProperty("labels", get: { $0.labels }, set: { $0.labels = $1 }),
            Type<UpdatePost>.optionalProperty("fromDate", get: { $0.fromDate }, set: { $0.fromDate = $1 }),
            Type<UpdatePost>.optionalProperty("toDate", get: { $0.toDate }, set: { $0.toDate = $1 }),
            Type<UpdatePost>.optionalProperty("metaType", get: { $0.metaType }, set: { $0.metaType = $1 }),
            Type<UpdatePost>.optionalProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension DeletePost : JsonSerializable
{
    public static var typeName:String { return "DeletePost" }
    public static var metadata = Metadata.create([
            Type<DeletePost>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension LockPost : JsonSerializable
{
    public static var typeName:String { return "LockPost" }
    public static var metadata = Metadata.create([
            Type<LockPost>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<LockPost>.optionalProperty("lock", get: { $0.lock }, set: { $0.lock = $1 }),
            Type<LockPost>.optionalProperty("reason", get: { $0.reason }, set: { $0.reason = $1 }),
        ])
}

extension HidePost : JsonSerializable
{
    public static var typeName:String { return "HidePost" }
    public static var metadata = Metadata.create([
            Type<HidePost>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<HidePost>.optionalProperty("hide", get: { $0.hide }, set: { $0.hide = $1 }),
            Type<HidePost>.optionalProperty("reason", get: { $0.reason }, set: { $0.reason = $1 }),
        ])
}

extension ChangeStatusPost : JsonSerializable
{
    public static var typeName:String { return "ChangeStatusPost" }
    public static var metadata = Metadata.create([
            Type<ChangeStatusPost>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<ChangeStatusPost>.optionalProperty("status", get: { $0.status }, set: { $0.status = $1 }),
            Type<ChangeStatusPost>.optionalProperty("reason", get: { $0.reason }, set: { $0.reason = $1 }),
        ])
}

extension ActionPostReport : JsonSerializable
{
    public static var typeName:String { return "ActionPostReport" }
    public static var metadata = Metadata.create([
            Type<ActionPostReport>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<ActionPostReport>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<ActionPostReport>.optionalProperty("reportAction", get: { $0.reportAction }, set: { $0.reportAction = $1 }),
        ])
}

extension CreatePostComment : JsonSerializable
{
    public static var typeName:String { return "CreatePostComment" }
    public static var metadata = Metadata.create([
            Type<CreatePostComment>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<CreatePostComment>.optionalProperty("replyId", get: { $0.replyId }, set: { $0.replyId = $1 }),
            Type<CreatePostComment>.optionalProperty("content", get: { $0.content }, set: { $0.content = $1 }),
        ])
}

extension UpdatePostComment : JsonSerializable
{
    public static var typeName:String { return "UpdatePostComment" }
    public static var metadata = Metadata.create([
            Type<UpdatePostComment>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UpdatePostComment>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<UpdatePostComment>.optionalProperty("content", get: { $0.content }, set: { $0.content = $1 }),
        ])
}

extension DeletePostComment : JsonSerializable
{
    public static var typeName:String { return "DeletePostComment" }
    public static var metadata = Metadata.create([
            Type<DeletePostComment>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<DeletePostComment>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
        ])
}

extension ActionPostCommentReport : JsonSerializable
{
    public static var typeName:String { return "ActionPostCommentReport" }
    public static var metadata = Metadata.create([
            Type<ActionPostCommentReport>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<ActionPostCommentReport>.optionalProperty("postCommentId", get: { $0.postCommentId }, set: { $0.postCommentId = $1 }),
            Type<ActionPostCommentReport>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<ActionPostCommentReport>.optionalProperty("reportAction", get: { $0.reportAction }, set: { $0.reportAction = $1 }),
        ])
}

extension GetUserPostCommentVotes : JsonSerializable
{
    public static var typeName:String { return "GetUserPostCommentVotes" }
    public static var metadata = Metadata.create([
            Type<GetUserPostCommentVotes>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
        ])
}

extension PinPostComment : JsonSerializable
{
    public static var typeName:String { return "PinPostComment" }
    public static var metadata = Metadata.create([
            Type<PinPostComment>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<PinPostComment>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<PinPostComment>.optionalProperty("pin", get: { $0.pin }, set: { $0.pin = $1 }),
        ])
}

extension GetUsersByEmails : JsonSerializable
{
    public static var typeName:String { return "GetUsersByEmails" }
    public static var metadata = Metadata.create([
            Type<GetUsersByEmails>.arrayProperty("emails", get: { $0.emails }, set: { $0.emails = $1 }),
        ])
}

extension GetUserPostActivity : JsonSerializable
{
    public static var typeName:String { return "GetUserPostActivity" }
    public static var metadata = Metadata.create([
        ])
}

extension GetUserOrganizations : JsonSerializable
{
    public static var typeName:String { return "GetUserOrganizations" }
    public static var metadata = Metadata.create([
        ])
}

extension UserPostVote : JsonSerializable
{
    public static var typeName:String { return "UserPostVote" }
    public static var metadata = Metadata.create([
            Type<UserPostVote>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UserPostVote>.optionalProperty("weight", get: { $0.weight }, set: { $0.weight = $1 }),
        ])
}

extension UserPostFavorite : JsonSerializable
{
    public static var typeName:String { return "UserPostFavorite" }
    public static var metadata = Metadata.create([
            Type<UserPostFavorite>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension UserPostReport : JsonSerializable
{
    public static var typeName:String { return "UserPostReport" }
    public static var metadata = Metadata.create([
            Type<UserPostReport>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UserPostReport>.optionalProperty("flagType", get: { $0.flagType }, set: { $0.flagType = $1 }),
            Type<UserPostReport>.optionalProperty("reportNotes", get: { $0.reportNotes }, set: { $0.reportNotes = $1 }),
        ])
}

extension UserPostCommentVote : JsonSerializable
{
    public static var typeName:String { return "UserPostCommentVote" }
    public static var metadata = Metadata.create([
            Type<UserPostCommentVote>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UserPostCommentVote>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<UserPostCommentVote>.optionalProperty("weight", get: { $0.weight }, set: { $0.weight = $1 }),
        ])
}

extension UserPostCommentReport : JsonSerializable
{
    public static var typeName:String { return "UserPostCommentReport" }
    public static var metadata = Metadata.create([
            Type<UserPostCommentReport>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UserPostCommentReport>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<UserPostCommentReport>.optionalProperty("flagType", get: { $0.flagType }, set: { $0.flagType = $1 }),
            Type<UserPostCommentReport>.optionalProperty("reportNotes", get: { $0.reportNotes }, set: { $0.reportNotes = $1 }),
        ])
}

extension StorePreRender : JsonSerializable
{
    public static var typeName:String { return "StorePreRender" }
    public static var metadata = Metadata.create([
            Type<StorePreRender>.optionalProperty("path", get: { $0.path }, set: { $0.path = $1 }),
        ])
}

extension GetPreRender : JsonSerializable
{
    public static var typeName:String { return "GetPreRender" }
    public static var metadata = Metadata.create([
            Type<GetPreRender>.optionalProperty("path", get: { $0.path }, set: { $0.path = $1 }),
        ])
}

extension SessionInfo : JsonSerializable
{
    public static var typeName:String { return "SessionInfo" }
    public static var metadata = Metadata.create([
        ])
}

extension SubscribeToOrganization : JsonSerializable
{
    public static var typeName:String { return "SubscribeToOrganization" }
    public static var metadata = Metadata.create([
            Type<SubscribeToOrganization>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<SubscribeToOrganization>.arrayProperty("postTypes", get: { $0.postTypes }, set: { $0.postTypes = $1 }),
            Type<SubscribeToOrganization>.optionalProperty("frequency", get: { $0.frequency }, set: { $0.frequency = $1 }),
        ])
}

extension SubscribeToPost : JsonSerializable
{
    public static var typeName:String { return "SubscribeToPost" }
    public static var metadata = Metadata.create([
            Type<SubscribeToPost>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
        ])
}

extension DeleteOrganizationSubscription : JsonSerializable
{
    public static var typeName:String { return "DeleteOrganizationSubscription" }
    public static var metadata = Metadata.create([
            Type<DeleteOrganizationSubscription>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
        ])
}

extension DeletePostSubscription : JsonSerializable
{
    public static var typeName:String { return "DeletePostSubscription" }
    public static var metadata = Metadata.create([
            Type<DeletePostSubscription>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
        ])
}

extension GetTechnologyPreviousVersions : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyPreviousVersions" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyPreviousVersions>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetAllTechnologies : JsonSerializable
{
    public static var typeName:String { return "GetAllTechnologies" }
    public static var metadata = Metadata.create([
        ])
}

extension FindTechnologies : JsonSerializable
{
    public static var typeName:String { return "FindTechnologies" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<FindTechnologies>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<FindTechnologies>.optionalProperty("nameContains", get: { $0.nameContains }, set: { $0.nameContains = $1 }),
            Type<FindTechnologies>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
            Type<FindTechnologies>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
            Type<FindTechnologies>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
            Type<FindTechnologies>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
            Type<FindTechnologies>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
            Type<FindTechnologies>.optionalProperty("fields", get: { $0.fields }, set: { $0.fields = $1 }),
            Type<FindTechnologies>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
    }
}

extension QueryTechnology : JsonSerializable
{
    public static var typeName:String { return "QueryTechnology" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<QueryTechnology>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
            Type<QueryTechnology>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
            Type<QueryTechnology>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
            Type<QueryTechnology>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
            Type<QueryTechnology>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
            Type<QueryTechnology>.optionalProperty("fields", get: { $0.fields }, set: { $0.fields = $1 }),
            Type<QueryTechnology>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
    }
}

extension GetTechnology : JsonSerializable
{
    public static var typeName:String { return "GetTechnology" }
    public static var metadata = Metadata.create([
            Type<GetTechnology>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetTechnologyFavoriteDetails : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyFavoriteDetails" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyFavoriteDetails>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension CreateTechnology : JsonSerializable
{
    public static var typeName:String { return "CreateTechnology" }
    public static var metadata = Metadata.create([
            Type<CreateTechnology>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<CreateTechnology>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<CreateTechnology>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<CreateTechnology>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
            Type<CreateTechnology>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
            Type<CreateTechnology>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
            Type<CreateTechnology>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<CreateTechnology>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
            Type<CreateTechnology>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
        ])
}

extension UpdateTechnology : JsonSerializable
{
    public static var typeName:String { return "UpdateTechnology" }
    public static var metadata = Metadata.create([
            Type<UpdateTechnology>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UpdateTechnology>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<UpdateTechnology>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<UpdateTechnology>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
            Type<UpdateTechnology>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
            Type<UpdateTechnology>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
            Type<UpdateTechnology>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<UpdateTechnology>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
            Type<UpdateTechnology>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
        ])
}

extension DeleteTechnology : JsonSerializable
{
    public static var typeName:String { return "DeleteTechnology" }
    public static var metadata = Metadata.create([
            Type<DeleteTechnology>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension GetTechnologyStackPreviousVersions : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackPreviousVersions" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyStackPreviousVersions>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetPageStats : JsonSerializable
{
    public static var typeName:String { return "GetPageStats" }
    public static var metadata = Metadata.create([
            Type<GetPageStats>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
            Type<GetPageStats>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<GetPageStats>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension ClearCache : JsonSerializable
{
    public static var typeName:String { return "ClearCache" }
    public static var metadata = Metadata.create([
        ])
}

extension HourlyTask : JsonSerializable
{
    public static var typeName:String { return "HourlyTask" }
    public static var metadata = Metadata.create([
            Type<HourlyTask>.optionalProperty("force", get: { $0.force }, set: { $0.force = $1 }),
        ])
}

extension FindTechStacks : JsonSerializable
{
    public static var typeName:String { return "FindTechStacks" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<FindTechStacks>.optionalProperty("nameContains", get: { $0.nameContains }, set: { $0.nameContains = $1 }),
            Type<FindTechStacks>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
            Type<FindTechStacks>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
            Type<FindTechStacks>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
            Type<FindTechStacks>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
            Type<FindTechStacks>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
            Type<FindTechStacks>.optionalProperty("fields", get: { $0.fields }, set: { $0.fields = $1 }),
            Type<FindTechStacks>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
    }
}

extension QueryTechStacks : JsonSerializable
{
    public static var typeName:String { return "QueryTechStacks" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<QueryTechStacks>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
            Type<QueryTechStacks>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
            Type<QueryTechStacks>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
            Type<QueryTechStacks>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
            Type<QueryTechStacks>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
            Type<QueryTechStacks>.optionalProperty("fields", get: { $0.fields }, set: { $0.fields = $1 }),
            Type<QueryTechStacks>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
    }
}

extension Overview : JsonSerializable
{
    public static var typeName:String { return "Overview" }
    public static var metadata = Metadata.create([
            Type<Overview>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        ])
}

extension AppOverview : JsonSerializable
{
    public static var typeName:String { return "AppOverview" }
    public static var metadata = Metadata.create([
            Type<AppOverview>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        ])
}

extension GetAllTechnologyStacks : JsonSerializable
{
    public static var typeName:String { return "GetAllTechnologyStacks" }
    public static var metadata = Metadata.create([
        ])
}

extension GetTechnologyStack : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStack" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyStack>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetTechnologyStackFavoriteDetails : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackFavoriteDetails" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyStackFavoriteDetails>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetConfig : JsonSerializable
{
    public static var typeName:String { return "GetConfig" }
    public static var metadata = Metadata.create([
        ])
}

extension CreateTechnologyStack : JsonSerializable
{
    public static var typeName:String { return "CreateTechnologyStack" }
    public static var metadata = Metadata.create([
            Type<CreateTechnologyStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<CreateTechnologyStack>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<CreateTechnologyStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<CreateTechnologyStack>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
            Type<CreateTechnologyStack>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
            Type<CreateTechnologyStack>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<CreateTechnologyStack>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
            Type<CreateTechnologyStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
            Type<CreateTechnologyStack>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
        ])
}

extension UpdateTechnologyStack : JsonSerializable
{
    public static var typeName:String { return "UpdateTechnologyStack" }
    public static var metadata = Metadata.create([
            Type<UpdateTechnologyStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UpdateTechnologyStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<UpdateTechnologyStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<UpdateTechnologyStack>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
            Type<UpdateTechnologyStack>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
            Type<UpdateTechnologyStack>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<UpdateTechnologyStack>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
            Type<UpdateTechnologyStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
            Type<UpdateTechnologyStack>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
        ])
}

extension DeleteTechnologyStack : JsonSerializable
{
    public static var typeName:String { return "DeleteTechnologyStack" }
    public static var metadata = Metadata.create([
            Type<DeleteTechnologyStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension GetFavoriteTechStack : JsonSerializable
{
    public static var typeName:String { return "GetFavoriteTechStack" }
    public static var metadata = Metadata.create([
            Type<GetFavoriteTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
        ])
}

extension AddFavoriteTechStack : JsonSerializable
{
    public static var typeName:String { return "AddFavoriteTechStack" }
    public static var metadata = Metadata.create([
            Type<AddFavoriteTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
        ])
}

extension RemoveFavoriteTechStack : JsonSerializable
{
    public static var typeName:String { return "RemoveFavoriteTechStack" }
    public static var metadata = Metadata.create([
            Type<RemoveFavoriteTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
        ])
}

extension GetFavoriteTechnologies : JsonSerializable
{
    public static var typeName:String { return "GetFavoriteTechnologies" }
    public static var metadata = Metadata.create([
            Type<GetFavoriteTechnologies>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        ])
}

extension AddFavoriteTechnology : JsonSerializable
{
    public static var typeName:String { return "AddFavoriteTechnology" }
    public static var metadata = Metadata.create([
            Type<AddFavoriteTechnology>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        ])
}

extension RemoveFavoriteTechnology : JsonSerializable
{
    public static var typeName:String { return "RemoveFavoriteTechnology" }
    public static var metadata = Metadata.create([
            Type<RemoveFavoriteTechnology>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        ])
}

extension GetUserFeed : JsonSerializable
{
    public static var typeName:String { return "GetUserFeed" }
    public static var metadata = Metadata.create([
        ])
}

extension GetUsersKarma : JsonSerializable
{
    public static var typeName:String { return "GetUsersKarma" }
    public static var metadata = Metadata.create([
            Type<GetUsersKarma>.arrayProperty("userIds", get: { $0.userIds }, set: { $0.userIds = $1 }),
        ])
}

extension GetUserInfo : JsonSerializable
{
    public static var typeName:String { return "GetUserInfo" }
    public static var metadata = Metadata.create([
            Type<GetUserInfo>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        ])
}

extension UserAvatar : JsonSerializable
{
    public static var typeName:String { return "UserAvatar" }
    public static var metadata = Metadata.create([
            Type<UserAvatar>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        ])
}

extension MqStart : JsonSerializable
{
    public static var typeName:String { return "MqStart" }
    public static var metadata = Metadata.create([
        ])
}

extension MqStop : JsonSerializable
{
    public static var typeName:String { return "MqStop" }
    public static var metadata = Metadata.create([
        ])
}

extension MqStats : JsonSerializable
{
    public static var typeName:String { return "MqStats" }
    public static var metadata = Metadata.create([
        ])
}

extension MqStatus : JsonSerializable
{
    public static var typeName:String { return "MqStatus" }
    public static var metadata = Metadata.create([
        ])
}

extension SyncDiscourseSite : JsonSerializable
{
    public static var typeName:String { return "SyncDiscourseSite" }
    public static var metadata = Metadata.create([
            Type<SyncDiscourseSite>.optionalProperty("site", get: { $0.site }, set: { $0.site = $1 }),
        ])
}

extension LogoUrlApproval : JsonSerializable
{
    public static var typeName:String { return "LogoUrlApproval" }
    public static var metadata = Metadata.create([
            Type<LogoUrlApproval>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
            Type<LogoUrlApproval>.optionalProperty("approved", get: { $0.approved }, set: { $0.approved = $1 }),
        ])
}

extension LockTechStack : JsonSerializable
{
    public static var typeName:String { return "LockTechStack" }
    public static var metadata = Metadata.create([
            Type<LockTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
            Type<LockTechStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        ])
}

extension LockTech : JsonSerializable
{
    public static var typeName:String { return "LockTech" }
    public static var metadata = Metadata.create([
            Type<LockTech>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
            Type<LockTech>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        ])
}

extension EmailTest : JsonSerializable
{
    public static var typeName:String { return "EmailTest" }
    public static var metadata = Metadata.create([
            Type<EmailTest>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
        ])
}

extension ImportUser : JsonSerializable
{
    public static var typeName:String { return "ImportUser" }
    public static var metadata = Metadata.create([
            Type<ImportUser>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<ImportUser>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
            Type<ImportUser>.optionalProperty("firstName", get: { $0.firstName }, set: { $0.firstName = $1 }),
            Type<ImportUser>.optionalProperty("lastName", get: { $0.lastName }, set: { $0.lastName = $1 }),
            Type<ImportUser>.optionalProperty("displayName", get: { $0.displayName }, set: { $0.displayName = $1 }),
            Type<ImportUser>.optionalProperty("company", get: { $0.company }, set: { $0.company = $1 }),
            Type<ImportUser>.optionalProperty("refSource", get: { $0.refSource }, set: { $0.refSource = $1 }),
            Type<ImportUser>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
            Type<ImportUser>.optionalProperty("refIdStr", get: { $0.refIdStr }, set: { $0.refIdStr = $1 }),
            Type<ImportUser>.optionalProperty("refUrn", get: { $0.refUrn }, set: { $0.refUrn = $1 }),
            Type<ImportUser>.optionalProperty("defaultProfileUrl", get: { $0.defaultProfileUrl }, set: { $0.defaultProfileUrl = $1 }),
            Type<ImportUser>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension ImportUserVoiceSuggestion : JsonSerializable
{
    public static var typeName:String { return "ImportUserVoiceSuggestion" }
    public static var metadata = Metadata.create([
            Type<ImportUserVoiceSuggestion>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("url", get: { $0.url }, set: { $0.url = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("topicId", get: { $0.topicId }, set: { $0.topicId = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("state", get: { $0.state }, set: { $0.state = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("category", get: { $0.category }, set: { $0.category = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("text", get: { $0.text }, set: { $0.text = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("formattedText", get: { $0.formattedText }, set: { $0.formattedText = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("voteCount", get: { $0.voteCount }, set: { $0.voteCount = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("closedAt", get: { $0.closedAt }, set: { $0.closedAt = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("statusKey", get: { $0.statusKey }, set: { $0.statusKey = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("statusHexColor", get: { $0.statusHexColor }, set: { $0.statusHexColor = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalObjectProperty("statusChangedBy", get: { $0.statusChangedBy }, set: { $0.statusChangedBy = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalObjectProperty("creator", get: { $0.creator }, set: { $0.creator = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalObjectProperty("response", get: { $0.response }, set: { $0.response = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("createdAt", get: { $0.createdAt }, set: { $0.createdAt = $1 }),
            Type<ImportUserVoiceSuggestion>.optionalProperty("updatedAt", get: { $0.updatedAt }, set: { $0.updatedAt = $1 }),
        ])
}

extension QueryPostComments : JsonSerializable
{
    public static var typeName:String { return "QueryPostComments" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<QueryPostComments>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<QueryPostComments>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<QueryPostComments>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
            Type<QueryPostComments>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
            Type<QueryPostComments>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
            Type<QueryPostComments>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
            Type<QueryPostComments>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
            Type<QueryPostComments>.optionalProperty("fields", get: { $0.fields }, set: { $0.fields = $1 }),
            Type<QueryPostComments>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
    }
}

extension FindTechnologiesAdmin : JsonSerializable
{
    public static var typeName:String { return "FindTechnologiesAdmin" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<FindTechnologiesAdmin>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<FindTechnologiesAdmin>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
            Type<FindTechnologiesAdmin>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
            Type<FindTechnologiesAdmin>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
            Type<FindTechnologiesAdmin>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
            Type<FindTechnologiesAdmin>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
            Type<FindTechnologiesAdmin>.optionalProperty("fields", get: { $0.fields }, set: { $0.fields = $1 }),
            Type<FindTechnologiesAdmin>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
    }
}

extension GetOrganizationResponse : JsonSerializable
{
    public static var typeName:String { return "GetOrganizationResponse" }
    public static var metadata = Metadata.create([
            Type<GetOrganizationResponse>.optionalProperty("cache", get: { $0.cache }, set: { $0.cache = $1 }),
            Type<GetOrganizationResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<GetOrganizationResponse>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<GetOrganizationResponse>.optionalObjectProperty("organization", get: { $0.organization }, set: { $0.organization = $1 }),
            Type<GetOrganizationResponse>.arrayProperty("labels", get: { $0.labels }, set: { $0.labels = $1 }),
            Type<GetOrganizationResponse>.arrayProperty("categories", get: { $0.categories }, set: { $0.categories = $1 }),
            Type<GetOrganizationResponse>.arrayProperty("owners", get: { $0.owners }, set: { $0.owners = $1 }),
            Type<GetOrganizationResponse>.arrayProperty("moderators", get: { $0.moderators }, set: { $0.moderators = $1 }),
            Type<GetOrganizationResponse>.optionalProperty("membersCount", get: { $0.membersCount }, set: { $0.membersCount = $1 }),
            Type<GetOrganizationResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetOrganizationMembersResponse : JsonSerializable
{
    public static var typeName:String { return "GetOrganizationMembersResponse" }
    public static var metadata = Metadata.create([
            Type<GetOrganizationMembersResponse>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<GetOrganizationMembersResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<GetOrganizationMembersResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetOrganizationAdminResponse : JsonSerializable
{
    public static var typeName:String { return "GetOrganizationAdminResponse" }
    public static var metadata = Metadata.create([
            Type<GetOrganizationAdminResponse>.arrayProperty("labels", get: { $0.labels }, set: { $0.labels = $1 }),
            Type<GetOrganizationAdminResponse>.arrayProperty("members", get: { $0.members }, set: { $0.members = $1 }),
            Type<GetOrganizationAdminResponse>.arrayProperty("memberInvites", get: { $0.memberInvites }, set: { $0.memberInvites = $1 }),
            Type<GetOrganizationAdminResponse>.arrayProperty("reportedPosts", get: { $0.reportedPosts }, set: { $0.reportedPosts = $1 }),
            Type<GetOrganizationAdminResponse>.arrayProperty("reportedPostComments", get: { $0.reportedPostComments }, set: { $0.reportedPostComments = $1 }),
            Type<GetOrganizationAdminResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension CreateOrganizationForTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "CreateOrganizationForTechnologyResponse" }
    public static var metadata = Metadata.create([
            Type<CreateOrganizationForTechnologyResponse>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<CreateOrganizationForTechnologyResponse>.optionalProperty("organizationSlug", get: { $0.organizationSlug }, set: { $0.organizationSlug = $1 }),
            Type<CreateOrganizationForTechnologyResponse>.optionalProperty("commentsPostId", get: { $0.commentsPostId }, set: { $0.commentsPostId = $1 }),
            Type<CreateOrganizationForTechnologyResponse>.optionalProperty("commentsPostSlug", get: { $0.commentsPostSlug }, set: { $0.commentsPostSlug = $1 }),
            Type<CreateOrganizationForTechnologyResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension CreateOrganizationResponse : JsonSerializable
{
    public static var typeName:String { return "CreateOrganizationResponse" }
    public static var metadata = Metadata.create([
            Type<CreateOrganizationResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<CreateOrganizationResponse>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<CreateOrganizationResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdateOrganizationResponse : JsonSerializable
{
    public static var typeName:String { return "UpdateOrganizationResponse" }
    public static var metadata = Metadata.create([
            Type<UpdateOrganizationResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension OrganizationLabelResponse : JsonSerializable
{
    public static var typeName:String { return "OrganizationLabelResponse" }
    public static var metadata = Metadata.create([
            Type<OrganizationLabelResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension AddCategoryResponse : JsonSerializable
{
    public static var typeName:String { return "AddCategoryResponse" }
    public static var metadata = Metadata.create([
            Type<AddCategoryResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<AddCategoryResponse>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<AddCategoryResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdateCategoryResponse : JsonSerializable
{
    public static var typeName:String { return "UpdateCategoryResponse" }
    public static var metadata = Metadata.create([
            Type<UpdateCategoryResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension AddOrganizationMemberResponse : JsonSerializable
{
    public static var typeName:String { return "AddOrganizationMemberResponse" }
    public static var metadata = Metadata.create([
            Type<AddOrganizationMemberResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdateOrganizationMemberResponse : JsonSerializable
{
    public static var typeName:String { return "UpdateOrganizationMemberResponse" }
    public static var metadata = Metadata.create([
            Type<UpdateOrganizationMemberResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension SetOrganizationMembersResponse : JsonSerializable
{
    public static var typeName:String { return "SetOrganizationMembersResponse" }
    public static var metadata = Metadata.create([
            Type<SetOrganizationMembersResponse>.arrayProperty("userIdsAdded", get: { $0.userIdsAdded }, set: { $0.userIdsAdded = $1 }),
            Type<SetOrganizationMembersResponse>.arrayProperty("userIdsRemoved", get: { $0.userIdsRemoved }, set: { $0.userIdsRemoved = $1 }),
            Type<SetOrganizationMembersResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetOrganizationMemberInvitesResponse : JsonSerializable
{
    public static var typeName:String { return "GetOrganizationMemberInvitesResponse" }
    public static var metadata = Metadata.create([
            Type<GetOrganizationMemberInvitesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<GetOrganizationMemberInvitesResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension RequestOrganizationMemberInviteResponse : JsonSerializable
{
    public static var typeName:String { return "RequestOrganizationMemberInviteResponse" }
    public static var metadata = Metadata.create([
            Type<RequestOrganizationMemberInviteResponse>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<RequestOrganizationMemberInviteResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdateOrganizationMemberInviteResponse : JsonSerializable
{
    public static var typeName:String { return "UpdateOrganizationMemberInviteResponse" }
    public static var metadata = Metadata.create([
            Type<UpdateOrganizationMemberInviteResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension QueryResponse : JsonSerializable
{
    public static var typeName:String { return "QueryResponse" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<QueryResponse>.optionalProperty("offset", get: { $0.offset }, set: { $0.offset = $1 }),
            Type<QueryResponse>.optionalProperty("total", get: { $0.total }, set: { $0.total = $1 }),
            Type<QueryResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<QueryResponse>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            Type<QueryResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
    }
}

extension GetPostResponse : JsonSerializable
{
    public static var typeName:String { return "GetPostResponse" }
    public static var metadata = Metadata.create([
            Type<GetPostResponse>.optionalProperty("cache", get: { $0.cache }, set: { $0.cache = $1 }),
            Type<GetPostResponse>.optionalObjectProperty("post", get: { $0.post }, set: { $0.post = $1 }),
            Type<GetPostResponse>.arrayProperty("comments", get: { $0.comments }, set: { $0.comments = $1 }),
            Type<GetPostResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension CreatePostResponse : JsonSerializable
{
    public static var typeName:String { return "CreatePostResponse" }
    public static var metadata = Metadata.create([
            Type<CreatePostResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<CreatePostResponse>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<CreatePostResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdatePostResponse : JsonSerializable
{
    public static var typeName:String { return "UpdatePostResponse" }
    public static var metadata = Metadata.create([
            Type<UpdatePostResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension DeletePostResponse : JsonSerializable
{
    public static var typeName:String { return "DeletePostResponse" }
    public static var metadata = Metadata.create([
            Type<DeletePostResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<DeletePostResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension CreatePostCommentResponse : JsonSerializable
{
    public static var typeName:String { return "CreatePostCommentResponse" }
    public static var metadata = Metadata.create([
            Type<CreatePostCommentResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<CreatePostCommentResponse>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<CreatePostCommentResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdatePostCommentResponse : JsonSerializable
{
    public static var typeName:String { return "UpdatePostCommentResponse" }
    public static var metadata = Metadata.create([
            Type<UpdatePostCommentResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension DeletePostCommentResponse : JsonSerializable
{
    public static var typeName:String { return "DeletePostCommentResponse" }
    public static var metadata = Metadata.create([
            Type<DeletePostCommentResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<DeletePostCommentResponse>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<DeletePostCommentResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetUserPostCommentVotesResponse : JsonSerializable
{
    public static var typeName:String { return "GetUserPostCommentVotesResponse" }
    public static var metadata = Metadata.create([
            Type<GetUserPostCommentVotesResponse>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<GetUserPostCommentVotesResponse>.arrayProperty("upVotedCommentIds", get: { $0.upVotedCommentIds }, set: { $0.upVotedCommentIds = $1 }),
            Type<GetUserPostCommentVotesResponse>.arrayProperty("downVotedCommentIds", get: { $0.downVotedCommentIds }, set: { $0.downVotedCommentIds = $1 }),
        ])
}

extension PinPostCommentResponse : JsonSerializable
{
    public static var typeName:String { return "PinPostCommentResponse" }
    public static var metadata = Metadata.create([
            Type<PinPostCommentResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetUsersByEmailsResponse : JsonSerializable
{
    public static var typeName:String { return "GetUsersByEmailsResponse" }
    public static var metadata = Metadata.create([
            Type<GetUsersByEmailsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<GetUsersByEmailsResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetUserPostActivityResponse : JsonSerializable
{
    public static var typeName:String { return "GetUserPostActivityResponse" }
    public static var metadata = Metadata.create([
            Type<GetUserPostActivityResponse>.arrayProperty("upVotedPostIds", get: { $0.upVotedPostIds }, set: { $0.upVotedPostIds = $1 }),
            Type<GetUserPostActivityResponse>.arrayProperty("downVotedPostIds", get: { $0.downVotedPostIds }, set: { $0.downVotedPostIds = $1 }),
            Type<GetUserPostActivityResponse>.arrayProperty("favoritePostIds", get: { $0.favoritePostIds }, set: { $0.favoritePostIds = $1 }),
            Type<GetUserPostActivityResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetUserOrganizationsResponse : JsonSerializable
{
    public static var typeName:String { return "GetUserOrganizationsResponse" }
    public static var metadata = Metadata.create([
            Type<GetUserOrganizationsResponse>.arrayProperty("members", get: { $0.members }, set: { $0.members = $1 }),
            Type<GetUserOrganizationsResponse>.arrayProperty("memberInvites", get: { $0.memberInvites }, set: { $0.memberInvites = $1 }),
            Type<GetUserOrganizationsResponse>.arrayProperty("subscriptions", get: { $0.subscriptions }, set: { $0.subscriptions = $1 }),
        ])
}

extension UserPostVoteResponse : JsonSerializable
{
    public static var typeName:String { return "UserPostVoteResponse" }
    public static var metadata = Metadata.create([
            Type<UserPostVoteResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UserPostFavoriteResponse : JsonSerializable
{
    public static var typeName:String { return "UserPostFavoriteResponse" }
    public static var metadata = Metadata.create([
            Type<UserPostFavoriteResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UserPostReportResponse : JsonSerializable
{
    public static var typeName:String { return "UserPostReportResponse" }
    public static var metadata = Metadata.create([
            Type<UserPostReportResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UserPostCommentVoteResponse : JsonSerializable
{
    public static var typeName:String { return "UserPostCommentVoteResponse" }
    public static var metadata = Metadata.create([
            Type<UserPostCommentVoteResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UserPostCommentReportResponse : JsonSerializable
{
    public static var typeName:String { return "UserPostCommentReportResponse" }
    public static var metadata = Metadata.create([
            Type<UserPostCommentReportResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension SessionInfoResponse : JsonSerializable
{
    public static var typeName:String { return "SessionInfoResponse" }
    public static var metadata = Metadata.create([
            Type<SessionInfoResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<SessionInfoResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<SessionInfoResponse>.optionalProperty("referrerUrl", get: { $0.referrerUrl }, set: { $0.referrerUrl = $1 }),
            Type<SessionInfoResponse>.optionalProperty("userAuthId", get: { $0.userAuthId }, set: { $0.userAuthId = $1 }),
            Type<SessionInfoResponse>.optionalProperty("userAuthName", get: { $0.userAuthName }, set: { $0.userAuthName = $1 }),
            Type<SessionInfoResponse>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<SessionInfoResponse>.optionalProperty("displayName", get: { $0.displayName }, set: { $0.displayName = $1 }),
            Type<SessionInfoResponse>.optionalProperty("firstName", get: { $0.firstName }, set: { $0.firstName = $1 }),
            Type<SessionInfoResponse>.optionalProperty("lastName", get: { $0.lastName }, set: { $0.lastName = $1 }),
            Type<SessionInfoResponse>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
            Type<SessionInfoResponse>.optionalProperty("createdAt", get: { $0.createdAt }, set: { $0.createdAt = $1 }),
            Type<SessionInfoResponse>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
            Type<SessionInfoResponse>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
            Type<SessionInfoResponse>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
            Type<SessionInfoResponse>.optionalProperty("isAuthenticated", get: { $0.isAuthenticated }, set: { $0.isAuthenticated = $1 }),
            Type<SessionInfoResponse>.optionalProperty("authProvider", get: { $0.authProvider }, set: { $0.authProvider = $1 }),
            Type<SessionInfoResponse>.optionalProperty("profileUrl", get: { $0.profileUrl }, set: { $0.profileUrl = $1 }),
            Type<SessionInfoResponse>.optionalProperty("githubProfileUrl", get: { $0.githubProfileUrl }, set: { $0.githubProfileUrl = $1 }),
            Type<SessionInfoResponse>.optionalProperty("twitterProfileUrl", get: { $0.twitterProfileUrl }, set: { $0.twitterProfileUrl = $1 }),
            Type<SessionInfoResponse>.optionalProperty("accessToken", get: { $0.accessToken }, set: { $0.accessToken = $1 }),
            Type<SessionInfoResponse>.optionalProperty("avatarUrl", get: { $0.avatarUrl }, set: { $0.avatarUrl = $1 }),
            Type<SessionInfoResponse>.arrayProperty("techStacks", get: { $0.techStacks }, set: { $0.techStacks = $1 }),
            Type<SessionInfoResponse>.arrayProperty("favoriteTechStacks", get: { $0.favoriteTechStacks }, set: { $0.favoriteTechStacks = $1 }),
            Type<SessionInfoResponse>.arrayProperty("favoriteTechnologies", get: { $0.favoriteTechnologies }, set: { $0.favoriteTechnologies = $1 }),
            Type<SessionInfoResponse>.optionalObjectProperty("userActivity", get: { $0.userActivity }, set: { $0.userActivity = $1 }),
            Type<SessionInfoResponse>.arrayProperty("members", get: { $0.members }, set: { $0.members = $1 }),
            Type<SessionInfoResponse>.arrayProperty("memberInvites", get: { $0.memberInvites }, set: { $0.memberInvites = $1 }),
            Type<SessionInfoResponse>.arrayProperty("subscriptions", get: { $0.subscriptions }, set: { $0.subscriptions = $1 }),
            Type<SessionInfoResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetTechnologyPreviousVersionsResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyPreviousVersionsResponse" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyPreviousVersionsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension GetAllTechnologiesResponse : JsonSerializable
{
    public static var typeName:String { return "GetAllTechnologiesResponse" }
    public static var metadata = Metadata.create([
            Type<GetAllTechnologiesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<GetAllTechnologiesResponse>.optionalProperty("total", get: { $0.total }, set: { $0.total = $1 }),
        ])
}

extension GetTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyResponse" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<GetTechnologyResponse>.optionalObjectProperty("technology", get: { $0.technology }, set: { $0.technology = $1 }),
            Type<GetTechnologyResponse>.arrayProperty("technologyStacks", get: { $0.technologyStacks }, set: { $0.technologyStacks = $1 }),
            Type<GetTechnologyResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetTechnologyFavoriteDetailsResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyFavoriteDetailsResponse" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyFavoriteDetailsResponse>.arrayProperty("users", get: { $0.users }, set: { $0.users = $1 }),
            Type<GetTechnologyFavoriteDetailsResponse>.optionalProperty("favoriteCount", get: { $0.favoriteCount }, set: { $0.favoriteCount = $1 }),
        ])
}

extension CreateTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "CreateTechnologyResponse" }
    public static var metadata = Metadata.create([
            Type<CreateTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<CreateTechnologyResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdateTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "UpdateTechnologyResponse" }
    public static var metadata = Metadata.create([
            Type<UpdateTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<UpdateTechnologyResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension DeleteTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "DeleteTechnologyResponse" }
    public static var metadata = Metadata.create([
            Type<DeleteTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<DeleteTechnologyResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetTechnologyStackPreviousVersionsResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackPreviousVersionsResponse" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyStackPreviousVersionsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension GetPageStatsResponse : JsonSerializable
{
    public static var typeName:String { return "GetPageStatsResponse" }
    public static var metadata = Metadata.create([
            Type<GetPageStatsResponse>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
            Type<GetPageStatsResponse>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<GetPageStatsResponse>.optionalProperty("viewCount", get: { $0.viewCount }, set: { $0.viewCount = $1 }),
            Type<GetPageStatsResponse>.optionalProperty("favCount", get: { $0.favCount }, set: { $0.favCount = $1 }),
        ])
}

extension HourlyTaskResponse : JsonSerializable
{
    public static var typeName:String { return "HourlyTaskResponse" }
    public static var metadata = Metadata.create([
            Type<HourlyTaskResponse>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            Type<HourlyTaskResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension OverviewResponse : JsonSerializable
{
    public static var typeName:String { return "OverviewResponse" }
    public static var metadata = Metadata.create([
            Type<OverviewResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<OverviewResponse>.arrayProperty("topUsers", get: { $0.topUsers }, set: { $0.topUsers = $1 }),
            Type<OverviewResponse>.arrayProperty("topTechnologies", get: { $0.topTechnologies }, set: { $0.topTechnologies = $1 }),
            Type<OverviewResponse>.arrayProperty("latestTechStacks", get: { $0.latestTechStacks }, set: { $0.latestTechStacks = $1 }),
            Type<OverviewResponse>.arrayProperty("popularTechStacks", get: { $0.popularTechStacks }, set: { $0.popularTechStacks = $1 }),
            Type<OverviewResponse>.arrayProperty("allOrganizations", get: { $0.allOrganizations }, set: { $0.allOrganizations = $1 }),
            Type<OverviewResponse>.objectProperty("topTechnologiesByTier", get: { $0.topTechnologiesByTier }, set: { $0.topTechnologiesByTier = $1 }),
            Type<OverviewResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension AppOverviewResponse : JsonSerializable
{
    public static var typeName:String { return "AppOverviewResponse" }
    public static var metadata = Metadata.create([
            Type<AppOverviewResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<AppOverviewResponse>.arrayProperty("allTiers", get: { $0.allTiers }, set: { $0.allTiers = $1 }),
            Type<AppOverviewResponse>.arrayProperty("topTechnologies", get: { $0.topTechnologies }, set: { $0.topTechnologies = $1 }),
            Type<AppOverviewResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetAllTechnologyStacksResponse : JsonSerializable
{
    public static var typeName:String { return "GetAllTechnologyStacksResponse" }
    public static var metadata = Metadata.create([
            Type<GetAllTechnologyStacksResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<GetAllTechnologyStacksResponse>.optionalProperty("total", get: { $0.total }, set: { $0.total = $1 }),
        ])
}

extension GetTechnologyStackResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackResponse" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyStackResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<GetTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<GetTechnologyStackResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetTechnologyStackFavoriteDetailsResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackFavoriteDetailsResponse" }
    public static var metadata = Metadata.create([
            Type<GetTechnologyStackFavoriteDetailsResponse>.arrayProperty("users", get: { $0.users }, set: { $0.users = $1 }),
            Type<GetTechnologyStackFavoriteDetailsResponse>.optionalProperty("favoriteCount", get: { $0.favoriteCount }, set: { $0.favoriteCount = $1 }),
        ])
}

extension GetConfigResponse : JsonSerializable
{
    public static var typeName:String { return "GetConfigResponse" }
    public static var metadata = Metadata.create([
            Type<GetConfigResponse>.arrayProperty("allTiers", get: { $0.allTiers }, set: { $0.allTiers = $1 }),
            Type<GetConfigResponse>.arrayProperty("allPostTypes", get: { $0.allPostTypes }, set: { $0.allPostTypes = $1 }),
            Type<GetConfigResponse>.arrayProperty("allFlagTypes", get: { $0.allFlagTypes }, set: { $0.allFlagTypes = $1 }),
        ])
}

extension CreateTechnologyStackResponse : JsonSerializable
{
    public static var typeName:String { return "CreateTechnologyStackResponse" }
    public static var metadata = Metadata.create([
            Type<CreateTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<CreateTechnologyStackResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdateTechnologyStackResponse : JsonSerializable
{
    public static var typeName:String { return "UpdateTechnologyStackResponse" }
    public static var metadata = Metadata.create([
            Type<UpdateTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<UpdateTechnologyStackResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension DeleteTechnologyStackResponse : JsonSerializable
{
    public static var typeName:String { return "DeleteTechnologyStackResponse" }
    public static var metadata = Metadata.create([
            Type<DeleteTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<DeleteTechnologyStackResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetFavoriteTechStackResponse : JsonSerializable
{
    public static var typeName:String { return "GetFavoriteTechStackResponse" }
    public static var metadata = Metadata.create([
            Type<GetFavoriteTechStackResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension FavoriteTechStackResponse : JsonSerializable
{
    public static var typeName:String { return "FavoriteTechStackResponse" }
    public static var metadata = Metadata.create([
            Type<FavoriteTechStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension GetFavoriteTechnologiesResponse : JsonSerializable
{
    public static var typeName:String { return "GetFavoriteTechnologiesResponse" }
    public static var metadata = Metadata.create([
            Type<GetFavoriteTechnologiesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension FavoriteTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "FavoriteTechnologyResponse" }
    public static var metadata = Metadata.create([
            Type<FavoriteTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension GetUserFeedResponse : JsonSerializable
{
    public static var typeName:String { return "GetUserFeedResponse" }
    public static var metadata = Metadata.create([
            Type<GetUserFeedResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension GetUsersKarmaResponse : JsonSerializable
{
    public static var typeName:String { return "GetUsersKarmaResponse" }
    public static var metadata = Metadata.create([
            Type<GetUsersKarmaResponse>.objectProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<GetUsersKarmaResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetUserInfoResponse : JsonSerializable
{
    public static var typeName:String { return "GetUserInfoResponse" }
    public static var metadata = Metadata.create([
            Type<GetUserInfoResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<GetUserInfoResponse>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<GetUserInfoResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<GetUserInfoResponse>.optionalProperty("avatarUrl", get: { $0.avatarUrl }, set: { $0.avatarUrl = $1 }),
            Type<GetUserInfoResponse>.arrayProperty("techStacks", get: { $0.techStacks }, set: { $0.techStacks = $1 }),
            Type<GetUserInfoResponse>.arrayProperty("favoriteTechStacks", get: { $0.favoriteTechStacks }, set: { $0.favoriteTechStacks = $1 }),
            Type<GetUserInfoResponse>.arrayProperty("favoriteTechnologies", get: { $0.favoriteTechnologies }, set: { $0.favoriteTechnologies = $1 }),
            Type<GetUserInfoResponse>.optionalObjectProperty("userActivity", get: { $0.userActivity }, set: { $0.userActivity = $1 }),
            Type<GetUserInfoResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension SyncDiscourseSiteResponse : JsonSerializable
{
    public static var typeName:String { return "SyncDiscourseSiteResponse" }
    public static var metadata = Metadata.create([
            Type<SyncDiscourseSiteResponse>.optionalProperty("timeTaken", get: { $0.timeTaken }, set: { $0.timeTaken = $1 }),
            Type<SyncDiscourseSiteResponse>.arrayProperty("userLogs", get: { $0.userLogs }, set: { $0.userLogs = $1 }),
            Type<SyncDiscourseSiteResponse>.arrayProperty("postsLogs", get: { $0.postsLogs }, set: { $0.postsLogs = $1 }),
            Type<SyncDiscourseSiteResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension LogoUrlApprovalResponse : JsonSerializable
{
    public static var typeName:String { return "LogoUrlApprovalResponse" }
    public static var metadata = Metadata.create([
            Type<LogoUrlApprovalResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension LockStackResponse : JsonSerializable
{
    public static var typeName:String { return "LockStackResponse" }
    public static var metadata = Metadata.create([
        ])
}

extension EmailTestRespoonse : JsonSerializable
{
    public static var typeName:String { return "EmailTestRespoonse" }
    public static var metadata = Metadata.create([
            Type<EmailTestRespoonse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension ImportUserResponse : JsonSerializable
{
    public static var typeName:String { return "ImportUserResponse" }
    public static var metadata = Metadata.create([
            Type<ImportUserResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<ImportUserResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension ImportUserVoiceSuggestionResponse : JsonSerializable
{
    public static var typeName:String { return "ImportUserVoiceSuggestionResponse" }
    public static var metadata = Metadata.create([
            Type<ImportUserVoiceSuggestionResponse>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<ImportUserVoiceSuggestionResponse>.optionalProperty("postSlug", get: { $0.postSlug }, set: { $0.postSlug = $1 }),
            Type<ImportUserVoiceSuggestionResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension Post : JsonSerializable
{
    public static var typeName:String { return "Post" }
    public static var metadata = Metadata.create([
            Type<Post>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<Post>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<Post>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<Post>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
            Type<Post>.optionalProperty("categoryId", get: { $0.categoryId }, set: { $0.categoryId = $1 }),
            Type<Post>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
            Type<Post>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<Post>.optionalProperty("url", get: { $0.url }, set: { $0.url = $1 }),
            Type<Post>.optionalProperty("imageUrl", get: { $0.imageUrl }, set: { $0.imageUrl = $1 }),
            Type<Post>.optionalProperty("content", get: { $0.content }, set: { $0.content = $1 }),
            Type<Post>.optionalProperty("contentHtml", get: { $0.contentHtml }, set: { $0.contentHtml = $1 }),
            Type<Post>.optionalProperty("pinCommentId", get: { $0.pinCommentId }, set: { $0.pinCommentId = $1 }),
            Type<Post>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
            Type<Post>.optionalProperty("fromDate", get: { $0.fromDate }, set: { $0.fromDate = $1 }),
            Type<Post>.optionalProperty("toDate", get: { $0.toDate }, set: { $0.toDate = $1 }),
            Type<Post>.optionalProperty("location", get: { $0.location }, set: { $0.location = $1 }),
            Type<Post>.optionalProperty("metaType", get: { $0.metaType }, set: { $0.metaType = $1 }),
            Type<Post>.optionalProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            Type<Post>.optionalProperty("approved", get: { $0.approved }, set: { $0.approved = $1 }),
            Type<Post>.optionalProperty("upVotes", get: { $0.upVotes }, set: { $0.upVotes = $1 }),
            Type<Post>.optionalProperty("downVotes", get: { $0.downVotes }, set: { $0.downVotes = $1 }),
            Type<Post>.optionalProperty("points", get: { $0.points }, set: { $0.points = $1 }),
            Type<Post>.optionalProperty("views", get: { $0.views }, set: { $0.views = $1 }),
            Type<Post>.optionalProperty("favorites", get: { $0.favorites }, set: { $0.favorites = $1 }),
            Type<Post>.optionalProperty("subscribers", get: { $0.subscribers }, set: { $0.subscribers = $1 }),
            Type<Post>.optionalProperty("replyCount", get: { $0.replyCount }, set: { $0.replyCount = $1 }),
            Type<Post>.optionalProperty("commentsCount", get: { $0.commentsCount }, set: { $0.commentsCount = $1 }),
            Type<Post>.optionalProperty("wordCount", get: { $0.wordCount }, set: { $0.wordCount = $1 }),
            Type<Post>.optionalProperty("reportCount", get: { $0.reportCount }, set: { $0.reportCount = $1 }),
            Type<Post>.optionalProperty("linksCount", get: { $0.linksCount }, set: { $0.linksCount = $1 }),
            Type<Post>.optionalProperty("linkedToCount", get: { $0.linkedToCount }, set: { $0.linkedToCount = $1 }),
            Type<Post>.optionalProperty("score", get: { $0.score }, set: { $0.score = $1 }),
            Type<Post>.optionalProperty("rank", get: { $0.rank }, set: { $0.rank = $1 }),
            Type<Post>.arrayProperty("labels", get: { $0.labels }, set: { $0.labels = $1 }),
            Type<Post>.arrayProperty("refUserIds", get: { $0.refUserIds }, set: { $0.refUserIds = $1 }),
            Type<Post>.arrayProperty("refLinks", get: { $0.refLinks }, set: { $0.refLinks = $1 }),
            Type<Post>.arrayProperty("muteUserIds", get: { $0.muteUserIds }, set: { $0.muteUserIds = $1 }),
            Type<Post>.optionalProperty("lastCommentDate", get: { $0.lastCommentDate }, set: { $0.lastCommentDate = $1 }),
            Type<Post>.optionalProperty("lastCommentId", get: { $0.lastCommentId }, set: { $0.lastCommentId = $1 }),
            Type<Post>.optionalProperty("lastCommentUserId", get: { $0.lastCommentUserId }, set: { $0.lastCommentUserId = $1 }),
            Type<Post>.optionalProperty("deleted", get: { $0.deleted }, set: { $0.deleted = $1 }),
            Type<Post>.optionalProperty("deletedBy", get: { $0.deletedBy }, set: { $0.deletedBy = $1 }),
            Type<Post>.optionalProperty("locked", get: { $0.locked }, set: { $0.locked = $1 }),
            Type<Post>.optionalProperty("lockedBy", get: { $0.lockedBy }, set: { $0.lockedBy = $1 }),
            Type<Post>.optionalProperty("hidden", get: { $0.hidden }, set: { $0.hidden = $1 }),
            Type<Post>.optionalProperty("hiddenBy", get: { $0.hiddenBy }, set: { $0.hiddenBy = $1 }),
            Type<Post>.optionalProperty("status", get: { $0.status }, set: { $0.status = $1 }),
            Type<Post>.optionalProperty("statusDate", get: { $0.statusDate }, set: { $0.statusDate = $1 }),
            Type<Post>.optionalProperty("statusBy", get: { $0.statusBy }, set: { $0.statusBy = $1 }),
            Type<Post>.optionalProperty("archived", get: { $0.archived }, set: { $0.archived = $1 }),
            Type<Post>.optionalProperty("bumped", get: { $0.bumped }, set: { $0.bumped = $1 }),
            Type<Post>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<Post>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
            Type<Post>.optionalProperty("modified", get: { $0.modified }, set: { $0.modified = $1 }),
            Type<Post>.optionalProperty("modifiedBy", get: { $0.modifiedBy }, set: { $0.modifiedBy = $1 }),
            Type<Post>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
            Type<Post>.optionalProperty("refSource", get: { $0.refSource }, set: { $0.refSource = $1 }),
            Type<Post>.optionalProperty("refUrn", get: { $0.refUrn }, set: { $0.refUrn = $1 }),
        ])
}

extension Organization : JsonSerializable
{
    public static var typeName:String { return "Organization" }
    public static var metadata = Metadata.create([
            Type<Organization>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<Organization>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<Organization>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<Organization>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<Organization>.optionalProperty("descriptionHtml", get: { $0.descriptionHtml }, set: { $0.descriptionHtml = $1 }),
            Type<Organization>.optionalProperty("color", get: { $0.color }, set: { $0.color = $1 }),
            Type<Organization>.optionalProperty("textColor", get: { $0.textColor }, set: { $0.textColor = $1 }),
            Type<Organization>.optionalProperty("linkColor", get: { $0.linkColor }, set: { $0.linkColor = $1 }),
            Type<Organization>.optionalProperty("backgroundColor", get: { $0.backgroundColor }, set: { $0.backgroundColor = $1 }),
            Type<Organization>.optionalProperty("backgroundUrl", get: { $0.backgroundUrl }, set: { $0.backgroundUrl = $1 }),
            Type<Organization>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
            Type<Organization>.optionalProperty("heroUrl", get: { $0.heroUrl }, set: { $0.heroUrl = $1 }),
            Type<Organization>.optionalProperty("lang", get: { $0.lang }, set: { $0.lang = $1 }),
            Type<Organization>.optionalProperty("defaultPostType", get: { $0.defaultPostType }, set: { $0.defaultPostType = $1 }),
            Type<Organization>.arrayProperty("defaultSubscriptionPostTypes", get: { $0.defaultSubscriptionPostTypes }, set: { $0.defaultSubscriptionPostTypes = $1 }),
            Type<Organization>.arrayProperty("postTypes", get: { $0.postTypes }, set: { $0.postTypes = $1 }),
            Type<Organization>.arrayProperty("moderatorPostTypes", get: { $0.moderatorPostTypes }, set: { $0.moderatorPostTypes = $1 }),
            Type<Organization>.optionalProperty("deletePostsWithReportCount", get: { $0.deletePostsWithReportCount }, set: { $0.deletePostsWithReportCount = $1 }),
            Type<Organization>.optionalProperty("disableInvites", get: { $0.disableInvites }, set: { $0.disableInvites = $1 }),
            Type<Organization>.optionalProperty("upVotes", get: { $0.upVotes }, set: { $0.upVotes = $1 }),
            Type<Organization>.optionalProperty("downVotes", get: { $0.downVotes }, set: { $0.downVotes = $1 }),
            Type<Organization>.optionalProperty("views", get: { $0.views }, set: { $0.views = $1 }),
            Type<Organization>.optionalProperty("favorites", get: { $0.favorites }, set: { $0.favorites = $1 }),
            Type<Organization>.optionalProperty("subscribers", get: { $0.subscribers }, set: { $0.subscribers = $1 }),
            Type<Organization>.optionalProperty("commentsCount", get: { $0.commentsCount }, set: { $0.commentsCount = $1 }),
            Type<Organization>.optionalProperty("postsCount", get: { $0.postsCount }, set: { $0.postsCount = $1 }),
            Type<Organization>.optionalProperty("score", get: { $0.score }, set: { $0.score = $1 }),
            Type<Organization>.optionalProperty("rank", get: { $0.rank }, set: { $0.rank = $1 }),
            Type<Organization>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
            Type<Organization>.optionalProperty("refSource", get: { $0.refSource }, set: { $0.refSource = $1 }),
            Type<Organization>.optionalProperty("hidden", get: { $0.hidden }, set: { $0.hidden = $1 }),
            Type<Organization>.optionalProperty("hiddenBy", get: { $0.hiddenBy }, set: { $0.hiddenBy = $1 }),
            Type<Organization>.optionalProperty("locked", get: { $0.locked }, set: { $0.locked = $1 }),
            Type<Organization>.optionalProperty("lockedBy", get: { $0.lockedBy }, set: { $0.lockedBy = $1 }),
            Type<Organization>.optionalProperty("deleted", get: { $0.deleted }, set: { $0.deleted = $1 }),
            Type<Organization>.optionalProperty("deletedBy", get: { $0.deletedBy }, set: { $0.deletedBy = $1 }),
            Type<Organization>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<Organization>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
            Type<Organization>.optionalProperty("modified", get: { $0.modified }, set: { $0.modified = $1 }),
            Type<Organization>.optionalProperty("modifiedBy", get: { $0.modifiedBy }, set: { $0.modifiedBy = $1 }),
        ])
}

extension OrganizationLabel : JsonSerializable
{
    public static var typeName:String { return "OrganizationLabel" }
    public static var metadata = Metadata.create([
            Type<OrganizationLabel>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<OrganizationLabel>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<OrganizationLabel>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<OrganizationLabel>.optionalProperty("color", get: { $0.color }, set: { $0.color = $1 }),
        ])
}

extension Category : JsonSerializable
{
    public static var typeName:String { return "Category" }
    public static var metadata = Metadata.create([
            Type<Category>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<Category>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<Category>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<Category>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<Category>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            Type<Category>.optionalProperty("color", get: { $0.color }, set: { $0.color = $1 }),
            Type<Category>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
            Type<Category>.optionalProperty("commentsCount", get: { $0.commentsCount }, set: { $0.commentsCount = $1 }),
            Type<Category>.optionalProperty("postsCount", get: { $0.postsCount }, set: { $0.postsCount = $1 }),
            Type<Category>.optionalProperty("score", get: { $0.score }, set: { $0.score = $1 }),
            Type<Category>.optionalProperty("rank", get: { $0.rank }, set: { $0.rank = $1 }),
        ])
}

extension OrganizationMember : JsonSerializable
{
    public static var typeName:String { return "OrganizationMember" }
    public static var metadata = Metadata.create([
            Type<OrganizationMember>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<OrganizationMember>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<OrganizationMember>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<OrganizationMember>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<OrganizationMember>.optionalProperty("isOwner", get: { $0.isOwner }, set: { $0.isOwner = $1 }),
            Type<OrganizationMember>.optionalProperty("isModerator", get: { $0.isModerator }, set: { $0.isModerator = $1 }),
            Type<OrganizationMember>.optionalProperty("denyAll", get: { $0.denyAll }, set: { $0.denyAll = $1 }),
            Type<OrganizationMember>.optionalProperty("denyPosts", get: { $0.denyPosts }, set: { $0.denyPosts = $1 }),
            Type<OrganizationMember>.optionalProperty("denyComments", get: { $0.denyComments }, set: { $0.denyComments = $1 }),
            Type<OrganizationMember>.optionalProperty("notes", get: { $0.notes }, set: { $0.notes = $1 }),
        ])
}

extension OrganizationMemberInvite : JsonSerializable
{
    public static var typeName:String { return "OrganizationMemberInvite" }
    public static var metadata = Metadata.create([
            Type<OrganizationMemberInvite>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<OrganizationMemberInvite>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<OrganizationMemberInvite>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<OrganizationMemberInvite>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<OrganizationMemberInvite>.optionalProperty("dismissed", get: { $0.dismissed }, set: { $0.dismissed = $1 }),
        ])
}

extension PostReportInfo : JsonSerializable
{
    public static var typeName:String { return "PostReportInfo" }
    public static var metadata = Metadata.create([
            Type<PostReportInfo>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<PostReportInfo>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<PostReportInfo>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<PostReportInfo>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<PostReportInfo>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<PostReportInfo>.optionalProperty("flagType", get: { $0.flagType }, set: { $0.flagType = $1 }),
            Type<PostReportInfo>.optionalProperty("reportNotes", get: { $0.reportNotes }, set: { $0.reportNotes = $1 }),
            Type<PostReportInfo>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<PostReportInfo>.optionalProperty("acknowledged", get: { $0.acknowledged }, set: { $0.acknowledged = $1 }),
            Type<PostReportInfo>.optionalProperty("acknowledgedBy", get: { $0.acknowledgedBy }, set: { $0.acknowledgedBy = $1 }),
            Type<PostReportInfo>.optionalProperty("dismissed", get: { $0.dismissed }, set: { $0.dismissed = $1 }),
            Type<PostReportInfo>.optionalProperty("dismissedBy", get: { $0.dismissedBy }, set: { $0.dismissedBy = $1 }),
            Type<PostReportInfo>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
            Type<PostReportInfo>.optionalProperty("reportCount", get: { $0.reportCount }, set: { $0.reportCount = $1 }),
            Type<PostReportInfo>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
        ])
}

extension PostCommentReportInfo : JsonSerializable
{
    public static var typeName:String { return "PostCommentReportInfo" }
    public static var metadata = Metadata.create([
            Type<PostCommentReportInfo>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("postCommentId", get: { $0.postCommentId }, set: { $0.postCommentId = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("flagType", get: { $0.flagType }, set: { $0.flagType = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("reportNotes", get: { $0.reportNotes }, set: { $0.reportNotes = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("acknowledged", get: { $0.acknowledged }, set: { $0.acknowledged = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("acknowledgedBy", get: { $0.acknowledgedBy }, set: { $0.acknowledgedBy = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("dismissed", get: { $0.dismissed }, set: { $0.dismissed = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("dismissedBy", get: { $0.dismissedBy }, set: { $0.dismissedBy = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("contentHtml", get: { $0.contentHtml }, set: { $0.contentHtml = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("reportCount", get: { $0.reportCount }, set: { $0.reportCount = $1 }),
            Type<PostCommentReportInfo>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
        ])
}

extension PostComment : JsonSerializable
{
    public static var typeName:String { return "PostComment" }
    public static var metadata = Metadata.create([
            Type<PostComment>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<PostComment>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
            Type<PostComment>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<PostComment>.optionalProperty("replyId", get: { $0.replyId }, set: { $0.replyId = $1 }),
            Type<PostComment>.optionalProperty("content", get: { $0.content }, set: { $0.content = $1 }),
            Type<PostComment>.optionalProperty("contentHtml", get: { $0.contentHtml }, set: { $0.contentHtml = $1 }),
            Type<PostComment>.optionalProperty("score", get: { $0.score }, set: { $0.score = $1 }),
            Type<PostComment>.optionalProperty("rank", get: { $0.rank }, set: { $0.rank = $1 }),
            Type<PostComment>.optionalProperty("upVotes", get: { $0.upVotes }, set: { $0.upVotes = $1 }),
            Type<PostComment>.optionalProperty("downVotes", get: { $0.downVotes }, set: { $0.downVotes = $1 }),
            Type<PostComment>.optionalProperty("favorites", get: { $0.favorites }, set: { $0.favorites = $1 }),
            Type<PostComment>.optionalProperty("wordCount", get: { $0.wordCount }, set: { $0.wordCount = $1 }),
            Type<PostComment>.optionalProperty("reportCount", get: { $0.reportCount }, set: { $0.reportCount = $1 }),
            Type<PostComment>.optionalProperty("deleted", get: { $0.deleted }, set: { $0.deleted = $1 }),
            Type<PostComment>.optionalProperty("hidden", get: { $0.hidden }, set: { $0.hidden = $1 }),
            Type<PostComment>.optionalProperty("modified", get: { $0.modified }, set: { $0.modified = $1 }),
            Type<PostComment>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<PostComment>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
            Type<PostComment>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
            Type<PostComment>.optionalProperty("refSource", get: { $0.refSource }, set: { $0.refSource = $1 }),
            Type<PostComment>.optionalProperty("refUrn", get: { $0.refUrn }, set: { $0.refUrn = $1 }),
        ])
}

extension PostType : StringSerializable
{
    public static var typeName:String { return "PostType" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Announcement: return "Announcement"
        case .Post: return "Post"
        case .Showcase: return "Showcase"
        case .Question: return "Question"
        case .Request: return "Request"
        }
    }
    public static func fromString(_ strValue:String) -> PostType? {
        switch strValue {
        case "Announcement": return .Announcement
        case "Post": return .Post
        case "Showcase": return .Showcase
        case "Question": return .Question
        case "Request": return .Request
        default: return nil
        }
    }
    public static func fromObject(_ any:Any) -> PostType? {
        switch any {
        case let i as Int: return PostType(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension ReportAction : StringSerializable
{
    public static var typeName:String { return "ReportAction" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Dismiss: return "Dismiss"
        case .Delete: return "Delete"
        }
    }
    public static func fromString(_ strValue:String) -> ReportAction? {
        switch strValue {
        case "Dismiss": return .Dismiss
        case "Delete": return .Delete
        default: return nil
        }
    }
    public static func fromObject(_ any:Any) -> ReportAction? {
        switch any {
        case let i as Int: return ReportAction(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension UserRef : JsonSerializable
{
    public static var typeName:String { return "UserRef" }
    public static var metadata = Metadata.create([
            Type<UserRef>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UserRef>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<UserRef>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
            Type<UserRef>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
            Type<UserRef>.optionalProperty("refSource", get: { $0.refSource }, set: { $0.refSource = $1 }),
            Type<UserRef>.optionalProperty("refUrn", get: { $0.refUrn }, set: { $0.refUrn = $1 }),
        ])
}

extension OrganizationSubscription : JsonSerializable
{
    public static var typeName:String { return "OrganizationSubscription" }
    public static var metadata = Metadata.create([
            Type<OrganizationSubscription>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<OrganizationSubscription>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<OrganizationSubscription>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<OrganizationSubscription>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<OrganizationSubscription>.arrayProperty("postTypes", get: { $0.postTypes }, set: { $0.postTypes = $1 }),
            Type<OrganizationSubscription>.optionalProperty("frequencyDays", get: { $0.frequencyDays }, set: { $0.frequencyDays = $1 }),
            Type<OrganizationSubscription>.optionalProperty("lastSyncedId", get: { $0.lastSyncedId }, set: { $0.lastSyncedId = $1 }),
            Type<OrganizationSubscription>.optionalProperty("lastSynced", get: { $0.lastSynced }, set: { $0.lastSynced = $1 }),
            Type<OrganizationSubscription>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        ])
}

extension FlagType : StringSerializable
{
    public static var typeName:String { return "FlagType" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Violation: return "Violation"
        case .Spam: return "Spam"
        case .Abusive: return "Abusive"
        case .Confidential: return "Confidential"
        case .OffTopic: return "OffTopic"
        case .Other: return "Other"
        }
    }
    public static func fromString(_ strValue:String) -> FlagType? {
        switch strValue {
        case "Violation": return .Violation
        case "Spam": return .Spam
        case "Abusive": return .Abusive
        case "Confidential": return .Confidential
        case "OffTopic": return .OffTopic
        case "Other": return .Other
        default: return nil
        }
    }
    public static func fromObject(_ any:Any) -> FlagType? {
        switch any {
        case let i as Int: return FlagType(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension TechnologyStack : JsonSerializable
{
    public static var typeName:String { return "TechnologyStack" }
    public static var metadata = Metadata.create([
            Type<TechnologyStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<TechnologyStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<TechnologyStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<TechnologyStack>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
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
            Type<TechnologyStack>.optionalProperty("detailsHtml", get: { $0.detailsHtml }, set: { $0.detailsHtml = $1 }),
            Type<TechnologyStack>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
            Type<TechnologyStack>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<TechnologyStack>.optionalProperty("commentsPostId", get: { $0.commentsPostId }, set: { $0.commentsPostId = $1 }),
            Type<TechnologyStack>.optionalProperty("viewCount", get: { $0.viewCount }, set: { $0.viewCount = $1 }),
            Type<TechnologyStack>.optionalProperty("favCount", get: { $0.favCount }, set: { $0.favCount = $1 }),
        ])
}

extension Technology : JsonSerializable
{
    public static var typeName:String { return "Technology" }
    public static var metadata = Metadata.create([
            Type<Technology>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<Technology>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<Technology>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<Technology>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
            Type<Technology>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
            Type<Technology>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
            Type<Technology>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
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
            Type<Technology>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<Technology>.optionalProperty("commentsPostId", get: { $0.commentsPostId }, set: { $0.commentsPostId = $1 }),
            Type<Technology>.optionalProperty("viewCount", get: { $0.viewCount }, set: { $0.viewCount = $1 }),
            Type<Technology>.optionalProperty("favCount", get: { $0.favCount }, set: { $0.favCount = $1 }),
        ])
}

extension UserActivity : JsonSerializable
{
    public static var typeName:String { return "UserActivity" }
    public static var metadata = Metadata.create([
            Type<UserActivity>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UserActivity>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<UserActivity>.optionalProperty("karma", get: { $0.karma }, set: { $0.karma = $1 }),
            Type<UserActivity>.optionalProperty("technologyCount", get: { $0.technologyCount }, set: { $0.technologyCount = $1 }),
            Type<UserActivity>.optionalProperty("techStacksCount", get: { $0.techStacksCount }, set: { $0.techStacksCount = $1 }),
            Type<UserActivity>.optionalProperty("postsCount", get: { $0.postsCount }, set: { $0.postsCount = $1 }),
            Type<UserActivity>.optionalProperty("postUpVotes", get: { $0.postUpVotes }, set: { $0.postUpVotes = $1 }),
            Type<UserActivity>.optionalProperty("postDownVotes", get: { $0.postDownVotes }, set: { $0.postDownVotes = $1 }),
            Type<UserActivity>.optionalProperty("commentUpVotes", get: { $0.commentUpVotes }, set: { $0.commentUpVotes = $1 }),
            Type<UserActivity>.optionalProperty("commentDownVotes", get: { $0.commentDownVotes }, set: { $0.commentDownVotes = $1 }),
            Type<UserActivity>.optionalProperty("postCommentsCount", get: { $0.postCommentsCount }, set: { $0.postCommentsCount = $1 }),
            Type<UserActivity>.optionalProperty("pinnedCommentCount", get: { $0.pinnedCommentCount }, set: { $0.pinnedCommentCount = $1 }),
            Type<UserActivity>.optionalProperty("postReportCount", get: { $0.postReportCount }, set: { $0.postReportCount = $1 }),
            Type<UserActivity>.optionalProperty("postCommentReportCount", get: { $0.postCommentReportCount }, set: { $0.postCommentReportCount = $1 }),
            Type<UserActivity>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
            Type<UserActivity>.optionalProperty("modified", get: { $0.modified }, set: { $0.modified = $1 }),
        ])
}

extension Frequency : StringSerializable
{
    public static var typeName:String { return "Frequency" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Daily: return "Daily"
        case .Weekly: return "Weekly"
        case .Monthly: return "Monthly"
        case .Quarterly: return "Quarterly"
        }
    }
    public static func fromString(_ strValue:String) -> Frequency? {
        switch strValue {
        case "Daily": return .Daily
        case "Weekly": return .Weekly
        case "Monthly": return .Monthly
        case "Quarterly": return .Quarterly
        default: return nil
        }
    }
    public static func fromObject(_ any:Any) -> Frequency? {
        switch any {
        case let i as Int: return Frequency(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension TechnologyHistory : JsonSerializable
{
    public static var typeName:String { return "TechnologyHistory" }
    public static var metadata = Metadata.create([
            Type<TechnologyHistory>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
            Type<TechnologyHistory>.optionalProperty("operation", get: { $0.operation }, set: { $0.operation = $1 }),
            Type<TechnologyHistory>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<TechnologyHistory>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<TechnologyHistory>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<TechnologyHistory>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
            Type<TechnologyHistory>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
            Type<TechnologyHistory>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
            Type<TechnologyHistory>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
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
            Type<TechnologyHistory>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<TechnologyHistory>.optionalProperty("commentsPostId", get: { $0.commentsPostId }, set: { $0.commentsPostId = $1 }),
            Type<TechnologyHistory>.optionalProperty("viewCount", get: { $0.viewCount }, set: { $0.viewCount = $1 }),
            Type<TechnologyHistory>.optionalProperty("favCount", get: { $0.favCount }, set: { $0.favCount = $1 }),
        ])
}

extension TechnologyTier : StringSerializable
{
    public static var typeName:String { return "TechnologyTier" }
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
    public static func fromString(_ strValue:String) -> TechnologyTier? {
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
    public static func fromObject(_ any:Any) -> TechnologyTier? {
        switch any {
        case let i as Int: return TechnologyTier(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension TechnologyStackHistory : JsonSerializable
{
    public static var typeName:String { return "TechnologyStackHistory" }
    public static var metadata = Metadata.create([
            Type<TechnologyStackHistory>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("operation", get: { $0.operation }, set: { $0.operation = $1 }),
            Type<TechnologyStackHistory>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
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
            Type<TechnologyStackHistory>.optionalProperty("detailsHtml", get: { $0.detailsHtml }, set: { $0.detailsHtml = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("commentsPostId", get: { $0.commentsPostId }, set: { $0.commentsPostId = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("viewCount", get: { $0.viewCount }, set: { $0.viewCount = $1 }),
            Type<TechnologyStackHistory>.optionalProperty("favCount", get: { $0.favCount }, set: { $0.favCount = $1 }),
        ])
}

extension UserInfo : JsonSerializable
{
    public static var typeName:String { return "UserInfo" }
    public static var metadata = Metadata.create([
            Type<UserInfo>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<UserInfo>.optionalProperty("avatarUrl", get: { $0.avatarUrl }, set: { $0.avatarUrl = $1 }),
            Type<UserInfo>.optionalProperty("stacksCount", get: { $0.stacksCount }, set: { $0.stacksCount = $1 }),
        ])
}

extension TechnologyInfo : JsonSerializable
{
    public static var typeName:String { return "TechnologyInfo" }
    public static var metadata = Metadata.create([
            Type<TechnologyInfo>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
            Type<TechnologyInfo>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<TechnologyInfo>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<TechnologyInfo>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
            Type<TechnologyInfo>.optionalProperty("stacksCount", get: { $0.stacksCount }, set: { $0.stacksCount = $1 }),
        ])
}

extension TechStackDetails : JsonSerializable
{
    public static var typeName:String { return "TechStackDetails" }
    public static var metadata = Metadata.create([
            Type<TechStackDetails>.arrayProperty("technologyChoices", get: { $0.technologyChoices }, set: { $0.technologyChoices = $1 }),
            Type<TechStackDetails>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<TechStackDetails>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<TechStackDetails>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<TechStackDetails>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
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
            Type<TechStackDetails>.optionalProperty("detailsHtml", get: { $0.detailsHtml }, set: { $0.detailsHtml = $1 }),
            Type<TechStackDetails>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
            Type<TechStackDetails>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<TechStackDetails>.optionalProperty("commentsPostId", get: { $0.commentsPostId }, set: { $0.commentsPostId = $1 }),
            Type<TechStackDetails>.optionalProperty("viewCount", get: { $0.viewCount }, set: { $0.viewCount = $1 }),
            Type<TechStackDetails>.optionalProperty("favCount", get: { $0.favCount }, set: { $0.favCount = $1 }),
        ])
}

extension OrganizationInfo : JsonSerializable
{
    public static var typeName:String { return "OrganizationInfo" }
    public static var metadata = Metadata.create([
            Type<OrganizationInfo>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<OrganizationInfo>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<OrganizationInfo>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<OrganizationInfo>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
            Type<OrganizationInfo>.optionalProperty("refSource", get: { $0.refSource }, set: { $0.refSource = $1 }),
            Type<OrganizationInfo>.optionalProperty("upVotes", get: { $0.upVotes }, set: { $0.upVotes = $1 }),
            Type<OrganizationInfo>.optionalProperty("downVotes", get: { $0.downVotes }, set: { $0.downVotes = $1 }),
            Type<OrganizationInfo>.optionalProperty("membersCount", get: { $0.membersCount }, set: { $0.membersCount = $1 }),
            Type<OrganizationInfo>.optionalProperty("rank", get: { $0.rank }, set: { $0.rank = $1 }),
            Type<OrganizationInfo>.optionalProperty("disableInvites", get: { $0.disableInvites }, set: { $0.disableInvites = $1 }),
            Type<OrganizationInfo>.optionalProperty("lang", get: { $0.lang }, set: { $0.lang = $1 }),
            Type<OrganizationInfo>.arrayProperty("postTypes", get: { $0.postTypes }, set: { $0.postTypes = $1 }),
            Type<OrganizationInfo>.arrayProperty("moderatorPostTypes", get: { $0.moderatorPostTypes }, set: { $0.moderatorPostTypes = $1 }),
            Type<OrganizationInfo>.optionalProperty("locked", get: { $0.locked }, set: { $0.locked = $1 }),
            Type<OrganizationInfo>.arrayProperty("labels", get: { $0.labels }, set: { $0.labels = $1 }),
            Type<OrganizationInfo>.arrayProperty("categories", get: { $0.categories }, set: { $0.categories = $1 }),
        ])
}

extension Option : JsonSerializable
{
    public static var typeName:String { return "Option" }
    public static var metadata = Metadata.create([
            Type<Option>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<Option>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
            Type<Option>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
        ])
}

extension UserVoiceUser : JsonSerializable
{
    public static var typeName:String { return "UserVoiceUser" }
    public static var metadata = Metadata.create([
            Type<UserVoiceUser>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<UserVoiceUser>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<UserVoiceUser>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
            Type<UserVoiceUser>.optionalProperty("avatarUrl", get: { $0.avatarUrl }, set: { $0.avatarUrl = $1 }),
            Type<UserVoiceUser>.optionalProperty("createdAt", get: { $0.createdAt }, set: { $0.createdAt = $1 }),
            Type<UserVoiceUser>.optionalProperty("updatedAt", get: { $0.updatedAt }, set: { $0.updatedAt = $1 }),
        ])
}

extension UserVoiceComment : JsonSerializable
{
    public static var typeName:String { return "UserVoiceComment" }
    public static var metadata = Metadata.create([
            Type<UserVoiceComment>.optionalProperty("text", get: { $0.text }, set: { $0.text = $1 }),
            Type<UserVoiceComment>.optionalProperty("formattedText", get: { $0.formattedText }, set: { $0.formattedText = $1 }),
            Type<UserVoiceComment>.optionalProperty("createdAt", get: { $0.createdAt }, set: { $0.createdAt = $1 }),
            Type<UserVoiceComment>.optionalObjectProperty("creator", get: { $0.creator }, set: { $0.creator = $1 }),
        ])
}

extension TechnologyInStack : JsonSerializable
{
    public static var typeName:String { return "TechnologyInStack" }
    public static var metadata = Metadata.create([
            Type<TechnologyInStack>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
            Type<TechnologyInStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
            Type<TechnologyInStack>.optionalProperty("justification", get: { $0.justification }, set: { $0.justification = $1 }),
            Type<TechnologyInStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<TechnologyInStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<TechnologyInStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
            Type<TechnologyInStack>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
            Type<TechnologyInStack>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
            Type<TechnologyInStack>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
            Type<TechnologyInStack>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
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
            Type<TechnologyInStack>.optionalProperty("organizationId", get: { $0.organizationId }, set: { $0.organizationId = $1 }),
            Type<TechnologyInStack>.optionalProperty("commentsPostId", get: { $0.commentsPostId }, set: { $0.commentsPostId = $1 }),
            Type<TechnologyInStack>.optionalProperty("viewCount", get: { $0.viewCount }, set: { $0.viewCount = $1 }),
            Type<TechnologyInStack>.optionalProperty("favCount", get: { $0.favCount }, set: { $0.favCount = $1 }),
        ])
}

extension LabelInfo : JsonSerializable
{
    public static var typeName:String { return "LabelInfo" }
    public static var metadata = Metadata.create([
            Type<LabelInfo>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
            Type<LabelInfo>.optionalProperty("color", get: { $0.color }, set: { $0.color = $1 }),
        ])
}

extension CategoryInfo : JsonSerializable
{
    public static var typeName:String { return "CategoryInfo" }
    public static var metadata = Metadata.create([
            Type<CategoryInfo>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<CategoryInfo>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<CategoryInfo>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}


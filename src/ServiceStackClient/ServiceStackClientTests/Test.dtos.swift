/* Options:
Date: 2015-09-21 05:59:02
SwiftVersion: 2.0
Version: 4.00
BaseUrl: http://test.servicestack.net

//BaseClass: 
//AddModelExtensions: True
//AddServiceStackTypes: True
//IncludeTypes: 
//ExcludeTypes: 
//ExcludeGenericBaseTypes: True
//AddResponseStatus: False
//AddImplicitVersion: 
//InitializeCollections: True
//DefaultImports: Foundation
*/

import Foundation;

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

    // @DataMember(Order=5)
    public var meta:[String:String] = [:]
}

public enum ExternalEnum : Int
{
    case Foo
    case Bar
    case Baz
}

public class ExternalType
{
    required public init(){}
    public var externalEnum2:ExternalEnum2?
}

public enum ExternalEnum3 : Int
{
    case Un
    case Deux
    case Trois
}

public class MetadataTestChild
{
    required public init(){}
    public var name:String?
    public var results:[MetadataTestNestedChild] = []
}

// @DataContract
public class MenuExample
{
    required public init(){}
    // @DataMember(Order=1)
    // @ApiMember()
    public var menuItemExample1:MenuItemExample?
}

public class NestedClass
{
    required public init(){}
    public var value:String?
}

public class ListResult
{
    required public init(){}
    public var result:String?
}

public class ArrayResult
{
    required public init(){}
    public var result:String?
}

public enum EnumType : Int
{
    case Value1
    case Value2
}

// @Flags()
public enum EnumFlags : Int
{
    case Value1 = 1
    case Value2 = 2
    case Value3 = 4
}

public class AllTypes
{
    required public init(){}
    public var id:Int?
    public var nullableId:Int?
    public var byte:Int8?
    public var short:Int16?
    public var int:Int?
    public var long:Int64?
    public var uShort:UInt16?
    public var uInt:UInt32?
    public var uLong:UInt64?
    public var float:Float?
    public var double:Double?
    public var decimal:Double?
    public var string:String?
    public var dateTime:NSDate?
    public var timeSpan:NSTimeInterval?
    public var dateTimeOffset:NSDate?
    public var guid:String?
    public var char:Character?
    public var nullableDateTime:NSDate?
    public var nullableTimeSpan:NSTimeInterval?
    public var stringList:[String] = []
    public var stringArray:[String] = []
    public var stringMap:[String:String] = [:]
    public var intStringMap:[Int:String] = [:]
    public var subType:SubType?
}

public class AllCollectionTypes
{
    required public init(){}
    public var intArray:[Int] = []
    public var intList:[Int] = []
    public var stringArray:[String] = []
    public var stringList:[String] = []
    public var pocoArray:[Poco] = []
    public var pocoList:[Poco] = []
    public var pocoLookup:[String:[Poco]] = [:]
    public var pocoLookupMap:[String:[String:Poco]] = [:]
}

public class HelloBase
{
    required public init(){}
    public var id:Int?
}

public class HelloResponseBase
{
    required public init(){}
    public var refId:Int?
}

public class Poco
{
    required public init(){}
    public var name:String?
}

public class HelloBase_1<T : JsonSerializable>
{
    required public init(){}
    public var items:[T] = []
    public var counts:[Int] = []
}

public class Item
{
    required public init(){}
    public var value:String?
}

public class InheritedItem
{
    required public init(){}
    public var name:String?
}

public class HelloWithReturnResponse
{
    required public init(){}
    public var result:String?
}

public class HelloType
{
    required public init(){}
    public var result:String?
}

public protocol IPoco
{
    var name:String? { get set }
}

public protocol IEmptyInterface
{
}

public class EmptyClass
{
    required public init(){}
}

public class InnerType
{
    required public init(){}
    public var id:Int64?
    public var name:String?
}

public enum InnerEnum : Int
{
    case Foo
    case Bar
    case Baz
}

public enum DayOfWeek : Int
{
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

public class PingService
{
    required public init(){}
}

public class CustomUserSession : AuthUserSession
{
    required public init(){}
    // @DataMember
    public var customName:String?

    // @DataMember
    public var customInfo:String?
}

public class UnAuthInfo
{
    required public init(){}
    public var customInfo:String?
}

public class RequestLogEntry
{
    required public init(){}
    public var id:Int64?
    public var dateTime:NSDate?
    public var httpMethod:String?
    public var absoluteUri:String?
    public var pathInfo:String?
    public var requestBody:String?
    //requestDto:Object ignored. Type could not be extended in Swift
    public var userAuthId:String?
    public var sessionId:String?
    public var ipAddress:String?
    public var forwardedFor:String?
    public var referer:String?
    public var headers:[String:String] = [:]
    public var formData:[String:String] = [:]
    public var items:[String:String] = [:]
    //session:Object ignored. Type could not be extended in Swift
    //responseDto:Object ignored. Type could not be extended in Swift
    //errorResponse:Object ignored. Type could not be extended in Swift
    public var requestDuration:NSTimeInterval?
}

public class QueryBase_1<T : JsonSerializable> : QueryBase
{
    required public init(){}
}

public class OnlyDefinedInGenericType
{
    required public init(){}
    public var id:Int?
    public var name:String?
}

public class QueryBase_2<From : JsonSerializable, Into : JsonSerializable> : QueryBase
{
    required public init(){}
}

public class OnlyDefinedInGenericTypeFrom
{
    required public init(){}
    public var id:Int?
    public var name:String?
}

public class OnlyDefinedInGenericTypeInto
{
    required public init(){}
    public var id:Int?
    public var name:String?
}

public class Rockstar
{
    required public init(){}
    public var id:Int?
    public var firstName:String?
    public var lastName:String?
    public var age:Int?
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

    // @DataMember(Order=4, EmitDefaultValue=false)
    public var meta:[String:String] = [:]
}

public enum ExternalEnum2 : Int
{
    case Uno
    case Due
    case Tre
}

public class MetadataTestNestedChild
{
    required public init(){}
    public var name:String?
}

public class MenuItemExample
{
    required public init(){}
    // @DataMember(Order=1)
    // @ApiMember()
    public var name1:String?

    public var menuItemExampleItem:MenuItemExampleItem?
}

public class SubType
{
    required public init(){}
    public var id:Int?
    public var name:String?
}

public class TypesGroup
{
    required public init(){}
}

public protocol IAuthTokens
{
    var provider:String? { get set }
    var userId:String? { get set }
    var accessToken:String? { get set }
    var accessTokenSecret:String? { get set }
    var refreshToken:String? { get set }
    var refreshTokenExpiry:NSDate? { get set }
    var requestToken:String? { get set }
    var requestTokenSecret:String? { get set }
    var items:[String:String]? { get set }
}

// @DataContract
public class AuthUserSession
{
    required public init(){}
    // @DataMember(Order=1)
    public var referrerUrl:String?

    // @DataMember(Order=2)
    public var id:String?

    // @DataMember(Order=3)
    public var userAuthId:String?

    // @DataMember(Order=4)
    public var userAuthName:String?

    // @DataMember(Order=5)
    public var userName:String?

    // @DataMember(Order=6)
    public var twitterUserId:String?

    // @DataMember(Order=7)
    public var twitterScreenName:String?

    // @DataMember(Order=8)
    public var facebookUserId:String?

    // @DataMember(Order=9)
    public var facebookUserName:String?

    // @DataMember(Order=10)
    public var firstName:String?

    // @DataMember(Order=11)
    public var lastName:String?

    // @DataMember(Order=12)
    public var displayName:String?

    // @DataMember(Order=13)
    public var company:String?

    // @DataMember(Order=14)
    public var email:String?

    // @DataMember(Order=15)
    public var primaryEmail:String?

    // @DataMember(Order=16)
    public var phoneNumber:String?

    // @DataMember(Order=17)
    public var birthDate:NSDate?

    // @DataMember(Order=18)
    public var birthDateRaw:String?

    // @DataMember(Order=19)
    public var address:String?

    // @DataMember(Order=20)
    public var address2:String?

    // @DataMember(Order=21)
    public var city:String?

    // @DataMember(Order=22)
    public var state:String?

    // @DataMember(Order=23)
    public var country:String?

    // @DataMember(Order=24)
    public var culture:String?

    // @DataMember(Order=25)
    public var fullName:String?

    // @DataMember(Order=26)
    public var gender:String?

    // @DataMember(Order=27)
    public var language:String?

    // @DataMember(Order=28)
    public var mailAddress:String?

    // @DataMember(Order=29)
    public var nickname:String?

    // @DataMember(Order=30)
    public var postalCode:String?

    // @DataMember(Order=31)
    public var timeZone:String?

    // @DataMember(Order=32)
    public var requestTokenSecret:String?

    // @DataMember(Order=33)
    public var createdAt:NSDate?

    // @DataMember(Order=34)
    public var lastModified:NSDate?

    // @DataMember(Order=35)
    public var roles:[String] = []

    // @DataMember(Order=36)
    public var permissions:[String] = []

    // @DataMember(Order=37)
    public var isAuthenticated:Bool?

    // @DataMember(Order=38)
    public var sequence:String?

    // @DataMember(Order=39)
    public var tag:Int64?

    //providerOAuthAccess:[IAuthTokens] ignored. Swift doesn't support interface properties
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
    public var meta:[String:String] = [:]
}

public class MenuItemExampleItem
{
    required public init(){}
    // @DataMember(Order=1)
    // @ApiMember()
    public var name1:String?
}

public class CustomHttpErrorResponse
{
    required public init(){}
    public var custom:String?
    public var responseStatus:ResponseStatus?
}

public class ThrowTypeResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

public class ThrowValidationResponse
{
    required public init(){}
    public var age:Int?
    public var required:String?
    public var email:String?
    public var responseStatus:ResponseStatus?
}

public class ExternalOperationResponse
{
    required public init(){}
    public var result:String?
}

public class ExternalOperation2Response
{
    required public init(){}
    public var externalType:ExternalType?
}

public class ExternalReturnTypeResponse
{
    required public init(){}
    public var externalEnum3:ExternalEnum3?
}

public class Account
{
    required public init(){}
    public var name:String?
}

public class Project
{
    required public init(){}
    public var account:String?
    public var name:String?
}

public class MetadataTestResponse
{
    required public init(){}
    public var id:Int?
    public var results:[MetadataTestChild] = []
}

// @DataContract
public class GetExampleResponse
{
    required public init(){}
    // @DataMember(Order=1)
    public var responseStatus:ResponseStatus?

    // @DataMember(Order=2)
    // @ApiMember()
    public var menuExample1:MenuExample?
}

public class GetRandomIdsResponse
{
    required public init(){}
    public var results:[String] = []
}

public class HelloResponse
{
    required public init(){}
    public var result:String?
}

public class HelloAllTypesResponse
{
    required public init(){}
    public var result:String?
    public var allTypes:AllTypes?
    public var allCollectionTypes:AllCollectionTypes?
}

// @DataContract
public class HelloWithDataContractResponse
{
    required public init(){}
    // @DataMember(Name="result", Order=1, IsRequired=true, EmitDefaultValue=false)
    public var result:String?
}

/**
* Description on HelloWithDescriptionResponse type
*/
public class HelloWithDescriptionResponse
{
    required public init(){}
    public var result:String?
}

public class HelloWithInheritanceResponse : HelloResponseBase
{
    required public init(){}
    public var result:String?
}

public class HelloWithAlternateReturnResponse : HelloWithReturnResponse
{
    required public init(){}
    public var altResult:String?
}

public class HelloWithRouteResponse
{
    required public init(){}
    public var result:String?
}

public class HelloWithTypeResponse
{
    required public init(){}
    public var result:HelloType?
}

public class HelloInnerTypesResponse
{
    required public init(){}
    public var innerType:InnerType?
    public var innerEnum:InnerEnum?
}

public class HelloVerbResponse
{
    required public init(){}
    public var result:String?
}

public class PingResponse
{
    required public init(){}
    public var responses:[String:ResponseStatus] = [:]
    public var responseStatus:ResponseStatus?
}

public class RequiresRoleResponse
{
    required public init(){}
    public var result:String?
    public var responseStatus:ResponseStatus?
}

public class SendVerbResponse
{
    required public init(){}
    public var id:Int?
    public var pathInfo:String?
    public var requestMethod:String?
}

public class GetSessionResponse
{
    required public init(){}
    public var result:CustomUserSession?
    public var unAuthInfo:UnAuthInfo?
    public var responseStatus:ResponseStatus?
}

// @Route("/wait/{ForMs}")
public class Wait
{
    required public init(){}
    public var forMs:Int?
}

// @DataContract
public class RequestLogsResponse
{
    required public init(){}
    // @DataMember(Order=1)
    public var results:[RequestLogEntry] = []

    // @DataMember(Order=2)
    public var usage:[String:String] = [:]

    // @DataMember(Order=3)
    public var responseStatus:ResponseStatus?
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

// @DataContract
public class AssignRolesResponse
{
    required public init(){}
    // @DataMember(Order=1)
    public var allRoles:[String] = []

    // @DataMember(Order=2)
    public var allPermissions:[String] = []

    // @DataMember(Order=3)
    public var responseStatus:ResponseStatus?
}

// @DataContract
public class UnAssignRolesResponse
{
    required public init(){}
    // @DataMember(Order=1)
    public var allRoles:[String] = []

    // @DataMember(Order=2)
    public var allPermissions:[String] = []

    // @DataMember(Order=3)
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

public class CustomHttpError : IReturn
{
    public typealias Return = CustomHttpErrorResponse

    required public init(){}
    public var statusCode:Int?
    public var statusDescription:String?
}

// @Route("/throwhttperror/{Status}")
public class ThrowHttpError
{
    required public init(){}
    public var status:Int?
    public var message:String?
}

// @Route("/throw404")
// @Route("/throw404/{Message}")
public class Throw404
{
    required public init(){}
    public var message:String?
}

// @Route("/throw/{Type}")
public class ThrowType : IReturn
{
    public typealias Return = ThrowTypeResponse

    required public init(){}
    public var type:String?
    public var message:String?
}

// @Route("/throwvalidation")
public class ThrowValidation : IReturn
{
    public typealias Return = ThrowValidationResponse

    required public init(){}
    public var age:Int?
    public var required:String?
    public var email:String?
}

public class ExternalOperation : IReturn
{
    public typealias Return = ExternalOperationResponse

    required public init(){}
    public var id:Int?
    public var name:String?
    public var externalEnum:ExternalEnum?
}

public class ExternalOperation2 : IReturn
{
    public typealias Return = ExternalOperation2Response

    required public init(){}
    public var id:Int?
}

public class ExternalOperation3 : IReturn
{
    public typealias Return = ExternalReturnTypeResponse

    required public init(){}
    public var id:Int?
}

public class ExternalOperation4
{
    required public init(){}
    public var id:Int?
}

// @Route("/{Path*}")
public class RootPathRoutes
{
    required public init(){}
    public var path:String?
}

public class GetAccount : IReturn
{
    public typealias Return = Account

    required public init(){}
    public var account:String?
}

public class GetProject : IReturn
{
    public typealias Return = Project

    required public init(){}
    public var account:String?
    public var project:String?
}

// @Route("/image-stream")
public class ImageAsStream
{
    required public init(){}
    public var format:String?
}

// @Route("/image-bytes")
public class ImageAsBytes
{
    required public init(){}
    public var format:String?
}

// @Route("/image-custom")
public class ImageAsCustomResult
{
    required public init(){}
    public var format:String?
}

// @Route("/image-response")
public class ImageWriteToResponse
{
    required public init(){}
    public var format:String?
}

// @Route("/image-file")
public class ImageAsFile
{
    required public init(){}
    public var format:String?
}

// @Route("/image-redirect")
public class ImageAsRedirect
{
    required public init(){}
    public var format:String?
}

// @Route("/image-draw/{Name}")
public class DrawImage
{
    required public init(){}
    public var name:String?
    public var format:String?
    public var width:Int?
    public var height:Int?
    public var fontSize:Int?
    public var foreground:String?
    public var background:String?
}

// @Route("/metadatatest")
public class MetadataTest : IReturn
{
    public typealias Return = MetadataTestResponse

    required public init(){}
    public var id:Int?
}

// @Route("/metadatatest-array")
public class MetadataTestArray
{
    required public init(){}
    public var id:Int?
}

// @Route("/example", "GET")
// @DataContract
public class GetExample : IReturn
{
    public typealias Return = GetExampleResponse

    required public init(){}
}

// @Route("/randomids")
public class GetRandomIds : IReturn
{
    public typealias Return = GetRandomIdsResponse

    required public init(){}
    public var take:Int?
}

// @Route("/textfile-test")
public class TextFileTest
{
    required public init(){}
    public var asAttachment:Bool?
}

// @Route("/hello")
// @Route("/hello/{Name}")
public class Hello : IReturn
{
    public typealias Return = HelloResponse

    required public init(){}
    // @Required()
    public var name:String?

    public var title:String?
}

public class HelloWithNestedClass : IReturn
{
    public typealias Return = HelloResponse

    required public init(){}
    public var name:String?
    public var nestedClassProp:NestedClass?
}

public class HelloList
{
    required public init(){}
    public var names:[String] = []
}

public class HelloArray
{
    required public init(){}
    public var names:[String] = []
}

public class HelloWithEnum
{
    required public init(){}
    public var enumProp:EnumType?
    public var nullableEnumProp:EnumType?
    public var enumFlags:EnumFlags?
}

public class HelloExternal
{
    required public init(){}
    public var name:String?
}

/**
* AllowedAttributes Description
*/
// @Route("/allowed-attributes", "GET")
// @Api("AllowedAttributes Description")
// @ApiResponse(400, "Your request was not understood")
// @DataContract
public class AllowedAttributes
{
    required public init(){}
    // @DataMember(Name="Aliased")
    // @ApiMember(ParameterType="path", Description="Range Description", DataType="double", IsRequired=true)
    public var range:Double?
}

// @Route("/all-types")
public class HelloAllTypes : IReturn
{
    public typealias Return = HelloAllTypesResponse

    required public init(){}
    public var name:String?
    public var allTypes:AllTypes?
    public var allCollectionTypes:AllCollectionTypes?
}

public class HelloString : IReturn
{
    public typealias Return = String

    required public init(){}
    public var name:String?
}

public class HelloVoid
{
    required public init(){}
    public var name:String?
}

// @DataContract
public class HelloWithDataContract : IReturn
{
    public typealias Return = HelloWithDataContractResponse

    required public init(){}
    // @DataMember(Name="name", Order=1, IsRequired=true, EmitDefaultValue=false)
    public var name:String?

    // @DataMember(Name="id", Order=2, EmitDefaultValue=false)
    public var id:Int?
}

/**
* Description on HelloWithDescription type
*/
public class HelloWithDescription : IReturn
{
    public typealias Return = HelloWithDescriptionResponse

    required public init(){}
    public var name:String?
}

public class HelloWithInheritance : HelloBase, IReturn
{
    public typealias Return = HelloWithInheritanceResponse

    required public init(){}
    public var name:String?
}
//Excluded HelloWithGenericInheritance : HelloBase<Poco>
//Excluded HelloWithGenericInheritance2 : HelloBase<Hello>
//Excluded HelloWithNestedInheritance : HelloBase<HelloWithNestedInheritance.Item>
//Excluded HelloWithListInheritance : List<InheritedItem>

public class HelloWithReturn : IReturn
{
    public typealias Return = HelloWithAlternateReturnResponse

    required public init(){}
    public var name:String?
}

// @Route("/helloroute")
public class HelloWithRoute : IReturn
{
    public typealias Return = HelloWithRouteResponse

    required public init(){}
    public var name:String?
}

public class HelloWithType : IReturn
{
    public typealias Return = HelloWithTypeResponse

    required public init(){}
    public var name:String?
}

public class HelloInterface
{
    required public init(){}
    //poco:IPoco ignored. Swift doesn't support interface properties
    //emptyInterface:IEmptyInterface ignored. Swift doesn't support interface properties
    public var emptyClass:EmptyClass?
}

public class HelloInnerTypes : IReturn
{
    public typealias Return = HelloInnerTypesResponse

    required public init(){}
}

public class HelloBuiltin
{
    required public init(){}
    public var dayOfWeek:DayOfWeek?
}

public class HelloGet : IReturn, IGet
{
    public typealias Return = HelloVerbResponse

    required public init(){}
    public var id:Int?
}

public class HelloPost : HelloBase, IReturn, IPost
{
    public typealias Return = HelloVerbResponse

    required public init(){}
}

public class HelloPut : IReturn, IPut
{
    public typealias Return = HelloVerbResponse

    required public init(){}
    public var id:Int?
}

public class HelloDelete : IReturn, IDelete
{
    public typealias Return = HelloVerbResponse

    required public init(){}
    public var id:Int?
}

public class HelloPatch : IReturn, IPatch
{
    public typealias Return = HelloVerbResponse

    required public init(){}
    public var id:Int?
}

public class HelloReturnVoid : IReturnVoid
{
    required public init(){}
    public var id:Int?
}

// @Route("/ping")
public class Ping : IReturn
{
    public typealias Return = PingResponse

    required public init(){}
}

// @Route("/reset-connections")
public class ResetConnections
{
    required public init(){}
}

// @Route("/requires-role")
public class RequiresRole : IReturn
{
    public typealias Return = RequiresRoleResponse

    required public init(){}
}

public class SendDefault : IReturn
{
    public typealias Return = SendVerbResponse

    required public init(){}
    public var id:Int?
}

// @Route("/sendrestget/{Id}", "GET")
public class SendRestGet : IReturn, IGet
{
    public typealias Return = SendVerbResponse

    required public init(){}
    public var id:Int?
}

public class SendGet : IReturn, IGet
{
    public typealias Return = SendVerbResponse

    required public init(){}
    public var id:Int?
}

public class SendPost : IReturn, IPost
{
    public typealias Return = SendVerbResponse

    required public init(){}
    public var id:Int?
}

public class SendPut : IReturn, IPut
{
    public typealias Return = SendVerbResponse

    required public init(){}
    public var id:Int?
}

// @Route("/session")
public class GetSession : IReturn
{
    public typealias Return = GetSessionResponse

    required public init(){}
}

// @Route("/session/edit/{CustomName}")
public class UpdateSession : IReturn
{
    public typealias Return = GetSessionResponse

    required public init(){}
    public var customName:String?
}

// @Route("/void-response")
public class TestVoidResponse
{
    required public init(){}
}

// @Route("/null-response")
public class TestNullResponse
{
    required public init(){}
}

// @Route("/requestlogs")
// @DataContract
public class RequestLogs : IReturn
{
    public typealias Return = RequestLogsResponse

    required public init(){}
    // @DataMember(Order=1)
    public var beforeSecs:Int?

    // @DataMember(Order=2)
    public var afterSecs:Int?

    // @DataMember(Order=3)
    public var ipAddress:String?

    // @DataMember(Order=4)
    public var forwardedFor:String?

    // @DataMember(Order=5)
    public var userAuthId:String?

    // @DataMember(Order=6)
    public var sessionId:String?

    // @DataMember(Order=7)
    public var referer:String?

    // @DataMember(Order=8)
    public var pathInfo:String?

    // @DataMember(Order=9)
    public var ids:[Int64] = []

    // @DataMember(Order=10)
    public var beforeId:Int?

    // @DataMember(Order=11)
    public var afterId:Int?

    // @DataMember(Order=12)
    public var hasResponse:Bool?

    // @DataMember(Order=13)
    public var withErrors:Bool?

    // @DataMember(Order=14)
    public var skip:Int?

    // @DataMember(Order=15)
    public var take:Int?

    // @DataMember(Order=16)
    public var enableSessionTracking:Bool?

    // @DataMember(Order=17)
    public var enableResponseTracking:Bool?

    // @DataMember(Order=18)
    public var enableErrorTracking:Bool?

    // @DataMember(Order=19)
    public var durationLongerThan:NSTimeInterval?

    // @DataMember(Order=20)
    public var durationLessThan:NSTimeInterval?
}

// @Route("/auth")
// @Route("/auth/{provider}")
// @Route("/authenticate")
// @Route("/authenticate/{provider}")
// @DataContract
public class Authenticate : IReturn
{
    public typealias Return = AuthenticateResponse

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
    public var `continue`:String?

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
// @DataContract
public class AssignRoles : IReturn
{
    public typealias Return = AssignRolesResponse

    required public init(){}
    // @DataMember(Order=1)
    public var userName:String?

    // @DataMember(Order=2)
    public var permissions:[String] = []

    // @DataMember(Order=3)
    public var roles:[String] = []
}

// @Route("/unassignroles")
// @DataContract
public class UnAssignRoles : IReturn
{
    public typealias Return = UnAssignRolesResponse

    required public init(){}
    // @DataMember(Order=1)
    public var userName:String?

    // @DataMember(Order=2)
    public var permissions:[String] = []

    // @DataMember(Order=3)
    public var roles:[String] = []
}
//Excluded QueryPocoBase : QueryBase<OnlyDefinedInGenericType>
//Excluded QueryPocoIntoBase : QueryBase<OnlyDefinedInGenericTypeFrom,OnlyDefinedInGenericTypeInto>
//Excluded QueryRockstars : QueryBase<Rockstar>


extension ResponseStatus : JsonSerializable
{
    public static var typeName:String { return "ResponseStatus" }
    public static var metadata = Metadata.create([
            Type<ResponseStatus>.optionalProperty("errorCode", get: { $0.errorCode }, set: { $0.errorCode = $1 }),
            Type<ResponseStatus>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
            Type<ResponseStatus>.optionalProperty("stackTrace", get: { $0.stackTrace }, set: { $0.stackTrace = $1 }),
            Type<ResponseStatus>.arrayProperty("errors", get: { $0.errors }, set: { $0.errors = $1 }),
            Type<ResponseStatus>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension ExternalEnum : StringSerializable
{
    public static var typeName:String { return "ExternalEnum" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Foo: return "Foo"
        case .Bar: return "Bar"
        case .Baz: return "Baz"
        }
    }
    public static func fromString(strValue:String) -> ExternalEnum? {
        switch strValue {
        case "Foo": return .Foo
        case "Bar": return .Bar
        case "Baz": return .Baz
        default: return nil
        }
    }
    public static func fromObject(any:AnyObject) -> ExternalEnum? {
        switch any {
        case let i as Int: return ExternalEnum(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension ExternalType : JsonSerializable
{
    public static var typeName:String { return "ExternalType" }
    public static var metadata = Metadata.create([
            Type<ExternalType>.optionalProperty("externalEnum2", get: { $0.externalEnum2 }, set: { $0.externalEnum2 = $1 }),
        ])
}

extension ExternalEnum3 : StringSerializable
{
    public static var typeName:String { return "ExternalEnum3" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Un: return "Un"
        case .Deux: return "Deux"
        case .Trois: return "Trois"
        }
    }
    public static func fromString(strValue:String) -> ExternalEnum3? {
        switch strValue {
        case "Un": return .Un
        case "Deux": return .Deux
        case "Trois": return .Trois
        default: return nil
        }
    }
    public static func fromObject(any:AnyObject) -> ExternalEnum3? {
        switch any {
        case let i as Int: return ExternalEnum3(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension MetadataTestChild : JsonSerializable
{
    public static var typeName:String { return "MetadataTestChild" }
    public static var metadata = Metadata.create([
            Type<MetadataTestChild>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<MetadataTestChild>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension MenuExample : JsonSerializable
{
    public static var typeName:String { return "MenuExample" }
    public static var metadata = Metadata.create([
            Type<MenuExample>.optionalObjectProperty("menuItemExample1", get: { $0.menuItemExample1 }, set: { $0.menuItemExample1 = $1 }),
        ])
}

extension NestedClass : JsonSerializable
{
    public static var typeName:String { return "NestedClass" }
    public static var metadata = Metadata.create([
            Type<NestedClass>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
        ])
}

extension ListResult : JsonSerializable
{
    public static var typeName:String { return "ListResult" }
    public static var metadata = Metadata.create([
            Type<ListResult>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension ArrayResult : JsonSerializable
{
    public static var typeName:String { return "ArrayResult" }
    public static var metadata = Metadata.create([
            Type<ArrayResult>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension EnumType : StringSerializable
{
    public static var typeName:String { return "EnumType" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Value1: return "Value1"
        case .Value2: return "Value2"
        }
    }
    public static func fromString(strValue:String) -> EnumType? {
        switch strValue {
        case "Value1": return .Value1
        case "Value2": return .Value2
        default: return nil
        }
    }
    public static func fromObject(any:AnyObject) -> EnumType? {
        switch any {
        case let i as Int: return EnumType(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension EnumFlags : StringSerializable
{
    public static var typeName:String { return "EnumFlags" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Value1: return "Value1"
        case .Value2: return "Value2"
        case .Value3: return "Value3"
        }
    }
    public static func fromString(strValue:String) -> EnumFlags? {
        switch strValue {
        case "Value1": return .Value1
        case "Value2": return .Value2
        case "Value3": return .Value3
        default: return nil
        }
    }
    public static func fromObject(any:AnyObject) -> EnumFlags? {
        switch any {
        case let i as Int: return EnumFlags(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension AllTypes : JsonSerializable
{
    public static var typeName:String { return "AllTypes" }
    public static var metadata = Metadata.create([
            Type<AllTypes>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<AllTypes>.optionalProperty("nullableId", get: { $0.nullableId }, set: { $0.nullableId = $1 }),
            Type<AllTypes>.optionalProperty("byte", get: { $0.byte }, set: { $0.byte = $1 }),
            Type<AllTypes>.optionalProperty("short", get: { $0.short }, set: { $0.short = $1 }),
            Type<AllTypes>.optionalProperty("int", get: { $0.int }, set: { $0.int = $1 }),
            Type<AllTypes>.optionalProperty("long", get: { $0.long }, set: { $0.long = $1 }),
            Type<AllTypes>.optionalProperty("uShort", get: { $0.uShort }, set: { $0.uShort = $1 }),
            Type<AllTypes>.optionalProperty("uInt", get: { $0.uInt }, set: { $0.uInt = $1 }),
            Type<AllTypes>.optionalProperty("uLong", get: { $0.uLong }, set: { $0.uLong = $1 }),
            Type<AllTypes>.optionalProperty("float", get: { $0.float }, set: { $0.float = $1 }),
            Type<AllTypes>.optionalProperty("double", get: { $0.double }, set: { $0.double = $1 }),
            Type<AllTypes>.optionalProperty("decimal", get: { $0.decimal }, set: { $0.decimal = $1 }),
            Type<AllTypes>.optionalProperty("string", get: { $0.string }, set: { $0.string = $1 }),
            Type<AllTypes>.optionalProperty("dateTime", get: { $0.dateTime }, set: { $0.dateTime = $1 }),
            Type<AllTypes>.optionalProperty("timeSpan", get: { $0.timeSpan }, set: { $0.timeSpan = $1 }),
            Type<AllTypes>.optionalProperty("dateTimeOffset", get: { $0.dateTimeOffset }, set: { $0.dateTimeOffset = $1 }),
            Type<AllTypes>.optionalProperty("guid", get: { $0.guid }, set: { $0.guid = $1 }),
            Type<AllTypes>.optionalProperty("char", get: { $0.char }, set: { $0.char = $1 }),
            Type<AllTypes>.optionalProperty("nullableDateTime", get: { $0.nullableDateTime }, set: { $0.nullableDateTime = $1 }),
            Type<AllTypes>.optionalProperty("nullableTimeSpan", get: { $0.nullableTimeSpan }, set: { $0.nullableTimeSpan = $1 }),
            Type<AllTypes>.arrayProperty("stringList", get: { $0.stringList }, set: { $0.stringList = $1 }),
            Type<AllTypes>.arrayProperty("stringArray", get: { $0.stringArray }, set: { $0.stringArray = $1 }),
            Type<AllTypes>.objectProperty("stringMap", get: { $0.stringMap }, set: { $0.stringMap = $1 }),
            Type<AllTypes>.objectProperty("intStringMap", get: { $0.intStringMap }, set: { $0.intStringMap = $1 }),
            Type<AllTypes>.optionalObjectProperty("subType", get: { $0.subType }, set: { $0.subType = $1 }),
        ])
}

extension AllCollectionTypes : JsonSerializable
{
    public static var typeName:String { return "AllCollectionTypes" }
    public static var metadata = Metadata.create([
            Type<AllCollectionTypes>.arrayProperty("intArray", get: { $0.intArray }, set: { $0.intArray = $1 }),
            Type<AllCollectionTypes>.arrayProperty("intList", get: { $0.intList }, set: { $0.intList = $1 }),
            Type<AllCollectionTypes>.arrayProperty("stringArray", get: { $0.stringArray }, set: { $0.stringArray = $1 }),
            Type<AllCollectionTypes>.arrayProperty("stringList", get: { $0.stringList }, set: { $0.stringList = $1 }),
            Type<AllCollectionTypes>.arrayProperty("pocoArray", get: { $0.pocoArray }, set: { $0.pocoArray = $1 }),
            Type<AllCollectionTypes>.arrayProperty("pocoList", get: { $0.pocoList }, set: { $0.pocoList = $1 }),
            Type<AllCollectionTypes>.objectProperty("pocoLookup", get: { $0.pocoLookup }, set: { $0.pocoLookup = $1 }),
            Type<AllCollectionTypes>.objectProperty("pocoLookupMap", get: { $0.pocoLookupMap }, set: { $0.pocoLookupMap = $1 }),
        ])
}

extension Poco : JsonSerializable
{
    public static var typeName:String { return "Poco" }
    public static var metadata = Metadata.create([
            Type<Poco>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension Item : JsonSerializable
{
    public static var typeName:String { return "Item" }
    public static var metadata = Metadata.create([
            Type<Item>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
        ])
}

extension InheritedItem : JsonSerializable
{
    public static var typeName:String { return "InheritedItem" }
    public static var metadata = Metadata.create([
            Type<InheritedItem>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension HelloType : JsonSerializable
{
    public static var typeName:String { return "HelloType" }
    public static var metadata = Metadata.create([
            Type<HelloType>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension EmptyClass : JsonSerializable
{
    public static var typeName:String { return "EmptyClass" }
    public static var metadata = Metadata.create([
        ])
}

extension InnerType : JsonSerializable
{
    public static var typeName:String { return "InnerType" }
    public static var metadata = Metadata.create([
            Type<InnerType>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<InnerType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension InnerEnum : StringSerializable
{
    public static var typeName:String { return "InnerEnum" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Foo: return "Foo"
        case .Bar: return "Bar"
        case .Baz: return "Baz"
        }
    }
    public static func fromString(strValue:String) -> InnerEnum? {
        switch strValue {
        case "Foo": return .Foo
        case "Bar": return .Bar
        case "Baz": return .Baz
        default: return nil
        }
    }
    public static func fromObject(any:AnyObject) -> InnerEnum? {
        switch any {
        case let i as Int: return InnerEnum(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension DayOfWeek : StringSerializable
{
    public static var typeName:String { return "DayOfWeek" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Sunday: return "Sunday"
        case .Monday: return "Monday"
        case .Tuesday: return "Tuesday"
        case .Wednesday: return "Wednesday"
        case .Thursday: return "Thursday"
        case .Friday: return "Friday"
        case .Saturday: return "Saturday"
        }
    }
    public static func fromString(strValue:String) -> DayOfWeek? {
        switch strValue {
        case "Sunday": return .Sunday
        case "Monday": return .Monday
        case "Tuesday": return .Tuesday
        case "Wednesday": return .Wednesday
        case "Thursday": return .Thursday
        case "Friday": return .Friday
        case "Saturday": return .Saturday
        default: return nil
        }
    }
    public static func fromObject(any:AnyObject) -> DayOfWeek? {
        switch any {
        case let i as Int: return DayOfWeek(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension PingService : JsonSerializable
{
    public static var typeName:String { return "PingService" }
    public static var metadata = Metadata.create([
        ])
}

extension CustomUserSession : JsonSerializable
{
    public static var typeName:String { return "CustomUserSession" }
    public static var metadata = Metadata.create([
            Type<CustomUserSession>.optionalProperty("customName", get: { $0.customName }, set: { $0.customName = $1 }),
            Type<CustomUserSession>.optionalProperty("customInfo", get: { $0.customInfo }, set: { $0.customInfo = $1 }),
            Type<CustomUserSession>.optionalProperty("referrerUrl", get: { $0.referrerUrl }, set: { $0.referrerUrl = $1 }),
            Type<CustomUserSession>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<CustomUserSession>.optionalProperty("userAuthId", get: { $0.userAuthId }, set: { $0.userAuthId = $1 }),
            Type<CustomUserSession>.optionalProperty("userAuthName", get: { $0.userAuthName }, set: { $0.userAuthName = $1 }),
            Type<CustomUserSession>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<CustomUserSession>.optionalProperty("twitterUserId", get: { $0.twitterUserId }, set: { $0.twitterUserId = $1 }),
            Type<CustomUserSession>.optionalProperty("twitterScreenName", get: { $0.twitterScreenName }, set: { $0.twitterScreenName = $1 }),
            Type<CustomUserSession>.optionalProperty("facebookUserId", get: { $0.facebookUserId }, set: { $0.facebookUserId = $1 }),
            Type<CustomUserSession>.optionalProperty("facebookUserName", get: { $0.facebookUserName }, set: { $0.facebookUserName = $1 }),
            Type<CustomUserSession>.optionalProperty("firstName", get: { $0.firstName }, set: { $0.firstName = $1 }),
            Type<CustomUserSession>.optionalProperty("lastName", get: { $0.lastName }, set: { $0.lastName = $1 }),
            Type<CustomUserSession>.optionalProperty("displayName", get: { $0.displayName }, set: { $0.displayName = $1 }),
            Type<CustomUserSession>.optionalProperty("company", get: { $0.company }, set: { $0.company = $1 }),
            Type<CustomUserSession>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
            Type<CustomUserSession>.optionalProperty("primaryEmail", get: { $0.primaryEmail }, set: { $0.primaryEmail = $1 }),
            Type<CustomUserSession>.optionalProperty("phoneNumber", get: { $0.phoneNumber }, set: { $0.phoneNumber = $1 }),
            Type<CustomUserSession>.optionalProperty("birthDate", get: { $0.birthDate }, set: { $0.birthDate = $1 }),
            Type<CustomUserSession>.optionalProperty("birthDateRaw", get: { $0.birthDateRaw }, set: { $0.birthDateRaw = $1 }),
            Type<CustomUserSession>.optionalProperty("address", get: { $0.address }, set: { $0.address = $1 }),
            Type<CustomUserSession>.optionalProperty("address2", get: { $0.address2 }, set: { $0.address2 = $1 }),
            Type<CustomUserSession>.optionalProperty("city", get: { $0.city }, set: { $0.city = $1 }),
            Type<CustomUserSession>.optionalProperty("state", get: { $0.state }, set: { $0.state = $1 }),
            Type<CustomUserSession>.optionalProperty("country", get: { $0.country }, set: { $0.country = $1 }),
            Type<CustomUserSession>.optionalProperty("culture", get: { $0.culture }, set: { $0.culture = $1 }),
            Type<CustomUserSession>.optionalProperty("fullName", get: { $0.fullName }, set: { $0.fullName = $1 }),
            Type<CustomUserSession>.optionalProperty("gender", get: { $0.gender }, set: { $0.gender = $1 }),
            Type<CustomUserSession>.optionalProperty("language", get: { $0.language }, set: { $0.language = $1 }),
            Type<CustomUserSession>.optionalProperty("mailAddress", get: { $0.mailAddress }, set: { $0.mailAddress = $1 }),
            Type<CustomUserSession>.optionalProperty("nickname", get: { $0.nickname }, set: { $0.nickname = $1 }),
            Type<CustomUserSession>.optionalProperty("postalCode", get: { $0.postalCode }, set: { $0.postalCode = $1 }),
            Type<CustomUserSession>.optionalProperty("timeZone", get: { $0.timeZone }, set: { $0.timeZone = $1 }),
            Type<CustomUserSession>.optionalProperty("requestTokenSecret", get: { $0.requestTokenSecret }, set: { $0.requestTokenSecret = $1 }),
            Type<CustomUserSession>.optionalProperty("createdAt", get: { $0.createdAt }, set: { $0.createdAt = $1 }),
            Type<CustomUserSession>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
            Type<CustomUserSession>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
            Type<CustomUserSession>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
            Type<CustomUserSession>.optionalProperty("isAuthenticated", get: { $0.isAuthenticated }, set: { $0.isAuthenticated = $1 }),
            Type<CustomUserSession>.optionalProperty("sequence", get: { $0.sequence }, set: { $0.sequence = $1 }),
            Type<CustomUserSession>.optionalProperty("tag", get: { $0.tag }, set: { $0.tag = $1 }),
        ])
}

extension UnAuthInfo : JsonSerializable
{
    public static var typeName:String { return "UnAuthInfo" }
    public static var metadata = Metadata.create([
            Type<UnAuthInfo>.optionalProperty("customInfo", get: { $0.customInfo }, set: { $0.customInfo = $1 }),
        ])
}

extension RequestLogEntry : JsonSerializable
{
    public static var typeName:String { return "RequestLogEntry" }
    public static var metadata = Metadata.create([
            Type<RequestLogEntry>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<RequestLogEntry>.optionalProperty("dateTime", get: { $0.dateTime }, set: { $0.dateTime = $1 }),
            Type<RequestLogEntry>.optionalProperty("httpMethod", get: { $0.httpMethod }, set: { $0.httpMethod = $1 }),
            Type<RequestLogEntry>.optionalProperty("absoluteUri", get: { $0.absoluteUri }, set: { $0.absoluteUri = $1 }),
            Type<RequestLogEntry>.optionalProperty("pathInfo", get: { $0.pathInfo }, set: { $0.pathInfo = $1 }),
            Type<RequestLogEntry>.optionalProperty("requestBody", get: { $0.requestBody }, set: { $0.requestBody = $1 }),
            Type<RequestLogEntry>.optionalProperty("userAuthId", get: { $0.userAuthId }, set: { $0.userAuthId = $1 }),
            Type<RequestLogEntry>.optionalProperty("sessionId", get: { $0.sessionId }, set: { $0.sessionId = $1 }),
            Type<RequestLogEntry>.optionalProperty("ipAddress", get: { $0.ipAddress }, set: { $0.ipAddress = $1 }),
            Type<RequestLogEntry>.optionalProperty("forwardedFor", get: { $0.forwardedFor }, set: { $0.forwardedFor = $1 }),
            Type<RequestLogEntry>.optionalProperty("referer", get: { $0.referer }, set: { $0.referer = $1 }),
            Type<RequestLogEntry>.objectProperty("headers", get: { $0.headers }, set: { $0.headers = $1 }),
            Type<RequestLogEntry>.objectProperty("formData", get: { $0.formData }, set: { $0.formData = $1 }),
            Type<RequestLogEntry>.objectProperty("items", get: { $0.items }, set: { $0.items = $1 }),
            Type<RequestLogEntry>.optionalProperty("requestDuration", get: { $0.requestDuration }, set: { $0.requestDuration = $1 }),
        ])
}

extension OnlyDefinedInGenericType : JsonSerializable
{
    public static var typeName:String { return "OnlyDefinedInGenericType" }
    public static var metadata = Metadata.create([
            Type<OnlyDefinedInGenericType>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<OnlyDefinedInGenericType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension OnlyDefinedInGenericTypeFrom : JsonSerializable
{
    public static var typeName:String { return "OnlyDefinedInGenericTypeFrom" }
    public static var metadata = Metadata.create([
            Type<OnlyDefinedInGenericTypeFrom>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<OnlyDefinedInGenericTypeFrom>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension OnlyDefinedInGenericTypeInto : JsonSerializable
{
    public static var typeName:String { return "OnlyDefinedInGenericTypeInto" }
    public static var metadata = Metadata.create([
            Type<OnlyDefinedInGenericTypeInto>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<OnlyDefinedInGenericTypeInto>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension Rockstar : JsonSerializable
{
    public static var typeName:String { return "Rockstar" }
    public static var metadata = Metadata.create([
            Type<Rockstar>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<Rockstar>.optionalProperty("firstName", get: { $0.firstName }, set: { $0.firstName = $1 }),
            Type<Rockstar>.optionalProperty("lastName", get: { $0.lastName }, set: { $0.lastName = $1 }),
            Type<Rockstar>.optionalProperty("age", get: { $0.age }, set: { $0.age = $1 }),
        ])
}

extension ResponseError : JsonSerializable
{
    public static var typeName:String { return "ResponseError" }
    public static var metadata = Metadata.create([
            Type<ResponseError>.optionalProperty("errorCode", get: { $0.errorCode }, set: { $0.errorCode = $1 }),
            Type<ResponseError>.optionalProperty("fieldName", get: { $0.fieldName }, set: { $0.fieldName = $1 }),
            Type<ResponseError>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
            Type<ResponseError>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension ExternalEnum2 : StringSerializable
{
    public static var typeName:String { return "ExternalEnum2" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .Uno: return "Uno"
        case .Due: return "Due"
        case .Tre: return "Tre"
        }
    }
    public static func fromString(strValue:String) -> ExternalEnum2? {
        switch strValue {
        case "Uno": return .Uno
        case "Due": return .Due
        case "Tre": return .Tre
        default: return nil
        }
    }
    public static func fromObject(any:AnyObject) -> ExternalEnum2? {
        switch any {
        case let i as Int: return ExternalEnum2(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension MetadataTestNestedChild : JsonSerializable
{
    public static var typeName:String { return "MetadataTestNestedChild" }
    public static var metadata = Metadata.create([
            Type<MetadataTestNestedChild>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension MenuItemExample : JsonSerializable
{
    public static var typeName:String { return "MenuItemExample" }
    public static var metadata = Metadata.create([
            Type<MenuItemExample>.optionalProperty("name1", get: { $0.name1 }, set: { $0.name1 = $1 }),
            Type<MenuItemExample>.optionalObjectProperty("menuItemExampleItem", get: { $0.menuItemExampleItem }, set: { $0.menuItemExampleItem = $1 }),
        ])
}

extension SubType : JsonSerializable
{
    public static var typeName:String { return "SubType" }
    public static var metadata = Metadata.create([
            Type<SubType>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<SubType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension TypesGroup : JsonSerializable
{
    public static var typeName:String { return "TypesGroup" }
    public static var metadata = Metadata.create([
        ])
}

extension MenuItemExampleItem : JsonSerializable
{
    public static var typeName:String { return "MenuItemExampleItem" }
    public static var metadata = Metadata.create([
            Type<MenuItemExampleItem>.optionalProperty("name1", get: { $0.name1 }, set: { $0.name1 = $1 }),
        ])
}

extension CustomHttpErrorResponse : JsonSerializable
{
    public static var typeName:String { return "CustomHttpErrorResponse" }
    public static var metadata = Metadata.create([
            Type<CustomHttpErrorResponse>.optionalProperty("custom", get: { $0.custom }, set: { $0.custom = $1 }),
            Type<CustomHttpErrorResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension ThrowTypeResponse : JsonSerializable
{
    public static var typeName:String { return "ThrowTypeResponse" }
    public static var metadata = Metadata.create([
            Type<ThrowTypeResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension ThrowValidationResponse : JsonSerializable
{
    public static var typeName:String { return "ThrowValidationResponse" }
    public static var metadata = Metadata.create([
            Type<ThrowValidationResponse>.optionalProperty("age", get: { $0.age }, set: { $0.age = $1 }),
            Type<ThrowValidationResponse>.optionalProperty("required", get: { $0.required }, set: { $0.required = $1 }),
            Type<ThrowValidationResponse>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
            Type<ThrowValidationResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension ExternalOperationResponse : JsonSerializable
{
    public static var typeName:String { return "ExternalOperationResponse" }
    public static var metadata = Metadata.create([
            Type<ExternalOperationResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension ExternalOperation2Response : JsonSerializable
{
    public static var typeName:String { return "ExternalOperation2Response" }
    public static var metadata = Metadata.create([
            Type<ExternalOperation2Response>.optionalObjectProperty("externalType", get: { $0.externalType }, set: { $0.externalType = $1 }),
        ])
}

extension ExternalReturnTypeResponse : JsonSerializable
{
    public static var typeName:String { return "ExternalReturnTypeResponse" }
    public static var metadata = Metadata.create([
            Type<ExternalReturnTypeResponse>.optionalProperty("externalEnum3", get: { $0.externalEnum3 }, set: { $0.externalEnum3 = $1 }),
        ])
}

extension Account : JsonSerializable
{
    public static var typeName:String { return "Account" }
    public static var metadata = Metadata.create([
            Type<Account>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension Project : JsonSerializable
{
    public static var typeName:String { return "Project" }
    public static var metadata = Metadata.create([
            Type<Project>.optionalProperty("account", get: { $0.account }, set: { $0.account = $1 }),
            Type<Project>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension MetadataTestResponse : JsonSerializable
{
    public static var typeName:String { return "MetadataTestResponse" }
    public static var metadata = Metadata.create([
            Type<MetadataTestResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<MetadataTestResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension GetExampleResponse : JsonSerializable
{
    public static var typeName:String { return "GetExampleResponse" }
    public static var metadata = Metadata.create([
            Type<GetExampleResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            Type<GetExampleResponse>.optionalObjectProperty("menuExample1", get: { $0.menuExample1 }, set: { $0.menuExample1 = $1 }),
        ])
}

extension GetRandomIdsResponse : JsonSerializable
{
    public static var typeName:String { return "GetRandomIdsResponse" }
    public static var metadata = Metadata.create([
            Type<GetRandomIdsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension HelloResponse : JsonSerializable
{
    public static var typeName:String { return "HelloResponse" }
    public static var metadata = Metadata.create([
            Type<HelloResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension HelloAllTypesResponse : JsonSerializable
{
    public static var typeName:String { return "HelloAllTypesResponse" }
    public static var metadata = Metadata.create([
            Type<HelloAllTypesResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<HelloAllTypesResponse>.optionalObjectProperty("allTypes", get: { $0.allTypes }, set: { $0.allTypes = $1 }),
            Type<HelloAllTypesResponse>.optionalObjectProperty("allCollectionTypes", get: { $0.allCollectionTypes }, set: { $0.allCollectionTypes = $1 }),
        ])
}

extension HelloWithDataContractResponse : JsonSerializable
{
    public static var typeName:String { return "HelloWithDataContractResponse" }
    public static var metadata = Metadata.create([
            Type<HelloWithDataContractResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension HelloWithDescriptionResponse : JsonSerializable
{
    public static var typeName:String { return "HelloWithDescriptionResponse" }
    public static var metadata = Metadata.create([
            Type<HelloWithDescriptionResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension HelloWithInheritanceResponse : JsonSerializable
{
    public static var typeName:String { return "HelloWithInheritanceResponse" }
    public static var metadata = Metadata.create([
            Type<HelloWithInheritanceResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<HelloWithInheritanceResponse>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
        ])
}

extension HelloWithAlternateReturnResponse : JsonSerializable
{
    public static var typeName:String { return "HelloWithAlternateReturnResponse" }
    public static var metadata = Metadata.create([
            Type<HelloWithAlternateReturnResponse>.optionalProperty("altResult", get: { $0.altResult }, set: { $0.altResult = $1 }),
            Type<HelloWithAlternateReturnResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension HelloWithRouteResponse : JsonSerializable
{
    public static var typeName:String { return "HelloWithRouteResponse" }
    public static var metadata = Metadata.create([
            Type<HelloWithRouteResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension HelloWithTypeResponse : JsonSerializable
{
    public static var typeName:String { return "HelloWithTypeResponse" }
    public static var metadata = Metadata.create([
            Type<HelloWithTypeResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension HelloInnerTypesResponse : JsonSerializable
{
    public static var typeName:String { return "HelloInnerTypesResponse" }
    public static var metadata = Metadata.create([
            Type<HelloInnerTypesResponse>.optionalObjectProperty("innerType", get: { $0.innerType }, set: { $0.innerType = $1 }),
            Type<HelloInnerTypesResponse>.optionalProperty("innerEnum", get: { $0.innerEnum }, set: { $0.innerEnum = $1 }),
        ])
}

extension HelloVerbResponse : JsonSerializable
{
    public static var typeName:String { return "HelloVerbResponse" }
    public static var metadata = Metadata.create([
            Type<HelloVerbResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension PingResponse : JsonSerializable
{
    public static var typeName:String { return "PingResponse" }
    public static var metadata = Metadata.create([
            Type<PingResponse>.objectProperty("responses", get: { $0.responses }, set: { $0.responses = $1 }),
            Type<PingResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension RequiresRoleResponse : JsonSerializable
{
    public static var typeName:String { return "RequiresRoleResponse" }
    public static var metadata = Metadata.create([
            Type<RequiresRoleResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<RequiresRoleResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension SendVerbResponse : JsonSerializable
{
    public static var typeName:String { return "SendVerbResponse" }
    public static var metadata = Metadata.create([
            Type<SendVerbResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<SendVerbResponse>.optionalProperty("pathInfo", get: { $0.pathInfo }, set: { $0.pathInfo = $1 }),
            Type<SendVerbResponse>.optionalProperty("requestMethod", get: { $0.requestMethod }, set: { $0.requestMethod = $1 }),
        ])
}

extension GetSessionResponse : JsonSerializable
{
    public static var typeName:String { return "GetSessionResponse" }
    public static var metadata = Metadata.create([
            Type<GetSessionResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            Type<GetSessionResponse>.optionalObjectProperty("unAuthInfo", get: { $0.unAuthInfo }, set: { $0.unAuthInfo = $1 }),
            Type<GetSessionResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension Wait : JsonSerializable
{
    public static var typeName:String { return "Wait" }
    public static var metadata = Metadata.create([
            Type<Wait>.optionalProperty("forMs", get: { $0.forMs }, set: { $0.forMs = $1 }),
        ])
}

extension RequestLogsResponse : JsonSerializable
{
    public static var typeName:String { return "RequestLogsResponse" }
    public static var metadata = Metadata.create([
            Type<RequestLogsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<RequestLogsResponse>.objectProperty("usage", get: { $0.usage }, set: { $0.usage = $1 }),
            Type<RequestLogsResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension AuthenticateResponse : JsonSerializable
{
    public static var typeName:String { return "AuthenticateResponse" }
    public static var metadata = Metadata.create([
            Type<AuthenticateResponse>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
            Type<AuthenticateResponse>.optionalProperty("sessionId", get: { $0.sessionId }, set: { $0.sessionId = $1 }),
            Type<AuthenticateResponse>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<AuthenticateResponse>.optionalProperty("displayName", get: { $0.displayName }, set: { $0.displayName = $1 }),
            Type<AuthenticateResponse>.optionalProperty("referrerUrl", get: { $0.referrerUrl }, set: { $0.referrerUrl = $1 }),
            Type<AuthenticateResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            Type<AuthenticateResponse>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension AssignRolesResponse : JsonSerializable
{
    public static var typeName:String { return "AssignRolesResponse" }
    public static var metadata = Metadata.create([
            Type<AssignRolesResponse>.arrayProperty("allRoles", get: { $0.allRoles }, set: { $0.allRoles = $1 }),
            Type<AssignRolesResponse>.arrayProperty("allPermissions", get: { $0.allPermissions }, set: { $0.allPermissions = $1 }),
            Type<AssignRolesResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UnAssignRolesResponse : JsonSerializable
{
    public static var typeName:String { return "UnAssignRolesResponse" }
    public static var metadata = Metadata.create([
            Type<UnAssignRolesResponse>.arrayProperty("allRoles", get: { $0.allRoles }, set: { $0.allRoles = $1 }),
            Type<UnAssignRolesResponse>.arrayProperty("allPermissions", get: { $0.allPermissions }, set: { $0.allPermissions = $1 }),
            Type<UnAssignRolesResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension QueryResponse : JsonSerializable
{
    public static var typeName:String { return "QueryResponse<T>" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<QueryResponse<T>>.optionalProperty("offset", get: { $0.offset }, set: { $0.offset = $1 }),
            Type<QueryResponse<T>>.optionalProperty("total", get: { $0.total }, set: { $0.total = $1 }),
            Type<QueryResponse<T>>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<QueryResponse<T>>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            Type<QueryResponse<T>>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
    }
}

extension CustomHttpError : JsonSerializable
{
    public static var typeName:String { return "CustomHttpError" }
    public static var metadata = Metadata.create([
            Type<CustomHttpError>.optionalProperty("statusCode", get: { $0.statusCode }, set: { $0.statusCode = $1 }),
            Type<CustomHttpError>.optionalProperty("statusDescription", get: { $0.statusDescription }, set: { $0.statusDescription = $1 }),
        ])
}

extension ThrowHttpError : JsonSerializable
{
    public static var typeName:String { return "ThrowHttpError" }
    public static var metadata = Metadata.create([
            Type<ThrowHttpError>.optionalProperty("status", get: { $0.status }, set: { $0.status = $1 }),
            Type<ThrowHttpError>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
        ])
}

extension Throw404 : JsonSerializable
{
    public static var typeName:String { return "Throw404" }
    public static var metadata = Metadata.create([
            Type<Throw404>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
        ])
}

extension ThrowType : JsonSerializable
{
    public static var typeName:String { return "ThrowType" }
    public static var metadata = Metadata.create([
            Type<ThrowType>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
            Type<ThrowType>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
        ])
}

extension ThrowValidation : JsonSerializable
{
    public static var typeName:String { return "ThrowValidation" }
    public static var metadata = Metadata.create([
            Type<ThrowValidation>.optionalProperty("age", get: { $0.age }, set: { $0.age = $1 }),
            Type<ThrowValidation>.optionalProperty("required", get: { $0.required }, set: { $0.required = $1 }),
            Type<ThrowValidation>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
        ])
}

extension ExternalOperation : JsonSerializable
{
    public static var typeName:String { return "ExternalOperation" }
    public static var metadata = Metadata.create([
            Type<ExternalOperation>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            Type<ExternalOperation>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<ExternalOperation>.optionalProperty("externalEnum", get: { $0.externalEnum }, set: { $0.externalEnum = $1 }),
        ])
}

extension ExternalOperation2 : JsonSerializable
{
    public static var typeName:String { return "ExternalOperation2" }
    public static var metadata = Metadata.create([
            Type<ExternalOperation2>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension ExternalOperation3 : JsonSerializable
{
    public static var typeName:String { return "ExternalOperation3" }
    public static var metadata = Metadata.create([
            Type<ExternalOperation3>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension ExternalOperation4 : JsonSerializable
{
    public static var typeName:String { return "ExternalOperation4" }
    public static var metadata = Metadata.create([
            Type<ExternalOperation4>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension RootPathRoutes : JsonSerializable
{
    public static var typeName:String { return "RootPathRoutes" }
    public static var metadata = Metadata.create([
            Type<RootPathRoutes>.optionalProperty("path", get: { $0.path }, set: { $0.path = $1 }),
        ])
}

extension GetAccount : JsonSerializable
{
    public static var typeName:String { return "GetAccount" }
    public static var metadata = Metadata.create([
            Type<GetAccount>.optionalProperty("account", get: { $0.account }, set: { $0.account = $1 }),
        ])
}

extension GetProject : JsonSerializable
{
    public static var typeName:String { return "GetProject" }
    public static var metadata = Metadata.create([
            Type<GetProject>.optionalProperty("account", get: { $0.account }, set: { $0.account = $1 }),
            Type<GetProject>.optionalProperty("project", get: { $0.project }, set: { $0.project = $1 }),
        ])
}

extension ImageAsStream : JsonSerializable
{
    public static var typeName:String { return "ImageAsStream" }
    public static var metadata = Metadata.create([
            Type<ImageAsStream>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
        ])
}

extension ImageAsBytes : JsonSerializable
{
    public static var typeName:String { return "ImageAsBytes" }
    public static var metadata = Metadata.create([
            Type<ImageAsBytes>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
        ])
}

extension ImageAsCustomResult : JsonSerializable
{
    public static var typeName:String { return "ImageAsCustomResult" }
    public static var metadata = Metadata.create([
            Type<ImageAsCustomResult>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
        ])
}

extension ImageWriteToResponse : JsonSerializable
{
    public static var typeName:String { return "ImageWriteToResponse" }
    public static var metadata = Metadata.create([
            Type<ImageWriteToResponse>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
        ])
}

extension ImageAsFile : JsonSerializable
{
    public static var typeName:String { return "ImageAsFile" }
    public static var metadata = Metadata.create([
            Type<ImageAsFile>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
        ])
}

extension ImageAsRedirect : JsonSerializable
{
    public static var typeName:String { return "ImageAsRedirect" }
    public static var metadata = Metadata.create([
            Type<ImageAsRedirect>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
        ])
}

extension DrawImage : JsonSerializable
{
    public static var typeName:String { return "DrawImage" }
    public static var metadata = Metadata.create([
            Type<DrawImage>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<DrawImage>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
            Type<DrawImage>.optionalProperty("width", get: { $0.width }, set: { $0.width = $1 }),
            Type<DrawImage>.optionalProperty("height", get: { $0.height }, set: { $0.height = $1 }),
            Type<DrawImage>.optionalProperty("fontSize", get: { $0.fontSize }, set: { $0.fontSize = $1 }),
            Type<DrawImage>.optionalProperty("foreground", get: { $0.foreground }, set: { $0.foreground = $1 }),
            Type<DrawImage>.optionalProperty("background", get: { $0.background }, set: { $0.background = $1 }),
        ])
}

extension MetadataTest : JsonSerializable
{
    public static var typeName:String { return "MetadataTest" }
    public static var metadata = Metadata.create([
            Type<MetadataTest>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension MetadataTestArray : JsonSerializable
{
    public static var typeName:String { return "MetadataTestArray" }
    public static var metadata = Metadata.create([
            Type<MetadataTestArray>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension GetExample : JsonSerializable
{
    public static var typeName:String { return "GetExample" }
    public static var metadata = Metadata.create([
        ])
}

extension GetRandomIds : JsonSerializable
{
    public static var typeName:String { return "GetRandomIds" }
    public static var metadata = Metadata.create([
            Type<GetRandomIds>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
        ])
}

extension TextFileTest : JsonSerializable
{
    public static var typeName:String { return "TextFileTest" }
    public static var metadata = Metadata.create([
            Type<TextFileTest>.optionalProperty("asAttachment", get: { $0.asAttachment }, set: { $0.asAttachment = $1 }),
        ])
}

extension Hello : JsonSerializable
{
    public static var typeName:String { return "Hello" }
    public static var metadata = Metadata.create([
            Type<Hello>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<Hello>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
        ])
}

extension HelloWithNestedClass : JsonSerializable
{
    public static var typeName:String { return "HelloWithNestedClass" }
    public static var metadata = Metadata.create([
            Type<HelloWithNestedClass>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<HelloWithNestedClass>.optionalObjectProperty("nestedClassProp", get: { $0.nestedClassProp }, set: { $0.nestedClassProp = $1 }),
        ])
}

extension HelloList : JsonSerializable
{
    public static var typeName:String { return "HelloList" }
    public static var metadata = Metadata.create([
            Type<HelloList>.arrayProperty("names", get: { $0.names }, set: { $0.names = $1 }),
        ])
}

extension HelloArray : JsonSerializable
{
    public static var typeName:String { return "HelloArray" }
    public static var metadata = Metadata.create([
            Type<HelloArray>.arrayProperty("names", get: { $0.names }, set: { $0.names = $1 }),
        ])
}

extension HelloWithEnum : JsonSerializable
{
    public static var typeName:String { return "HelloWithEnum" }
    public static var metadata = Metadata.create([
            Type<HelloWithEnum>.optionalProperty("enumProp", get: { $0.enumProp }, set: { $0.enumProp = $1 }),
            Type<HelloWithEnum>.optionalProperty("nullableEnumProp", get: { $0.nullableEnumProp }, set: { $0.nullableEnumProp = $1 }),
            Type<HelloWithEnum>.optionalProperty("enumFlags", get: { $0.enumFlags }, set: { $0.enumFlags = $1 }),
        ])
}

extension HelloExternal : JsonSerializable
{
    public static var typeName:String { return "HelloExternal" }
    public static var metadata = Metadata.create([
            Type<HelloExternal>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension AllowedAttributes : JsonSerializable
{
    public static var typeName:String { return "AllowedAttributes" }
    public static var metadata = Metadata.create([
            Type<AllowedAttributes>.optionalProperty("range", get: { $0.range }, set: { $0.range = $1 }),
        ])
}

extension HelloAllTypes : JsonSerializable
{
    public static var typeName:String { return "HelloAllTypes" }
    public static var metadata = Metadata.create([
            Type<HelloAllTypes>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<HelloAllTypes>.optionalObjectProperty("allTypes", get: { $0.allTypes }, set: { $0.allTypes = $1 }),
            Type<HelloAllTypes>.optionalObjectProperty("allCollectionTypes", get: { $0.allCollectionTypes }, set: { $0.allCollectionTypes = $1 }),
        ])
}

extension HelloString : JsonSerializable
{
    public static var typeName:String { return "HelloString" }
    public static var metadata = Metadata.create([
            Type<HelloString>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension HelloVoid : JsonSerializable
{
    public static var typeName:String { return "HelloVoid" }
    public static var metadata = Metadata.create([
            Type<HelloVoid>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension HelloWithDataContract : JsonSerializable
{
    public static var typeName:String { return "HelloWithDataContract" }
    public static var metadata = Metadata.create([
            Type<HelloWithDataContract>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<HelloWithDataContract>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension HelloWithDescription : JsonSerializable
{
    public static var typeName:String { return "HelloWithDescription" }
    public static var metadata = Metadata.create([
            Type<HelloWithDescription>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension HelloWithInheritance : JsonSerializable
{
    public static var typeName:String { return "HelloWithInheritance" }
    public static var metadata = Metadata.create([
            Type<HelloWithInheritance>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            Type<HelloWithInheritance>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension HelloWithReturn : JsonSerializable
{
    public static var typeName:String { return "HelloWithReturn" }
    public static var metadata = Metadata.create([
            Type<HelloWithReturn>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension HelloWithRoute : JsonSerializable
{
    public static var typeName:String { return "HelloWithRoute" }
    public static var metadata = Metadata.create([
            Type<HelloWithRoute>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension HelloWithType : JsonSerializable
{
    public static var typeName:String { return "HelloWithType" }
    public static var metadata = Metadata.create([
            Type<HelloWithType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        ])
}

extension HelloInterface : JsonSerializable
{
    public static var typeName:String { return "HelloInterface" }
    public static var metadata = Metadata.create([
            Type<HelloInterface>.optionalObjectProperty("emptyClass", get: { $0.emptyClass }, set: { $0.emptyClass = $1 }),
        ])
}

extension HelloInnerTypes : JsonSerializable
{
    public static var typeName:String { return "HelloInnerTypes" }
    public static var metadata = Metadata.create([
        ])
}

extension HelloBuiltin : JsonSerializable
{
    public static var typeName:String { return "HelloBuiltin" }
    public static var metadata = Metadata.create([
            Type<HelloBuiltin>.optionalProperty("dayOfWeek", get: { $0.dayOfWeek }, set: { $0.dayOfWeek = $1 }),
        ])
}

extension HelloGet : JsonSerializable
{
    public static var typeName:String { return "HelloGet" }
    public static var metadata = Metadata.create([
            Type<HelloGet>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension HelloPost : JsonSerializable
{
    public static var typeName:String { return "HelloPost" }
    public static var metadata = Metadata.create([
            Type<HelloPost>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension HelloPut : JsonSerializable
{
    public static var typeName:String { return "HelloPut" }
    public static var metadata = Metadata.create([
            Type<HelloPut>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension HelloDelete : JsonSerializable
{
    public static var typeName:String { return "HelloDelete" }
    public static var metadata = Metadata.create([
            Type<HelloDelete>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension HelloPatch : JsonSerializable
{
    public static var typeName:String { return "HelloPatch" }
    public static var metadata = Metadata.create([
            Type<HelloPatch>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension HelloReturnVoid : JsonSerializable
{
    public static var typeName:String { return "HelloReturnVoid" }
    public static var metadata = Metadata.create([
            Type<HelloReturnVoid>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension Ping : JsonSerializable
{
    public static var typeName:String { return "Ping" }
    public static var metadata = Metadata.create([
        ])
}

extension ResetConnections : JsonSerializable
{
    public static var typeName:String { return "ResetConnections" }
    public static var metadata = Metadata.create([
        ])
}

extension RequiresRole : JsonSerializable
{
    public static var typeName:String { return "RequiresRole" }
    public static var metadata = Metadata.create([
        ])
}

extension SendDefault : JsonSerializable
{
    public static var typeName:String { return "SendDefault" }
    public static var metadata = Metadata.create([
            Type<SendDefault>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension SendRestGet : JsonSerializable
{
    public static var typeName:String { return "SendRestGet" }
    public static var metadata = Metadata.create([
            Type<SendRestGet>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension SendGet : JsonSerializable
{
    public static var typeName:String { return "SendGet" }
    public static var metadata = Metadata.create([
            Type<SendGet>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension SendPost : JsonSerializable
{
    public static var typeName:String { return "SendPost" }
    public static var metadata = Metadata.create([
            Type<SendPost>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension SendPut : JsonSerializable
{
    public static var typeName:String { return "SendPut" }
    public static var metadata = Metadata.create([
            Type<SendPut>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension GetSession : JsonSerializable
{
    public static var typeName:String { return "GetSession" }
    public static var metadata = Metadata.create([
        ])
}

extension UpdateSession : JsonSerializable
{
    public static var typeName:String { return "UpdateSession" }
    public static var metadata = Metadata.create([
            Type<UpdateSession>.optionalProperty("customName", get: { $0.customName }, set: { $0.customName = $1 }),
        ])
}

extension TestVoidResponse : JsonSerializable
{
    public static var typeName:String { return "TestVoidResponse" }
    public static var metadata = Metadata.create([
        ])
}

extension TestNullResponse : JsonSerializable
{
    public static var typeName:String { return "TestNullResponse" }
    public static var metadata = Metadata.create([
        ])
}

extension RequestLogs : JsonSerializable
{
    public static var typeName:String { return "RequestLogs" }
    public static var metadata = Metadata.create([
            Type<RequestLogs>.optionalProperty("beforeSecs", get: { $0.beforeSecs }, set: { $0.beforeSecs = $1 }),
            Type<RequestLogs>.optionalProperty("afterSecs", get: { $0.afterSecs }, set: { $0.afterSecs = $1 }),
            Type<RequestLogs>.optionalProperty("ipAddress", get: { $0.ipAddress }, set: { $0.ipAddress = $1 }),
            Type<RequestLogs>.optionalProperty("forwardedFor", get: { $0.forwardedFor }, set: { $0.forwardedFor = $1 }),
            Type<RequestLogs>.optionalProperty("userAuthId", get: { $0.userAuthId }, set: { $0.userAuthId = $1 }),
            Type<RequestLogs>.optionalProperty("sessionId", get: { $0.sessionId }, set: { $0.sessionId = $1 }),
            Type<RequestLogs>.optionalProperty("referer", get: { $0.referer }, set: { $0.referer = $1 }),
            Type<RequestLogs>.optionalProperty("pathInfo", get: { $0.pathInfo }, set: { $0.pathInfo = $1 }),
            Type<RequestLogs>.arrayProperty("ids", get: { $0.ids }, set: { $0.ids = $1 }),
            Type<RequestLogs>.optionalProperty("beforeId", get: { $0.beforeId }, set: { $0.beforeId = $1 }),
            Type<RequestLogs>.optionalProperty("afterId", get: { $0.afterId }, set: { $0.afterId = $1 }),
            Type<RequestLogs>.optionalProperty("hasResponse", get: { $0.hasResponse }, set: { $0.hasResponse = $1 }),
            Type<RequestLogs>.optionalProperty("withErrors", get: { $0.withErrors }, set: { $0.withErrors = $1 }),
            Type<RequestLogs>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
            Type<RequestLogs>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
            Type<RequestLogs>.optionalProperty("enableSessionTracking", get: { $0.enableSessionTracking }, set: { $0.enableSessionTracking = $1 }),
            Type<RequestLogs>.optionalProperty("enableResponseTracking", get: { $0.enableResponseTracking }, set: { $0.enableResponseTracking = $1 }),
            Type<RequestLogs>.optionalProperty("enableErrorTracking", get: { $0.enableErrorTracking }, set: { $0.enableErrorTracking = $1 }),
            Type<RequestLogs>.optionalProperty("durationLongerThan", get: { $0.durationLongerThan }, set: { $0.durationLongerThan = $1 }),
            Type<RequestLogs>.optionalProperty("durationLessThan", get: { $0.durationLessThan }, set: { $0.durationLessThan = $1 }),
        ])
}

extension Authenticate : JsonSerializable
{
    public static var typeName:String { return "Authenticate" }
    public static var metadata = Metadata.create([
            Type<Authenticate>.optionalProperty("provider", get: { $0.provider }, set: { $0.provider = $1 }),
            Type<Authenticate>.optionalProperty("state", get: { $0.state }, set: { $0.state = $1 }),
            Type<Authenticate>.optionalProperty("oauth_token", get: { $0.oauth_token }, set: { $0.oauth_token = $1 }),
            Type<Authenticate>.optionalProperty("oauth_verifier", get: { $0.oauth_verifier }, set: { $0.oauth_verifier = $1 }),
            Type<Authenticate>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<Authenticate>.optionalProperty("password", get: { $0.password }, set: { $0.password = $1 }),
            Type<Authenticate>.optionalProperty("rememberMe", get: { $0.rememberMe }, set: { $0.rememberMe = $1 }),
            Type<Authenticate>.optionalProperty("`continue`", get: { $0.`continue` }, set: { $0.`continue` = $1 }),
            Type<Authenticate>.optionalProperty("nonce", get: { $0.nonce }, set: { $0.nonce = $1 }),
            Type<Authenticate>.optionalProperty("uri", get: { $0.uri }, set: { $0.uri = $1 }),
            Type<Authenticate>.optionalProperty("response", get: { $0.response }, set: { $0.response = $1 }),
            Type<Authenticate>.optionalProperty("qop", get: { $0.qop }, set: { $0.qop = $1 }),
            Type<Authenticate>.optionalProperty("nc", get: { $0.nc }, set: { $0.nc = $1 }),
            Type<Authenticate>.optionalProperty("cnonce", get: { $0.cnonce }, set: { $0.cnonce = $1 }),
            Type<Authenticate>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension AssignRoles : JsonSerializable
{
    public static var typeName:String { return "AssignRoles" }
    public static var metadata = Metadata.create([
            Type<AssignRoles>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<AssignRoles>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
            Type<AssignRoles>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
        ])
}

extension UnAssignRoles : JsonSerializable
{
    public static var typeName:String { return "UnAssignRoles" }
    public static var metadata = Metadata.create([
            Type<UnAssignRoles>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
            Type<UnAssignRoles>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
            Type<UnAssignRoles>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
        ])
}

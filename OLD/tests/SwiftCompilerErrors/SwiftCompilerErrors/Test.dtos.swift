/* Options:
Date: 2015-02-23 12:46:03
Version: 1
BaseUrl: http://test.servicestack.net

//BaseClass: 
//AddModelExtensions: True
//AddServiceStackTypes: True
//IncludeTypes: 
//ExcludeTypes: 
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

// @DataContract
public class RestService
{
    required public init(){}
    // @DataMember(Name="path")
    public var path:String?

    // @DataMember(Name="description")
    public var Description:String?
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

public class GetSessionResponse
{
    required public init(){}
    public var result:CustomUserSession?
    public var unAuthInfo:UnAuthInfo?
    public var responseStatus:ResponseStatus?
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

// @DataContract
public class ResourcesResponse
{
    required public init(){}
    // @DataMember(Name="swaggerVersion")
    public var swaggerVersion:String?

    // @DataMember(Name="apiVersion")
    public var apiVersion:String?

    // @DataMember(Name="basePath")
    public var basePath:String?

    // @DataMember(Name="apis")
    public var apis:[RestService] = []
}

public class CustomHttpError : IReturn
{
    typealias Return = CustomHttpErrorResponse

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
    typealias Return = ThrowTypeResponse

    required public init(){}
    public var type:String?
    public var message:String?
}

// @Route("/throwvalidation")
public class ThrowValidation : IReturn
{
    typealias Return = ThrowValidationResponse

    required public init(){}
    public var age:Int?
    public var required:String?
    public var email:String?
}

public class ExternalOperation : IReturn
{
    typealias Return = ExternalOperationResponse

    required public init(){}
    public var id:Int?
    public var name:String?
    public var externalEnum:ExternalEnum?
}

public class ExternalOperation2 : IReturn
{
    typealias Return = ExternalOperation2Response

    required public init(){}
    public var id:Int?
}

public class ExternalOperation3 : IReturn
{
    typealias Return = ExternalReturnTypeResponse

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
    typealias Return = Account

    required public init(){}
    public var account:String?
}

public class GetProject : IReturn
{
    typealias Return = Project

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
    typealias Return = MetadataTestResponse

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
    typealias Return = GetExampleResponse

    required public init(){}
}

// @Route("/randomids")
public class GetRandomIds : IReturn
{
    typealias Return = GetRandomIdsResponse

    required public init(){}
    public var take:Int?
}

// @Route("/textfile-test")
public class TextFileTest
{
    required public init(){}
    public var asAttachment:Bool?
}

// @Route("/hello/{Name}")
// @Route("/hello")
public class Hello : IReturn
{
    typealias Return = HelloResponse

    required public init(){}
    // @Required()
    public var name:String?

    public var title:String?
}

public class HelloWithNestedClass : IReturn
{
    typealias Return = HelloResponse

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

public class HelloAllTypes : IReturn
{
    typealias Return = HelloAllTypesResponse

    required public init(){}
    public var name:String?
    public var allTypes:AllTypes?
    public var allCollectionTypes:AllCollectionTypes?
}

public class HelloString
{
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
    typealias Return = HelloWithDataContractResponse

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
    typealias Return = HelloWithDescriptionResponse

    required public init(){}
    public var name:String?
}

public class HelloWithInheritance : HelloBase, IReturn
{
    typealias Return = HelloWithInheritanceResponse

    required public init(){}
    public var name:String?
}

public class HelloWithGenericInheritance<Poco : JsonSerializable> : HelloBase_1<Poco>
{
    required public init(){}
    public var result:String?
}

public class HelloWithGenericInheritance2<Hello : JsonSerializable> : HelloBase_1<Hello>
{
    required public init(){}
    public var result:String?
}

public class HelloWithNestedInheritance<Item : JsonSerializable> : HelloBase_1<Item>
{
    required public init(){}
}

public class HelloWithListInheritance<InheritedItem : JsonSerializable> : List<InheritedItem>
{
    required public init(){}
}

public class HelloWithReturn : IReturn
{
    typealias Return = HelloWithAlternateReturnResponse

    required public init(){}
    public var name:String?
}

// @Route("/helloroute")
public class HelloWithRoute : IReturn
{
    typealias Return = HelloWithRouteResponse

    required public init(){}
    public var name:String?
}

public class HelloWithType : IReturn
{
    typealias Return = HelloWithTypeResponse

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
    typealias Return = HelloInnerTypesResponse

    required public init(){}
}

// @Route("/ping")
public class Ping : IReturn
{
    typealias Return = PingResponse

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
    typealias Return = RequiresRoleResponse

    required public init(){}
}

// @Route("/session")
public class GetSession : IReturn
{
    typealias Return = GetSessionResponse

    required public init(){}
}

// @Route("/session/edit/{CustomName}")
public class UpdateSession : IReturn
{
    typealias Return = GetSessionResponse

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

// @Route("/postman")
public class Postman
{
    required public init(){}
    public var label:[String] = []
    public var exportSession:Bool?
    public var ssid:String?
    public var sspid:String?
    public var ssopt:String?
}

// @Route("/requestlogs")
// @DataContract
public class RequestLogs : IReturn
{
    typealias Return = RequestLogsResponse

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

// @Route("/resources")
// @DataContract
public class Resources : IReturn
{
    typealias Return = ResourcesResponse

    required public init(){}
    // @DataMember(Name="apiKey")
    public var apiKey:String?
}

// @Route("/resource/{Name*}")
// @DataContract
public class ResourceRequest
{
    required public init(){}
    // @DataMember(Name="apiKey")
    public var apiKey:String?

    // @DataMember(Name="name")
    public var name:String?
}


extension ResponseStatus : JsonSerializable
{
    public class var typeName:String { return "ResponseStatus" }
    public class func reflect() -> Type<ResponseStatus> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ResponseStatus>(
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
    public class var typeName:String { return "ExternalType" }
    public class func reflect() -> Type<ExternalType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ExternalType>(
            properties: [
                Type<ExternalType>.optionalProperty("externalEnum2", get: { $0.externalEnum2 }, set: { $0.externalEnum2 = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ExternalType.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ExternalType? {
        return ExternalType.reflect().fromJson(ExternalType(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ExternalType? {
        return ExternalType.reflect().fromObject(ExternalType(), any:any)
    }
    public func toString() -> String {
        return ExternalType.reflect().toString(self)
    }
    public class func fromString(string:String) -> ExternalType? {
        return ExternalType.reflect().fromString(ExternalType(), string: string)
    }
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
    public class var typeName:String { return "MetadataTestChild" }
    public class func reflect() -> Type<MetadataTestChild> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataTestChild>(
            properties: [
                Type<MetadataTestChild>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<MetadataTestChild>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataTestChild.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataTestChild? {
        return MetadataTestChild.reflect().fromJson(MetadataTestChild(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataTestChild? {
        return MetadataTestChild.reflect().fromObject(MetadataTestChild(), any:any)
    }
    public func toString() -> String {
        return MetadataTestChild.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataTestChild? {
        return MetadataTestChild.reflect().fromString(MetadataTestChild(), string: string)
    }
}

extension MenuExample : JsonSerializable
{
    public class var typeName:String { return "MenuExample" }
    public class func reflect() -> Type<MenuExample> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MenuExample>(
            properties: [
                Type<MenuExample>.optionalObjectProperty("menuItemExample1", get: { $0.menuItemExample1 }, set: { $0.menuItemExample1 = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MenuExample.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MenuExample? {
        return MenuExample.reflect().fromJson(MenuExample(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MenuExample? {
        return MenuExample.reflect().fromObject(MenuExample(), any:any)
    }
    public func toString() -> String {
        return MenuExample.reflect().toString(self)
    }
    public class func fromString(string:String) -> MenuExample? {
        return MenuExample.reflect().fromString(MenuExample(), string: string)
    }
}

extension NestedClass : JsonSerializable
{
    public class var typeName:String { return "NestedClass" }
    public class func reflect() -> Type<NestedClass> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<NestedClass>(
            properties: [
                Type<NestedClass>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
            ]))
    }
    public func toJson() -> String {
        return NestedClass.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> NestedClass? {
        return NestedClass.reflect().fromJson(NestedClass(), json: json)
    }
    public class func fromObject(any:AnyObject) -> NestedClass? {
        return NestedClass.reflect().fromObject(NestedClass(), any:any)
    }
    public func toString() -> String {
        return NestedClass.reflect().toString(self)
    }
    public class func fromString(string:String) -> NestedClass? {
        return NestedClass.reflect().fromString(NestedClass(), string: string)
    }
}

extension ListResult : JsonSerializable
{
    public class var typeName:String { return "ListResult" }
    public class func reflect() -> Type<ListResult> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ListResult>(
            properties: [
                Type<ListResult>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ListResult.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ListResult? {
        return ListResult.reflect().fromJson(ListResult(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ListResult? {
        return ListResult.reflect().fromObject(ListResult(), any:any)
    }
    public func toString() -> String {
        return ListResult.reflect().toString(self)
    }
    public class func fromString(string:String) -> ListResult? {
        return ListResult.reflect().fromString(ListResult(), string: string)
    }
}

extension ArrayResult : JsonSerializable
{
    public class var typeName:String { return "ArrayResult" }
    public class func reflect() -> Type<ArrayResult> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ArrayResult>(
            properties: [
                Type<ArrayResult>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ArrayResult.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ArrayResult? {
        return ArrayResult.reflect().fromJson(ArrayResult(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ArrayResult? {
        return ArrayResult.reflect().fromObject(ArrayResult(), any:any)
    }
    public func toString() -> String {
        return ArrayResult.reflect().toString(self)
    }
    public class func fromString(string:String) -> ArrayResult? {
        return ArrayResult.reflect().fromString(ArrayResult(), string: string)
    }
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
    public class var typeName:String { return "AllTypes" }
    public class func reflect() -> Type<AllTypes> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AllTypes>(
            properties: [
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
            ]))
    }
    public func toJson() -> String {
        return AllTypes.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AllTypes? {
        return AllTypes.reflect().fromJson(AllTypes(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AllTypes? {
        return AllTypes.reflect().fromObject(AllTypes(), any:any)
    }
    public func toString() -> String {
        return AllTypes.reflect().toString(self)
    }
    public class func fromString(string:String) -> AllTypes? {
        return AllTypes.reflect().fromString(AllTypes(), string: string)
    }
}

extension AllCollectionTypes : JsonSerializable
{
    public class var typeName:String { return "AllCollectionTypes" }
    public class func reflect() -> Type<AllCollectionTypes> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AllCollectionTypes>(
            properties: [
                Type<AllCollectionTypes>.arrayProperty("intArray", get: { $0.intArray }, set: { $0.intArray = $1 }),
                Type<AllCollectionTypes>.arrayProperty("intList", get: { $0.intList }, set: { $0.intList = $1 }),
                Type<AllCollectionTypes>.arrayProperty("stringArray", get: { $0.stringArray }, set: { $0.stringArray = $1 }),
                Type<AllCollectionTypes>.arrayProperty("stringList", get: { $0.stringList }, set: { $0.stringList = $1 }),
                Type<AllCollectionTypes>.arrayProperty("pocoArray", get: { $0.pocoArray }, set: { $0.pocoArray = $1 }),
                Type<AllCollectionTypes>.arrayProperty("pocoList", get: { $0.pocoList }, set: { $0.pocoList = $1 }),
                Type<AllCollectionTypes>.objectProperty("pocoLookup", get: { $0.pocoLookup }, set: { $0.pocoLookup = $1 }),
                Type<AllCollectionTypes>.objectProperty("pocoLookupMap", get: { $0.pocoLookupMap }, set: { $0.pocoLookupMap = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AllCollectionTypes.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AllCollectionTypes? {
        return AllCollectionTypes.reflect().fromJson(AllCollectionTypes(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AllCollectionTypes? {
        return AllCollectionTypes.reflect().fromObject(AllCollectionTypes(), any:any)
    }
    public func toString() -> String {
        return AllCollectionTypes.reflect().toString(self)
    }
    public class func fromString(string:String) -> AllCollectionTypes? {
        return AllCollectionTypes.reflect().fromString(AllCollectionTypes(), string: string)
    }
}

extension Poco : JsonSerializable
{
    public class var typeName:String { return "Poco" }
    public class func reflect() -> Type<Poco> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Poco>(
            properties: [
                Type<Poco>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Poco.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Poco? {
        return Poco.reflect().fromJson(Poco(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Poco? {
        return Poco.reflect().fromObject(Poco(), any:any)
    }
    public func toString() -> String {
        return Poco.reflect().toString(self)
    }
    public class func fromString(string:String) -> Poco? {
        return Poco.reflect().fromString(Poco(), string: string)
    }
}

extension Item : JsonSerializable
{
    public class var typeName:String { return "Item" }
    public class func reflect() -> Type<Item> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Item>(
            properties: [
                Type<Item>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Item.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Item? {
        return Item.reflect().fromJson(Item(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Item? {
        return Item.reflect().fromObject(Item(), any:any)
    }
    public func toString() -> String {
        return Item.reflect().toString(self)
    }
    public class func fromString(string:String) -> Item? {
        return Item.reflect().fromString(Item(), string: string)
    }
}

extension InheritedItem : JsonSerializable
{
    public class var typeName:String { return "InheritedItem" }
    public class func reflect() -> Type<InheritedItem> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<InheritedItem>(
            properties: [
                Type<InheritedItem>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return InheritedItem.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> InheritedItem? {
        return InheritedItem.reflect().fromJson(InheritedItem(), json: json)
    }
    public class func fromObject(any:AnyObject) -> InheritedItem? {
        return InheritedItem.reflect().fromObject(InheritedItem(), any:any)
    }
    public func toString() -> String {
        return InheritedItem.reflect().toString(self)
    }
    public class func fromString(string:String) -> InheritedItem? {
        return InheritedItem.reflect().fromString(InheritedItem(), string: string)
    }
}

extension HelloType : JsonSerializable
{
    public class var typeName:String { return "HelloType" }
    public class func reflect() -> Type<HelloType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloType>(
            properties: [
                Type<HelloType>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloType.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloType? {
        return HelloType.reflect().fromJson(HelloType(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloType? {
        return HelloType.reflect().fromObject(HelloType(), any:any)
    }
    public func toString() -> String {
        return HelloType.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloType? {
        return HelloType.reflect().fromString(HelloType(), string: string)
    }
}

extension EmptyClass : JsonSerializable
{
    public class var typeName:String { return "EmptyClass" }
    public class func reflect() -> Type<EmptyClass> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<EmptyClass>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return EmptyClass.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> EmptyClass? {
        return EmptyClass.reflect().fromJson(EmptyClass(), json: json)
    }
    public class func fromObject(any:AnyObject) -> EmptyClass? {
        return EmptyClass.reflect().fromObject(EmptyClass(), any:any)
    }
    public func toString() -> String {
        return EmptyClass.reflect().toString(self)
    }
    public class func fromString(string:String) -> EmptyClass? {
        return EmptyClass.reflect().fromString(EmptyClass(), string: string)
    }
}

extension InnerType : JsonSerializable
{
    public class var typeName:String { return "InnerType" }
    public class func reflect() -> Type<InnerType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<InnerType>(
            properties: [
                Type<InnerType>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<InnerType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return InnerType.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> InnerType? {
        return InnerType.reflect().fromJson(InnerType(), json: json)
    }
    public class func fromObject(any:AnyObject) -> InnerType? {
        return InnerType.reflect().fromObject(InnerType(), any:any)
    }
    public func toString() -> String {
        return InnerType.reflect().toString(self)
    }
    public class func fromString(string:String) -> InnerType? {
        return InnerType.reflect().fromString(InnerType(), string: string)
    }
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

extension PingService : JsonSerializable
{
    public class var typeName:String { return "PingService" }
    public class func reflect() -> Type<PingService> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<PingService>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return PingService.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> PingService? {
        return PingService.reflect().fromJson(PingService(), json: json)
    }
    public class func fromObject(any:AnyObject) -> PingService? {
        return PingService.reflect().fromObject(PingService(), any:any)
    }
    public func toString() -> String {
        return PingService.reflect().toString(self)
    }
    public class func fromString(string:String) -> PingService? {
        return PingService.reflect().fromString(PingService(), string: string)
    }
}

extension CustomUserSession : JsonSerializable
{
    public class var typeName:String { return "CustomUserSession" }
    public class func reflect() -> Type<CustomUserSession> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<CustomUserSession>(
            properties: [
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
            ]))
    }
    public func toJson() -> String {
        return CustomUserSession.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> CustomUserSession? {
        return CustomUserSession.reflect().fromJson(CustomUserSession(), json: json)
    }
    public class func fromObject(any:AnyObject) -> CustomUserSession? {
        return CustomUserSession.reflect().fromObject(CustomUserSession(), any:any)
    }
    public func toString() -> String {
        return CustomUserSession.reflect().toString(self)
    }
    public class func fromString(string:String) -> CustomUserSession? {
        return CustomUserSession.reflect().fromString(CustomUserSession(), string: string)
    }
}

extension UnAuthInfo : JsonSerializable
{
    public class var typeName:String { return "UnAuthInfo" }
    public class func reflect() -> Type<UnAuthInfo> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UnAuthInfo>(
            properties: [
                Type<UnAuthInfo>.optionalProperty("customInfo", get: { $0.customInfo }, set: { $0.customInfo = $1 }),
            ]))
    }
    public func toJson() -> String {
        return UnAuthInfo.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> UnAuthInfo? {
        return UnAuthInfo.reflect().fromJson(UnAuthInfo(), json: json)
    }
    public class func fromObject(any:AnyObject) -> UnAuthInfo? {
        return UnAuthInfo.reflect().fromObject(UnAuthInfo(), any:any)
    }
    public func toString() -> String {
        return UnAuthInfo.reflect().toString(self)
    }
    public class func fromString(string:String) -> UnAuthInfo? {
        return UnAuthInfo.reflect().fromString(UnAuthInfo(), string: string)
    }
}

extension RequestLogEntry : JsonSerializable
{
    public class var typeName:String { return "RequestLogEntry" }
    public class func reflect() -> Type<RequestLogEntry> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RequestLogEntry>(
            properties: [
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
            ]))
    }
    public func toJson() -> String {
        return RequestLogEntry.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RequestLogEntry? {
        return RequestLogEntry.reflect().fromJson(RequestLogEntry(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RequestLogEntry? {
        return RequestLogEntry.reflect().fromObject(RequestLogEntry(), any:any)
    }
    public func toString() -> String {
        return RequestLogEntry.reflect().toString(self)
    }
    public class func fromString(string:String) -> RequestLogEntry? {
        return RequestLogEntry.reflect().fromString(RequestLogEntry(), string: string)
    }
}

extension RestService : JsonSerializable
{
    public class var typeName:String { return "RestService" }
    public class func reflect() -> Type<RestService> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RestService>(
            properties: [
                Type<RestService>.optionalProperty("path", get: { $0.path }, set: { $0.path = $1 }),
                Type<RestService>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
            ]))
    }
    public func toJson() -> String {
        return RestService.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RestService? {
        return RestService.reflect().fromJson(RestService(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RestService? {
        return RestService.reflect().fromObject(RestService(), any:any)
    }
    public func toString() -> String {
        return RestService.reflect().toString(self)
    }
    public class func fromString(string:String) -> RestService? {
        return RestService.reflect().fromString(RestService(), string: string)
    }
}

extension ResponseError : JsonSerializable
{
    public class var typeName:String { return "ResponseError" }
    public class func reflect() -> Type<ResponseError> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ResponseError>(
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
    public class var typeName:String { return "MetadataTestNestedChild" }
    public class func reflect() -> Type<MetadataTestNestedChild> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataTestNestedChild>(
            properties: [
                Type<MetadataTestNestedChild>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataTestNestedChild.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataTestNestedChild? {
        return MetadataTestNestedChild.reflect().fromJson(MetadataTestNestedChild(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataTestNestedChild? {
        return MetadataTestNestedChild.reflect().fromObject(MetadataTestNestedChild(), any:any)
    }
    public func toString() -> String {
        return MetadataTestNestedChild.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataTestNestedChild? {
        return MetadataTestNestedChild.reflect().fromString(MetadataTestNestedChild(), string: string)
    }
}

extension MenuItemExample : JsonSerializable
{
    public class var typeName:String { return "MenuItemExample" }
    public class func reflect() -> Type<MenuItemExample> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MenuItemExample>(
            properties: [
                Type<MenuItemExample>.optionalProperty("name1", get: { $0.name1 }, set: { $0.name1 = $1 }),
                Type<MenuItemExample>.optionalObjectProperty("menuItemExampleItem", get: { $0.menuItemExampleItem }, set: { $0.menuItemExampleItem = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MenuItemExample.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MenuItemExample? {
        return MenuItemExample.reflect().fromJson(MenuItemExample(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MenuItemExample? {
        return MenuItemExample.reflect().fromObject(MenuItemExample(), any:any)
    }
    public func toString() -> String {
        return MenuItemExample.reflect().toString(self)
    }
    public class func fromString(string:String) -> MenuItemExample? {
        return MenuItemExample.reflect().fromString(MenuItemExample(), string: string)
    }
}

extension SubType : JsonSerializable
{
    public class var typeName:String { return "SubType" }
    public class func reflect() -> Type<SubType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<SubType>(
            properties: [
                Type<SubType>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<SubType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return SubType.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> SubType? {
        return SubType.reflect().fromJson(SubType(), json: json)
    }
    public class func fromObject(any:AnyObject) -> SubType? {
        return SubType.reflect().fromObject(SubType(), any:any)
    }
    public func toString() -> String {
        return SubType.reflect().toString(self)
    }
    public class func fromString(string:String) -> SubType? {
        return SubType.reflect().fromString(SubType(), string: string)
    }
}

extension TypesGroup : JsonSerializable
{
    public class var typeName:String { return "TypesGroup" }
    public class func reflect() -> Type<TypesGroup> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TypesGroup>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return TypesGroup.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TypesGroup? {
        return TypesGroup.reflect().fromJson(TypesGroup(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TypesGroup? {
        return TypesGroup.reflect().fromObject(TypesGroup(), any:any)
    }
    public func toString() -> String {
        return TypesGroup.reflect().toString(self)
    }
    public class func fromString(string:String) -> TypesGroup? {
        return TypesGroup.reflect().fromString(TypesGroup(), string: string)
    }
}

extension MenuItemExampleItem : JsonSerializable
{
    public class var typeName:String { return "MenuItemExampleItem" }
    public class func reflect() -> Type<MenuItemExampleItem> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MenuItemExampleItem>(
            properties: [
                Type<MenuItemExampleItem>.optionalProperty("name1", get: { $0.name1 }, set: { $0.name1 = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MenuItemExampleItem.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MenuItemExampleItem? {
        return MenuItemExampleItem.reflect().fromJson(MenuItemExampleItem(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MenuItemExampleItem? {
        return MenuItemExampleItem.reflect().fromObject(MenuItemExampleItem(), any:any)
    }
    public func toString() -> String {
        return MenuItemExampleItem.reflect().toString(self)
    }
    public class func fromString(string:String) -> MenuItemExampleItem? {
        return MenuItemExampleItem.reflect().fromString(MenuItemExampleItem(), string: string)
    }
}

extension CustomHttpErrorResponse : JsonSerializable
{
    public class var typeName:String { return "CustomHttpErrorResponse" }
    public class func reflect() -> Type<CustomHttpErrorResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<CustomHttpErrorResponse>(
            properties: [
                Type<CustomHttpErrorResponse>.optionalProperty("custom", get: { $0.custom }, set: { $0.custom = $1 }),
                Type<CustomHttpErrorResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return CustomHttpErrorResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> CustomHttpErrorResponse? {
        return CustomHttpErrorResponse.reflect().fromJson(CustomHttpErrorResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> CustomHttpErrorResponse? {
        return CustomHttpErrorResponse.reflect().fromObject(CustomHttpErrorResponse(), any:any)
    }
    public func toString() -> String {
        return CustomHttpErrorResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> CustomHttpErrorResponse? {
        return CustomHttpErrorResponse.reflect().fromString(CustomHttpErrorResponse(), string: string)
    }
}

extension ThrowTypeResponse : JsonSerializable
{
    public class var typeName:String { return "ThrowTypeResponse" }
    public class func reflect() -> Type<ThrowTypeResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ThrowTypeResponse>(
            properties: [
                Type<ThrowTypeResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ThrowTypeResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ThrowTypeResponse? {
        return ThrowTypeResponse.reflect().fromJson(ThrowTypeResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ThrowTypeResponse? {
        return ThrowTypeResponse.reflect().fromObject(ThrowTypeResponse(), any:any)
    }
    public func toString() -> String {
        return ThrowTypeResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> ThrowTypeResponse? {
        return ThrowTypeResponse.reflect().fromString(ThrowTypeResponse(), string: string)
    }
}

extension ThrowValidationResponse : JsonSerializable
{
    public class var typeName:String { return "ThrowValidationResponse" }
    public class func reflect() -> Type<ThrowValidationResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ThrowValidationResponse>(
            properties: [
                Type<ThrowValidationResponse>.optionalProperty("age", get: { $0.age }, set: { $0.age = $1 }),
                Type<ThrowValidationResponse>.optionalProperty("required", get: { $0.required }, set: { $0.required = $1 }),
                Type<ThrowValidationResponse>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
                Type<ThrowValidationResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ThrowValidationResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ThrowValidationResponse? {
        return ThrowValidationResponse.reflect().fromJson(ThrowValidationResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ThrowValidationResponse? {
        return ThrowValidationResponse.reflect().fromObject(ThrowValidationResponse(), any:any)
    }
    public func toString() -> String {
        return ThrowValidationResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> ThrowValidationResponse? {
        return ThrowValidationResponse.reflect().fromString(ThrowValidationResponse(), string: string)
    }
}

extension ExternalOperationResponse : JsonSerializable
{
    public class var typeName:String { return "ExternalOperationResponse" }
    public class func reflect() -> Type<ExternalOperationResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ExternalOperationResponse>(
            properties: [
                Type<ExternalOperationResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ExternalOperationResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ExternalOperationResponse? {
        return ExternalOperationResponse.reflect().fromJson(ExternalOperationResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ExternalOperationResponse? {
        return ExternalOperationResponse.reflect().fromObject(ExternalOperationResponse(), any:any)
    }
    public func toString() -> String {
        return ExternalOperationResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> ExternalOperationResponse? {
        return ExternalOperationResponse.reflect().fromString(ExternalOperationResponse(), string: string)
    }
}

extension ExternalOperation2Response : JsonSerializable
{
    public class var typeName:String { return "ExternalOperation2Response" }
    public class func reflect() -> Type<ExternalOperation2Response> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ExternalOperation2Response>(
            properties: [
                Type<ExternalOperation2Response>.optionalObjectProperty("externalType", get: { $0.externalType }, set: { $0.externalType = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ExternalOperation2Response.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ExternalOperation2Response? {
        return ExternalOperation2Response.reflect().fromJson(ExternalOperation2Response(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ExternalOperation2Response? {
        return ExternalOperation2Response.reflect().fromObject(ExternalOperation2Response(), any:any)
    }
    public func toString() -> String {
        return ExternalOperation2Response.reflect().toString(self)
    }
    public class func fromString(string:String) -> ExternalOperation2Response? {
        return ExternalOperation2Response.reflect().fromString(ExternalOperation2Response(), string: string)
    }
}

extension ExternalReturnTypeResponse : JsonSerializable
{
    public class var typeName:String { return "ExternalReturnTypeResponse" }
    public class func reflect() -> Type<ExternalReturnTypeResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ExternalReturnTypeResponse>(
            properties: [
                Type<ExternalReturnTypeResponse>.optionalProperty("externalEnum3", get: { $0.externalEnum3 }, set: { $0.externalEnum3 = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ExternalReturnTypeResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ExternalReturnTypeResponse? {
        return ExternalReturnTypeResponse.reflect().fromJson(ExternalReturnTypeResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ExternalReturnTypeResponse? {
        return ExternalReturnTypeResponse.reflect().fromObject(ExternalReturnTypeResponse(), any:any)
    }
    public func toString() -> String {
        return ExternalReturnTypeResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> ExternalReturnTypeResponse? {
        return ExternalReturnTypeResponse.reflect().fromString(ExternalReturnTypeResponse(), string: string)
    }
}

extension Account : JsonSerializable
{
    public class var typeName:String { return "Account" }
    public class func reflect() -> Type<Account> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Account>(
            properties: [
                Type<Account>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Account.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Account? {
        return Account.reflect().fromJson(Account(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Account? {
        return Account.reflect().fromObject(Account(), any:any)
    }
    public func toString() -> String {
        return Account.reflect().toString(self)
    }
    public class func fromString(string:String) -> Account? {
        return Account.reflect().fromString(Account(), string: string)
    }
}

extension Project : JsonSerializable
{
    public class var typeName:String { return "Project" }
    public class func reflect() -> Type<Project> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Project>(
            properties: [
                Type<Project>.optionalProperty("account", get: { $0.account }, set: { $0.account = $1 }),
                Type<Project>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Project.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Project? {
        return Project.reflect().fromJson(Project(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Project? {
        return Project.reflect().fromObject(Project(), any:any)
    }
    public func toString() -> String {
        return Project.reflect().toString(self)
    }
    public class func fromString(string:String) -> Project? {
        return Project.reflect().fromString(Project(), string: string)
    }
}

extension MetadataTestResponse : JsonSerializable
{
    public class var typeName:String { return "MetadataTestResponse" }
    public class func reflect() -> Type<MetadataTestResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataTestResponse>(
            properties: [
                Type<MetadataTestResponse>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<MetadataTestResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataTestResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataTestResponse? {
        return MetadataTestResponse.reflect().fromJson(MetadataTestResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataTestResponse? {
        return MetadataTestResponse.reflect().fromObject(MetadataTestResponse(), any:any)
    }
    public func toString() -> String {
        return MetadataTestResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataTestResponse? {
        return MetadataTestResponse.reflect().fromString(MetadataTestResponse(), string: string)
    }
}

extension GetExampleResponse : JsonSerializable
{
    public class var typeName:String { return "GetExampleResponse" }
    public class func reflect() -> Type<GetExampleResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetExampleResponse>(
            properties: [
                Type<GetExampleResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
                Type<GetExampleResponse>.optionalObjectProperty("menuExample1", get: { $0.menuExample1 }, set: { $0.menuExample1 = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetExampleResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetExampleResponse? {
        return GetExampleResponse.reflect().fromJson(GetExampleResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetExampleResponse? {
        return GetExampleResponse.reflect().fromObject(GetExampleResponse(), any:any)
    }
    public func toString() -> String {
        return GetExampleResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetExampleResponse? {
        return GetExampleResponse.reflect().fromString(GetExampleResponse(), string: string)
    }
}

extension GetRandomIdsResponse : JsonSerializable
{
    public class var typeName:String { return "GetRandomIdsResponse" }
    public class func reflect() -> Type<GetRandomIdsResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetRandomIdsResponse>(
            properties: [
                Type<GetRandomIdsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetRandomIdsResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetRandomIdsResponse? {
        return GetRandomIdsResponse.reflect().fromJson(GetRandomIdsResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetRandomIdsResponse? {
        return GetRandomIdsResponse.reflect().fromObject(GetRandomIdsResponse(), any:any)
    }
    public func toString() -> String {
        return GetRandomIdsResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetRandomIdsResponse? {
        return GetRandomIdsResponse.reflect().fromString(GetRandomIdsResponse(), string: string)
    }
}

extension HelloResponse : JsonSerializable
{
    public class var typeName:String { return "HelloResponse" }
    public class func reflect() -> Type<HelloResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloResponse>(
            properties: [
                Type<HelloResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloResponse? {
        return HelloResponse.reflect().fromJson(HelloResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloResponse? {
        return HelloResponse.reflect().fromObject(HelloResponse(), any:any)
    }
    public func toString() -> String {
        return HelloResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloResponse? {
        return HelloResponse.reflect().fromString(HelloResponse(), string: string)
    }
}

extension HelloAllTypesResponse : JsonSerializable
{
    public class var typeName:String { return "HelloAllTypesResponse" }
    public class func reflect() -> Type<HelloAllTypesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloAllTypesResponse>(
            properties: [
                Type<HelloAllTypesResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<HelloAllTypesResponse>.optionalObjectProperty("allTypes", get: { $0.allTypes }, set: { $0.allTypes = $1 }),
                Type<HelloAllTypesResponse>.optionalObjectProperty("allCollectionTypes", get: { $0.allCollectionTypes }, set: { $0.allCollectionTypes = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloAllTypesResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloAllTypesResponse? {
        return HelloAllTypesResponse.reflect().fromJson(HelloAllTypesResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloAllTypesResponse? {
        return HelloAllTypesResponse.reflect().fromObject(HelloAllTypesResponse(), any:any)
    }
    public func toString() -> String {
        return HelloAllTypesResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloAllTypesResponse? {
        return HelloAllTypesResponse.reflect().fromString(HelloAllTypesResponse(), string: string)
    }
}

extension HelloWithDataContractResponse : JsonSerializable
{
    public class var typeName:String { return "HelloWithDataContractResponse" }
    public class func reflect() -> Type<HelloWithDataContractResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithDataContractResponse>(
            properties: [
                Type<HelloWithDataContractResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithDataContractResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithDataContractResponse? {
        return HelloWithDataContractResponse.reflect().fromJson(HelloWithDataContractResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithDataContractResponse? {
        return HelloWithDataContractResponse.reflect().fromObject(HelloWithDataContractResponse(), any:any)
    }
    public func toString() -> String {
        return HelloWithDataContractResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithDataContractResponse? {
        return HelloWithDataContractResponse.reflect().fromString(HelloWithDataContractResponse(), string: string)
    }
}

extension HelloWithDescriptionResponse : JsonSerializable
{
    public class var typeName:String { return "HelloWithDescriptionResponse" }
    public class func reflect() -> Type<HelloWithDescriptionResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithDescriptionResponse>(
            properties: [
                Type<HelloWithDescriptionResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithDescriptionResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithDescriptionResponse? {
        return HelloWithDescriptionResponse.reflect().fromJson(HelloWithDescriptionResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithDescriptionResponse? {
        return HelloWithDescriptionResponse.reflect().fromObject(HelloWithDescriptionResponse(), any:any)
    }
    public func toString() -> String {
        return HelloWithDescriptionResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithDescriptionResponse? {
        return HelloWithDescriptionResponse.reflect().fromString(HelloWithDescriptionResponse(), string: string)
    }
}

extension HelloWithInheritanceResponse : JsonSerializable
{
    public class var typeName:String { return "HelloWithInheritanceResponse" }
    public class func reflect() -> Type<HelloWithInheritanceResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithInheritanceResponse>(
            properties: [
                Type<HelloWithInheritanceResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<HelloWithInheritanceResponse>.optionalProperty("refId", get: { $0.refId }, set: { $0.refId = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithInheritanceResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithInheritanceResponse? {
        return HelloWithInheritanceResponse.reflect().fromJson(HelloWithInheritanceResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithInheritanceResponse? {
        return HelloWithInheritanceResponse.reflect().fromObject(HelloWithInheritanceResponse(), any:any)
    }
    public func toString() -> String {
        return HelloWithInheritanceResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithInheritanceResponse? {
        return HelloWithInheritanceResponse.reflect().fromString(HelloWithInheritanceResponse(), string: string)
    }
}

extension HelloWithAlternateReturnResponse : JsonSerializable
{
    public class var typeName:String { return "HelloWithAlternateReturnResponse" }
    public class func reflect() -> Type<HelloWithAlternateReturnResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithAlternateReturnResponse>(
            properties: [
                Type<HelloWithAlternateReturnResponse>.optionalProperty("altResult", get: { $0.altResult }, set: { $0.altResult = $1 }),
                Type<HelloWithAlternateReturnResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithAlternateReturnResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithAlternateReturnResponse? {
        return HelloWithAlternateReturnResponse.reflect().fromJson(HelloWithAlternateReturnResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithAlternateReturnResponse? {
        return HelloWithAlternateReturnResponse.reflect().fromObject(HelloWithAlternateReturnResponse(), any:any)
    }
    public func toString() -> String {
        return HelloWithAlternateReturnResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithAlternateReturnResponse? {
        return HelloWithAlternateReturnResponse.reflect().fromString(HelloWithAlternateReturnResponse(), string: string)
    }
}

extension HelloWithRouteResponse : JsonSerializable
{
    public class var typeName:String { return "HelloWithRouteResponse" }
    public class func reflect() -> Type<HelloWithRouteResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithRouteResponse>(
            properties: [
                Type<HelloWithRouteResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithRouteResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithRouteResponse? {
        return HelloWithRouteResponse.reflect().fromJson(HelloWithRouteResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithRouteResponse? {
        return HelloWithRouteResponse.reflect().fromObject(HelloWithRouteResponse(), any:any)
    }
    public func toString() -> String {
        return HelloWithRouteResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithRouteResponse? {
        return HelloWithRouteResponse.reflect().fromString(HelloWithRouteResponse(), string: string)
    }
}

extension HelloWithTypeResponse : JsonSerializable
{
    public class var typeName:String { return "HelloWithTypeResponse" }
    public class func reflect() -> Type<HelloWithTypeResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithTypeResponse>(
            properties: [
                Type<HelloWithTypeResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithTypeResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithTypeResponse? {
        return HelloWithTypeResponse.reflect().fromJson(HelloWithTypeResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithTypeResponse? {
        return HelloWithTypeResponse.reflect().fromObject(HelloWithTypeResponse(), any:any)
    }
    public func toString() -> String {
        return HelloWithTypeResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithTypeResponse? {
        return HelloWithTypeResponse.reflect().fromString(HelloWithTypeResponse(), string: string)
    }
}

extension HelloInnerTypesResponse : JsonSerializable
{
    public class var typeName:String { return "HelloInnerTypesResponse" }
    public class func reflect() -> Type<HelloInnerTypesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloInnerTypesResponse>(
            properties: [
                Type<HelloInnerTypesResponse>.optionalObjectProperty("innerType", get: { $0.innerType }, set: { $0.innerType = $1 }),
                Type<HelloInnerTypesResponse>.optionalProperty("innerEnum", get: { $0.innerEnum }, set: { $0.innerEnum = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloInnerTypesResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloInnerTypesResponse? {
        return HelloInnerTypesResponse.reflect().fromJson(HelloInnerTypesResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloInnerTypesResponse? {
        return HelloInnerTypesResponse.reflect().fromObject(HelloInnerTypesResponse(), any:any)
    }
    public func toString() -> String {
        return HelloInnerTypesResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloInnerTypesResponse? {
        return HelloInnerTypesResponse.reflect().fromString(HelloInnerTypesResponse(), string: string)
    }
}

extension PingResponse : JsonSerializable
{
    public class var typeName:String { return "PingResponse" }
    public class func reflect() -> Type<PingResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<PingResponse>(
            properties: [
                Type<PingResponse>.objectProperty("responses", get: { $0.responses }, set: { $0.responses = $1 }),
                Type<PingResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return PingResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> PingResponse? {
        return PingResponse.reflect().fromJson(PingResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> PingResponse? {
        return PingResponse.reflect().fromObject(PingResponse(), any:any)
    }
    public func toString() -> String {
        return PingResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> PingResponse? {
        return PingResponse.reflect().fromString(PingResponse(), string: string)
    }
}

extension RequiresRoleResponse : JsonSerializable
{
    public class var typeName:String { return "RequiresRoleResponse" }
    public class func reflect() -> Type<RequiresRoleResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RequiresRoleResponse>(
            properties: [
                Type<RequiresRoleResponse>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<RequiresRoleResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return RequiresRoleResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RequiresRoleResponse? {
        return RequiresRoleResponse.reflect().fromJson(RequiresRoleResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RequiresRoleResponse? {
        return RequiresRoleResponse.reflect().fromObject(RequiresRoleResponse(), any:any)
    }
    public func toString() -> String {
        return RequiresRoleResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> RequiresRoleResponse? {
        return RequiresRoleResponse.reflect().fromString(RequiresRoleResponse(), string: string)
    }
}

extension GetSessionResponse : JsonSerializable
{
    public class var typeName:String { return "GetSessionResponse" }
    public class func reflect() -> Type<GetSessionResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetSessionResponse>(
            properties: [
                Type<GetSessionResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<GetSessionResponse>.optionalObjectProperty("unAuthInfo", get: { $0.unAuthInfo }, set: { $0.unAuthInfo = $1 }),
                Type<GetSessionResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetSessionResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetSessionResponse? {
        return GetSessionResponse.reflect().fromJson(GetSessionResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetSessionResponse? {
        return GetSessionResponse.reflect().fromObject(GetSessionResponse(), any:any)
    }
    public func toString() -> String {
        return GetSessionResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetSessionResponse? {
        return GetSessionResponse.reflect().fromString(GetSessionResponse(), string: string)
    }
}

extension RequestLogsResponse : JsonSerializable
{
    public class var typeName:String { return "RequestLogsResponse" }
    public class func reflect() -> Type<RequestLogsResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RequestLogsResponse>(
            properties: [
                Type<RequestLogsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
                Type<RequestLogsResponse>.objectProperty("usage", get: { $0.usage }, set: { $0.usage = $1 }),
                Type<RequestLogsResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return RequestLogsResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RequestLogsResponse? {
        return RequestLogsResponse.reflect().fromJson(RequestLogsResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RequestLogsResponse? {
        return RequestLogsResponse.reflect().fromObject(RequestLogsResponse(), any:any)
    }
    public func toString() -> String {
        return RequestLogsResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> RequestLogsResponse? {
        return RequestLogsResponse.reflect().fromString(RequestLogsResponse(), string: string)
    }
}

extension AuthenticateResponse : JsonSerializable
{
    public class var typeName:String { return "AuthenticateResponse" }
    public class func reflect() -> Type<AuthenticateResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AuthenticateResponse>(
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
    public class var typeName:String { return "AssignRolesResponse" }
    public class func reflect() -> Type<AssignRolesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AssignRolesResponse>(
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
    public class var typeName:String { return "UnAssignRolesResponse" }
    public class func reflect() -> Type<UnAssignRolesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UnAssignRolesResponse>(
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

extension ResourcesResponse : JsonSerializable
{
    public class var typeName:String { return "ResourcesResponse" }
    public class func reflect() -> Type<ResourcesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ResourcesResponse>(
            properties: [
                Type<ResourcesResponse>.optionalProperty("swaggerVersion", get: { $0.swaggerVersion }, set: { $0.swaggerVersion = $1 }),
                Type<ResourcesResponse>.optionalProperty("apiVersion", get: { $0.apiVersion }, set: { $0.apiVersion = $1 }),
                Type<ResourcesResponse>.optionalProperty("basePath", get: { $0.basePath }, set: { $0.basePath = $1 }),
                Type<ResourcesResponse>.arrayProperty("apis", get: { $0.apis }, set: { $0.apis = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ResourcesResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ResourcesResponse? {
        return ResourcesResponse.reflect().fromJson(ResourcesResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ResourcesResponse? {
        return ResourcesResponse.reflect().fromObject(ResourcesResponse(), any:any)
    }
    public func toString() -> String {
        return ResourcesResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> ResourcesResponse? {
        return ResourcesResponse.reflect().fromString(ResourcesResponse(), string: string)
    }
}

extension CustomHttpError : JsonSerializable
{
    public class var typeName:String { return "CustomHttpError" }
    public class func reflect() -> Type<CustomHttpError> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<CustomHttpError>(
            properties: [
                Type<CustomHttpError>.optionalProperty("statusCode", get: { $0.statusCode }, set: { $0.statusCode = $1 }),
                Type<CustomHttpError>.optionalProperty("statusDescription", get: { $0.statusDescription }, set: { $0.statusDescription = $1 }),
            ]))
    }
    public func toJson() -> String {
        return CustomHttpError.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> CustomHttpError? {
        return CustomHttpError.reflect().fromJson(CustomHttpError(), json: json)
    }
    public class func fromObject(any:AnyObject) -> CustomHttpError? {
        return CustomHttpError.reflect().fromObject(CustomHttpError(), any:any)
    }
    public func toString() -> String {
        return CustomHttpError.reflect().toString(self)
    }
    public class func fromString(string:String) -> CustomHttpError? {
        return CustomHttpError.reflect().fromString(CustomHttpError(), string: string)
    }
}

extension ThrowHttpError : JsonSerializable
{
    public class var typeName:String { return "ThrowHttpError" }
    public class func reflect() -> Type<ThrowHttpError> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ThrowHttpError>(
            properties: [
                Type<ThrowHttpError>.optionalProperty("status", get: { $0.status }, set: { $0.status = $1 }),
                Type<ThrowHttpError>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ThrowHttpError.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ThrowHttpError? {
        return ThrowHttpError.reflect().fromJson(ThrowHttpError(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ThrowHttpError? {
        return ThrowHttpError.reflect().fromObject(ThrowHttpError(), any:any)
    }
    public func toString() -> String {
        return ThrowHttpError.reflect().toString(self)
    }
    public class func fromString(string:String) -> ThrowHttpError? {
        return ThrowHttpError.reflect().fromString(ThrowHttpError(), string: string)
    }
}

extension Throw404 : JsonSerializable
{
    public class var typeName:String { return "Throw404" }
    public class func reflect() -> Type<Throw404> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Throw404>(
            properties: [
                Type<Throw404>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Throw404.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Throw404? {
        return Throw404.reflect().fromJson(Throw404(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Throw404? {
        return Throw404.reflect().fromObject(Throw404(), any:any)
    }
    public func toString() -> String {
        return Throw404.reflect().toString(self)
    }
    public class func fromString(string:String) -> Throw404? {
        return Throw404.reflect().fromString(Throw404(), string: string)
    }
}

extension ThrowType : JsonSerializable
{
    public class var typeName:String { return "ThrowType" }
    public class func reflect() -> Type<ThrowType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ThrowType>(
            properties: [
                Type<ThrowType>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
                Type<ThrowType>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ThrowType.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ThrowType? {
        return ThrowType.reflect().fromJson(ThrowType(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ThrowType? {
        return ThrowType.reflect().fromObject(ThrowType(), any:any)
    }
    public func toString() -> String {
        return ThrowType.reflect().toString(self)
    }
    public class func fromString(string:String) -> ThrowType? {
        return ThrowType.reflect().fromString(ThrowType(), string: string)
    }
}

extension ThrowValidation : JsonSerializable
{
    public class var typeName:String { return "ThrowValidation" }
    public class func reflect() -> Type<ThrowValidation> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ThrowValidation>(
            properties: [
                Type<ThrowValidation>.optionalProperty("age", get: { $0.age }, set: { $0.age = $1 }),
                Type<ThrowValidation>.optionalProperty("required", get: { $0.required }, set: { $0.required = $1 }),
                Type<ThrowValidation>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ThrowValidation.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ThrowValidation? {
        return ThrowValidation.reflect().fromJson(ThrowValidation(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ThrowValidation? {
        return ThrowValidation.reflect().fromObject(ThrowValidation(), any:any)
    }
    public func toString() -> String {
        return ThrowValidation.reflect().toString(self)
    }
    public class func fromString(string:String) -> ThrowValidation? {
        return ThrowValidation.reflect().fromString(ThrowValidation(), string: string)
    }
}

extension ExternalOperation : JsonSerializable
{
    public class var typeName:String { return "ExternalOperation" }
    public class func reflect() -> Type<ExternalOperation> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ExternalOperation>(
            properties: [
                Type<ExternalOperation>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<ExternalOperation>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<ExternalOperation>.optionalProperty("externalEnum", get: { $0.externalEnum }, set: { $0.externalEnum = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ExternalOperation.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ExternalOperation? {
        return ExternalOperation.reflect().fromJson(ExternalOperation(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ExternalOperation? {
        return ExternalOperation.reflect().fromObject(ExternalOperation(), any:any)
    }
    public func toString() -> String {
        return ExternalOperation.reflect().toString(self)
    }
    public class func fromString(string:String) -> ExternalOperation? {
        return ExternalOperation.reflect().fromString(ExternalOperation(), string: string)
    }
}

extension ExternalOperation2 : JsonSerializable
{
    public class var typeName:String { return "ExternalOperation2" }
    public class func reflect() -> Type<ExternalOperation2> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ExternalOperation2>(
            properties: [
                Type<ExternalOperation2>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ExternalOperation2.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ExternalOperation2? {
        return ExternalOperation2.reflect().fromJson(ExternalOperation2(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ExternalOperation2? {
        return ExternalOperation2.reflect().fromObject(ExternalOperation2(), any:any)
    }
    public func toString() -> String {
        return ExternalOperation2.reflect().toString(self)
    }
    public class func fromString(string:String) -> ExternalOperation2? {
        return ExternalOperation2.reflect().fromString(ExternalOperation2(), string: string)
    }
}

extension ExternalOperation3 : JsonSerializable
{
    public class var typeName:String { return "ExternalOperation3" }
    public class func reflect() -> Type<ExternalOperation3> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ExternalOperation3>(
            properties: [
                Type<ExternalOperation3>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ExternalOperation3.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ExternalOperation3? {
        return ExternalOperation3.reflect().fromJson(ExternalOperation3(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ExternalOperation3? {
        return ExternalOperation3.reflect().fromObject(ExternalOperation3(), any:any)
    }
    public func toString() -> String {
        return ExternalOperation3.reflect().toString(self)
    }
    public class func fromString(string:String) -> ExternalOperation3? {
        return ExternalOperation3.reflect().fromString(ExternalOperation3(), string: string)
    }
}

extension ExternalOperation4 : JsonSerializable
{
    public class var typeName:String { return "ExternalOperation4" }
    public class func reflect() -> Type<ExternalOperation4> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ExternalOperation4>(
            properties: [
                Type<ExternalOperation4>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ExternalOperation4.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ExternalOperation4? {
        return ExternalOperation4.reflect().fromJson(ExternalOperation4(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ExternalOperation4? {
        return ExternalOperation4.reflect().fromObject(ExternalOperation4(), any:any)
    }
    public func toString() -> String {
        return ExternalOperation4.reflect().toString(self)
    }
    public class func fromString(string:String) -> ExternalOperation4? {
        return ExternalOperation4.reflect().fromString(ExternalOperation4(), string: string)
    }
}

extension RootPathRoutes : JsonSerializable
{
    public class var typeName:String { return "RootPathRoutes" }
    public class func reflect() -> Type<RootPathRoutes> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RootPathRoutes>(
            properties: [
                Type<RootPathRoutes>.optionalProperty("path", get: { $0.path }, set: { $0.path = $1 }),
            ]))
    }
    public func toJson() -> String {
        return RootPathRoutes.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RootPathRoutes? {
        return RootPathRoutes.reflect().fromJson(RootPathRoutes(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RootPathRoutes? {
        return RootPathRoutes.reflect().fromObject(RootPathRoutes(), any:any)
    }
    public func toString() -> String {
        return RootPathRoutes.reflect().toString(self)
    }
    public class func fromString(string:String) -> RootPathRoutes? {
        return RootPathRoutes.reflect().fromString(RootPathRoutes(), string: string)
    }
}

extension GetAccount : JsonSerializable
{
    public class var typeName:String { return "GetAccount" }
    public class func reflect() -> Type<GetAccount> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetAccount>(
            properties: [
                Type<GetAccount>.optionalProperty("account", get: { $0.account }, set: { $0.account = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetAccount.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetAccount? {
        return GetAccount.reflect().fromJson(GetAccount(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetAccount? {
        return GetAccount.reflect().fromObject(GetAccount(), any:any)
    }
    public func toString() -> String {
        return GetAccount.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetAccount? {
        return GetAccount.reflect().fromString(GetAccount(), string: string)
    }
}

extension GetProject : JsonSerializable
{
    public class var typeName:String { return "GetProject" }
    public class func reflect() -> Type<GetProject> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetProject>(
            properties: [
                Type<GetProject>.optionalProperty("account", get: { $0.account }, set: { $0.account = $1 }),
                Type<GetProject>.optionalProperty("project", get: { $0.project }, set: { $0.project = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetProject.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetProject? {
        return GetProject.reflect().fromJson(GetProject(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetProject? {
        return GetProject.reflect().fromObject(GetProject(), any:any)
    }
    public func toString() -> String {
        return GetProject.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetProject? {
        return GetProject.reflect().fromString(GetProject(), string: string)
    }
}

extension ImageAsStream : JsonSerializable
{
    public class var typeName:String { return "ImageAsStream" }
    public class func reflect() -> Type<ImageAsStream> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ImageAsStream>(
            properties: [
                Type<ImageAsStream>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ImageAsStream.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ImageAsStream? {
        return ImageAsStream.reflect().fromJson(ImageAsStream(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ImageAsStream? {
        return ImageAsStream.reflect().fromObject(ImageAsStream(), any:any)
    }
    public func toString() -> String {
        return ImageAsStream.reflect().toString(self)
    }
    public class func fromString(string:String) -> ImageAsStream? {
        return ImageAsStream.reflect().fromString(ImageAsStream(), string: string)
    }
}

extension ImageAsBytes : JsonSerializable
{
    public class var typeName:String { return "ImageAsBytes" }
    public class func reflect() -> Type<ImageAsBytes> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ImageAsBytes>(
            properties: [
                Type<ImageAsBytes>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ImageAsBytes.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ImageAsBytes? {
        return ImageAsBytes.reflect().fromJson(ImageAsBytes(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ImageAsBytes? {
        return ImageAsBytes.reflect().fromObject(ImageAsBytes(), any:any)
    }
    public func toString() -> String {
        return ImageAsBytes.reflect().toString(self)
    }
    public class func fromString(string:String) -> ImageAsBytes? {
        return ImageAsBytes.reflect().fromString(ImageAsBytes(), string: string)
    }
}

extension ImageAsCustomResult : JsonSerializable
{
    public class var typeName:String { return "ImageAsCustomResult" }
    public class func reflect() -> Type<ImageAsCustomResult> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ImageAsCustomResult>(
            properties: [
                Type<ImageAsCustomResult>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ImageAsCustomResult.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ImageAsCustomResult? {
        return ImageAsCustomResult.reflect().fromJson(ImageAsCustomResult(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ImageAsCustomResult? {
        return ImageAsCustomResult.reflect().fromObject(ImageAsCustomResult(), any:any)
    }
    public func toString() -> String {
        return ImageAsCustomResult.reflect().toString(self)
    }
    public class func fromString(string:String) -> ImageAsCustomResult? {
        return ImageAsCustomResult.reflect().fromString(ImageAsCustomResult(), string: string)
    }
}

extension ImageWriteToResponse : JsonSerializable
{
    public class var typeName:String { return "ImageWriteToResponse" }
    public class func reflect() -> Type<ImageWriteToResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ImageWriteToResponse>(
            properties: [
                Type<ImageWriteToResponse>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ImageWriteToResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ImageWriteToResponse? {
        return ImageWriteToResponse.reflect().fromJson(ImageWriteToResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ImageWriteToResponse? {
        return ImageWriteToResponse.reflect().fromObject(ImageWriteToResponse(), any:any)
    }
    public func toString() -> String {
        return ImageWriteToResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> ImageWriteToResponse? {
        return ImageWriteToResponse.reflect().fromString(ImageWriteToResponse(), string: string)
    }
}

extension ImageAsFile : JsonSerializable
{
    public class var typeName:String { return "ImageAsFile" }
    public class func reflect() -> Type<ImageAsFile> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ImageAsFile>(
            properties: [
                Type<ImageAsFile>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ImageAsFile.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ImageAsFile? {
        return ImageAsFile.reflect().fromJson(ImageAsFile(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ImageAsFile? {
        return ImageAsFile.reflect().fromObject(ImageAsFile(), any:any)
    }
    public func toString() -> String {
        return ImageAsFile.reflect().toString(self)
    }
    public class func fromString(string:String) -> ImageAsFile? {
        return ImageAsFile.reflect().fromString(ImageAsFile(), string: string)
    }
}

extension ImageAsRedirect : JsonSerializable
{
    public class var typeName:String { return "ImageAsRedirect" }
    public class func reflect() -> Type<ImageAsRedirect> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ImageAsRedirect>(
            properties: [
                Type<ImageAsRedirect>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ImageAsRedirect.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ImageAsRedirect? {
        return ImageAsRedirect.reflect().fromJson(ImageAsRedirect(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ImageAsRedirect? {
        return ImageAsRedirect.reflect().fromObject(ImageAsRedirect(), any:any)
    }
    public func toString() -> String {
        return ImageAsRedirect.reflect().toString(self)
    }
    public class func fromString(string:String) -> ImageAsRedirect? {
        return ImageAsRedirect.reflect().fromString(ImageAsRedirect(), string: string)
    }
}

extension DrawImage : JsonSerializable
{
    public class var typeName:String { return "DrawImage" }
    public class func reflect() -> Type<DrawImage> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<DrawImage>(
            properties: [
                Type<DrawImage>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<DrawImage>.optionalProperty("format", get: { $0.format }, set: { $0.format = $1 }),
                Type<DrawImage>.optionalProperty("width", get: { $0.width }, set: { $0.width = $1 }),
                Type<DrawImage>.optionalProperty("height", get: { $0.height }, set: { $0.height = $1 }),
                Type<DrawImage>.optionalProperty("fontSize", get: { $0.fontSize }, set: { $0.fontSize = $1 }),
                Type<DrawImage>.optionalProperty("foreground", get: { $0.foreground }, set: { $0.foreground = $1 }),
                Type<DrawImage>.optionalProperty("background", get: { $0.background }, set: { $0.background = $1 }),
            ]))
    }
    public func toJson() -> String {
        return DrawImage.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> DrawImage? {
        return DrawImage.reflect().fromJson(DrawImage(), json: json)
    }
    public class func fromObject(any:AnyObject) -> DrawImage? {
        return DrawImage.reflect().fromObject(DrawImage(), any:any)
    }
    public func toString() -> String {
        return DrawImage.reflect().toString(self)
    }
    public class func fromString(string:String) -> DrawImage? {
        return DrawImage.reflect().fromString(DrawImage(), string: string)
    }
}

extension MetadataTest : JsonSerializable
{
    public class var typeName:String { return "MetadataTest" }
    public class func reflect() -> Type<MetadataTest> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataTest>(
            properties: [
                Type<MetadataTest>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataTest.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataTest? {
        return MetadataTest.reflect().fromJson(MetadataTest(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataTest? {
        return MetadataTest.reflect().fromObject(MetadataTest(), any:any)
    }
    public func toString() -> String {
        return MetadataTest.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataTest? {
        return MetadataTest.reflect().fromString(MetadataTest(), string: string)
    }
}

extension MetadataTestArray : JsonSerializable
{
    public class var typeName:String { return "MetadataTestArray" }
    public class func reflect() -> Type<MetadataTestArray> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataTestArray>(
            properties: [
                Type<MetadataTestArray>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataTestArray.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataTestArray? {
        return MetadataTestArray.reflect().fromJson(MetadataTestArray(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataTestArray? {
        return MetadataTestArray.reflect().fromObject(MetadataTestArray(), any:any)
    }
    public func toString() -> String {
        return MetadataTestArray.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataTestArray? {
        return MetadataTestArray.reflect().fromString(MetadataTestArray(), string: string)
    }
}

extension GetExample : JsonSerializable
{
    public class var typeName:String { return "GetExample" }
    public class func reflect() -> Type<GetExample> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetExample>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return GetExample.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetExample? {
        return GetExample.reflect().fromJson(GetExample(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetExample? {
        return GetExample.reflect().fromObject(GetExample(), any:any)
    }
    public func toString() -> String {
        return GetExample.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetExample? {
        return GetExample.reflect().fromString(GetExample(), string: string)
    }
}

extension GetRandomIds : JsonSerializable
{
    public class var typeName:String { return "GetRandomIds" }
    public class func reflect() -> Type<GetRandomIds> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetRandomIds>(
            properties: [
                Type<GetRandomIds>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetRandomIds.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetRandomIds? {
        return GetRandomIds.reflect().fromJson(GetRandomIds(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetRandomIds? {
        return GetRandomIds.reflect().fromObject(GetRandomIds(), any:any)
    }
    public func toString() -> String {
        return GetRandomIds.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetRandomIds? {
        return GetRandomIds.reflect().fromString(GetRandomIds(), string: string)
    }
}

extension TextFileTest : JsonSerializable
{
    public class var typeName:String { return "TextFileTest" }
    public class func reflect() -> Type<TextFileTest> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TextFileTest>(
            properties: [
                Type<TextFileTest>.optionalProperty("asAttachment", get: { $0.asAttachment }, set: { $0.asAttachment = $1 }),
            ]))
    }
    public func toJson() -> String {
        return TextFileTest.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TextFileTest? {
        return TextFileTest.reflect().fromJson(TextFileTest(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TextFileTest? {
        return TextFileTest.reflect().fromObject(TextFileTest(), any:any)
    }
    public func toString() -> String {
        return TextFileTest.reflect().toString(self)
    }
    public class func fromString(string:String) -> TextFileTest? {
        return TextFileTest.reflect().fromString(TextFileTest(), string: string)
    }
}

extension Hello : JsonSerializable
{
    public class var typeName:String { return "Hello" }
    public class func reflect() -> Type<Hello> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Hello>(
            properties: [
                Type<Hello>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<Hello>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Hello.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Hello? {
        return Hello.reflect().fromJson(Hello(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Hello? {
        return Hello.reflect().fromObject(Hello(), any:any)
    }
    public func toString() -> String {
        return Hello.reflect().toString(self)
    }
    public class func fromString(string:String) -> Hello? {
        return Hello.reflect().fromString(Hello(), string: string)
    }
}

extension HelloWithNestedClass : JsonSerializable
{
    public class var typeName:String { return "HelloWithNestedClass" }
    public class func reflect() -> Type<HelloWithNestedClass> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithNestedClass>(
            properties: [
                Type<HelloWithNestedClass>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<HelloWithNestedClass>.optionalObjectProperty("nestedClassProp", get: { $0.nestedClassProp }, set: { $0.nestedClassProp = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithNestedClass.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithNestedClass? {
        return HelloWithNestedClass.reflect().fromJson(HelloWithNestedClass(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithNestedClass? {
        return HelloWithNestedClass.reflect().fromObject(HelloWithNestedClass(), any:any)
    }
    public func toString() -> String {
        return HelloWithNestedClass.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithNestedClass? {
        return HelloWithNestedClass.reflect().fromString(HelloWithNestedClass(), string: string)
    }
}

extension HelloList : JsonSerializable
{
    public class var typeName:String { return "HelloList" }
    public class func reflect() -> Type<HelloList> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloList>(
            properties: [
                Type<HelloList>.arrayProperty("names", get: { $0.names }, set: { $0.names = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloList.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloList? {
        return HelloList.reflect().fromJson(HelloList(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloList? {
        return HelloList.reflect().fromObject(HelloList(), any:any)
    }
    public func toString() -> String {
        return HelloList.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloList? {
        return HelloList.reflect().fromString(HelloList(), string: string)
    }
}

extension HelloArray : JsonSerializable
{
    public class var typeName:String { return "HelloArray" }
    public class func reflect() -> Type<HelloArray> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloArray>(
            properties: [
                Type<HelloArray>.arrayProperty("names", get: { $0.names }, set: { $0.names = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloArray.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloArray? {
        return HelloArray.reflect().fromJson(HelloArray(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloArray? {
        return HelloArray.reflect().fromObject(HelloArray(), any:any)
    }
    public func toString() -> String {
        return HelloArray.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloArray? {
        return HelloArray.reflect().fromString(HelloArray(), string: string)
    }
}

extension HelloWithEnum : JsonSerializable
{
    public class var typeName:String { return "HelloWithEnum" }
    public class func reflect() -> Type<HelloWithEnum> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithEnum>(
            properties: [
                Type<HelloWithEnum>.optionalProperty("enumProp", get: { $0.enumProp }, set: { $0.enumProp = $1 }),
                Type<HelloWithEnum>.optionalProperty("nullableEnumProp", get: { $0.nullableEnumProp }, set: { $0.nullableEnumProp = $1 }),
                Type<HelloWithEnum>.optionalProperty("enumFlags", get: { $0.enumFlags }, set: { $0.enumFlags = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithEnum.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithEnum? {
        return HelloWithEnum.reflect().fromJson(HelloWithEnum(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithEnum? {
        return HelloWithEnum.reflect().fromObject(HelloWithEnum(), any:any)
    }
    public func toString() -> String {
        return HelloWithEnum.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithEnum? {
        return HelloWithEnum.reflect().fromString(HelloWithEnum(), string: string)
    }
}

extension HelloExternal : JsonSerializable
{
    public class var typeName:String { return "HelloExternal" }
    public class func reflect() -> Type<HelloExternal> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloExternal>(
            properties: [
                Type<HelloExternal>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloExternal.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloExternal? {
        return HelloExternal.reflect().fromJson(HelloExternal(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloExternal? {
        return HelloExternal.reflect().fromObject(HelloExternal(), any:any)
    }
    public func toString() -> String {
        return HelloExternal.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloExternal? {
        return HelloExternal.reflect().fromString(HelloExternal(), string: string)
    }
}

extension AllowedAttributes : JsonSerializable
{
    public class var typeName:String { return "AllowedAttributes" }
    public class func reflect() -> Type<AllowedAttributes> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AllowedAttributes>(
            properties: [
                Type<AllowedAttributes>.optionalProperty("range", get: { $0.range }, set: { $0.range = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AllowedAttributes.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AllowedAttributes? {
        return AllowedAttributes.reflect().fromJson(AllowedAttributes(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AllowedAttributes? {
        return AllowedAttributes.reflect().fromObject(AllowedAttributes(), any:any)
    }
    public func toString() -> String {
        return AllowedAttributes.reflect().toString(self)
    }
    public class func fromString(string:String) -> AllowedAttributes? {
        return AllowedAttributes.reflect().fromString(AllowedAttributes(), string: string)
    }
}

extension HelloAllTypes : JsonSerializable
{
    public class var typeName:String { return "HelloAllTypes" }
    public class func reflect() -> Type<HelloAllTypes> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloAllTypes>(
            properties: [
                Type<HelloAllTypes>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<HelloAllTypes>.optionalObjectProperty("allTypes", get: { $0.allTypes }, set: { $0.allTypes = $1 }),
                Type<HelloAllTypes>.optionalObjectProperty("allCollectionTypes", get: { $0.allCollectionTypes }, set: { $0.allCollectionTypes = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloAllTypes.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloAllTypes? {
        return HelloAllTypes.reflect().fromJson(HelloAllTypes(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloAllTypes? {
        return HelloAllTypes.reflect().fromObject(HelloAllTypes(), any:any)
    }
    public func toString() -> String {
        return HelloAllTypes.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloAllTypes? {
        return HelloAllTypes.reflect().fromString(HelloAllTypes(), string: string)
    }
}

extension HelloString : JsonSerializable
{
    public class var typeName:String { return "HelloString" }
    public class func reflect() -> Type<HelloString> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloString>(
            properties: [
                Type<HelloString>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloString.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloString? {
        return HelloString.reflect().fromJson(HelloString(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloString? {
        return HelloString.reflect().fromObject(HelloString(), any:any)
    }
    public func toString() -> String {
        return HelloString.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloString? {
        return HelloString.reflect().fromString(HelloString(), string: string)
    }
}

extension HelloVoid : JsonSerializable
{
    public class var typeName:String { return "HelloVoid" }
    public class func reflect() -> Type<HelloVoid> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloVoid>(
            properties: [
                Type<HelloVoid>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloVoid.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloVoid? {
        return HelloVoid.reflect().fromJson(HelloVoid(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloVoid? {
        return HelloVoid.reflect().fromObject(HelloVoid(), any:any)
    }
    public func toString() -> String {
        return HelloVoid.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloVoid? {
        return HelloVoid.reflect().fromString(HelloVoid(), string: string)
    }
}

extension HelloWithDataContract : JsonSerializable
{
    public class var typeName:String { return "HelloWithDataContract" }
    public class func reflect() -> Type<HelloWithDataContract> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithDataContract>(
            properties: [
                Type<HelloWithDataContract>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<HelloWithDataContract>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithDataContract.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithDataContract? {
        return HelloWithDataContract.reflect().fromJson(HelloWithDataContract(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithDataContract? {
        return HelloWithDataContract.reflect().fromObject(HelloWithDataContract(), any:any)
    }
    public func toString() -> String {
        return HelloWithDataContract.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithDataContract? {
        return HelloWithDataContract.reflect().fromString(HelloWithDataContract(), string: string)
    }
}

extension HelloWithDescription : JsonSerializable
{
    public class var typeName:String { return "HelloWithDescription" }
    public class func reflect() -> Type<HelloWithDescription> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithDescription>(
            properties: [
                Type<HelloWithDescription>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithDescription.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithDescription? {
        return HelloWithDescription.reflect().fromJson(HelloWithDescription(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithDescription? {
        return HelloWithDescription.reflect().fromObject(HelloWithDescription(), any:any)
    }
    public func toString() -> String {
        return HelloWithDescription.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithDescription? {
        return HelloWithDescription.reflect().fromString(HelloWithDescription(), string: string)
    }
}

extension HelloWithInheritance : JsonSerializable
{
    public class var typeName:String { return "HelloWithInheritance" }
    public class func reflect() -> Type<HelloWithInheritance> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithInheritance>(
            properties: [
                Type<HelloWithInheritance>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<HelloWithInheritance>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithInheritance.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithInheritance? {
        return HelloWithInheritance.reflect().fromJson(HelloWithInheritance(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithInheritance? {
        return HelloWithInheritance.reflect().fromObject(HelloWithInheritance(), any:any)
    }
    public func toString() -> String {
        return HelloWithInheritance.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithInheritance? {
        return HelloWithInheritance.reflect().fromString(HelloWithInheritance(), string: string)
    }
}

extension HelloWithGenericInheritance : JsonSerializable
{
    public class var typeName:String { return "HelloWithGenericInheritance" }
    public class func reflect() -> Type<HelloWithGenericInheritance> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithGenericInheritance>(
            properties: [
                Type<HelloWithGenericInheritance>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<HelloWithGenericInheritance>.arrayProperty("items", get: { $0.items }, set: { $0.items = $1 }),
                Type<HelloWithGenericInheritance>.arrayProperty("counts", get: { $0.counts }, set: { $0.counts = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithGenericInheritance.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithGenericInheritance? {
        return HelloWithGenericInheritance.reflect().fromJson(HelloWithGenericInheritance(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithGenericInheritance? {
        return HelloWithGenericInheritance.reflect().fromObject(HelloWithGenericInheritance(), any:any)
    }
    public func toString() -> String {
        return HelloWithGenericInheritance.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithGenericInheritance? {
        return HelloWithGenericInheritance.reflect().fromString(HelloWithGenericInheritance(), string: string)
    }
}

extension HelloWithGenericInheritance2 : JsonSerializable
{
    public class var typeName:String { return "HelloWithGenericInheritance2" }
    public class func reflect() -> Type<HelloWithGenericInheritance2> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithGenericInheritance2>(
            properties: [
                Type<HelloWithGenericInheritance2>.optionalProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<HelloWithGenericInheritance2>.arrayProperty("items", get: { $0.items }, set: { $0.items = $1 }),
                Type<HelloWithGenericInheritance2>.arrayProperty("counts", get: { $0.counts }, set: { $0.counts = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithGenericInheritance2.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithGenericInheritance2? {
        return HelloWithGenericInheritance2.reflect().fromJson(HelloWithGenericInheritance2(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithGenericInheritance2? {
        return HelloWithGenericInheritance2.reflect().fromObject(HelloWithGenericInheritance2(), any:any)
    }
    public func toString() -> String {
        return HelloWithGenericInheritance2.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithGenericInheritance2? {
        return HelloWithGenericInheritance2.reflect().fromString(HelloWithGenericInheritance2(), string: string)
    }
}

extension HelloWithNestedInheritance : JsonSerializable
{
    public class var typeName:String { return "HelloWithNestedInheritance" }
    public class func reflect() -> Type<HelloWithNestedInheritance> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithNestedInheritance>(
            properties: [
                Type<HelloWithNestedInheritance>.arrayProperty("items", get: { $0.items }, set: { $0.items = $1 }),
                Type<HelloWithNestedInheritance>.arrayProperty("counts", get: { $0.counts }, set: { $0.counts = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithNestedInheritance.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithNestedInheritance? {
        return HelloWithNestedInheritance.reflect().fromJson(HelloWithNestedInheritance(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithNestedInheritance? {
        return HelloWithNestedInheritance.reflect().fromObject(HelloWithNestedInheritance(), any:any)
    }
    public func toString() -> String {
        return HelloWithNestedInheritance.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithNestedInheritance? {
        return HelloWithNestedInheritance.reflect().fromString(HelloWithNestedInheritance(), string: string)
    }
}

extension HelloWithListInheritance : JsonSerializable
{
    public class var typeName:String { return "HelloWithListInheritance" }
    public class func reflect() -> Type<HelloWithListInheritance> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithListInheritance>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return HelloWithListInheritance.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithListInheritance? {
        return HelloWithListInheritance.reflect().fromJson(HelloWithListInheritance(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithListInheritance? {
        return HelloWithListInheritance.reflect().fromObject(HelloWithListInheritance(), any:any)
    }
    public func toString() -> String {
        return HelloWithListInheritance.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithListInheritance? {
        return HelloWithListInheritance.reflect().fromString(HelloWithListInheritance(), string: string)
    }
}

extension HelloWithReturn : JsonSerializable
{
    public class var typeName:String { return "HelloWithReturn" }
    public class func reflect() -> Type<HelloWithReturn> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithReturn>(
            properties: [
                Type<HelloWithReturn>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithReturn.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithReturn? {
        return HelloWithReturn.reflect().fromJson(HelloWithReturn(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithReturn? {
        return HelloWithReturn.reflect().fromObject(HelloWithReturn(), any:any)
    }
    public func toString() -> String {
        return HelloWithReturn.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithReturn? {
        return HelloWithReturn.reflect().fromString(HelloWithReturn(), string: string)
    }
}

extension HelloWithRoute : JsonSerializable
{
    public class var typeName:String { return "HelloWithRoute" }
    public class func reflect() -> Type<HelloWithRoute> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithRoute>(
            properties: [
                Type<HelloWithRoute>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithRoute.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithRoute? {
        return HelloWithRoute.reflect().fromJson(HelloWithRoute(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithRoute? {
        return HelloWithRoute.reflect().fromObject(HelloWithRoute(), any:any)
    }
    public func toString() -> String {
        return HelloWithRoute.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithRoute? {
        return HelloWithRoute.reflect().fromString(HelloWithRoute(), string: string)
    }
}

extension HelloWithType : JsonSerializable
{
    public class var typeName:String { return "HelloWithType" }
    public class func reflect() -> Type<HelloWithType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloWithType>(
            properties: [
                Type<HelloWithType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloWithType.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloWithType? {
        return HelloWithType.reflect().fromJson(HelloWithType(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloWithType? {
        return HelloWithType.reflect().fromObject(HelloWithType(), any:any)
    }
    public func toString() -> String {
        return HelloWithType.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloWithType? {
        return HelloWithType.reflect().fromString(HelloWithType(), string: string)
    }
}

extension HelloInterface : JsonSerializable
{
    public class var typeName:String { return "HelloInterface" }
    public class func reflect() -> Type<HelloInterface> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloInterface>(
            properties: [
                Type<HelloInterface>.optionalObjectProperty("emptyClass", get: { $0.emptyClass }, set: { $0.emptyClass = $1 }),
            ]))
    }
    public func toJson() -> String {
        return HelloInterface.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloInterface? {
        return HelloInterface.reflect().fromJson(HelloInterface(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloInterface? {
        return HelloInterface.reflect().fromObject(HelloInterface(), any:any)
    }
    public func toString() -> String {
        return HelloInterface.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloInterface? {
        return HelloInterface.reflect().fromString(HelloInterface(), string: string)
    }
}

extension HelloInnerTypes : JsonSerializable
{
    public class var typeName:String { return "HelloInnerTypes" }
    public class func reflect() -> Type<HelloInnerTypes> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<HelloInnerTypes>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return HelloInnerTypes.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> HelloInnerTypes? {
        return HelloInnerTypes.reflect().fromJson(HelloInnerTypes(), json: json)
    }
    public class func fromObject(any:AnyObject) -> HelloInnerTypes? {
        return HelloInnerTypes.reflect().fromObject(HelloInnerTypes(), any:any)
    }
    public func toString() -> String {
        return HelloInnerTypes.reflect().toString(self)
    }
    public class func fromString(string:String) -> HelloInnerTypes? {
        return HelloInnerTypes.reflect().fromString(HelloInnerTypes(), string: string)
    }
}

extension Ping : JsonSerializable
{
    public class var typeName:String { return "Ping" }
    public class func reflect() -> Type<Ping> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Ping>(
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

extension ResetConnections : JsonSerializable
{
    public class var typeName:String { return "ResetConnections" }
    public class func reflect() -> Type<ResetConnections> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ResetConnections>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return ResetConnections.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ResetConnections? {
        return ResetConnections.reflect().fromJson(ResetConnections(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ResetConnections? {
        return ResetConnections.reflect().fromObject(ResetConnections(), any:any)
    }
    public func toString() -> String {
        return ResetConnections.reflect().toString(self)
    }
    public class func fromString(string:String) -> ResetConnections? {
        return ResetConnections.reflect().fromString(ResetConnections(), string: string)
    }
}

extension RequiresRole : JsonSerializable
{
    public class var typeName:String { return "RequiresRole" }
    public class func reflect() -> Type<RequiresRole> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RequiresRole>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return RequiresRole.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RequiresRole? {
        return RequiresRole.reflect().fromJson(RequiresRole(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RequiresRole? {
        return RequiresRole.reflect().fromObject(RequiresRole(), any:any)
    }
    public func toString() -> String {
        return RequiresRole.reflect().toString(self)
    }
    public class func fromString(string:String) -> RequiresRole? {
        return RequiresRole.reflect().fromString(RequiresRole(), string: string)
    }
}

extension GetSession : JsonSerializable
{
    public class var typeName:String { return "GetSession" }
    public class func reflect() -> Type<GetSession> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetSession>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return GetSession.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetSession? {
        return GetSession.reflect().fromJson(GetSession(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetSession? {
        return GetSession.reflect().fromObject(GetSession(), any:any)
    }
    public func toString() -> String {
        return GetSession.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetSession? {
        return GetSession.reflect().fromString(GetSession(), string: string)
    }
}

extension UpdateSession : JsonSerializable
{
    public class var typeName:String { return "UpdateSession" }
    public class func reflect() -> Type<UpdateSession> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UpdateSession>(
            properties: [
                Type<UpdateSession>.optionalProperty("customName", get: { $0.customName }, set: { $0.customName = $1 }),
            ]))
    }
    public func toJson() -> String {
        return UpdateSession.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> UpdateSession? {
        return UpdateSession.reflect().fromJson(UpdateSession(), json: json)
    }
    public class func fromObject(any:AnyObject) -> UpdateSession? {
        return UpdateSession.reflect().fromObject(UpdateSession(), any:any)
    }
    public func toString() -> String {
        return UpdateSession.reflect().toString(self)
    }
    public class func fromString(string:String) -> UpdateSession? {
        return UpdateSession.reflect().fromString(UpdateSession(), string: string)
    }
}

extension TestVoidResponse : JsonSerializable
{
    public class var typeName:String { return "TestVoidResponse" }
    public class func reflect() -> Type<TestVoidResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TestVoidResponse>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return TestVoidResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TestVoidResponse? {
        return TestVoidResponse.reflect().fromJson(TestVoidResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TestVoidResponse? {
        return TestVoidResponse.reflect().fromObject(TestVoidResponse(), any:any)
    }
    public func toString() -> String {
        return TestVoidResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> TestVoidResponse? {
        return TestVoidResponse.reflect().fromString(TestVoidResponse(), string: string)
    }
}

extension TestNullResponse : JsonSerializable
{
    public class var typeName:String { return "TestNullResponse" }
    public class func reflect() -> Type<TestNullResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<TestNullResponse>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return TestNullResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> TestNullResponse? {
        return TestNullResponse.reflect().fromJson(TestNullResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> TestNullResponse? {
        return TestNullResponse.reflect().fromObject(TestNullResponse(), any:any)
    }
    public func toString() -> String {
        return TestNullResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> TestNullResponse? {
        return TestNullResponse.reflect().fromString(TestNullResponse(), string: string)
    }
}

extension Postman : JsonSerializable
{
    public class var typeName:String { return "Postman" }
    public class func reflect() -> Type<Postman> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Postman>(
            properties: [
                Type<Postman>.arrayProperty("label", get: { $0.label }, set: { $0.label = $1 }),
                Type<Postman>.optionalProperty("exportSession", get: { $0.exportSession }, set: { $0.exportSession = $1 }),
                Type<Postman>.optionalProperty("ssid", get: { $0.ssid }, set: { $0.ssid = $1 }),
                Type<Postman>.optionalProperty("sspid", get: { $0.sspid }, set: { $0.sspid = $1 }),
                Type<Postman>.optionalProperty("ssopt", get: { $0.ssopt }, set: { $0.ssopt = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Postman.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Postman? {
        return Postman.reflect().fromJson(Postman(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Postman? {
        return Postman.reflect().fromObject(Postman(), any:any)
    }
    public func toString() -> String {
        return Postman.reflect().toString(self)
    }
    public class func fromString(string:String) -> Postman? {
        return Postman.reflect().fromString(Postman(), string: string)
    }
}

extension RequestLogs : JsonSerializable
{
    public class var typeName:String { return "RequestLogs" }
    public class func reflect() -> Type<RequestLogs> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RequestLogs>(
            properties: [
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
            ]))
    }
    public func toJson() -> String {
        return RequestLogs.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RequestLogs? {
        return RequestLogs.reflect().fromJson(RequestLogs(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RequestLogs? {
        return RequestLogs.reflect().fromObject(RequestLogs(), any:any)
    }
    public func toString() -> String {
        return RequestLogs.reflect().toString(self)
    }
    public class func fromString(string:String) -> RequestLogs? {
        return RequestLogs.reflect().fromString(RequestLogs(), string: string)
    }
}

extension Authenticate : JsonSerializable
{
    public class var typeName:String { return "Authenticate" }
    public class func reflect() -> Type<Authenticate> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Authenticate>(
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
    public class var typeName:String { return "AssignRoles" }
    public class func reflect() -> Type<AssignRoles> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AssignRoles>(
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
    public class var typeName:String { return "UnAssignRoles" }
    public class func reflect() -> Type<UnAssignRoles> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<UnAssignRoles>(
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

extension Resources : JsonSerializable
{
    public class var typeName:String { return "Resources" }
    public class func reflect() -> Type<Resources> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Resources>(
            properties: [
                Type<Resources>.optionalProperty("apiKey", get: { $0.apiKey }, set: { $0.apiKey = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Resources.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Resources? {
        return Resources.reflect().fromJson(Resources(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Resources? {
        return Resources.reflect().fromObject(Resources(), any:any)
    }
    public func toString() -> String {
        return Resources.reflect().toString(self)
    }
    public class func fromString(string:String) -> Resources? {
        return Resources.reflect().fromString(Resources(), string: string)
    }
}

extension ResourceRequest : JsonSerializable
{
    public class var typeName:String { return "ResourceRequest" }
    public class func reflect() -> Type<ResourceRequest> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ResourceRequest>(
            properties: [
                Type<ResourceRequest>.optionalProperty("apiKey", get: { $0.apiKey }, set: { $0.apiKey = $1 }),
                Type<ResourceRequest>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ResourceRequest.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> ResourceRequest? {
        return ResourceRequest.reflect().fromJson(ResourceRequest(), json: json)
    }
    public class func fromObject(any:AnyObject) -> ResourceRequest? {
        return ResourceRequest.reflect().fromObject(ResourceRequest(), any:any)
    }
    public func toString() -> String {
        return ResourceRequest.reflect().toString(self)
    }
    public class func fromString(string:String) -> ResourceRequest? {
        return ResourceRequest.reflect().fromString(ResourceRequest(), string: string)
    }
}


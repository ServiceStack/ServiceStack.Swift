/* Options:
Date: 2024-11-25 09:52:41
SwiftVersion: 6.0
Version: 8.41
Tip: To override a DTO option, remove "//" prefix before updating
BaseUrl: https://test.servicestack.net

//BaseClass: 
//AddModelExtensions: True
//AddServiceStackTypes: True
//MakePropertiesOptional: True
//IncludeTypes: 
ExcludeTypes: QueryResponse`1,QueryBase`1,QueryBase`1,QueryBase,DummyTypes,MessageQuery,SpeechToText,TextOutput,IGeneration
//ExcludeGenericBaseTypes: False
//AddResponseStatus: False
//AddImplicitVersion: 
//AddDescriptionAsComments: True
//InitializeCollections: False
//TreatTypesAsStrings: 
//DefaultImports: Foundation,ServiceStack
*/

import Foundation
import ServiceStack

public class QueryItems : QueryDb2<Item, Poco>, IReturn
{
    public typealias Return = QueryResponse<Poco>

    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

// @Route("/channels/{Channel}/raw")
public class PostRawToChannel : IReturnVoid, Codable
{
    public var from:String?
    public var toUserId:String?
    public var channel:String?
    public var message:String?
    public var selector:String?

    required public init(){}
}

// @Route("/channels/{Channel}/chat")
public class PostChatToChannel : IReturn, Codable
{
    public typealias Return = ChatMessage

    public var from:String?
    public var toUserId:String?
    public var channel:String?
    public var message:String?
    public var selector:String?

    required public init(){}
}

// @Route("/chathistory")
public class GetChatHistory : IReturn, Codable
{
    public typealias Return = GetChatHistoryResponse

    public var channels:[String]?
    public var afterId:Int?
    public var take:Int?

    required public init(){}
}

// @Route("/reset")
public class ClearChatHistory : IReturnVoid, Codable
{
    required public init(){}
}

// @Route("/reset-serverevents")
public class ResetServerEvents : IReturnVoid, Codable
{
    required public init(){}
}

// @Route("/channels/{Channel}/object")
public class PostObjectToChannel : IReturnVoid, Codable
{
    public var toUserId:String?
    public var channel:String?
    public var selector:String?
    public var customType:CustomType?
    public var setterType:SetterType?

    required public init(){}
}

// @Route("/account")
public class GetUserDetails : IReturn, Codable
{
    public typealias Return = GetUserDetailsResponse

    required public init(){}
}

public class CustomHttpError : IReturn, Codable
{
    public typealias Return = CustomHttpErrorResponse

    public var statusCode:Int?
    public var statusDescription:String?

    required public init(){}
}

public class AltQueryItems : IReturn, Codable
{
    public typealias Return = QueryResponseAlt<Item>

    public var name:String?

    required public init(){}
}

public class GetItems : IReturn, Codable
{
    public typealias Return = Items

    required public init(){}
}

public class GetNakedItems : IReturn, Codable
{
    public typealias Return = [Item]

    required public init(){}
}

// @ValidateRequest(Validator="IsAuthenticated")
public class DeclarativeValidationAuth : Codable
{
    public var name:String?

    required public init(){}
}

public class DeclarativeCollectiveValidationTest : IReturn, Codable
{
    public typealias Return = EmptyResponse

    // @Validate(Validator="NotEmpty")
    // @Validate(Validator="MaximumLength(20)")
    public var site:String?

    public var declarativeValidations:[DeclarativeChildValidation] = []
    public var fluentValidations:[FluentChildValidation] = []

    required public init(){}
}

public class DeclarativeSingleValidationTest : IReturn, Codable
{
    public typealias Return = EmptyResponse

    // @Validate(Validator="NotEmpty")
    // @Validate(Validator="MaximumLength(20)")
    public var site:String?

    public var declarativeSingleValidation:DeclarativeSingleValidation?
    public var fluentSingleValidation:FluentSingleValidation?

    required public init(){}
}

// @Route("/throwhttperror/{Status}")
public class ThrowHttpError : Codable
{
    public var status:Int?
    public var message:String?

    required public init(){}
}

// @Route("/throw404")
// @Route("/throw404/{Message}")
public class Throw404 : Codable
{
    public var message:String?

    required public init(){}
}

// @Route("/throwcustom400")
// @Route("/throwcustom400/{Message}")
public class ThrowCustom400 : Codable
{
    public var message:String?

    required public init(){}
}

// @Route("/returncustom400")
// @Route("/returncustom400/{Message}")
public class ReturnCustom400 : IReturn, Codable
{
    public typealias Return = ReturnCustom400Response

    public var message:String?

    required public init(){}
}

// @Route("/throw/{Type}")
public class ThrowType : IReturn, Codable
{
    public typealias Return = ThrowTypeResponse

    public var type:String?
    public var message:String?

    required public init(){}
}

// @Route("/throwvalidation")
public class ThrowValidation : IReturn, Codable
{
    public typealias Return = ThrowValidationResponse

    public var age:Int?
    public var required:String?
    public var email:String?

    required public init(){}
}

// @Route("/throwbusinesserror")
public class ThrowBusinessError : IReturn, Codable
{
    public typealias Return = ThrowBusinessErrorResponse

    required public init(){}
}

public class TestFileUploads : IReturn, Codable
{
    public typealias Return = TestFileUploadsResponse

    public var id:Int?
    public var refId:String?

    required public init(){}
}

public class RootPathRoutes : Codable
{
    public var path:String?

    required public init(){}
}

public class GetAccount : IReturn, Codable
{
    public typealias Return = Account

    public var account:String?

    required public init(){}
}

public class GetProject : IReturn, Codable
{
    public typealias Return = Project

    public var account:String?
    public var project:String?

    required public init(){}
}

// @Route("/image-stream")
public class ImageAsStream : IReturn, Codable
{
    public typealias Return = Data

    public var format:String?

    required public init(){}
}

// @Route("/image-bytes")
public class ImageAsBytes : IReturn, Codable
{
    public typealias Return = [UInt8]

    public var format:String?

    required public init(){}
}

// @Route("/image-custom")
public class ImageAsCustomResult : IReturn, Codable
{
    public typealias Return = [UInt8]

    public var format:String?

    required public init(){}
}

// @Route("/image-response")
public class ImageWriteToResponse : IReturn, Codable
{
    public typealias Return = [UInt8]

    public var format:String?

    required public init(){}
}

// @Route("/image-file")
public class ImageAsFile : IReturn, Codable
{
    public typealias Return = [UInt8]

    public var format:String?

    required public init(){}
}

// @Route("/image-redirect")
public class ImageAsRedirect : Codable
{
    public var format:String?

    required public init(){}
}

// @Route("/hello-image/{Name}")
public class HelloImage : IReturn, Codable
{
    public typealias Return = [UInt8]

    public var name:String?
    public var format:String?
    public var width:Int?
    public var height:Int?
    public var fontSize:Int?
    public var fontFamily:String?
    public var foreground:String?
    public var background:String?

    required public init(){}
}

// @Route("/secured")
// @ValidateRequest(Validator="IsAuthenticated")
public class Secured : IReturn, Codable
{
    public typealias Return = SecuredResponse

    public var name:String?

    required public init(){}
}

// @Route("/jwt")
public class CreateJwt : AuthUserSession, IReturn
{
    public typealias Return = CreateJwtResponse

    public var jwtExpiry:Date?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case jwtExpiry
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        jwtExpiry = try container.decodeIfPresent(Date.self, forKey: .jwtExpiry)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if jwtExpiry != nil { try container.encode(jwtExpiry, forKey: .jwtExpiry) }
    }
}

// @Route("/jwt-refresh")
public class CreateRefreshJwt : IReturn, Codable
{
    public typealias Return = CreateRefreshJwtResponse

    public var userAuthId:String?
    public var jwtExpiry:Date?

    required public init(){}
}

// @Route("/jwt-invalidate")
public class InvalidateLastAccessToken : IReturn, Codable
{
    public typealias Return = EmptyResponse

    required public init(){}
}

// @Route("/logs")
public class ViewLogs : IReturn, Codable
{
    public typealias Return = String

    public var clear:Bool?

    required public init(){}
}

// @Route("/metadatatest")
public class MetadataTest : IReturn, Codable
{
    public typealias Return = MetadataTestResponse

    public var id:Int?

    required public init(){}
}

// @Route("/metadatatest-array")
public class MetadataTestArray : IReturn, Codable
{
    public typealias Return = [MetadataTestChild]

    public var id:Int?

    required public init(){}
}

// @Route("/example", "GET")
// @DataContract
public class GetExample : IReturn, Codable
{
    public typealias Return = GetExampleResponse

    required public init(){}
}

// @Route("/messages/{Id}", "GET")
public class RequestMessage : IReturn, Codable
{
    public typealias Return = Message

    public var id:Int?

    required public init(){}
}

// @Route("/messages/{Id}", "PUT")
public class Message : IReturn, Codable
{
    public typealias Return = Message

    public var id:Int?
    public var name:String?

    required public init(){}
}

// @Route("/randomids")
public class GetRandomIds : IReturn, Codable
{
    public typealias Return = GetRandomIdsResponse

    public var take:Int?

    required public init(){}
}

// @Route("/textfile-test")
public class TextFileTest : Codable
{
    public var asAttachment:Bool?

    required public init(){}
}

// @Route("/return/text")
public class ReturnText : Codable
{
    public var text:String?

    required public init(){}
}

// @Route("/return/html")
public class ReturnHtml : Codable
{
    public var text:String?

    required public init(){}
}

// @Route("/hello")
// @Route("/hello/{Name}")
public class Hello : IReturn, Codable
{
    public typealias Return = HelloResponse

    // @Required()
    public var name:String?

    public var title:String?

    required public init(){}
}

// @Route("/hello-secure/{Name}")
// @ValidateRequest(Validator="IsAuthenticated")
public class HelloSecure : IReturn, Codable
{
    public typealias Return = HelloResponse

    public var name:String?

    required public init(){}
}

/**
* Description on HelloAll type
*/
// @DataContract
public class HelloAnnotated : IReturn, Codable
{
    public typealias Return = HelloAnnotatedResponse

    // @DataMember
    public var name:String?

    required public init(){}
}

public class HelloWithNestedClass : IReturn, Codable
{
    public typealias Return = HelloResponse

    public var name:String?
    public var nestedClassProp:NestedClass?

    required public init(){}
}

public class HelloList : IReturn, Codable
{
    public typealias Return = [ListResult]

    public var names:[String] = []

    required public init(){}
}

public class HelloArray : IReturn, Codable
{
    public typealias Return = [ArrayResult]

    public var names:[String] = []

    required public init(){}
}

public class HelloMap : IReturn, Codable
{
    public typealias Return = [String:ArrayResult]

    public var names:[String] = []

    required public init(){}
}

public class HelloQueryResponse : IReturn, Codable
{
    public typealias Return = QueryResponse<String>

    public var names:[String] = []

    required public init(){}
}

public class HelloWithEnum : Codable
{
    public var enumProp:EnumType?
    public var enumTypeFlags:EnumTypeFlags?
    public var enumWithValues:EnumWithValues?
    public var nullableEnumProp:EnumType?
    public var enumFlags:EnumFlags?
    public var enumAsInt:EnumAsInt?
    public var enumStyle:EnumStyle?
    public var enumStyleMembers:EnumStyleMembers?

    required public init(){}
}

public class HelloWithEnumList : Codable
{
    public var enumProp:[EnumType] = []
    public var enumWithValues:[EnumWithValues] = []
    public var nullableEnumProp:[EnumType?] = []
    public var enumFlags:[EnumFlags] = []
    public var enumStyle:[EnumStyle] = []

    required public init(){}
}

public class HelloWithEnumMap : Codable
{
    public var enumProp:[EnumType:EnumType] = [:]
    public var enumWithValues:[EnumWithValues:EnumWithValues] = [:]
    public var nullableEnumProp:[EnumType?:EnumType?] = [:]
    public var enumFlags:[EnumFlags:EnumFlags] = [:]
    public var enumStyle:[EnumStyle:EnumStyle] = [:]

    required public init(){}
}

public class RestrictedAttributes : Codable
{
    public var id:Int?
    public var name:String?
    public var hello:Hello?

    required public init(){}
}

/**
* AllowedAttributes Description
*/
// @Route("/allowed-attributes", "GET")
// @Api(Description="AllowedAttributes Description")
// @ApiResponse(Description="Your request was not understood", StatusCode=400)
// @DataContract
public class AllowedAttributes : Codable
{
    /**
    * Range Description
    */
    // @DataMember(Name="Aliased")
    // @ApiMember(DataType="double", Description="Range Description", IsRequired=true, ParameterType="path")
    public var Aliased:Double?

    required public init(){}
}

// @Route("/all-types")
public class HelloAllTypes : IReturn, Codable
{
    public typealias Return = HelloAllTypesResponse

    public var name:String?
    public var allTypes:AllTypes?
    public var allCollectionTypes:AllCollectionTypes?

    required public init(){}
}

public class HelloSubAllTypes : AllTypesBase, IReturn
{
    public typealias Return = SubAllTypes

    public var hierarchy:Int?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case hierarchy
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hierarchy = try container.decodeIfPresent(Int.self, forKey: .hierarchy)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if hierarchy != nil { try container.encode(hierarchy, forKey: .hierarchy) }
    }
}

public class AllTypes : IReturn, Codable
{
    public typealias Return = AllTypes

    public var id:Int?
    public var nullableId:Int?
    public var byte:UInt8?
    public var short:Int16?
    public var int:Int?
    public var long:Int?
    public var uShort:UInt16?
    public var uInt:UInt32?
    public var uLong:UInt64?
    public var float:Float?
    public var double:Double?
    public var decimal:Double?
    public var string:String?
    public var dateTime:Date?
    @TimeSpan public var timeSpan:TimeInterval?
    public var dateTimeOffset:Date?
    public var guid:String?
    public var char:String?
    public var keyValuePair:KeyValuePair<String, String>?
    public var nullableDateTime:Date?
    @TimeSpan public var nullableTimeSpan:TimeInterval?
    public var stringList:[String] = []
    public var stringArray:[String] = []
    public var stringMap:[String:String] = [:]
    public var intStringMap:[Int:String] = [:]
    public var subType:SubType?

    required public init(){}
}

public class AllCollectionTypes : IReturn, Codable
{
    public typealias Return = AllCollectionTypes

    public var intArray:[Int] = []
    public var intList:[Int] = []
    public var stringArray:[String] = []
    public var stringList:[String] = []
    public var floatArray:[Float] = []
    public var doubleList:[Double] = []
    public var byteArray:[UInt8] = []
    public var charArray:[String] = []
    public var decimalList:[Double] = []
    public var pocoArray:[Poco] = []
    public var pocoList:[Poco] = []
    public var pocoLookup:[String:[Poco]] = [:]
    public var pocoLookupMap:[String:[[String:Poco]]] = [:]

    required public init(){}
}

public class HelloString : IReturn, Codable
{
    public typealias Return = String

    public var name:String?

    required public init(){}
}

public class HelloDateTime : IReturn, Codable
{
    public typealias Return = HelloDateTime

    public var dateTime:Date?

    required public init(){}
}

public class HelloVoid : Codable
{
    public var name:String?

    required public init(){}
}

// @DataContract
public class HelloWithDataContract : IReturn, Codable
{
    public typealias Return = HelloWithDataContractResponse

    // @DataMember(Name="name", Order=1, IsRequired=true, EmitDefaultValue=false)
    public var name:String?

    // @DataMember(Name="id", Order=2, EmitDefaultValue=false)
    public var id:Int?

    required public init(){}
}

/**
* Description on HelloWithDescription type
*/
public class HelloWithDescription : IReturn, Codable
{
    public typealias Return = HelloWithDescriptionResponse

    public var name:String?

    required public init(){}
}

public class HelloWithInheritance : HelloBase, IReturn
{
    public typealias Return = HelloWithInheritanceResponse

    public var name:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case name
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if name != nil { try container.encode(name, forKey: .name) }
    }
}

public class HelloWithGenericInheritance : HelloBase_1<Poco>
{
    public var result:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case result
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decodeIfPresent(String.self, forKey: .result)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if result != nil { try container.encode(result, forKey: .result) }
    }
}

public class HelloWithGenericInheritance2 : HelloBase_1<Hello>
{
    public var result:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case result
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decodeIfPresent(String.self, forKey: .result)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if result != nil { try container.encode(result, forKey: .result) }
    }
}

public class HelloWithReturn : IReturn, Codable
{
    public typealias Return = HelloWithAlternateReturnResponse

    public var name:String?

    required public init(){}
}

// @Route("/helloroute")
public class HelloWithRoute : IReturn, Codable
{
    public typealias Return = HelloWithRouteResponse

    public var name:String?

    required public init(){}
}

public class HelloWithType : IReturn, Codable
{
    public typealias Return = HelloWithTypeResponse

    public var name:String?

    required public init(){}
}

public class HelloInterface : Codable
{
    //poco:IPoco ignored. Swift doesn't support interface properties
    //emptyInterface:IEmptyInterface ignored. Swift doesn't support interface properties
    public var emptyClass:EmptyClass?

    required public init(){}
}

public class HelloInnerTypes : IReturn, Codable
{
    public typealias Return = HelloInnerTypesResponse

    required public init(){}
}

public class HelloBuiltin : Codable
{
    public var dayOfWeek:DayOfWeek?

    required public init(){}
}

public class HelloGet : IReturn, IGet, Codable
{
    public typealias Return = HelloVerbResponse

    public var id:Int?

    required public init(){}
}

public class HelloPost : HelloBase, IReturn, IPost
{
    public typealias Return = HelloVerbResponse

    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class HelloPut : IReturn, IPut, Codable
{
    public typealias Return = HelloVerbResponse

    public var id:Int?

    required public init(){}
}

public class HelloDelete : IReturn, IDelete, Codable
{
    public typealias Return = HelloVerbResponse

    public var id:Int?

    required public init(){}
}

public class HelloPatch : IReturn, IPatch, Codable
{
    public typealias Return = HelloVerbResponse

    public var id:Int?

    required public init(){}
}

public class HelloReturnVoid : IReturnVoid, Codable
{
    public var id:Int?

    required public init(){}
}

public class EnumRequest : IReturn, IPut, Codable
{
    public typealias Return = EnumResponse

    public var `operator`:ScopeType?

    required public init(){}
}

// @Route("/hellotypes/{Name}")
public class HelloTypes : IReturn, Codable
{
    public typealias Return = HelloTypes

    public var string:String?
    public var bool:Bool?
    public var int:Int?

    required public init(){}
}

// @Route("/hellozip")
// @DataContract
public class HelloZip : IReturn, Codable
{
    public typealias Return = HelloZipResponse

    // @DataMember
    public var name:String?

    // @DataMember
    public var test:[String] = []

    required public init(){}
}

// @Route("/ping")
public class Ping : IReturn, Codable
{
    public typealias Return = PingResponse

    required public init(){}
}

// @Route("/reset-connections")
public class ResetConnections : Codable
{
    required public init(){}
}

// @Route("/requires-role")
public class RequiresRole : IReturn, Codable
{
    public typealias Return = RequiresRoleResponse

    required public init(){}
}

// @Route("/return/string")
public class ReturnString : IReturn, Codable
{
    public typealias Return = String

    public var data:String?

    required public init(){}
}

// @Route("/return/bytes")
public class ReturnBytes : IReturn, Codable
{
    public typealias Return = [UInt8]

    public var data:[UInt8] = []

    required public init(){}
}

// @Route("/return/stream")
public class ReturnStream : IReturn, Codable
{
    public typealias Return = Data

    public var data:[UInt8] = []

    required public init(){}
}

// @Route("/return/json")
public class ReturnJson : Codable
{
    required public init(){}
}

// @Route("/return/json/header")
public class ReturnJsonHeader : Codable
{
    required public init(){}
}

// @Route("/write/json")
public class WriteJson : Codable
{
    required public init(){}
}

// @Route("/Request1", "GET")
public class GetRequest1 : IReturn, IGet, Codable
{
    public typealias Return = [ReturnedDto]

    required public init(){}
}

// @Route("/Request2", "GET")
public class GetRequest2 : IReturn, IGet, Codable
{
    public typealias Return = [ReturnedDto]

    required public init(){}
}

// @Route("/sendjson")
public class SendJson : IReturn, Codable
{
    public typealias Return = String

    public var id:Int?
    public var name:String?
    public var requestStream:Data?

    required public init(){}
}

// @Route("/sendtext")
public class SendText : IReturn, Codable
{
    public typealias Return = String

    public var id:Int?
    public var name:String?
    public var contentType:String?
    public var requestStream:Data?

    required public init(){}
}

// @Route("/sendraw")
public class SendRaw : IReturn, Codable
{
    public typealias Return = [UInt8]

    public var id:Int?
    public var name:String?
    public var contentType:String?
    public var requestStream:Data?

    required public init(){}
}

public class SendDefault : IReturn, Codable
{
    public typealias Return = SendVerbResponse

    public var id:Int?

    required public init(){}
}

// @Route("/sendrestget/{Id}", "GET")
public class SendRestGet : IReturn, IGet, Codable
{
    public typealias Return = SendVerbResponse

    public var id:Int?

    required public init(){}
}

public class SendGet : IReturn, IGet, Codable
{
    public typealias Return = SendVerbResponse

    public var id:Int?

    required public init(){}
}

public class SendPost : IReturn, IPost, Codable
{
    public typealias Return = SendVerbResponse

    public var id:Int?

    required public init(){}
}

public class SendPut : IReturn, IPut, Codable
{
    public typealias Return = SendVerbResponse

    public var id:Int?

    required public init(){}
}

public class SendReturnVoid : IReturnVoid, Codable
{
    public var id:Int?

    required public init(){}
}

// @Route("/session")
public class GetSession : IReturn, Codable
{
    public typealias Return = GetSessionResponse

    required public init(){}
}

// @Route("/session/edit/{CustomName}")
public class UpdateSession : IReturn, Codable
{
    public typealias Return = GetSessionResponse

    public var customName:String?

    required public init(){}
}

// @Route("/Stuff")
// @DataContract(Namespace="http://schemas.servicestack.net/types")
public class GetStuff : IReturn, Codable
{
    public typealias Return = GetStuffResponse

    // @DataMember
    // @ApiMember(DataType="DateTime", Name="Summary Date")
    public var summaryDate:Date?

    // @DataMember
    // @ApiMember(DataType="DateTime", Name="Summary End Date")
    public var summaryEndDate:Date?

    // @DataMember
    // @ApiMember(DataType="string", Name="Symbol")
    public var symbol:String?

    // @DataMember
    // @ApiMember(DataType="string", Name="Email")
    public var email:String?

    // @DataMember
    // @ApiMember(DataType="bool", Name="Is Enabled")
    public var isEnabled:Bool?

    required public init(){}
}

public class StoreLogs : IReturn, Codable
{
    public typealias Return = StoreLogsResponse

    public var loggers:[Logger] = []

    required public init(){}
}

public class HelloAuth : IReturn, Codable
{
    public typealias Return = HelloResponse

    public var name:String?

    required public init(){}
}

// @Route("/testauth")
public class TestAuth : IReturn, Codable
{
    public typealias Return = TestAuthResponse

    required public init(){}
}

public class RequiresAdmin : IReturn, Codable
{
    public typealias Return = RequiresAdmin

    public var id:Int?

    required public init(){}
}

// @Route("/testdata/AllTypes")
public class TestDataAllTypes : IReturn, Codable
{
    public typealias Return = AllTypes

    required public init(){}
}

// @Route("/testdata/AllCollectionTypes")
public class TestDataAllCollectionTypes : IReturn, Codable
{
    public typealias Return = AllCollectionTypes

    required public init(){}
}

// @Route("/custom")
// @Route("/custom/{Data}")
public class CustomRoute : IReturn, Codable
{
    public typealias Return = CustomRoute

    public var data:String?

    required public init(){}
}

// @Route("/void-response")
public class TestVoidResponse : Codable
{
    required public init(){}
}

// @Route("/null-response")
public class TestNullResponse : Codable
{
    required public init(){}
}

// @Route("/wait/{ForMs}")
public class Wait : IReturn, Codable
{
    public typealias Return = Wait

    public var forMs:Int?

    required public init(){}
}

// @Route("/echo/types")
public class EchoTypes : IReturn, Codable
{
    public typealias Return = EchoTypes

    public var byte:UInt8?
    public var short:Int16?
    public var int:Int?
    public var long:Int?
    public var uShort:UInt16?
    public var uInt:UInt32?
    public var uLong:UInt64?
    public var float:Float?
    public var double:Double?
    public var decimal:Double?
    public var string:String?
    public var dateTime:Date?
    @TimeSpan public var timeSpan:TimeInterval?
    public var dateTimeOffset:Date?
    public var guid:String?
    public var char:String?

    required public init(){}
}

// @Route("/echo/collections")
public class EchoCollections : IReturn, Codable
{
    public typealias Return = EchoCollections

    public var stringList:[String]?
    public var stringArray:[String]?
    public var stringMap:[String:String]?
    public var intStringMap:[Int:String]?

    required public init(){}
}

// @Route("/echo/complex")
public class EchoComplexTypes : IReturn, Codable
{
    public typealias Return = EchoComplexTypes

    public var subType:SubType?
    public var subTypes:[SubType]?
    public var subTypeMap:[String:SubType]?
    public var stringMap:[String:String]?
    public var intStringMap:[Int:String]?

    required public init(){}
}

// @Route("/rockstars", "POST")
public class StoreRockstars : List<Rockstar>, IReturn
{
    public typealias Return = StoreRockstars

    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

/**
* Sign Up
*/
// @Route("/register", "PUT,POST")
// @Api(Description="Sign Up")
// @DataContract
public class Register : IReturn, IPost, Codable
{
    public typealias Return = RegisterResponse

    // @DataMember(Order=1)
    public var userName:String?

    // @DataMember(Order=2)
    public var firstName:String?

    // @DataMember(Order=3)
    public var lastName:String?

    // @DataMember(Order=4)
    public var displayName:String?

    // @DataMember(Order=5)
    public var email:String?

    // @DataMember(Order=6)
    public var password:String?

    // @DataMember(Order=7)
    public var confirmPassword:String?

    // @DataMember(Order=8)
    public var autoLogin:Bool?

    // @DataMember(Order=10)
    public var errorView:String?

    // @DataMember(Order=11)
    public var meta:[String:String]?

    required public init(){}
}

/**
* Sign In
*/
// @Route("/auth", "GET,POST")
// @Route("/auth/{provider}", "GET,POST")
// @Api(Description="Sign In")
// @DataContract
public class Authenticate : IReturn, IPost, Codable
{
    public typealias Return = AuthenticateResponse

    /**
    * AuthProvider, e.g. credentials
    */
    // @DataMember(Order=1)
    public var provider:String?

    // @DataMember(Order=2)
    public var userName:String?

    // @DataMember(Order=3)
    public var password:String?

    // @DataMember(Order=4)
    public var rememberMe:Bool?

    // @DataMember(Order=5)
    public var accessToken:String?

    // @DataMember(Order=6)
    public var accessTokenSecret:String?

    // @DataMember(Order=7)
    public var returnUrl:String?

    // @DataMember(Order=8)
    public var errorView:String?

    // @DataMember(Order=9)
    public var meta:[String:String]?

    required public init(){}
}

// @Route("/assignroles", "POST")
// @DataContract
public class AssignRoles : IReturn, IPost, Codable
{
    public typealias Return = AssignRolesResponse

    // @DataMember(Order=1)
    public var userName:String?

    // @DataMember(Order=2)
    public var permissions:[String]?

    // @DataMember(Order=3)
    public var roles:[String]?

    // @DataMember(Order=4)
    public var meta:[String:String]?

    required public init(){}
}

// @Route("/unassignroles", "POST")
// @DataContract
public class UnAssignRoles : IReturn, IPost, Codable
{
    public typealias Return = UnAssignRolesResponse

    // @DataMember(Order=1)
    public var userName:String?

    // @DataMember(Order=2)
    public var permissions:[String]?

    // @DataMember(Order=3)
    public var roles:[String]?

    // @DataMember(Order=4)
    public var meta:[String:String]?

    required public init(){}
}

public class QueryRockstarAudit : QueryDbTenant<RockstarAuditTenant, RockstarAuto>, IReturn
{
    public typealias Return = QueryResponse<RockstarAuto>

    public var id:Int?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case id
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try container.encode(id, forKey: .id) }
    }
}

public class QueryRockstarAuditSubOr : QueryDb2<RockstarAuditTenant, RockstarAuto>, IReturn
{
    public typealias Return = QueryResponse<RockstarAuto>

    public var firstNameStartsWith:String?
    public var ageOlderThan:Int?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case firstNameStartsWith
        case ageOlderThan
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        firstNameStartsWith = try container.decodeIfPresent(String.self, forKey: .firstNameStartsWith)
        ageOlderThan = try container.decodeIfPresent(Int.self, forKey: .ageOlderThan)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if firstNameStartsWith != nil { try container.encode(firstNameStartsWith, forKey: .firstNameStartsWith) }
        if ageOlderThan != nil { try container.encode(ageOlderThan, forKey: .ageOlderThan) }
    }
}

public class QueryPocoBase : QueryDb<OnlyDefinedInGenericType>, IReturn
{
    public typealias Return = QueryResponse<OnlyDefinedInGenericType>

    public var id:Int?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case id
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try container.encode(id, forKey: .id) }
    }
}

public class QueryPocoIntoBase : QueryDb2<OnlyDefinedInGenericTypeFrom, OnlyDefinedInGenericTypeInto>, IReturn
{
    public typealias Return = QueryResponse<OnlyDefinedInGenericTypeInto>

    public var id:Int?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case id
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try container.encode(id, forKey: .id) }
    }
}

// @Route("/rockstars", "GET")
public class QueryRockstars : QueryDb<Rockstar>, IReturn
{
    public typealias Return = QueryResponse<Rockstar>

    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class CreateRockstarAudit : RockstarBase, IReturn
{
    public typealias Return = RockstarWithIdResponse

    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class CreateRockstarAuditTenant : CreateAuditTenantBase<RockstarAuditTenant, RockstarWithIdAndResultResponse>, IReturn, IHasSessionId
{
    public typealias Return = RockstarWithIdAndResultResponse

    public var sessionId:String?
    public var firstName:String?
    public var lastName:String?
    public var age:Int?
    public var dateOfBirth:Date?
    public var dateDied:Date?
    public var livingStatus:LivingStatus?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case sessionId
        case firstName
        case lastName
        case age
        case dateOfBirth
        case dateDied
        case livingStatus
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        age = try container.decodeIfPresent(Int.self, forKey: .age)
        dateOfBirth = try container.decodeIfPresent(Date.self, forKey: .dateOfBirth)
        dateDied = try container.decodeIfPresent(Date.self, forKey: .dateDied)
        livingStatus = try container.decodeIfPresent(LivingStatus.self, forKey: .livingStatus)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if sessionId != nil { try container.encode(sessionId, forKey: .sessionId) }
        if firstName != nil { try container.encode(firstName, forKey: .firstName) }
        if lastName != nil { try container.encode(lastName, forKey: .lastName) }
        if age != nil { try container.encode(age, forKey: .age) }
        if dateOfBirth != nil { try container.encode(dateOfBirth, forKey: .dateOfBirth) }
        if dateDied != nil { try container.encode(dateDied, forKey: .dateDied) }
        if livingStatus != nil { try container.encode(livingStatus, forKey: .livingStatus) }
    }
}

public class UpdateRockstarAuditTenant : UpdateAuditTenantBase<RockstarAuditTenant, RockstarWithIdAndResultResponse>, IReturn, IHasSessionId
{
    public typealias Return = RockstarWithIdAndResultResponse

    public var sessionId:String?
    public var id:Int?
    public var firstName:String?
    public var livingStatus:LivingStatus?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case sessionId
        case id
        case firstName
        case livingStatus
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        livingStatus = try container.decodeIfPresent(LivingStatus.self, forKey: .livingStatus)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if sessionId != nil { try container.encode(sessionId, forKey: .sessionId) }
        if id != nil { try container.encode(id, forKey: .id) }
        if firstName != nil { try container.encode(firstName, forKey: .firstName) }
        if livingStatus != nil { try container.encode(livingStatus, forKey: .livingStatus) }
    }
}

public class PatchRockstarAuditTenant : PatchAuditTenantBase<RockstarAuditTenant, RockstarWithIdAndResultResponse>, IReturn, IHasSessionId
{
    public typealias Return = RockstarWithIdAndResultResponse

    public var sessionId:String?
    public var id:Int?
    public var firstName:String?
    public var livingStatus:LivingStatus?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case sessionId
        case id
        case firstName
        case livingStatus
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sessionId = try container.decodeIfPresent(String.self, forKey: .sessionId)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        livingStatus = try container.decodeIfPresent(LivingStatus.self, forKey: .livingStatus)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if sessionId != nil { try container.encode(sessionId, forKey: .sessionId) }
        if id != nil { try container.encode(id, forKey: .id) }
        if firstName != nil { try container.encode(firstName, forKey: .firstName) }
        if livingStatus != nil { try container.encode(livingStatus, forKey: .livingStatus) }
    }
}

public class SoftDeleteAuditTenant : SoftDeleteAuditTenantBase<RockstarAuditTenant, RockstarWithIdAndResultResponse>, IReturn
{
    public typealias Return = RockstarWithIdAndResultResponse

    public var id:Int?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case id
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try container.encode(id, forKey: .id) }
    }
}

public class CreateRockstarAuditMqToken : RockstarBase, IReturn, IHasBearerToken
{
    public typealias Return = RockstarWithIdResponse

    public var bearerToken:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case bearerToken
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bearerToken = try container.decodeIfPresent(String.self, forKey: .bearerToken)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if bearerToken != nil { try container.encode(bearerToken, forKey: .bearerToken) }
    }
}

public class RealDeleteAuditTenant : IReturn, IHasSessionId, Codable
{
    public typealias Return = RockstarWithIdAndCountResponse

    public var sessionId:String?
    public var id:Int?
    public var age:Int?

    required public init(){}
}

public class CreateRockstarVersion : RockstarBase, IReturn
{
    public typealias Return = RockstarWithIdAndRowVersionResponse

    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

// @Route("/messages/crud/{Id}", "PUT")
public class MessageCrud : IReturnVoid, Codable
{
    public var id:Int?
    public var name:String?

    required public init(){}
}

// @Route("/access-token")
// @DataContract
public class GetAccessToken : IReturn, IPost, Codable
{
    public typealias Return = GetAccessTokenResponse

    // @DataMember(Order=1)
    public var refreshToken:String?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    required public init(){}
}

public class ChatMessage : Codable
{
    public var id:Int?
    public var channel:String?
    public var fromUserId:String?
    public var fromName:String?
    public var displayName:String?
    public var message:String?
    public var userAuthId:String?
    public var `private`:Bool?

    required public init(){}
}

public class GetChatHistoryResponse : Codable
{
    public var results:[ChatMessage]?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class GetUserDetailsResponse : Codable
{
    public var provider:String?
    public var userId:String?
    public var userName:String?
    public var fullName:String?
    public var displayName:String?
    public var firstName:String?
    public var lastName:String?
    public var company:String?
    public var email:String?
    public var phoneNumber:String?
    public var birthDate:Date?
    public var birthDateRaw:String?
    public var address:String?
    public var address2:String?
    public var city:String?
    public var state:String?
    public var country:String?
    public var culture:String?
    public var gender:String?
    public var language:String?
    public var mailAddress:String?
    public var nickname:String?
    public var postalCode:String?
    public var timeZone:String?

    required public init(){}
}

public class CustomHttpErrorResponse : Codable
{
    public var custom:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class QueryResponseAlt<T : Codable> : Codable
{
    public var offset:Int?
    public var total:Int?
    public var results:[Item] = []
    public var meta:[String:String] = [:]
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class Items : Codable
{
    public var results:[Item] = []

    required public init(){}
}

public class ReturnCustom400Response : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class ThrowTypeResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class ThrowValidationResponse : Codable
{
    public var age:Int?
    public var required:String?
    public var email:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class ThrowBusinessErrorResponse : Codable
{
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class TestFileUploadsResponse : Codable
{
    public var id:Int?
    public var refId:String?
    public var files:[UploadInfo] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class Account : Codable
{
    public var name:String?

    required public init(){}
}

public class Project : Codable
{
    public var account:String?
    public var name:String?

    required public init(){}
}

public class SecuredResponse : Codable
{
    public var result:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class CreateJwtResponse : Codable
{
    public var token:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class CreateRefreshJwtResponse : Codable
{
    public var token:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class MetadataTestResponse : Codable
{
    public var id:Int?
    public var results:[MetadataTestChild] = []

    required public init(){}
}

// @DataContract
public class GetExampleResponse : Codable
{
    // @DataMember(Order=1)
    public var responseStatus:ResponseStatus?

    // @DataMember(Order=2)
    // @ApiMember()
    public var menuExample1:MenuExample?

    required public init(){}
}

public class GetRandomIdsResponse : Codable
{
    public var results:[String] = []

    required public init(){}
}

public class HelloResponse : Codable
{
    public var result:String?

    required public init(){}
}

/**
* Description on HelloAllResponse type
*/
// @DataContract
public class HelloAnnotatedResponse : Codable
{
    // @DataMember
    public var result:String?

    required public init(){}
}

public class HelloAllTypesResponse : Codable
{
    public var result:String?
    public var allTypes:AllTypes?
    public var allCollectionTypes:AllCollectionTypes?

    required public init(){}
}

public class SubAllTypes : AllTypesBase
{
    public var hierarchy:Int?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case hierarchy
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hierarchy = try container.decodeIfPresent(Int.self, forKey: .hierarchy)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if hierarchy != nil { try container.encode(hierarchy, forKey: .hierarchy) }
    }
}

// @DataContract
public class HelloWithDataContractResponse : Codable
{
    // @DataMember(Name="result", Order=1, IsRequired=true, EmitDefaultValue=false)
    public var result:String?

    required public init(){}
}

/**
* Description on HelloWithDescriptionResponse type
*/
public class HelloWithDescriptionResponse : Codable
{
    public var result:String?

    required public init(){}
}

public class HelloWithInheritanceResponse : HelloResponseBase
{
    public var result:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case result
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        result = try container.decodeIfPresent(String.self, forKey: .result)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if result != nil { try container.encode(result, forKey: .result) }
    }
}

public class HelloWithAlternateReturnResponse : HelloWithReturnResponse
{
    public var altResult:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case altResult
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        altResult = try container.decodeIfPresent(String.self, forKey: .altResult)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if altResult != nil { try container.encode(altResult, forKey: .altResult) }
    }
}

public class HelloWithRouteResponse : Codable
{
    public var result:String?

    required public init(){}
}

public class HelloWithTypeResponse : Codable
{
    public var result:HelloType?

    required public init(){}
}

public class HelloInnerTypesResponse : Codable
{
    public var innerType:InnerType?
    public var innerEnum:InnerEnum?

    required public init(){}
}

public class HelloVerbResponse : Codable
{
    public var result:String?

    required public init(){}
}

public class EnumResponse : Codable
{
    public var `operator`:ScopeType?

    required public init(){}
}

// @DataContract
public class HelloZipResponse : Codable
{
    // @DataMember
    public var result:String?

    required public init(){}
}

public class PingResponse : Codable
{
    public var responses:[String:ResponseStatus]?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class RequiresRoleResponse : Codable
{
    public var result:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class SendVerbResponse : Codable
{
    public var id:Int?
    public var pathInfo:String?
    public var requestMethod:String?

    required public init(){}
}

public class GetSessionResponse : Codable
{
    public var result:CustomUserSession?
    public var unAuthInfo:UnAuthInfo?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract(Namespace="http://schemas.servicestack.net/types")
public class GetStuffResponse : Codable
{
    // @DataMember
    public var summaryDate:Date?

    // @DataMember
    public var summaryEndDate:Date?

    // @DataMember
    public var symbol:String?

    // @DataMember
    public var email:String?

    // @DataMember
    public var isEnabled:Bool?

    required public init(){}
}

public class StoreLogsResponse : Codable
{
    public var existingLogs:[Logger] = []
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class TestAuthResponse : Codable
{
    public var userId:String?
    public var sessionId:String?
    public var userName:String?
    public var displayName:String?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class RegisterResponse : IHasSessionId, IHasBearerToken, Codable
{
    // @DataMember(Order=1)
    public var userId:String?

    // @DataMember(Order=2)
    public var sessionId:String?

    // @DataMember(Order=3)
    public var userName:String?

    // @DataMember(Order=4)
    public var referrerUrl:String?

    // @DataMember(Order=5)
    public var bearerToken:String?

    // @DataMember(Order=6)
    public var refreshToken:String?

    // @DataMember(Order=7)
    public var refreshTokenExpiry:Date?

    // @DataMember(Order=8)
    public var roles:[String]?

    // @DataMember(Order=9)
    public var permissions:[String]?

    // @DataMember(Order=10)
    public var redirectUrl:String?

    // @DataMember(Order=11)
    public var responseStatus:ResponseStatus?

    // @DataMember(Order=12)
    public var meta:[String:String]?

    required public init(){}
}

// @DataContract
public class AuthenticateResponse : IHasSessionId, IHasBearerToken, Codable
{
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
    public var bearerToken:String?

    // @DataMember(Order=7)
    public var refreshToken:String?

    // @DataMember(Order=8)
    public var refreshTokenExpiry:Date?

    // @DataMember(Order=9)
    public var profileUrl:String?

    // @DataMember(Order=10)
    public var roles:[String]?

    // @DataMember(Order=11)
    public var permissions:[String]?

    // @DataMember(Order=12)
    public var authProvider:String?

    // @DataMember(Order=13)
    public var responseStatus:ResponseStatus?

    // @DataMember(Order=14)
    public var meta:[String:String]?

    required public init(){}
}

// @DataContract
public class AssignRolesResponse : Codable
{
    // @DataMember(Order=1)
    public var allRoles:[String]?

    // @DataMember(Order=2)
    public var allPermissions:[String]?

    // @DataMember(Order=3)
    public var meta:[String:String]?

    // @DataMember(Order=4)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class UnAssignRolesResponse : Codable
{
    // @DataMember(Order=1)
    public var allRoles:[String]?

    // @DataMember(Order=2)
    public var allPermissions:[String]?

    // @DataMember(Order=3)
    public var meta:[String:String]?

    // @DataMember(Order=4)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class RockstarWithIdResponse : Codable
{
    public var id:Int?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class RockstarWithIdAndResultResponse : Codable
{
    public var id:Int?
    public var result:RockstarAuto?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class RockstarWithIdAndCountResponse : Codable
{
    public var id:Int?
    public var count:Int?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class RockstarWithIdAndRowVersionResponse : Codable
{
    public var id:Int?
    public var rowVersion:UInt32?
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class GetAccessTokenResponse : Codable
{
    // @DataMember(Order=1)
    public var accessToken:String?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    // @DataMember(Order=3)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class Item : Codable
{
    public var name:String?
    public var Description:String?

    required public init(){}
}

public class Poco : Codable
{
    public var name:String?

    required public init(){}
}

public class CustomType : Codable
{
    public var id:Int?
    public var name:String?

    required public init(){}
}

public class SetterType : Codable
{
    public var id:Int?
    public var name:String?

    required public init(){}
}

public class DeclarativeChildValidation : Codable
{
    public var name:String?
    // @Validate(Validator="MaximumLength(20)")
    public var value:String?

    required public init(){}
}

public class FluentChildValidation : Codable
{
    public var name:String?
    public var value:String?

    required public init(){}
}

public class DeclarativeSingleValidation : Codable
{
    public var name:String?
    // @Validate(Validator="MaximumLength(20)")
    public var value:String?

    required public init(){}
}

public class FluentSingleValidation : Codable
{
    public var name:String?
    public var value:String?

    required public init(){}
}

// @DataContract
public class CancelRequest : IPost, Codable
{
    // @DataMember(Order=1)
    public var tag:String?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    required public init(){}
}

// @DataContract
public class CancelRequestResponse : Codable
{
    // @DataMember(Order=1)
    public var tag:String?

    // @DataMember(Order=2)
    @TimeSpan public var elapsed:TimeInterval?

    // @DataMember(Order=3)
    public var meta:[String:String]?

    // @DataMember(Order=4)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class UpdateEventSubscriber : IPost, Codable
{
    // @DataMember(Order=1)
    public var id:String?

    // @DataMember(Order=2)
    public var subscribeChannels:[String]?

    // @DataMember(Order=3)
    public var unsubscribeChannels:[String]?

    required public init(){}
}

// @DataContract
public class UpdateEventSubscriberResponse : Codable
{
    // @DataMember(Order=1)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class GetApiKeys : IGet, Codable
{
    // @DataMember(Order=1)
    public var environment:String?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    required public init(){}
}

// @DataContract
public class GetApiKeysResponse : Codable
{
    // @DataMember(Order=1)
    public var results:[UserApiKey]?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    // @DataMember(Order=3)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class RegenerateApiKeys : IPost, Codable
{
    // @DataMember(Order=1)
    public var environment:String?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    required public init(){}
}

// @DataContract
public class RegenerateApiKeysResponse : Codable
{
    // @DataMember(Order=1)
    public var results:[UserApiKey]?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    // @DataMember(Order=3)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class UserApiKey : Codable
{
    // @DataMember(Order=1)
    public var key:String?

    // @DataMember(Order=2)
    public var keyType:String?

    // @DataMember(Order=3)
    public var expiryDate:Date?

    // @DataMember(Order=4)
    public var meta:[String:String]?

    required public init(){}
}

// @DataContract
public class ConvertSessionToToken : IPost, Codable
{
    // @DataMember(Order=1)
    public var preserveSession:Bool?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    required public init(){}
}

// @DataContract
public class ConvertSessionToTokenResponse : Codable
{
    // @DataMember(Order=1)
    public var meta:[String:String]?

    // @DataMember(Order=2)
    public var accessToken:String?

    // @DataMember(Order=3)
    public var refreshToken:String?

    // @DataMember(Order=4)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public class NavItem : Codable
{
    public var label:String?
    public var href:String?
    public var exact:Bool?
    public var id:String?
    public var className:String?
    public var iconClass:String?
    public var iconSrc:String?
    public var show:String?
    public var hide:String?
    public var children:[NavItem]?
    public var meta:[String:String]?

    required public init(){}
}

// @DataContract
public class GetNavItems : Codable
{
    // @DataMember(Order=1)
    public var name:String?

    required public init(){}
}

// @DataContract
public class GetNavItemsResponse : Codable
{
    // @DataMember(Order=1)
    public var baseUrl:String?

    // @DataMember(Order=2)
    public var results:[NavItem]?

    // @DataMember(Order=3)
    public var navItemsMap:[String:[NavItem]]?

    // @DataMember(Order=4)
    public var meta:[String:String]?

    // @DataMember(Order=5)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class IdResponse : Codable
{
    // @DataMember(Order=1)
    public var id:String?

    // @DataMember(Order=2)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class StringResponse : Codable
{
    // @DataMember(Order=1)
    public var result:String?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    // @DataMember(Order=3)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

// @DataContract
public class StringsResponse : Codable
{
    // @DataMember(Order=1)
    public var results:[String]?

    // @DataMember(Order=2)
    public var meta:[String:String]?

    // @DataMember(Order=3)
    public var responseStatus:ResponseStatus?

    required public init(){}
}

public protocol IAuthTokens
{
    var provider:String? { get set }
    var userId:String? { get set }
    var accessToken:String? { get set }
    var accessTokenSecret:String? { get set }
    var refreshToken:String? { get set }
    var refreshTokenExpiry:Date? { get set }
    var requestToken:String? { get set }
    var requestTokenSecret:String? { get set }
    var items:[String:String]? { get set }

}

// @DataContract
public class AuthUserSession : Codable
{
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
    public var birthDate:Date?

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
    public var createdAt:Date?

    // @DataMember(Order=34)
    public var lastModified:Date?

    // @DataMember(Order=35)
    public var roles:[String]?

    // @DataMember(Order=36)
    public var permissions:[String]?

    // @DataMember(Order=37)
    public var isAuthenticated:Bool?

    // @DataMember(Order=38)
    public var fromToken:Bool?

    // @DataMember(Order=39)
    public var profileUrl:String?

    // @DataMember(Order=40)
    public var sequence:String?

    // @DataMember(Order=41)
    public var tag:Int?

    // @DataMember(Order=42)
    public var authProvider:String?

    //providerOAuthAccess:[IAuthTokens] ignored. Swift doesn't support interface properties

    // @DataMember(Order=44)
    public var meta:[String:String]?

    // @DataMember(Order=45)
    public var audiences:[String]?

    // @DataMember(Order=46)
    public var scopes:[String]?

    // @DataMember(Order=47)
    public var dns:String?

    // @DataMember(Order=48)
    public var rsa:String?

    // @DataMember(Order=49)
    public var sid:String?

    // @DataMember(Order=50)
    public var hash:String?

    // @DataMember(Order=51)
    public var homePhone:String?

    // @DataMember(Order=52)
    public var mobilePhone:String?

    // @DataMember(Order=53)
    public var webpage:String?

    // @DataMember(Order=54)
    public var emailConfirmed:Bool?

    // @DataMember(Order=55)
    public var phoneNumberConfirmed:Bool?

    // @DataMember(Order=56)
    public var twoFactorEnabled:Bool?

    // @DataMember(Order=57)
    public var securityStamp:String?

    // @DataMember(Order=58)
    public var type:String?

    // @DataMember(Order=59)
    public var recoveryToken:String?

    // @DataMember(Order=60)
    public var refId:Int?

    // @DataMember(Order=61)
    public var refIdStr:String?

    required public init(){}
}

public class NestedClass : Codable
{
    public var value:String?

    required public init(){}
}

public enum EnumType : String, Codable
{
    case Value1
    case Value2
    case Value3
}

// @Flags()
public enum EnumTypeFlags : Int, Codable
{
    case Value1 = 0
    case Value2 = 1
    case Value3 = 2
}

public enum EnumWithValues : String, Codable
{
    case None
    case Value1
    case Value2
}

// @Flags()
public enum EnumFlags : Int, Codable
{
    case Value0 = 0
    case Value1 = 1
    case Value2 = 2
    case Value3 = 4
    case Value123 = 7
}

public enum EnumAsInt : Int, Codable
{
    case Value1 = 1000
    case Value2 = 2000
    case Value3 = 3000
}

public enum EnumStyle : String, Codable
{
    case lower
    case UPPER
    case PascalCase
    case camelCase
    case camelUPPER
    case PascalUPPER
}

public enum EnumStyleMembers : String, Codable
{
    case Lower
    case Upper
    case PascalCase
    case CamelCase
    case CamelUpper
    case PascalUpper
}

public class KeyValuePair<TKey : Codable, TValue : Codable> : Codable
{
    public var key:TKey?
    public var value:TValue?

    required public init(){}
}

public class SubType : Codable
{
    public var id:Int?
    public var name:String?

    required public init(){}
}

public class AllTypesBase : Codable
{
    public var id:Int?
    public var nullableId:Int?
    public var byte:UInt8?
    public var short:Int16?
    public var int:Int?
    public var long:Int?
    public var uShort:UInt16?
    public var uInt:UInt32?
    public var uLong:UInt64?
    public var float:Float?
    public var double:Double?
    public var decimal:Double?
    public var string:String?
    public var dateTime:Date?
    @TimeSpan public var timeSpan:TimeInterval?
    public var dateTimeOffset:Date?
    public var guid:String?
    public var char:String?
    public var keyValuePair:KeyValuePair<String, String>?
    public var nullableDateTime:Date?
    @TimeSpan public var nullableTimeSpan:TimeInterval?
    public var stringList:[String] = []
    public var stringArray:[String] = []
    public var stringMap:[String:String] = [:]
    public var intStringMap:[Int:String] = [:]
    public var subType:SubType?

    required public init(){}

    private enum CodingKeys : String, CodingKey {
        case id
        case nullableId
        case byte
        case short
        case int
        case long
        case uShort
        case uInt
        case uLong
        case float
        case double
        case decimal
        case string
        case dateTime
        case timeSpan
        case dateTimeOffset
        case guid
        case char
        case keyValuePair
        case nullableDateTime
        case nullableTimeSpan
        case stringList
        case stringArray
        case stringMap
        case intStringMap
        case subType
    }

    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        nullableId = try container.decodeIfPresent(Int.self, forKey: .nullableId)
        byte = try container.decodeIfPresent(UInt8.self, forKey: .byte)
        short = try container.decodeIfPresent(Int16.self, forKey: .short)
        int = try container.decodeIfPresent(Int.self, forKey: .int)
        long = try container.decodeIfPresent(Int.self, forKey: .long)
        uShort = try container.decodeIfPresent(UInt16.self, forKey: .uShort)
        uInt = try container.decodeIfPresent(UInt32.self, forKey: .uInt)
        uLong = try container.decodeIfPresent(UInt64.self, forKey: .uLong)
        float = try container.decodeIfPresent(Float.self, forKey: .float)
        double = try container.decodeIfPresent(Double.self, forKey: .double)
        decimal = try container.decodeIfPresent(Double.self, forKey: .decimal)
        string = try container.decodeIfPresent(String.self, forKey: .string)
        dateTime = try container.decodeIfPresent(Date.self, forKey: .dateTime)
        timeSpan = try container.convertIfPresent(TimeInterval.self, forKey: .timeSpan)
        dateTimeOffset = try container.decodeIfPresent(Date.self, forKey: .dateTimeOffset)
        guid = try container.decodeIfPresent(String.self, forKey: .guid)
        char = try container.decodeIfPresent(String.self, forKey: .char)
        keyValuePair = try container.decodeIfPresent(KeyValuePair<String, String>.self, forKey: .keyValuePair)
        nullableDateTime = try container.decodeIfPresent(Date.self, forKey: .nullableDateTime)
        nullableTimeSpan = try container.convertIfPresent(TimeInterval.self, forKey: .nullableTimeSpan)
        stringList = try container.decodeIfPresent([String].self, forKey: .stringList) ?? []
        stringArray = try container.decodeIfPresent([String].self, forKey: .stringArray) ?? []
        stringMap = try container.decodeIfPresent([String:String].self, forKey: .stringMap) ?? [:]
        intStringMap = try container.decodeIfPresent([Int:String].self, forKey: .intStringMap) ?? [:]
        subType = try container.decodeIfPresent(SubType.self, forKey: .subType)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try container.encode(id, forKey: .id) }
        if nullableId != nil { try container.encode(nullableId, forKey: .nullableId) }
        if byte != nil { try container.encode(byte, forKey: .byte) }
        if short != nil { try container.encode(short, forKey: .short) }
        if int != nil { try container.encode(int, forKey: .int) }
        if long != nil { try container.encode(long, forKey: .long) }
        if uShort != nil { try container.encode(uShort, forKey: .uShort) }
        if uInt != nil { try container.encode(uInt, forKey: .uInt) }
        if uLong != nil { try container.encode(uLong, forKey: .uLong) }
        if float != nil { try container.encode(float, forKey: .float) }
        if double != nil { try container.encode(double, forKey: .double) }
        if decimal != nil { try container.encode(decimal, forKey: .decimal) }
        if string != nil { try container.encode(string, forKey: .string) }
        if dateTime != nil { try container.encode(dateTime, forKey: .dateTime) }
        if timeSpan != nil { try container.encode(timeSpan, forKey: .timeSpan) }
        if dateTimeOffset != nil { try container.encode(dateTimeOffset, forKey: .dateTimeOffset) }
        if guid != nil { try container.encode(guid, forKey: .guid) }
        if char != nil { try container.encode(char, forKey: .char) }
        if keyValuePair != nil { try container.encode(keyValuePair, forKey: .keyValuePair) }
        if nullableDateTime != nil { try container.encode(nullableDateTime, forKey: .nullableDateTime) }
        if nullableTimeSpan != nil { try container.encode(nullableTimeSpan, forKey: .nullableTimeSpan) }
        if stringList.count > 0 { try container.encode(stringList, forKey: .stringList) }
        if stringArray.count > 0 { try container.encode(stringArray, forKey: .stringArray) }
        if stringMap.count > 0 { try container.encode(stringMap, forKey: .stringMap) }
        if intStringMap.count > 0 { try container.encode(intStringMap, forKey: .intStringMap) }
        if subType != nil { try container.encode(subType, forKey: .subType) }
    }
}

public class HelloBase : Codable
{
    public var id:Int?

    required public init(){}
}

public class HelloBase_1<T : Codable> : Codable
{
    public var items:[T] = []
    public var counts:[Int] = []

    required public init(){}
}

public protocol IPoco
{
    var name:String? { get set }

}

public protocol IEmptyInterface
{
}

public class EmptyClass : Codable
{
    required public init(){}
}

public enum DayOfWeek : String, Codable
{
    case Sunday
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
}

// @DataContract
public enum ScopeType : Int, Codable
{
    case Global = 1
    case Sale = 2
}

public class Logger : Codable
{
    public var id:Int?
    public var devices:[Device] = []

    required public init(){}
}

public class Rockstar : Codable
{
    public var id:Int?
    public var firstName:String?
    public var lastName:String?
    public var age:Int?

    required public init(){}
}

public class QueryDbTenant<From : Codable, Into : Codable> : QueryDb2<From, Into>
{
    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class RockstarAuditTenant : AuditBase
{
    public var tenantId:Int?
    public var id:Int?
    public var firstName:String?
    public var lastName:String?
    public var age:Int?
    public var dateOfBirth:Date?
    public var dateDied:Date?
    public var livingStatus:LivingStatus?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case tenantId
        case id
        case firstName
        case lastName
        case age
        case dateOfBirth
        case dateDied
        case livingStatus
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tenantId = try container.decodeIfPresent(Int.self, forKey: .tenantId)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        age = try container.decodeIfPresent(Int.self, forKey: .age)
        dateOfBirth = try container.decodeIfPresent(Date.self, forKey: .dateOfBirth)
        dateDied = try container.decodeIfPresent(Date.self, forKey: .dateDied)
        livingStatus = try container.decodeIfPresent(LivingStatus.self, forKey: .livingStatus)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if tenantId != nil { try container.encode(tenantId, forKey: .tenantId) }
        if id != nil { try container.encode(id, forKey: .id) }
        if firstName != nil { try container.encode(firstName, forKey: .firstName) }
        if lastName != nil { try container.encode(lastName, forKey: .lastName) }
        if age != nil { try container.encode(age, forKey: .age) }
        if dateOfBirth != nil { try container.encode(dateOfBirth, forKey: .dateOfBirth) }
        if dateDied != nil { try container.encode(dateDied, forKey: .dateDied) }
        if livingStatus != nil { try container.encode(livingStatus, forKey: .livingStatus) }
    }
}

public class RockstarAuto : RockstarBase
{
    public var id:Int?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case id
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try container.encode(id, forKey: .id) }
    }
}

public class OnlyDefinedInGenericType : Codable
{
    public var id:Int?
    public var name:String?

    required public init(){}
}

public class OnlyDefinedInGenericTypeFrom : Codable
{
    public var id:Int?
    public var name:String?

    required public init(){}
}

public class OnlyDefinedInGenericTypeInto : Codable
{
    public var id:Int?
    public var name:String?

    required public init(){}
}

public enum LivingStatus : String, Codable
{
    case Alive
    case Dead
}

public class RockstarBase : Codable
{
    public var firstName:String?
    public var lastName:String?
    public var age:Int?
    public var dateOfBirth:Date?
    public var dateDied:Date?
    public var livingStatus:LivingStatus?

    required public init(){}
}

public class RockstarAudit : RockstarBase
{
    public var id:Int?
    public var createdDate:Date?
    public var createdBy:String?
    public var createdInfo:String?
    public var modifiedDate:Date?
    public var modifiedBy:String?
    public var modifiedInfo:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case id
        case createdDate
        case createdBy
        case createdInfo
        case modifiedDate
        case modifiedBy
        case modifiedInfo
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        createdDate = try container.decodeIfPresent(Date.self, forKey: .createdDate)
        createdBy = try container.decodeIfPresent(String.self, forKey: .createdBy)
        createdInfo = try container.decodeIfPresent(String.self, forKey: .createdInfo)
        modifiedDate = try container.decodeIfPresent(Date.self, forKey: .modifiedDate)
        modifiedBy = try container.decodeIfPresent(String.self, forKey: .modifiedBy)
        modifiedInfo = try container.decodeIfPresent(String.self, forKey: .modifiedInfo)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try container.encode(id, forKey: .id) }
        if createdDate != nil { try container.encode(createdDate, forKey: .createdDate) }
        if createdBy != nil { try container.encode(createdBy, forKey: .createdBy) }
        if createdInfo != nil { try container.encode(createdInfo, forKey: .createdInfo) }
        if modifiedDate != nil { try container.encode(modifiedDate, forKey: .modifiedDate) }
        if modifiedBy != nil { try container.encode(modifiedBy, forKey: .modifiedBy) }
        if modifiedInfo != nil { try container.encode(modifiedInfo, forKey: .modifiedInfo) }
    }
}

public class CreateAuditTenantBase<Table : Codable, TResponse : Codable> : CreateAuditBase<Table, TResponse>
{
    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class UpdateAuditTenantBase<Table : Codable, TResponse : Codable> : UpdateAuditBase<Table, TResponse>
{
    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class PatchAuditTenantBase<Table : Codable, TResponse : Codable> : PatchAuditBase<Table, TResponse>
{
    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class SoftDeleteAuditTenantBase<Table : Codable, TResponse : Codable> : SoftDeleteAuditBase<Table, TResponse>
{
    required public init(){ super.init() }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
    }
}

public class RockstarVersion : RockstarBase
{
    public var id:Int?
    public var rowVersion:UInt64?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case id
        case rowVersion
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        rowVersion = try container.decodeIfPresent(UInt64.self, forKey: .rowVersion)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if id != nil { try container.encode(id, forKey: .id) }
        if rowVersion != nil { try container.encode(rowVersion, forKey: .rowVersion) }
    }
}

public class UploadInfo : Codable
{
    public var name:String?
    public var fileName:String?
    public var contentLength:Int?
    public var contentType:String?

    required public init(){}
}

public class MetadataTestChild : Codable
{
    public var name:String?
    public var results:[MetadataTestNestedChild] = []

    required public init(){}
}

// @DataContract
public class MenuExample : Codable
{
    // @DataMember(Order=1)
    // @ApiMember()
    public var menuItemExample1:MenuItemExample?

    required public init(){}
}

public class ListResult : Codable
{
    public var result:String?

    required public init(){}
}

public class ArrayResult : Codable
{
    public var result:String?

    required public init(){}
}

public class HelloResponseBase : Codable
{
    public var refId:Int?

    required public init(){}
}

public class HelloWithReturnResponse : Codable
{
    public var result:String?

    required public init(){}
}

public class HelloType : Codable
{
    public var result:String?

    required public init(){}
}

public class InnerType : Codable
{
    public var id:Int?
    public var name:String?

    required public init(){}
}

public enum InnerEnum : String, Codable
{
    case Foo
    case Bar
    case Baz
}

public class ReturnedDto : Codable
{
    public var id:Int?

    required public init(){}
}

public class CustomUserSession : AuthUserSession
{
    // @DataMember
    public var customName:String?

    // @DataMember
    public var customInfo:String?

    required public init(){ super.init() }

    private enum CodingKeys : String, CodingKey {
        case customName
        case customInfo
    }

    required public init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        customName = try container.decodeIfPresent(String.self, forKey: .customName)
        customInfo = try container.decodeIfPresent(String.self, forKey: .customInfo)
    }

    public override func encode(to encoder: Encoder) throws {
        try super.encode(to: encoder)
        var container = encoder.container(keyedBy: CodingKeys.self)
        if customName != nil { try container.encode(customName, forKey: .customName) }
        if customInfo != nil { try container.encode(customInfo, forKey: .customInfo) }
    }
}

public class UnAuthInfo : Codable
{
    public var customInfo:String?

    required public init(){}
}

public class Device : Codable
{
    public var id:Int?
    public var type:String?
    public var timeStamp:Int?
    public var channels:[Channel] = []

    required public init(){}
}

public class CreateAuditBase<Table : Codable, TResponse : Codable> : Codable
{
    required public init(){}
}

public class UpdateAuditBase<Table : Codable, TResponse : Codable> : Codable
{
    required public init(){}
}

public class PatchAuditBase<Table : Codable, TResponse : Codable> : Codable
{
    required public init(){}
}

public class SoftDeleteAuditBase<Table : Codable, TResponse : Codable> : Codable
{
    required public init(){}
}

public class MetadataTestNestedChild : Codable
{
    public var name:String?

    required public init(){}
}

public class MenuItemExample : Codable
{
    // @DataMember(Order=1)
    // @ApiMember()
    public var name1:String?

    public var menuItemExampleItem:MenuItemExampleItem?

    required public init(){}
}

public class TypesGroup : Codable
{
    required public init(){}
}

public class Channel : Codable
{
    public var name:String?
    public var value:String?

    required public init(){}
}

public class MenuItemExampleItem : Codable
{
    // @DataMember(Order=1)
    // @ApiMember()
    public var name1:String?

    required public init(){}
}



#if false

/* Options:
Date: 2015-01-26 08:25:41
Version: 1
BaseUrl: http://test.servicestack.net

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
    public var dateTime:String?
    public var timeSpan:String?
    public var nullableDateTime:String?
    public var nullableTimeSpan:String?
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

public class HelloBase_1<T>
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

public class CustomHttpError : IReturn
{
    typealias Return = CustomHttpError

    required public init(){}
    public var statusCode:Int?
    public var statusDescription:String?
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
    typealias Return = ExternalOperation3

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
public class MetadataTestArray : IReturn
{
    typealias Return = [MetadataTestChild]

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
    typealias Return = GetRandomIds

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

public class HelloList : IReturn
{
    typealias Return = [ListResult]

    required public init(){}
    public var names:[String] = []
}

public class HelloArray : IReturn
{
    typealias Return = [ArrayResult]

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
// @ApiResponse(400, "Your request was not understood")
// @Api("AllowedAttributes Description")
// @DataContract
public class AllowedAttributes
{
    required public init(){}
    // @Default(5)
    // @Required()
    public var id:Int?

    // @DataMember(Name="Aliased")
    // @ApiMember(ParameterType="path", Description="Range Description", DataType="double", IsRequired=true)
    public var range:Double?

    // @References(typeof(Hello))
    // @StringLength(20)
    // @Meta("Foo", "Bar")
    public var name:String?
}

public class HelloAllTypes : IReturn
{
    typealias Return = HelloAllTypes

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
    typealias Return = HelloWithDataContract

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
    typealias Return = HelloWithDescription

    required public init(){}
    public var name:String?
}

public class HelloWithInheritance : HelloBase, IReturn
{
    typealias Return = HelloWithInheritance

    required public init(){}
    public var name:String?
}

public class HelloWithGenericInheritance<Poco> : HelloBase_1<Poco>
{
    required public init(){}
    public var result:String?
}

public class HelloWithGenericInheritance2<Hello> : HelloBase_1<Hello>
{
    required public init(){}
    public var result:String?
}

public class HelloWithNestedInheritance<Item> : HelloBase_1<Item>
{
    required public init(){}
}

public class HelloWithListInheritance<InheritedItem> : List<InheritedItem>
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
    typealias Return = HelloWithRoute

    required public init(){}
    public var name:String?
}

public class HelloWithType : IReturn
{
    typealias Return = HelloWithType

    required public init(){}
    public var name:String?
}

public class HelloInterface
{
    required public init(){}
    public var poco:IPoco?
    public var emptyInterface:IEmptyInterface?
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
    typealias Return = Ping

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
    typealias Return = RequiresRole

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


extension ExternalEnum : StringSerializable
{
    public func toString() -> String
    {
        switch self {
        case .Foo: return "Foo"
        case .Bar: return "Bar"
        case .Baz: return "Baz"
        }
    }

    public static func fromString(strValue:String) -> ExternalEnum?
    {
        switch strValue {
        case "Foo": return .Foo
        case "Bar": return .Bar
        case "Baz": return .Baz
        default: return nil
        }
    }
}

extension ExternalType : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ExternalType>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ExternalType>(
            writers: [
                ("externalEnum2", { (x:ExternalType, map:NSDictionary) in setOptionalValue(&x.externalEnum2, map, "externalEnum2") }),
            ],
            readers: [
                ("externalEnum2", Type<ExternalType>.value { $0.externalEnum2 }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ExternalType.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ExternalType
    {
        return populate(ExternalType(), map, ExternalType.typeConfig())
    }

    public class func fromJson(json:String) -> ExternalType
    {
        return populate(ExternalType(), json, ExternalType.typeConfig())
    }
}

extension ExternalEnum3 : StringSerializable
{
    public func toString() -> String
    {
        switch self {
        case .Un: return "Un"
        case .Deux: return "Deux"
        case .Trois: return "Trois"
        }
    }

    public static func fromString(strValue:String) -> ExternalEnum3?
    {
        switch strValue {
        case "Un": return .Un
        case "Deux": return .Deux
        case "Trois": return .Trois
        default: return nil
        }
    }
}

extension MetadataTestChild : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<MetadataTestChild>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<MetadataTestChild>(
            writers: [
                ("name", { (x:MetadataTestChild, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("results", { (x:MetadataTestChild, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("name", Type<MetadataTestChild>.value { $0.name }),
                ("results", Type<MetadataTestChild>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, MetadataTestChild.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> MetadataTestChild
    {
        return populate(MetadataTestChild(), map, MetadataTestChild.typeConfig())
    }

    public class func fromJson(json:String) -> MetadataTestChild
    {
        return populate(MetadataTestChild(), json, MetadataTestChild.typeConfig())
    }
}

extension MenuExample : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<MenuExample>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<MenuExample>(
            writers: [
                ("menuItemExample1", { (x:MenuExample, map:NSDictionary) in setOptionalValue(&x.menuItemExample1, map, "menuItemExample1") }),
            ],
            readers: [
                ("menuItemExample1", Type<MenuExample>.value { $0.menuItemExample1 }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, MenuExample.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> MenuExample
    {
        return populate(MenuExample(), map, MenuExample.typeConfig())
    }

    public class func fromJson(json:String) -> MenuExample
    {
        return populate(MenuExample(), json, MenuExample.typeConfig())
    }
}

extension NestedClass : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<NestedClass>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<NestedClass>(
            writers: [
                ("value", { (x:NestedClass, map:NSDictionary) in setOptionalValue(&x.value, map, "value") }),
            ],
            readers: [
                ("value", Type<NestedClass>.value { $0.value }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, NestedClass.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> NestedClass
    {
        return populate(NestedClass(), map, NestedClass.typeConfig())
    }

    public class func fromJson(json:String) -> NestedClass
    {
        return populate(NestedClass(), json, NestedClass.typeConfig())
    }
}

extension ListResult : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ListResult>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ListResult>(
            writers: [
                ("result", { (x:ListResult, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<ListResult>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ListResult.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ListResult
    {
        return populate(ListResult(), map, ListResult.typeConfig())
    }

    public class func fromJson(json:String) -> ListResult
    {
        return populate(ListResult(), json, ListResult.typeConfig())
    }
}

extension ArrayResult : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ArrayResult>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ArrayResult>(
            writers: [
                ("result", { (x:ArrayResult, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<ArrayResult>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ArrayResult.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ArrayResult
    {
        return populate(ArrayResult(), map, ArrayResult.typeConfig())
    }

    public class func fromJson(json:String) -> ArrayResult
    {
        return populate(ArrayResult(), json, ArrayResult.typeConfig())
    }
}

extension EnumType : StringSerializable
{
    public func toString() -> String
    {
        switch self {
        case .Value1: return "Value1"
        case .Value2: return "Value2"
        }
    }

    public static func fromString(strValue:String) -> EnumType?
    {
        switch strValue {
        case "Value1": return .Value1
        case "Value2": return .Value2
        default: return nil
        }
    }
}

extension EnumFlags : StringSerializable
{
    public func toString() -> String
    {
        switch self {
        case .Value1: return "Value1"
        case .Value2: return "Value2"
        case .Value3: return "Value3"
        }
    }

    public static func fromString(strValue:String) -> EnumFlags?
    {
        switch strValue {
        case "Value1": return .Value1
        case "Value2": return .Value2
        case "Value3": return .Value3
        default: return nil
        }
    }
}

extension AllTypes : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<AllTypes>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<AllTypes>(
            writers: [
                ("id", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("nullableId", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.nullableId, map, "nullableId") }),
                ("byte", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.byte, map, "byte") }),
                ("short", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.short, map, "short") }),
                ("int", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.int, map, "int") }),
                ("long", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.long, map, "long") }),
                ("uShort", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.uShort, map, "uShort") }),
                ("uInt", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.uInt, map, "uInt") }),
                ("uLong", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.uLong, map, "uLong") }),
                ("float", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.float, map, "float") }),
                ("double", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.double, map, "double") }),
                ("decimal", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.decimal, map, "decimal") }),
                ("string", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.string, map, "string") }),
                ("dateTime", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.dateTime, map, "dateTime") }),
                ("timeSpan", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.timeSpan, map, "timeSpan") }),
                ("nullableDateTime", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.nullableDateTime, map, "nullableDateTime") }),
                ("nullableTimeSpan", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.nullableTimeSpan, map, "nullableTimeSpan") }),
                ("stringList", { (x:AllTypes, map:NSDictionary) in setValue(&x.stringList, map, "stringList") }),
                ("stringArray", { (x:AllTypes, map:NSDictionary) in setValue(&x.stringArray, map, "stringArray") }),
                ("stringMap", { (x:AllTypes, map:NSDictionary) in setValue(&x.stringMap, map, "stringMap") }),
                ("intStringMap", { (x:AllTypes, map:NSDictionary) in setValue(&x.intStringMap, map, "intStringMap") }),
                ("subType", { (x:AllTypes, map:NSDictionary) in setOptionalValue(&x.subType, map, "subType") }),
            ],
            readers: [
                ("id", Type<AllTypes>.value { $0.id }),
                ("nullableId", Type<AllTypes>.value { $0.nullableId }),
                ("byte", Type<AllTypes>.value { $0.byte }),
                ("short", Type<AllTypes>.value { $0.short }),
                ("int", Type<AllTypes>.value { $0.int }),
                ("long", Type<AllTypes>.value { $0.long }),
                ("uShort", Type<AllTypes>.value { $0.uShort }),
                ("uInt", Type<AllTypes>.value { $0.uInt }),
                ("uLong", Type<AllTypes>.value { $0.uLong }),
                ("float", Type<AllTypes>.value { $0.float }),
                ("double", Type<AllTypes>.value { $0.double }),
                ("decimal", Type<AllTypes>.value { $0.decimal }),
                ("string", Type<AllTypes>.value { $0.string }),
                ("dateTime", Type<AllTypes>.value { $0.dateTime }),
                ("timeSpan", Type<AllTypes>.value { $0.timeSpan }),
                ("nullableDateTime", Type<AllTypes>.value { $0.nullableDateTime }),
                ("nullableTimeSpan", Type<AllTypes>.value { $0.nullableTimeSpan }),
                ("stringList", Type<AllTypes>.value { $0.stringList }),
                ("stringArray", Type<AllTypes>.value { $0.stringArray }),
                ("stringMap", Type<AllTypes>.value { $0.stringMap }),
                ("intStringMap", Type<AllTypes>.value { $0.intStringMap }),
                ("subType", Type<AllTypes>.value { $0.subType }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, AllTypes.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> AllTypes
    {
        return populate(AllTypes(), map, AllTypes.typeConfig())
    }

    public class func fromJson(json:String) -> AllTypes
    {
        return populate(AllTypes(), json, AllTypes.typeConfig())
    }
}

extension AllCollectionTypes : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<AllCollectionTypes>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<AllCollectionTypes>(
            writers: [
                ("intArray", { (x:AllCollectionTypes, map:NSDictionary) in setValue(&x.intArray, map, "intArray") }),
                ("intList", { (x:AllCollectionTypes, map:NSDictionary) in setValue(&x.intList, map, "intList") }),
                ("stringArray", { (x:AllCollectionTypes, map:NSDictionary) in setValue(&x.stringArray, map, "stringArray") }),
                ("stringList", { (x:AllCollectionTypes, map:NSDictionary) in setValue(&x.stringList, map, "stringList") }),
                ("pocoArray", { (x:AllCollectionTypes, map:NSDictionary) in setValue(&x.pocoArray, map, "pocoArray") }),
                ("pocoList", { (x:AllCollectionTypes, map:NSDictionary) in setValue(&x.pocoList, map, "pocoList") }),
                ("pocoLookup", { (x:AllCollectionTypes, map:NSDictionary) in setValue(&x.pocoLookup, map, "pocoLookup") }),
                ("pocoLookupMap", { (x:AllCollectionTypes, map:NSDictionary) in setValue(&x.pocoLookupMap, map, "pocoLookupMap") }),
            ],
            readers: [
                ("intArray", Type<AllCollectionTypes>.value { $0.intArray }),
                ("intList", Type<AllCollectionTypes>.value { $0.intList }),
                ("stringArray", Type<AllCollectionTypes>.value { $0.stringArray }),
                ("stringList", Type<AllCollectionTypes>.value { $0.stringList }),
                ("pocoArray", Type<AllCollectionTypes>.value { $0.pocoArray }),
                ("pocoList", Type<AllCollectionTypes>.value { $0.pocoList }),
                ("pocoLookup", Type<AllCollectionTypes>.value { $0.pocoLookup }),
                ("pocoLookupMap", Type<AllCollectionTypes>.value { $0.pocoLookupMap }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, AllCollectionTypes.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> AllCollectionTypes
    {
        return populate(AllCollectionTypes(), map, AllCollectionTypes.typeConfig())
    }

    public class func fromJson(json:String) -> AllCollectionTypes
    {
        return populate(AllCollectionTypes(), json, AllCollectionTypes.typeConfig())
    }
}

extension Poco : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<Poco>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Poco>(
            writers: [
                ("name", { (x:Poco, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<Poco>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, Poco.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> Poco
    {
        return populate(Poco(), map, Poco.typeConfig())
    }

    public class func fromJson(json:String) -> Poco
    {
        return populate(Poco(), json, Poco.typeConfig())
    }
}

extension Item : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<Item>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Item>(
            writers: [
                ("value", { (x:Item, map:NSDictionary) in setOptionalValue(&x.value, map, "value") }),
            ],
            readers: [
                ("value", Type<Item>.value { $0.value }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, Item.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> Item
    {
        return populate(Item(), map, Item.typeConfig())
    }

    public class func fromJson(json:String) -> Item
    {
        return populate(Item(), json, Item.typeConfig())
    }
}

extension InheritedItem : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<InheritedItem>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<InheritedItem>(
            writers: [
                ("name", { (x:InheritedItem, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<InheritedItem>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, InheritedItem.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> InheritedItem
    {
        return populate(InheritedItem(), map, InheritedItem.typeConfig())
    }

    public class func fromJson(json:String) -> InheritedItem
    {
        return populate(InheritedItem(), json, InheritedItem.typeConfig())
    }
}

extension HelloType : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloType>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloType>(
            writers: [
                ("result", { (x:HelloType, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<HelloType>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloType.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloType
    {
        return populate(HelloType(), map, HelloType.typeConfig())
    }

    public class func fromJson(json:String) -> HelloType
    {
        return populate(HelloType(), json, HelloType.typeConfig())
    }
}

extension EmptyClass : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<EmptyClass>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<EmptyClass>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, EmptyClass.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> EmptyClass
    {
        return populate(EmptyClass(), map, EmptyClass.typeConfig())
    }

    public class func fromJson(json:String) -> EmptyClass
    {
        return populate(EmptyClass(), json, EmptyClass.typeConfig())
    }
}

extension InnerType : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<InnerType>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<InnerType>(
            writers: [
                ("id", { (x:InnerType, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:InnerType, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("id", Type<InnerType>.value { $0.id }),
                ("name", Type<InnerType>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, InnerType.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> InnerType
    {
        return populate(InnerType(), map, InnerType.typeConfig())
    }

    public class func fromJson(json:String) -> InnerType
    {
        return populate(InnerType(), json, InnerType.typeConfig())
    }
}

extension InnerEnum : StringSerializable
{
    public func toString() -> String
    {
        switch self {
        case .Foo: return "Foo"
        case .Bar: return "Bar"
        case .Baz: return "Baz"
        }
    }

    public static func fromString(strValue:String) -> InnerEnum?
    {
        switch strValue {
        case "Foo": return .Foo
        case "Bar": return .Bar
        case "Baz": return .Baz
        default: return nil
        }
    }
}

extension PingService : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<PingService>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<PingService>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, PingService.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> PingService
    {
        return populate(PingService(), map, PingService.typeConfig())
    }

    public class func fromJson(json:String) -> PingService
    {
        return populate(PingService(), json, PingService.typeConfig())
    }
}

extension CustomUserSession : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<CustomUserSession>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<CustomUserSession>(
            writers: [
                ("referrerUrl", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.referrerUrl, map, "referrerUrl") }),
                ("id", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("userAuthId", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.userAuthId, map, "userAuthId") }),
                ("userAuthName", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.userAuthName, map, "userAuthName") }),
                ("userName", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.userName, map, "userName") }),
                ("twitterUserId", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.twitterUserId, map, "twitterUserId") }),
                ("twitterScreenName", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.twitterScreenName, map, "twitterScreenName") }),
                ("facebookUserId", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.facebookUserId, map, "facebookUserId") }),
                ("facebookUserName", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.facebookUserName, map, "facebookUserName") }),
                ("firstName", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.firstName, map, "firstName") }),
                ("lastName", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.lastName, map, "lastName") }),
                ("displayName", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.displayName, map, "displayName") }),
                ("company", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.company, map, "company") }),
                ("email", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.email, map, "email") }),
                ("primaryEmail", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.primaryEmail, map, "primaryEmail") }),
                ("phoneNumber", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.phoneNumber, map, "phoneNumber") }),
                ("birthDate", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.birthDate, map, "birthDate") }),
                ("birthDateRaw", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.birthDateRaw, map, "birthDateRaw") }),
                ("address", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.address, map, "address") }),
                ("address2", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.address2, map, "address2") }),
                ("city", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.city, map, "city") }),
                ("state", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.state, map, "state") }),
                ("country", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.country, map, "country") }),
                ("culture", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.culture, map, "culture") }),
                ("fullName", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.fullName, map, "fullName") }),
                ("gender", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.gender, map, "gender") }),
                ("language", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.language, map, "language") }),
                ("mailAddress", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.mailAddress, map, "mailAddress") }),
                ("nickname", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.nickname, map, "nickname") }),
                ("postalCode", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.postalCode, map, "postalCode") }),
                ("timeZone", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.timeZone, map, "timeZone") }),
                ("requestTokenSecret", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.requestTokenSecret, map, "requestTokenSecret") }),
                ("createdAt", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.createdAt, map, "createdAt") }),
                ("lastModified", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.lastModified, map, "lastModified") }),
                ("providerOAuthAccess", { (x:CustomUserSession, map:NSDictionary) in setValue(&x.providerOAuthAccess, map, "providerOAuthAccess") }),
                ("roles", { (x:CustomUserSession, map:NSDictionary) in setValue(&x.roles, map, "roles") }),
                ("permissions", { (x:CustomUserSession, map:NSDictionary) in setValue(&x.permissions, map, "permissions") }),
                ("isAuthenticated", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.isAuthenticated, map, "isAuthenticated") }),
                ("sequence", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.sequence, map, "sequence") }),
                ("tag", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.tag, map, "tag") }),
                ("customName", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.customName, map, "customName") }),
                ("customInfo", { (x:CustomUserSession, map:NSDictionary) in setOptionalValue(&x.customInfo, map, "customInfo") }),
            ],
            readers: [
                ("referrerUrl", Type<CustomUserSession>.value { $0.referrerUrl }),
                ("id", Type<CustomUserSession>.value { $0.id }),
                ("userAuthId", Type<CustomUserSession>.value { $0.userAuthId }),
                ("userAuthName", Type<CustomUserSession>.value { $0.userAuthName }),
                ("userName", Type<CustomUserSession>.value { $0.userName }),
                ("twitterUserId", Type<CustomUserSession>.value { $0.twitterUserId }),
                ("twitterScreenName", Type<CustomUserSession>.value { $0.twitterScreenName }),
                ("facebookUserId", Type<CustomUserSession>.value { $0.facebookUserId }),
                ("facebookUserName", Type<CustomUserSession>.value { $0.facebookUserName }),
                ("firstName", Type<CustomUserSession>.value { $0.firstName }),
                ("lastName", Type<CustomUserSession>.value { $0.lastName }),
                ("displayName", Type<CustomUserSession>.value { $0.displayName }),
                ("company", Type<CustomUserSession>.value { $0.company }),
                ("email", Type<CustomUserSession>.value { $0.email }),
                ("primaryEmail", Type<CustomUserSession>.value { $0.primaryEmail }),
                ("phoneNumber", Type<CustomUserSession>.value { $0.phoneNumber }),
                ("birthDate", Type<CustomUserSession>.value { $0.birthDate }),
                ("birthDateRaw", Type<CustomUserSession>.value { $0.birthDateRaw }),
                ("address", Type<CustomUserSession>.value { $0.address }),
                ("address2", Type<CustomUserSession>.value { $0.address2 }),
                ("city", Type<CustomUserSession>.value { $0.city }),
                ("state", Type<CustomUserSession>.value { $0.state }),
                ("country", Type<CustomUserSession>.value { $0.country }),
                ("culture", Type<CustomUserSession>.value { $0.culture }),
                ("fullName", Type<CustomUserSession>.value { $0.fullName }),
                ("gender", Type<CustomUserSession>.value { $0.gender }),
                ("language", Type<CustomUserSession>.value { $0.language }),
                ("mailAddress", Type<CustomUserSession>.value { $0.mailAddress }),
                ("nickname", Type<CustomUserSession>.value { $0.nickname }),
                ("postalCode", Type<CustomUserSession>.value { $0.postalCode }),
                ("timeZone", Type<CustomUserSession>.value { $0.timeZone }),
                ("requestTokenSecret", Type<CustomUserSession>.value { $0.requestTokenSecret }),
                ("createdAt", Type<CustomUserSession>.value { $0.createdAt }),
                ("lastModified", Type<CustomUserSession>.value { $0.lastModified }),
                ("providerOAuthAccess", Type<CustomUserSession>.value { $0.providerOAuthAccess }),
                ("roles", Type<CustomUserSession>.value { $0.roles }),
                ("permissions", Type<CustomUserSession>.value { $0.permissions }),
                ("isAuthenticated", Type<CustomUserSession>.value { $0.isAuthenticated }),
                ("sequence", Type<CustomUserSession>.value { $0.sequence }),
                ("tag", Type<CustomUserSession>.value { $0.tag }),
                ("customName", Type<CustomUserSession>.value { $0.customName }),
                ("customInfo", Type<CustomUserSession>.value { $0.customInfo }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, CustomUserSession.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> CustomUserSession
    {
        return populate(CustomUserSession(), map, CustomUserSession.typeConfig())
    }

    public class func fromJson(json:String) -> CustomUserSession
    {
        return populate(CustomUserSession(), json, CustomUserSession.typeConfig())
    }
}

extension UnAuthInfo : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<UnAuthInfo>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<UnAuthInfo>(
            writers: [
                ("customInfo", { (x:UnAuthInfo, map:NSDictionary) in setOptionalValue(&x.customInfo, map, "customInfo") }),
            ],
            readers: [
                ("customInfo", Type<UnAuthInfo>.value { $0.customInfo }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, UnAuthInfo.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> UnAuthInfo
    {
        return populate(UnAuthInfo(), map, UnAuthInfo.typeConfig())
    }

    public class func fromJson(json:String) -> UnAuthInfo
    {
        return populate(UnAuthInfo(), json, UnAuthInfo.typeConfig())
    }
}

extension ExternalEnum2 : StringSerializable
{
    public func toString() -> String
    {
        switch self {
        case .Uno: return "Uno"
        case .Due: return "Due"
        case .Tre: return "Tre"
        }
    }

    public static func fromString(strValue:String) -> ExternalEnum2?
    {
        switch strValue {
        case "Uno": return .Uno
        case "Due": return .Due
        case "Tre": return .Tre
        default: return nil
        }
    }
}

extension MetadataTestNestedChild : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<MetadataTestNestedChild>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<MetadataTestNestedChild>(
            writers: [
                ("name", { (x:MetadataTestNestedChild, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<MetadataTestNestedChild>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, MetadataTestNestedChild.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> MetadataTestNestedChild
    {
        return populate(MetadataTestNestedChild(), map, MetadataTestNestedChild.typeConfig())
    }

    public class func fromJson(json:String) -> MetadataTestNestedChild
    {
        return populate(MetadataTestNestedChild(), json, MetadataTestNestedChild.typeConfig())
    }
}

extension MenuItemExample : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<MenuItemExample>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<MenuItemExample>(
            writers: [
                ("name1", { (x:MenuItemExample, map:NSDictionary) in setOptionalValue(&x.name1, map, "name1") }),
                ("menuItemExampleItem", { (x:MenuItemExample, map:NSDictionary) in setOptionalValue(&x.menuItemExampleItem, map, "menuItemExampleItem") }),
            ],
            readers: [
                ("name1", Type<MenuItemExample>.value { $0.name1 }),
                ("menuItemExampleItem", Type<MenuItemExample>.value { $0.menuItemExampleItem }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, MenuItemExample.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> MenuItemExample
    {
        return populate(MenuItemExample(), map, MenuItemExample.typeConfig())
    }

    public class func fromJson(json:String) -> MenuItemExample
    {
        return populate(MenuItemExample(), json, MenuItemExample.typeConfig())
    }
}

extension SubType : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<SubType>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<SubType>(
            writers: [
                ("id", { (x:SubType, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:SubType, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("id", Type<SubType>.value { $0.id }),
                ("name", Type<SubType>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, SubType.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> SubType
    {
        return populate(SubType(), map, SubType.typeConfig())
    }

    public class func fromJson(json:String) -> SubType
    {
        return populate(SubType(), json, SubType.typeConfig())
    }
}

extension TypesGroup : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<TypesGroup>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<TypesGroup>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, TypesGroup.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> TypesGroup
    {
        return populate(TypesGroup(), map, TypesGroup.typeConfig())
    }

    public class func fromJson(json:String) -> TypesGroup
    {
        return populate(TypesGroup(), json, TypesGroup.typeConfig())
    }
}

extension MenuItemExampleItem : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<MenuItemExampleItem>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<MenuItemExampleItem>(
            writers: [
                ("name1", { (x:MenuItemExampleItem, map:NSDictionary) in setOptionalValue(&x.name1, map, "name1") }),
            ],
            readers: [
                ("name1", Type<MenuItemExampleItem>.value { $0.name1 }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, MenuItemExampleItem.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> MenuItemExampleItem
    {
        return populate(MenuItemExampleItem(), map, MenuItemExampleItem.typeConfig())
    }

    public class func fromJson(json:String) -> MenuItemExampleItem
    {
        return populate(MenuItemExampleItem(), json, MenuItemExampleItem.typeConfig())
    }
}

extension CustomHttpErrorResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<CustomHttpErrorResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<CustomHttpErrorResponse>(
            writers: [
                ("custom", { (x:CustomHttpErrorResponse, map:NSDictionary) in setOptionalValue(&x.custom, map, "custom") }),
                ("responseStatus", { (x:CustomHttpErrorResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("custom", Type<CustomHttpErrorResponse>.value { $0.custom }),
                ("responseStatus", Type<CustomHttpErrorResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, CustomHttpErrorResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> CustomHttpErrorResponse
    {
        return populate(CustomHttpErrorResponse(), map, CustomHttpErrorResponse.typeConfig())
    }

    public class func fromJson(json:String) -> CustomHttpErrorResponse
    {
        return populate(CustomHttpErrorResponse(), json, CustomHttpErrorResponse.typeConfig())
    }
}

extension ExternalOperationResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ExternalOperationResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ExternalOperationResponse>(
            writers: [
                ("result", { (x:ExternalOperationResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<ExternalOperationResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ExternalOperationResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ExternalOperationResponse
    {
        return populate(ExternalOperationResponse(), map, ExternalOperationResponse.typeConfig())
    }

    public class func fromJson(json:String) -> ExternalOperationResponse
    {
        return populate(ExternalOperationResponse(), json, ExternalOperationResponse.typeConfig())
    }
}

extension ExternalOperation2Response : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ExternalOperation2Response>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ExternalOperation2Response>(
            writers: [
                ("externalType", { (x:ExternalOperation2Response, map:NSDictionary) in setOptionalValue(&x.externalType, map, "externalType") }),
            ],
            readers: [
                ("externalType", Type<ExternalOperation2Response>.value { $0.externalType }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ExternalOperation2Response.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ExternalOperation2Response
    {
        return populate(ExternalOperation2Response(), map, ExternalOperation2Response.typeConfig())
    }

    public class func fromJson(json:String) -> ExternalOperation2Response
    {
        return populate(ExternalOperation2Response(), json, ExternalOperation2Response.typeConfig())
    }
}

extension ExternalReturnTypeResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ExternalReturnTypeResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ExternalReturnTypeResponse>(
            writers: [
                ("externalEnum3", { (x:ExternalReturnTypeResponse, map:NSDictionary) in setOptionalValue(&x.externalEnum3, map, "externalEnum3") }),
            ],
            readers: [
                ("externalEnum3", Type<ExternalReturnTypeResponse>.value { $0.externalEnum3 }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ExternalReturnTypeResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ExternalReturnTypeResponse
    {
        return populate(ExternalReturnTypeResponse(), map, ExternalReturnTypeResponse.typeConfig())
    }

    public class func fromJson(json:String) -> ExternalReturnTypeResponse
    {
        return populate(ExternalReturnTypeResponse(), json, ExternalReturnTypeResponse.typeConfig())
    }
}

extension Account : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<Account>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Account>(
            writers: [
                ("name", { (x:Account, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<Account>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, Account.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> Account
    {
        return populate(Account(), map, Account.typeConfig())
    }

    public class func fromJson(json:String) -> Account
    {
        return populate(Account(), json, Account.typeConfig())
    }
}

extension Project : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<Project>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Project>(
            writers: [
                ("account", { (x:Project, map:NSDictionary) in setOptionalValue(&x.account, map, "account") }),
                ("name", { (x:Project, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("account", Type<Project>.value { $0.account }),
                ("name", Type<Project>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, Project.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> Project
    {
        return populate(Project(), map, Project.typeConfig())
    }

    public class func fromJson(json:String) -> Project
    {
        return populate(Project(), json, Project.typeConfig())
    }
}

extension MetadataTestResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<MetadataTestResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<MetadataTestResponse>(
            writers: [
                ("id", { (x:MetadataTestResponse, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("results", { (x:MetadataTestResponse, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("id", Type<MetadataTestResponse>.value { $0.id }),
                ("results", Type<MetadataTestResponse>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, MetadataTestResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> MetadataTestResponse
    {
        return populate(MetadataTestResponse(), map, MetadataTestResponse.typeConfig())
    }

    public class func fromJson(json:String) -> MetadataTestResponse
    {
        return populate(MetadataTestResponse(), json, MetadataTestResponse.typeConfig())
    }
}

extension GetExampleResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetExampleResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetExampleResponse>(
            writers: [
                ("responseStatus", { (x:GetExampleResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
                ("menuExample1", { (x:GetExampleResponse, map:NSDictionary) in setOptionalValue(&x.menuExample1, map, "menuExample1") }),
            ],
            readers: [
                ("responseStatus", Type<GetExampleResponse>.value { $0.responseStatus }),
                ("menuExample1", Type<GetExampleResponse>.value { $0.menuExample1 }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetExampleResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetExampleResponse
    {
        return populate(GetExampleResponse(), map, GetExampleResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetExampleResponse
    {
        return populate(GetExampleResponse(), json, GetExampleResponse.typeConfig())
    }
}

extension GetRandomIdsResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetRandomIdsResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetRandomIdsResponse>(
            writers: [
                ("results", { (x:GetRandomIdsResponse, map:NSDictionary) in setValue(&x.results, map, "results") }),
            ],
            readers: [
                ("results", Type<GetRandomIdsResponse>.value { $0.results }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetRandomIdsResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetRandomIdsResponse
    {
        return populate(GetRandomIdsResponse(), map, GetRandomIdsResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetRandomIdsResponse
    {
        return populate(GetRandomIdsResponse(), json, GetRandomIdsResponse.typeConfig())
    }
}

extension HelloResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloResponse>(
            writers: [
                ("result", { (x:HelloResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<HelloResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloResponse
    {
        return populate(HelloResponse(), map, HelloResponse.typeConfig())
    }

    public class func fromJson(json:String) -> HelloResponse
    {
        return populate(HelloResponse(), json, HelloResponse.typeConfig())
    }
}

extension HelloAllTypesResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloAllTypesResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloAllTypesResponse>(
            writers: [
                ("result", { (x:HelloAllTypesResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("allTypes", { (x:HelloAllTypesResponse, map:NSDictionary) in setOptionalValue(&x.allTypes, map, "allTypes") }),
                ("allCollectionTypes", { (x:HelloAllTypesResponse, map:NSDictionary) in setOptionalValue(&x.allCollectionTypes, map, "allCollectionTypes") }),
            ],
            readers: [
                ("result", Type<HelloAllTypesResponse>.value { $0.result }),
                ("allTypes", Type<HelloAllTypesResponse>.value { $0.allTypes }),
                ("allCollectionTypes", Type<HelloAllTypesResponse>.value { $0.allCollectionTypes }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloAllTypesResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloAllTypesResponse
    {
        return populate(HelloAllTypesResponse(), map, HelloAllTypesResponse.typeConfig())
    }

    public class func fromJson(json:String) -> HelloAllTypesResponse
    {
        return populate(HelloAllTypesResponse(), json, HelloAllTypesResponse.typeConfig())
    }
}

extension HelloWithDataContractResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithDataContractResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithDataContractResponse>(
            writers: [
                ("result", { (x:HelloWithDataContractResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<HelloWithDataContractResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithDataContractResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithDataContractResponse
    {
        return populate(HelloWithDataContractResponse(), map, HelloWithDataContractResponse.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithDataContractResponse
    {
        return populate(HelloWithDataContractResponse(), json, HelloWithDataContractResponse.typeConfig())
    }
}

extension HelloWithDescriptionResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithDescriptionResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithDescriptionResponse>(
            writers: [
                ("result", { (x:HelloWithDescriptionResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<HelloWithDescriptionResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithDescriptionResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithDescriptionResponse
    {
        return populate(HelloWithDescriptionResponse(), map, HelloWithDescriptionResponse.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithDescriptionResponse
    {
        return populate(HelloWithDescriptionResponse(), json, HelloWithDescriptionResponse.typeConfig())
    }
}

extension HelloWithInheritanceResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithInheritanceResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithInheritanceResponse>(
            writers: [
                ("refId", { (x:HelloWithInheritanceResponse, map:NSDictionary) in setOptionalValue(&x.refId, map, "refId") }),
                ("result", { (x:HelloWithInheritanceResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("refId", Type<HelloWithInheritanceResponse>.value { $0.refId }),
                ("result", Type<HelloWithInheritanceResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithInheritanceResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithInheritanceResponse
    {
        return populate(HelloWithInheritanceResponse(), map, HelloWithInheritanceResponse.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithInheritanceResponse
    {
        return populate(HelloWithInheritanceResponse(), json, HelloWithInheritanceResponse.typeConfig())
    }
}

extension HelloWithAlternateReturnResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithAlternateReturnResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithAlternateReturnResponse>(
            writers: [
                ("result", { (x:HelloWithAlternateReturnResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("altResult", { (x:HelloWithAlternateReturnResponse, map:NSDictionary) in setOptionalValue(&x.altResult, map, "altResult") }),
            ],
            readers: [
                ("result", Type<HelloWithAlternateReturnResponse>.value { $0.result }),
                ("altResult", Type<HelloWithAlternateReturnResponse>.value { $0.altResult }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithAlternateReturnResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithAlternateReturnResponse
    {
        return populate(HelloWithAlternateReturnResponse(), map, HelloWithAlternateReturnResponse.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithAlternateReturnResponse
    {
        return populate(HelloWithAlternateReturnResponse(), json, HelloWithAlternateReturnResponse.typeConfig())
    }
}

extension HelloWithRouteResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithRouteResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithRouteResponse>(
            writers: [
                ("result", { (x:HelloWithRouteResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<HelloWithRouteResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithRouteResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithRouteResponse
    {
        return populate(HelloWithRouteResponse(), map, HelloWithRouteResponse.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithRouteResponse
    {
        return populate(HelloWithRouteResponse(), json, HelloWithRouteResponse.typeConfig())
    }
}

extension HelloWithTypeResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithTypeResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithTypeResponse>(
            writers: [
                ("result", { (x:HelloWithTypeResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("result", Type<HelloWithTypeResponse>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithTypeResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithTypeResponse
    {
        return populate(HelloWithTypeResponse(), map, HelloWithTypeResponse.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithTypeResponse
    {
        return populate(HelloWithTypeResponse(), json, HelloWithTypeResponse.typeConfig())
    }
}

extension HelloInnerTypesResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloInnerTypesResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloInnerTypesResponse>(
            writers: [
                ("innerType", { (x:HelloInnerTypesResponse, map:NSDictionary) in setOptionalValue(&x.innerType, map, "innerType") }),
                ("innerEnum", { (x:HelloInnerTypesResponse, map:NSDictionary) in setOptionalValue(&x.innerEnum, map, "innerEnum") }),
            ],
            readers: [
                ("innerType", Type<HelloInnerTypesResponse>.value { $0.innerType }),
                ("innerEnum", Type<HelloInnerTypesResponse>.value { $0.innerEnum }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloInnerTypesResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloInnerTypesResponse
    {
        return populate(HelloInnerTypesResponse(), map, HelloInnerTypesResponse.typeConfig())
    }

    public class func fromJson(json:String) -> HelloInnerTypesResponse
    {
        return populate(HelloInnerTypesResponse(), json, HelloInnerTypesResponse.typeConfig())
    }
}

extension PingResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<PingResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<PingResponse>(
            writers: [
                ("responses", { (x:PingResponse, map:NSDictionary) in setValue(&x.responses, map, "responses") }),
                ("responseStatus", { (x:PingResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("responses", Type<PingResponse>.value { $0.responses }),
                ("responseStatus", Type<PingResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, PingResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> PingResponse
    {
        return populate(PingResponse(), map, PingResponse.typeConfig())
    }

    public class func fromJson(json:String) -> PingResponse
    {
        return populate(PingResponse(), json, PingResponse.typeConfig())
    }
}

extension RequiresRoleResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<RequiresRoleResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<RequiresRoleResponse>(
            writers: [
                ("result", { (x:RequiresRoleResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("responseStatus", { (x:RequiresRoleResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("result", Type<RequiresRoleResponse>.value { $0.result }),
                ("responseStatus", Type<RequiresRoleResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, RequiresRoleResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> RequiresRoleResponse
    {
        return populate(RequiresRoleResponse(), map, RequiresRoleResponse.typeConfig())
    }

    public class func fromJson(json:String) -> RequiresRoleResponse
    {
        return populate(RequiresRoleResponse(), json, RequiresRoleResponse.typeConfig())
    }
}

extension GetSessionResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetSessionResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetSessionResponse>(
            writers: [
                ("result", { (x:GetSessionResponse, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
                ("unAuthInfo", { (x:GetSessionResponse, map:NSDictionary) in setOptionalValue(&x.unAuthInfo, map, "unAuthInfo") }),
                ("responseStatus", { (x:GetSessionResponse, map:NSDictionary) in setOptionalValue(&x.responseStatus, map, "responseStatus") }),
            ],
            readers: [
                ("result", Type<GetSessionResponse>.value { $0.result }),
                ("unAuthInfo", Type<GetSessionResponse>.value { $0.unAuthInfo }),
                ("responseStatus", Type<GetSessionResponse>.value { $0.responseStatus }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetSessionResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetSessionResponse
    {
        return populate(GetSessionResponse(), map, GetSessionResponse.typeConfig())
    }

    public class func fromJson(json:String) -> GetSessionResponse
    {
        return populate(GetSessionResponse(), json, GetSessionResponse.typeConfig())
    }
}

extension CustomHttpError : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<CustomHttpError>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<CustomHttpError>(
            writers: [
                ("statusCode", { (x:CustomHttpError, map:NSDictionary) in setOptionalValue(&x.statusCode, map, "statusCode") }),
                ("statusDescription", { (x:CustomHttpError, map:NSDictionary) in setOptionalValue(&x.statusDescription, map, "statusDescription") }),
            ],
            readers: [
                ("statusCode", Type<CustomHttpError>.value { $0.statusCode }),
                ("statusDescription", Type<CustomHttpError>.value { $0.statusDescription }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, CustomHttpError.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> CustomHttpError
    {
        return populate(CustomHttpError(), map, CustomHttpError.typeConfig())
    }

    public class func fromJson(json:String) -> CustomHttpError
    {
        return populate(CustomHttpError(), json, CustomHttpError.typeConfig())
    }
}

extension ExternalOperation : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ExternalOperation>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ExternalOperation>(
            writers: [
                ("id", { (x:ExternalOperation, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:ExternalOperation, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("externalEnum", { (x:ExternalOperation, map:NSDictionary) in setOptionalValue(&x.externalEnum, map, "externalEnum") }),
            ],
            readers: [
                ("id", Type<ExternalOperation>.value { $0.id }),
                ("name", Type<ExternalOperation>.value { $0.name }),
                ("externalEnum", Type<ExternalOperation>.value { $0.externalEnum }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ExternalOperation.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ExternalOperation
    {
        return populate(ExternalOperation(), map, ExternalOperation.typeConfig())
    }

    public class func fromJson(json:String) -> ExternalOperation
    {
        return populate(ExternalOperation(), json, ExternalOperation.typeConfig())
    }
}

extension ExternalOperation2 : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ExternalOperation2>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ExternalOperation2>(
            writers: [
                ("id", { (x:ExternalOperation2, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("id", Type<ExternalOperation2>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ExternalOperation2.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ExternalOperation2
    {
        return populate(ExternalOperation2(), map, ExternalOperation2.typeConfig())
    }

    public class func fromJson(json:String) -> ExternalOperation2
    {
        return populate(ExternalOperation2(), json, ExternalOperation2.typeConfig())
    }
}

extension ExternalOperation3 : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ExternalOperation3>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ExternalOperation3>(
            writers: [
                ("id", { (x:ExternalOperation3, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("id", Type<ExternalOperation3>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ExternalOperation3.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ExternalOperation3
    {
        return populate(ExternalOperation3(), map, ExternalOperation3.typeConfig())
    }

    public class func fromJson(json:String) -> ExternalOperation3
    {
        return populate(ExternalOperation3(), json, ExternalOperation3.typeConfig())
    }
}

extension ExternalOperation4 : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ExternalOperation4>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ExternalOperation4>(
            writers: [
                ("id", { (x:ExternalOperation4, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("id", Type<ExternalOperation4>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ExternalOperation4.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ExternalOperation4
    {
        return populate(ExternalOperation4(), map, ExternalOperation4.typeConfig())
    }

    public class func fromJson(json:String) -> ExternalOperation4
    {
        return populate(ExternalOperation4(), json, ExternalOperation4.typeConfig())
    }
}

extension RootPathRoutes : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<RootPathRoutes>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<RootPathRoutes>(
            writers: [
                ("path", { (x:RootPathRoutes, map:NSDictionary) in setOptionalValue(&x.path, map, "path") }),
            ],
            readers: [
                ("path", Type<RootPathRoutes>.value { $0.path }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, RootPathRoutes.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> RootPathRoutes
    {
        return populate(RootPathRoutes(), map, RootPathRoutes.typeConfig())
    }

    public class func fromJson(json:String) -> RootPathRoutes
    {
        return populate(RootPathRoutes(), json, RootPathRoutes.typeConfig())
    }
}

extension GetAccount : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetAccount>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetAccount>(
            writers: [
                ("account", { (x:GetAccount, map:NSDictionary) in setOptionalValue(&x.account, map, "account") }),
            ],
            readers: [
                ("account", Type<GetAccount>.value { $0.account }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetAccount.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetAccount
    {
        return populate(GetAccount(), map, GetAccount.typeConfig())
    }

    public class func fromJson(json:String) -> GetAccount
    {
        return populate(GetAccount(), json, GetAccount.typeConfig())
    }
}

extension GetProject : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetProject>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetProject>(
            writers: [
                ("account", { (x:GetProject, map:NSDictionary) in setOptionalValue(&x.account, map, "account") }),
                ("project", { (x:GetProject, map:NSDictionary) in setOptionalValue(&x.project, map, "project") }),
            ],
            readers: [
                ("account", Type<GetProject>.value { $0.account }),
                ("project", Type<GetProject>.value { $0.project }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetProject.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetProject
    {
        return populate(GetProject(), map, GetProject.typeConfig())
    }

    public class func fromJson(json:String) -> GetProject
    {
        return populate(GetProject(), json, GetProject.typeConfig())
    }
}

extension ImageAsStream : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ImageAsStream>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ImageAsStream>(
            writers: [
                ("format", { (x:ImageAsStream, map:NSDictionary) in setOptionalValue(&x.format, map, "format") }),
            ],
            readers: [
                ("format", Type<ImageAsStream>.value { $0.format }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ImageAsStream.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ImageAsStream
    {
        return populate(ImageAsStream(), map, ImageAsStream.typeConfig())
    }

    public class func fromJson(json:String) -> ImageAsStream
    {
        return populate(ImageAsStream(), json, ImageAsStream.typeConfig())
    }
}

extension ImageAsBytes : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ImageAsBytes>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ImageAsBytes>(
            writers: [
                ("format", { (x:ImageAsBytes, map:NSDictionary) in setOptionalValue(&x.format, map, "format") }),
            ],
            readers: [
                ("format", Type<ImageAsBytes>.value { $0.format }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ImageAsBytes.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ImageAsBytes
    {
        return populate(ImageAsBytes(), map, ImageAsBytes.typeConfig())
    }

    public class func fromJson(json:String) -> ImageAsBytes
    {
        return populate(ImageAsBytes(), json, ImageAsBytes.typeConfig())
    }
}

extension ImageAsCustomResult : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ImageAsCustomResult>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ImageAsCustomResult>(
            writers: [
                ("format", { (x:ImageAsCustomResult, map:NSDictionary) in setOptionalValue(&x.format, map, "format") }),
            ],
            readers: [
                ("format", Type<ImageAsCustomResult>.value { $0.format }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ImageAsCustomResult.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ImageAsCustomResult
    {
        return populate(ImageAsCustomResult(), map, ImageAsCustomResult.typeConfig())
    }

    public class func fromJson(json:String) -> ImageAsCustomResult
    {
        return populate(ImageAsCustomResult(), json, ImageAsCustomResult.typeConfig())
    }
}

extension ImageWriteToResponse : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ImageWriteToResponse>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ImageWriteToResponse>(
            writers: [
                ("format", { (x:ImageWriteToResponse, map:NSDictionary) in setOptionalValue(&x.format, map, "format") }),
            ],
            readers: [
                ("format", Type<ImageWriteToResponse>.value { $0.format }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ImageWriteToResponse.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ImageWriteToResponse
    {
        return populate(ImageWriteToResponse(), map, ImageWriteToResponse.typeConfig())
    }

    public class func fromJson(json:String) -> ImageWriteToResponse
    {
        return populate(ImageWriteToResponse(), json, ImageWriteToResponse.typeConfig())
    }
}

extension ImageAsFile : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ImageAsFile>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ImageAsFile>(
            writers: [
                ("format", { (x:ImageAsFile, map:NSDictionary) in setOptionalValue(&x.format, map, "format") }),
            ],
            readers: [
                ("format", Type<ImageAsFile>.value { $0.format }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ImageAsFile.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ImageAsFile
    {
        return populate(ImageAsFile(), map, ImageAsFile.typeConfig())
    }

    public class func fromJson(json:String) -> ImageAsFile
    {
        return populate(ImageAsFile(), json, ImageAsFile.typeConfig())
    }
}

extension ImageAsRedirect : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ImageAsRedirect>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ImageAsRedirect>(
            writers: [
                ("format", { (x:ImageAsRedirect, map:NSDictionary) in setOptionalValue(&x.format, map, "format") }),
            ],
            readers: [
                ("format", Type<ImageAsRedirect>.value { $0.format }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ImageAsRedirect.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ImageAsRedirect
    {
        return populate(ImageAsRedirect(), map, ImageAsRedirect.typeConfig())
    }

    public class func fromJson(json:String) -> ImageAsRedirect
    {
        return populate(ImageAsRedirect(), json, ImageAsRedirect.typeConfig())
    }
}

extension DrawImage : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<DrawImage>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<DrawImage>(
            writers: [
                ("name", { (x:DrawImage, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("format", { (x:DrawImage, map:NSDictionary) in setOptionalValue(&x.format, map, "format") }),
                ("width", { (x:DrawImage, map:NSDictionary) in setOptionalValue(&x.width, map, "width") }),
                ("height", { (x:DrawImage, map:NSDictionary) in setOptionalValue(&x.height, map, "height") }),
                ("fontSize", { (x:DrawImage, map:NSDictionary) in setOptionalValue(&x.fontSize, map, "fontSize") }),
                ("foreground", { (x:DrawImage, map:NSDictionary) in setOptionalValue(&x.foreground, map, "foreground") }),
                ("background", { (x:DrawImage, map:NSDictionary) in setOptionalValue(&x.background, map, "background") }),
            ],
            readers: [
                ("name", Type<DrawImage>.value { $0.name }),
                ("format", Type<DrawImage>.value { $0.format }),
                ("width", Type<DrawImage>.value { $0.width }),
                ("height", Type<DrawImage>.value { $0.height }),
                ("fontSize", Type<DrawImage>.value { $0.fontSize }),
                ("foreground", Type<DrawImage>.value { $0.foreground }),
                ("background", Type<DrawImage>.value { $0.background }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, DrawImage.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> DrawImage
    {
        return populate(DrawImage(), map, DrawImage.typeConfig())
    }

    public class func fromJson(json:String) -> DrawImage
    {
        return populate(DrawImage(), json, DrawImage.typeConfig())
    }
}

extension MetadataTest : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<MetadataTest>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<MetadataTest>(
            writers: [
                ("id", { (x:MetadataTest, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("id", Type<MetadataTest>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, MetadataTest.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> MetadataTest
    {
        return populate(MetadataTest(), map, MetadataTest.typeConfig())
    }

    public class func fromJson(json:String) -> MetadataTest
    {
        return populate(MetadataTest(), json, MetadataTest.typeConfig())
    }
}

extension MetadataTestArray : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<MetadataTestArray>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<MetadataTestArray>(
            writers: [
                ("id", { (x:MetadataTestArray, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("id", Type<MetadataTestArray>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, MetadataTestArray.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> MetadataTestArray
    {
        return populate(MetadataTestArray(), map, MetadataTestArray.typeConfig())
    }

    public class func fromJson(json:String) -> MetadataTestArray
    {
        return populate(MetadataTestArray(), json, MetadataTestArray.typeConfig())
    }
}

extension GetExample : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetExample>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetExample>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetExample.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetExample
    {
        return populate(GetExample(), map, GetExample.typeConfig())
    }

    public class func fromJson(json:String) -> GetExample
    {
        return populate(GetExample(), json, GetExample.typeConfig())
    }
}

extension GetRandomIds : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetRandomIds>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetRandomIds>(
            writers: [
                ("take", { (x:GetRandomIds, map:NSDictionary) in setOptionalValue(&x.take, map, "take") }),
            ],
            readers: [
                ("take", Type<GetRandomIds>.value { $0.take }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetRandomIds.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetRandomIds
    {
        return populate(GetRandomIds(), map, GetRandomIds.typeConfig())
    }

    public class func fromJson(json:String) -> GetRandomIds
    {
        return populate(GetRandomIds(), json, GetRandomIds.typeConfig())
    }
}

extension TextFileTest : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<TextFileTest>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<TextFileTest>(
            writers: [
                ("asAttachment", { (x:TextFileTest, map:NSDictionary) in setOptionalValue(&x.asAttachment, map, "asAttachment") }),
            ],
            readers: [
                ("asAttachment", Type<TextFileTest>.value { $0.asAttachment }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, TextFileTest.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> TextFileTest
    {
        return populate(TextFileTest(), map, TextFileTest.typeConfig())
    }

    public class func fromJson(json:String) -> TextFileTest
    {
        return populate(TextFileTest(), json, TextFileTest.typeConfig())
    }
}

extension Hello : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<Hello>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Hello>(
            writers: [
                ("name", { (x:Hello, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("title", { (x:Hello, map:NSDictionary) in setOptionalValue(&x.title, map, "title") }),
            ],
            readers: [
                ("name", Type<Hello>.value { $0.name }),
                ("title", Type<Hello>.value { $0.title }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, Hello.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> Hello
    {
        return populate(Hello(), map, Hello.typeConfig())
    }

    public class func fromJson(json:String) -> Hello
    {
        return populate(Hello(), json, Hello.typeConfig())
    }
}

extension HelloWithNestedClass : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithNestedClass>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithNestedClass>(
            writers: [
                ("name", { (x:HelloWithNestedClass, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("nestedClassProp", { (x:HelloWithNestedClass, map:NSDictionary) in setOptionalValue(&x.nestedClassProp, map, "nestedClassProp") }),
            ],
            readers: [
                ("name", Type<HelloWithNestedClass>.value { $0.name }),
                ("nestedClassProp", Type<HelloWithNestedClass>.value { $0.nestedClassProp }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithNestedClass.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithNestedClass
    {
        return populate(HelloWithNestedClass(), map, HelloWithNestedClass.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithNestedClass
    {
        return populate(HelloWithNestedClass(), json, HelloWithNestedClass.typeConfig())
    }
}

extension HelloList : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloList>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloList>(
            writers: [
                ("names", { (x:HelloList, map:NSDictionary) in setValue(&x.names, map, "names") }),
            ],
            readers: [
                ("names", Type<HelloList>.value { $0.names }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloList.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloList
    {
        return populate(HelloList(), map, HelloList.typeConfig())
    }

    public class func fromJson(json:String) -> HelloList
    {
        return populate(HelloList(), json, HelloList.typeConfig())
    }
}

extension HelloArray : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloArray>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloArray>(
            writers: [
                ("names", { (x:HelloArray, map:NSDictionary) in setValue(&x.names, map, "names") }),
            ],
            readers: [
                ("names", Type<HelloArray>.value { $0.names }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloArray.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloArray
    {
        return populate(HelloArray(), map, HelloArray.typeConfig())
    }

    public class func fromJson(json:String) -> HelloArray
    {
        return populate(HelloArray(), json, HelloArray.typeConfig())
    }
}

extension HelloWithEnum : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithEnum>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithEnum>(
            writers: [
                ("enumProp", { (x:HelloWithEnum, map:NSDictionary) in setOptionalValue(&x.enumProp, map, "enumProp") }),
                ("nullableEnumProp", { (x:HelloWithEnum, map:NSDictionary) in setOptionalValue(&x.nullableEnumProp, map, "nullableEnumProp") }),
                ("enumFlags", { (x:HelloWithEnum, map:NSDictionary) in setOptionalValue(&x.enumFlags, map, "enumFlags") }),
            ],
            readers: [
                ("enumProp", Type<HelloWithEnum>.value { $0.enumProp }),
                ("nullableEnumProp", Type<HelloWithEnum>.value { $0.nullableEnumProp }),
                ("enumFlags", Type<HelloWithEnum>.value { $0.enumFlags }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithEnum.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithEnum
    {
        return populate(HelloWithEnum(), map, HelloWithEnum.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithEnum
    {
        return populate(HelloWithEnum(), json, HelloWithEnum.typeConfig())
    }
}

extension HelloExternal : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloExternal>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloExternal>(
            writers: [
                ("name", { (x:HelloExternal, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<HelloExternal>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloExternal.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloExternal
    {
        return populate(HelloExternal(), map, HelloExternal.typeConfig())
    }

    public class func fromJson(json:String) -> HelloExternal
    {
        return populate(HelloExternal(), json, HelloExternal.typeConfig())
    }
}

extension AllowedAttributes : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<AllowedAttributes>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<AllowedAttributes>(
            writers: [
                ("id", { (x:AllowedAttributes, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("range", { (x:AllowedAttributes, map:NSDictionary) in setOptionalValue(&x.range, map, "range") }),
                ("name", { (x:AllowedAttributes, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("id", Type<AllowedAttributes>.value { $0.id }),
                ("range", Type<AllowedAttributes>.value { $0.range }),
                ("name", Type<AllowedAttributes>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, AllowedAttributes.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> AllowedAttributes
    {
        return populate(AllowedAttributes(), map, AllowedAttributes.typeConfig())
    }

    public class func fromJson(json:String) -> AllowedAttributes
    {
        return populate(AllowedAttributes(), json, AllowedAttributes.typeConfig())
    }
}

extension HelloAllTypes : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloAllTypes>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloAllTypes>(
            writers: [
                ("name", { (x:HelloAllTypes, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("allTypes", { (x:HelloAllTypes, map:NSDictionary) in setOptionalValue(&x.allTypes, map, "allTypes") }),
                ("allCollectionTypes", { (x:HelloAllTypes, map:NSDictionary) in setOptionalValue(&x.allCollectionTypes, map, "allCollectionTypes") }),
            ],
            readers: [
                ("name", Type<HelloAllTypes>.value { $0.name }),
                ("allTypes", Type<HelloAllTypes>.value { $0.allTypes }),
                ("allCollectionTypes", Type<HelloAllTypes>.value { $0.allCollectionTypes }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloAllTypes.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloAllTypes
    {
        return populate(HelloAllTypes(), map, HelloAllTypes.typeConfig())
    }

    public class func fromJson(json:String) -> HelloAllTypes
    {
        return populate(HelloAllTypes(), json, HelloAllTypes.typeConfig())
    }
}

extension HelloString : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloString>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloString>(
            writers: [
                ("name", { (x:HelloString, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<HelloString>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloString.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloString
    {
        return populate(HelloString(), map, HelloString.typeConfig())
    }

    public class func fromJson(json:String) -> HelloString
    {
        return populate(HelloString(), json, HelloString.typeConfig())
    }
}

extension HelloVoid : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloVoid>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloVoid>(
            writers: [
                ("name", { (x:HelloVoid, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<HelloVoid>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloVoid.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloVoid
    {
        return populate(HelloVoid(), map, HelloVoid.typeConfig())
    }

    public class func fromJson(json:String) -> HelloVoid
    {
        return populate(HelloVoid(), json, HelloVoid.typeConfig())
    }
}

extension HelloWithDataContract : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithDataContract>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithDataContract>(
            writers: [
                ("name", { (x:HelloWithDataContract, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("id", { (x:HelloWithDataContract, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
            ],
            readers: [
                ("name", Type<HelloWithDataContract>.value { $0.name }),
                ("id", Type<HelloWithDataContract>.value { $0.id }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithDataContract.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithDataContract
    {
        return populate(HelloWithDataContract(), map, HelloWithDataContract.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithDataContract
    {
        return populate(HelloWithDataContract(), json, HelloWithDataContract.typeConfig())
    }
}

extension HelloWithDescription : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithDescription>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithDescription>(
            writers: [
                ("name", { (x:HelloWithDescription, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<HelloWithDescription>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithDescription.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithDescription
    {
        return populate(HelloWithDescription(), map, HelloWithDescription.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithDescription
    {
        return populate(HelloWithDescription(), json, HelloWithDescription.typeConfig())
    }
}

extension HelloWithInheritance : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithInheritance>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithInheritance>(
            writers: [
                ("id", { (x:HelloWithInheritance, map:NSDictionary) in setOptionalValue(&x.id, map, "id") }),
                ("name", { (x:HelloWithInheritance, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("id", Type<HelloWithInheritance>.value { $0.id }),
                ("name", Type<HelloWithInheritance>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithInheritance.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithInheritance
    {
        return populate(HelloWithInheritance(), map, HelloWithInheritance.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithInheritance
    {
        return populate(HelloWithInheritance(), json, HelloWithInheritance.typeConfig())
    }
}

extension HelloWithGenericInheritance : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithGenericInheritance>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithGenericInheritance>(
            writers: [
                ("items", { (x:HelloWithGenericInheritance, map:NSDictionary) in setValue(&x.items, map, "items") }),
                ("counts", { (x:HelloWithGenericInheritance, map:NSDictionary) in setValue(&x.counts, map, "counts") }),
                ("result", { (x:HelloWithGenericInheritance, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("items", Type<HelloWithGenericInheritance>.value { $0.items }),
                ("counts", Type<HelloWithGenericInheritance>.value { $0.counts }),
                ("result", Type<HelloWithGenericInheritance>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithGenericInheritance.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithGenericInheritance
    {
        return populate(HelloWithGenericInheritance(), map, HelloWithGenericInheritance.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithGenericInheritance
    {
        return populate(HelloWithGenericInheritance(), json, HelloWithGenericInheritance.typeConfig())
    }
}

extension HelloWithGenericInheritance2 : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithGenericInheritance2>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithGenericInheritance2>(
            writers: [
                ("items", { (x:HelloWithGenericInheritance2, map:NSDictionary) in setValue(&x.items, map, "items") }),
                ("counts", { (x:HelloWithGenericInheritance2, map:NSDictionary) in setValue(&x.counts, map, "counts") }),
                ("result", { (x:HelloWithGenericInheritance2, map:NSDictionary) in setOptionalValue(&x.result, map, "result") }),
            ],
            readers: [
                ("items", Type<HelloWithGenericInheritance2>.value { $0.items }),
                ("counts", Type<HelloWithGenericInheritance2>.value { $0.counts }),
                ("result", Type<HelloWithGenericInheritance2>.value { $0.result }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithGenericInheritance2.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithGenericInheritance2
    {
        return populate(HelloWithGenericInheritance2(), map, HelloWithGenericInheritance2.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithGenericInheritance2
    {
        return populate(HelloWithGenericInheritance2(), json, HelloWithGenericInheritance2.typeConfig())
    }
}

extension HelloWithNestedInheritance : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithNestedInheritance>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithNestedInheritance>(
            writers: [
                ("items", { (x:HelloWithNestedInheritance, map:NSDictionary) in setValue(&x.items, map, "items") }),
                ("counts", { (x:HelloWithNestedInheritance, map:NSDictionary) in setValue(&x.counts, map, "counts") }),
            ],
            readers: [
                ("items", Type<HelloWithNestedInheritance>.value { $0.items }),
                ("counts", Type<HelloWithNestedInheritance>.value { $0.counts }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithNestedInheritance.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithNestedInheritance
    {
        return populate(HelloWithNestedInheritance(), map, HelloWithNestedInheritance.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithNestedInheritance
    {
        return populate(HelloWithNestedInheritance(), json, HelloWithNestedInheritance.typeConfig())
    }
}

extension HelloWithListInheritance : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithListInheritance>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithListInheritance>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithListInheritance.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithListInheritance
    {
        return populate(HelloWithListInheritance(), map, HelloWithListInheritance.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithListInheritance
    {
        return populate(HelloWithListInheritance(), json, HelloWithListInheritance.typeConfig())
    }
}

extension HelloWithReturn : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithReturn>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithReturn>(
            writers: [
                ("name", { (x:HelloWithReturn, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<HelloWithReturn>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithReturn.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithReturn
    {
        return populate(HelloWithReturn(), map, HelloWithReturn.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithReturn
    {
        return populate(HelloWithReturn(), json, HelloWithReturn.typeConfig())
    }
}

extension HelloWithRoute : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithRoute>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithRoute>(
            writers: [
                ("name", { (x:HelloWithRoute, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<HelloWithRoute>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithRoute.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithRoute
    {
        return populate(HelloWithRoute(), map, HelloWithRoute.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithRoute
    {
        return populate(HelloWithRoute(), json, HelloWithRoute.typeConfig())
    }
}

extension HelloWithType : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloWithType>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloWithType>(
            writers: [
                ("name", { (x:HelloWithType, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("name", Type<HelloWithType>.value { $0.name }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloWithType.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloWithType
    {
        return populate(HelloWithType(), map, HelloWithType.typeConfig())
    }

    public class func fromJson(json:String) -> HelloWithType
    {
        return populate(HelloWithType(), json, HelloWithType.typeConfig())
    }
}

extension HelloInterface : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloInterface>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloInterface>(
            writers: [
                ("poco", { (x:HelloInterface, map:NSDictionary) in setOptionalValue(&x.poco, map, "poco") }),
                ("emptyInterface", { (x:HelloInterface, map:NSDictionary) in setOptionalValue(&x.emptyInterface, map, "emptyInterface") }),
                ("emptyClass", { (x:HelloInterface, map:NSDictionary) in setOptionalValue(&x.emptyClass, map, "emptyClass") }),
            ],
            readers: [
                ("poco", Type<HelloInterface>.value { $0.poco }),
                ("emptyInterface", Type<HelloInterface>.value { $0.emptyInterface }),
                ("emptyClass", Type<HelloInterface>.value { $0.emptyClass }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloInterface.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloInterface
    {
        return populate(HelloInterface(), map, HelloInterface.typeConfig())
    }

    public class func fromJson(json:String) -> HelloInterface
    {
        return populate(HelloInterface(), json, HelloInterface.typeConfig())
    }
}

extension HelloInnerTypes : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<HelloInnerTypes>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<HelloInnerTypes>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, HelloInnerTypes.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> HelloInnerTypes
    {
        return populate(HelloInnerTypes(), map, HelloInnerTypes.typeConfig())
    }

    public class func fromJson(json:String) -> HelloInnerTypes
    {
        return populate(HelloInnerTypes(), json, HelloInnerTypes.typeConfig())
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

extension ResetConnections : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<ResetConnections>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<ResetConnections>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, ResetConnections.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> ResetConnections
    {
        return populate(ResetConnections(), map, ResetConnections.typeConfig())
    }

    public class func fromJson(json:String) -> ResetConnections
    {
        return populate(ResetConnections(), json, ResetConnections.typeConfig())
    }
}

extension RequiresRole : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<RequiresRole>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<RequiresRole>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, RequiresRole.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> RequiresRole
    {
        return populate(RequiresRole(), map, RequiresRole.typeConfig())
    }

    public class func fromJson(json:String) -> RequiresRole
    {
        return populate(RequiresRole(), json, RequiresRole.typeConfig())
    }
}

extension GetSession : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<GetSession>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<GetSession>(
            writers: [
            ],
            readers: [
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, GetSession.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> GetSession
    {
        return populate(GetSession(), map, GetSession.typeConfig())
    }

    public class func fromJson(json:String) -> GetSession
    {
        return populate(GetSession(), json, GetSession.typeConfig())
    }
}

extension UpdateSession : JsonSerializable
{
    public class func typeConfig() -> JsConfigType<UpdateSession>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<UpdateSession>(
            writers: [
                ("customName", { (x:UpdateSession, map:NSDictionary) in setOptionalValue(&x.customName, map, "customName") }),
            ],
            readers: [
                ("customName", Type<UpdateSession>.value { $0.customName }),
            ]
        ))
    }

    public func toJson() -> String
    {
        return serializeToJson(self, UpdateSession.typeConfig())
    }

    public class func fromDictionary(map:NSDictionary) -> UpdateSession
    {
        return populate(UpdateSession(), map, UpdateSession.typeConfig())
    }

    public class func fromJson(json:String) -> UpdateSession
    {
        return populate(UpdateSession(), json, UpdateSession.typeConfig())
    }
}

#endif

/* Options:
Date: 2015-04-13 16:03:08
Version: 1
BaseUrl: http://test.servicestack.net

//BaseClass:
//AddModelExtensions: True
//AddServiceStackTypes: True
IncludeTypes: HelloAllTypes,HelloAllTypesResponse,AllTypes,AllCollectionTypes,Poco,SubType,ThrowType,ThrowTypeResponse,ThrowValidation,ThrowValidationResponse
//ExcludeTypes:
//AddResponseStatus: False
//AddImplicitVersion:
//InitializeCollections: True
//DefaultImports: Foundation
*/

import Foundation;

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

public class Poco
{
    required public init(){}
    public var name:String?
}

public class SubType
{
    required public init(){}
    public var id:Int?
    public var name:String?
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

public class HelloAllTypesResponse
{
    required public init(){}
    public var result:String?
    public var allTypes:AllTypes?
    public var allCollectionTypes:AllCollectionTypes?
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

public class HelloAllTypes : IReturn
{
    typealias Return = HelloAllTypesResponse

    required public init(){}
    public var name:String?
    public var allTypes:AllTypes?
    public var allCollectionTypes:AllCollectionTypes?
}


extension AllTypes : JsonSerializable
{
    public static var typeName:String { return "AllTypes" }
    public static func reflect() -> Type<AllTypes> {
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
    public static func fromJson(json:String) -> AllTypes? {
        return AllTypes.reflect().fromJson(AllTypes(), json: json)
    }
    public static func fromObject(any:AnyObject) -> AllTypes? {
        return AllTypes.reflect().fromObject(AllTypes(), any:any)
    }
    public func toString() -> String {
        return AllTypes.reflect().toString(self)
    }
    public static func fromString(string:String) -> AllTypes? {
        return AllTypes.reflect().fromString(AllTypes(), string: string)
    }
}

extension AllCollectionTypes : JsonSerializable
{
    public static var typeName:String { return "AllCollectionTypes" }
    public static func reflect() -> Type<AllCollectionTypes> {
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
    public static func fromJson(json:String) -> AllCollectionTypes? {
        return AllCollectionTypes.reflect().fromJson(AllCollectionTypes(), json: json)
    }
    public static func fromObject(any:AnyObject) -> AllCollectionTypes? {
        return AllCollectionTypes.reflect().fromObject(AllCollectionTypes(), any:any)
    }
    public func toString() -> String {
        return AllCollectionTypes.reflect().toString(self)
    }
    public static func fromString(string:String) -> AllCollectionTypes? {
        return AllCollectionTypes.reflect().fromString(AllCollectionTypes(), string: string)
    }
}

extension Poco : JsonSerializable
{
    public static var typeName:String { return "Poco" }
    public static func reflect() -> Type<Poco> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Poco>(
            properties: [
                Type<Poco>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Poco.reflect().toJson(self)
    }
    public static func fromJson(json:String) -> Poco? {
        return Poco.reflect().fromJson(Poco(), json: json)
    }
    public static func fromObject(any:AnyObject) -> Poco? {
        return Poco.reflect().fromObject(Poco(), any:any)
    }
    public func toString() -> String {
        return Poco.reflect().toString(self)
    }
    public static func fromString(string:String) -> Poco? {
        return Poco.reflect().fromString(Poco(), string: string)
    }
}

extension SubType : JsonSerializable
{
    public static var typeName:String { return "SubType" }
    public static func reflect() -> Type<SubType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<SubType>(
            properties: [
                Type<SubType>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<SubType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
            ]))
    }
    public func toJson() -> String {
        return SubType.reflect().toJson(self)
    }
    public static func fromJson(json:String) -> SubType? {
        return SubType.reflect().fromJson(SubType(), json: json)
    }
    public static func fromObject(any:AnyObject) -> SubType? {
        return SubType.reflect().fromObject(SubType(), any:any)
    }
    public func toString() -> String {
        return SubType.reflect().toString(self)
    }
    public static func fromString(string:String) -> SubType? {
        return SubType.reflect().fromString(SubType(), string: string)
    }
}

extension ThrowTypeResponse : JsonSerializable
{
    public static var typeName:String { return "ThrowTypeResponse" }
    public static func reflect() -> Type<ThrowTypeResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ThrowTypeResponse>(
            properties: [
                Type<ThrowTypeResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ThrowTypeResponse.reflect().toJson(self)
    }
    public static func fromJson(json:String) -> ThrowTypeResponse? {
        return ThrowTypeResponse.reflect().fromJson(ThrowTypeResponse(), json: json)
    }
    public static func fromObject(any:AnyObject) -> ThrowTypeResponse? {
        return ThrowTypeResponse.reflect().fromObject(ThrowTypeResponse(), any:any)
    }
    public func toString() -> String {
        return ThrowTypeResponse.reflect().toString(self)
    }
    public static func fromString(string:String) -> ThrowTypeResponse? {
        return ThrowTypeResponse.reflect().fromString(ThrowTypeResponse(), string: string)
    }
}

extension ThrowValidationResponse : JsonSerializable
{
    public static var typeName:String { return "ThrowValidationResponse" }
    public static func reflect() -> Type<ThrowValidationResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ThrowValidationResponse>(
            properties: [
                Type<ThrowValidationResponse>.optionalProperty("age", get: { $0.age }, set: { $0.age = $1 }),
                Type<ThrowValidationResponse>.optionalProperty("required", get: { $0.required }, set: { $0.required = $1 }),
                Type<ThrowValidationResponse>.optionalProperty("email", get: { $0.email }, set: { $0.email = $1 }),
                Type<ThrowValidationResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ThrowValidationResponse.reflect().toJson(self)
    }
    public static func fromJson(json:String) -> ThrowValidationResponse? {
        return ThrowValidationResponse.reflect().fromJson(ThrowValidationResponse(), json: json)
    }
    public static func fromObject(any:AnyObject) -> ThrowValidationResponse? {
        return ThrowValidationResponse.reflect().fromObject(ThrowValidationResponse(), any:any)
    }
    public func toString() -> String {
        return ThrowValidationResponse.reflect().toString(self)
    }
    public static func fromString(string:String) -> ThrowValidationResponse? {
        return ThrowValidationResponse.reflect().fromString(ThrowValidationResponse(), string: string)
    }
}

extension HelloAllTypesResponse : JsonSerializable
{
    public static var typeName:String { return "HelloAllTypesResponse" }
    public static func reflect() -> Type<HelloAllTypesResponse> {
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
    public static func fromJson(json:String) -> HelloAllTypesResponse? {
        return HelloAllTypesResponse.reflect().fromJson(HelloAllTypesResponse(), json: json)
    }
    public static func fromObject(any:AnyObject) -> HelloAllTypesResponse? {
        return HelloAllTypesResponse.reflect().fromObject(HelloAllTypesResponse(), any:any)
    }
    public func toString() -> String {
        return HelloAllTypesResponse.reflect().toString(self)
    }
    public static func fromString(string:String) -> HelloAllTypesResponse? {
        return HelloAllTypesResponse.reflect().fromString(HelloAllTypesResponse(), string: string)
    }
}

extension ThrowType : JsonSerializable
{
    public static var typeName:String { return "ThrowType" }
    public static func reflect() -> Type<ThrowType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<ThrowType>(
            properties: [
                Type<ThrowType>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
                Type<ThrowType>.optionalProperty("message", get: { $0.message }, set: { $0.message = $1 }),
            ]))
    }
    public func toJson() -> String {
        return ThrowType.reflect().toJson(self)
    }
    public static func fromJson(json:String) -> ThrowType? {
        return ThrowType.reflect().fromJson(ThrowType(), json: json)
    }
    public static func fromObject(any:AnyObject) -> ThrowType? {
        return ThrowType.reflect().fromObject(ThrowType(), any:any)
    }
    public func toString() -> String {
        return ThrowType.reflect().toString(self)
    }
    public static func fromString(string:String) -> ThrowType? {
        return ThrowType.reflect().fromString(ThrowType(), string: string)
    }
}

extension ThrowValidation : JsonSerializable
{
    public static var typeName:String { return "ThrowValidation" }
    public static func reflect() -> Type<ThrowValidation> {
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
    public static func fromJson(json:String) -> ThrowValidation? {
        return ThrowValidation.reflect().fromJson(ThrowValidation(), json: json)
    }
    public static func fromObject(any:AnyObject) -> ThrowValidation? {
        return ThrowValidation.reflect().fromObject(ThrowValidation(), any:any)
    }
    public func toString() -> String {
        return ThrowValidation.reflect().toString(self)
    }
    public static func fromString(string:String) -> ThrowValidation? {
        return ThrowValidation.reflect().fromString(ThrowValidation(), string: string)
    }
}

extension HelloAllTypes : JsonSerializable
{
    public static var typeName:String { return "HelloAllTypes" }
    public static func reflect() -> Type<HelloAllTypes> {
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
    public static func fromJson(json:String) -> HelloAllTypes? {
        return HelloAllTypes.reflect().fromJson(HelloAllTypes(), json: json)
    }
    public static func fromObject(any:AnyObject) -> HelloAllTypes? {
        return HelloAllTypes.reflect().fromObject(HelloAllTypes(), any:any)
    }
    public func toString() -> String {
        return HelloAllTypes.reflect().toString(self)
    }
    public static func fromString(string:String) -> HelloAllTypes? {
        return HelloAllTypes.reflect().fromString(HelloAllTypes(), string: string)
    }
}

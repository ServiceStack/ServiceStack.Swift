/* Options:
Date: 2015-01-31 08:59:07
Version: 1
BaseUrl: http://test.servicestack.net

//AddResponseStatus: False
//AddModelExtensions: True
//AddServiceStackTypes: True
//FlattenAbstractTypes: True
//InitializeCollections: True
//AddImplicitVersion:
IncludeTypes: HelloAllTypes,HelloAllTypesResponse,AllTypes,AllCollectionTypes,Poco,SubType
//ExcludeTypes:
//DefaultNamespaces: Foundation
*/

import Foundation

public class AllTypes
{
    required public init(){}
    public var id:Int32?
    public var nullableId:Int32?
    public var byte:Int8?
    public var short:Int16?
    public var int:Int32?
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
    public var intStringMap:[Int32:String] = [:]
    public var subType:SubType?
}

public class AllCollectionTypes
{
    required public init(){}
    public var intArray:[Int32] = []
    public var intList:[Int32] = []
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
    public var id:Int32?
    public var name:String?
}

public class HelloAllTypesResponse
{
    required public init(){}
    public var result:String?
    public var allTypes:AllTypes?
    public var allCollectionTypes:AllCollectionTypes?
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

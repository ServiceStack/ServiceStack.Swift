/* AutoQueryViewer Services */

// @Route("/services")
public class GetAutoQueryServices : IReturn
{
    typealias Return = GetAutoQueryServicesResponse
    
    required public init(){}
    public var reload:Bool?
}

// @Route("/services/register")
public class RegisterAutoQueryService : IReturn
{
    typealias Return = RegisterAutoQueryServiceResponse
    
    required public init(){}
    public var baseUrl:String?
}

public class GetAutoQueryServicesResponse
{
    required public init(){}
    public var results:[AutoQueryService] = []
    public var responseStatus:ResponseStatus?
}

public class RegisterAutoQueryServiceResponse
{
    required public init(){}
    public var result:AutoQueryService?
    public var responseStatus:ResponseStatus?
}

public class AutoQueryService
{
    required public init(){}
    public var id:Int?
    public var serviceBaseUrl:String?
    public var serviceName:String?
    public var serviceDescription:String?
    public var serviceImageUrl:String?
    public var onlyShowAnnotatedServices:Bool?
    public var defaultSearchField:String?
    public var defaultSearchType:String?
    public var defaultSearchText:String?
    public var brandUrl:String?
    public var brandImageUrl:String?
    public var textColor:String?
    public var linkColor:String?
    public var backgroundColor:String?
    public var backgroundImageUrl:String?
    public var ownerId:String?
    public var created:NSDate?
    public var createdBy:String?
    public var lastModified:NSDate?
    public var lastModifiedBy:String?
}

extension GetAutoQueryServicesResponse : JsonSerializable
{
    public class var typeName:String { return "GetAutoQueryServicesResponse" }
    public class func reflect() -> Type<GetAutoQueryServicesResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetAutoQueryServicesResponse>(
            properties: [
                Type<GetAutoQueryServicesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
                Type<GetAutoQueryServicesResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetAutoQueryServicesResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetAutoQueryServicesResponse? {
        return GetAutoQueryServicesResponse.reflect().fromJson(GetAutoQueryServicesResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetAutoQueryServicesResponse? {
        return GetAutoQueryServicesResponse.reflect().fromObject(GetAutoQueryServicesResponse(), any:any)
    }
    public func toString() -> String {
        return GetAutoQueryServicesResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetAutoQueryServicesResponse? {
        return GetAutoQueryServicesResponse.reflect().fromString(GetAutoQueryServicesResponse(), string: string)
    }
}

extension RegisterAutoQueryServiceResponse : JsonSerializable
{
    public class var typeName:String { return "RegisterAutoQueryServiceResponse" }
    public class func reflect() -> Type<RegisterAutoQueryServiceResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RegisterAutoQueryServiceResponse>(
            properties: [
                Type<RegisterAutoQueryServiceResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
                Type<RegisterAutoQueryServiceResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return RegisterAutoQueryServiceResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RegisterAutoQueryServiceResponse? {
        return RegisterAutoQueryServiceResponse.reflect().fromJson(RegisterAutoQueryServiceResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RegisterAutoQueryServiceResponse? {
        return RegisterAutoQueryServiceResponse.reflect().fromObject(RegisterAutoQueryServiceResponse(), any:any)
    }
    public func toString() -> String {
        return RegisterAutoQueryServiceResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> RegisterAutoQueryServiceResponse? {
        return RegisterAutoQueryServiceResponse.reflect().fromString(RegisterAutoQueryServiceResponse(), string: string)
    }
}

extension GetAutoQueryServices : JsonSerializable
{
    public class var typeName:String { return "GetAutoQueryServices" }
    public class func reflect() -> Type<GetAutoQueryServices> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<GetAutoQueryServices>(
            properties: [
                Type<GetAutoQueryServices>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
            ]))
    }
    public func toJson() -> String {
        return GetAutoQueryServices.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> GetAutoQueryServices? {
        return GetAutoQueryServices.reflect().fromJson(GetAutoQueryServices(), json: json)
    }
    public class func fromObject(any:AnyObject) -> GetAutoQueryServices? {
        return GetAutoQueryServices.reflect().fromObject(GetAutoQueryServices(), any:any)
    }
    public func toString() -> String {
        return GetAutoQueryServices.reflect().toString(self)
    }
    public class func fromString(string:String) -> GetAutoQueryServices? {
        return GetAutoQueryServices.reflect().fromString(GetAutoQueryServices(), string: string)
    }
}

extension RegisterAutoQueryService : JsonSerializable
{
    public class var typeName:String { return "RegisterAutoQueryService" }
    public class func reflect() -> Type<RegisterAutoQueryService> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<RegisterAutoQueryService>(
            properties: [
                Type<RegisterAutoQueryService>.optionalProperty("baseUrl", get: { $0.baseUrl }, set: { $0.baseUrl = $1 }),
            ]))
    }
    public func toJson() -> String {
        return RegisterAutoQueryService.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> RegisterAutoQueryService? {
        return RegisterAutoQueryService.reflect().fromJson(RegisterAutoQueryService(), json: json)
    }
    public class func fromObject(any:AnyObject) -> RegisterAutoQueryService? {
        return RegisterAutoQueryService.reflect().fromObject(RegisterAutoQueryService(), any:any)
    }
    public func toString() -> String {
        return RegisterAutoQueryService.reflect().toString(self)
    }
    public class func fromString(string:String) -> RegisterAutoQueryService? {
        return RegisterAutoQueryService.reflect().fromString(RegisterAutoQueryService(), string: string)
    }
}

extension AutoQueryService : JsonSerializable
{
    public class var typeName:String { return "AutoQueryService" }
    public class func reflect() -> Type<AutoQueryService> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AutoQueryService>(
            properties: [
                Type<AutoQueryService>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
                Type<AutoQueryService>.optionalProperty("serviceBaseUrl", get: { $0.serviceBaseUrl }, set: { $0.serviceBaseUrl = $1 }),
                Type<AutoQueryService>.optionalProperty("serviceName", get: { $0.serviceName }, set: { $0.serviceName = $1 }),
                Type<AutoQueryService>.optionalProperty("serviceDescription", get: { $0.serviceDescription }, set: { $0.serviceDescription = $1 }),
                Type<AutoQueryService>.optionalProperty("serviceImageUrl", get: { $0.serviceImageUrl }, set: { $0.serviceImageUrl = $1 }),
                Type<AutoQueryService>.optionalProperty("onlyShowAnnotatedServices", get: { $0.onlyShowAnnotatedServices }, set: { $0.onlyShowAnnotatedServices = $1 }),
                Type<AutoQueryService>.optionalProperty("defaultSearchField", get: { $0.defaultSearchField }, set: { $0.defaultSearchField = $1 }),
                Type<AutoQueryService>.optionalProperty("defaultSearchType", get: { $0.defaultSearchType }, set: { $0.defaultSearchType = $1 }),
                Type<AutoQueryService>.optionalProperty("defaultSearchText", get: { $0.defaultSearchText }, set: { $0.defaultSearchText = $1 }),
                Type<AutoQueryService>.optionalProperty("brandUrl", get: { $0.brandUrl }, set: { $0.brandUrl = $1 }),
                Type<AutoQueryService>.optionalProperty("brandImageUrl", get: { $0.brandImageUrl }, set: { $0.brandImageUrl = $1 }),
                Type<AutoQueryService>.optionalProperty("textColor", get: { $0.textColor }, set: { $0.textColor = $1 }),
                Type<AutoQueryService>.optionalProperty("linkColor", get: { $0.linkColor }, set: { $0.linkColor = $1 }),
                Type<AutoQueryService>.optionalProperty("backgroundColor", get: { $0.backgroundColor }, set: { $0.backgroundColor = $1 }),
                Type<AutoQueryService>.optionalProperty("backgroundImageUrl", get: { $0.backgroundImageUrl }, set: { $0.backgroundImageUrl = $1 }),
                Type<AutoQueryService>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
                Type<AutoQueryService>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
                Type<AutoQueryService>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
                Type<AutoQueryService>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
                Type<AutoQueryService>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AutoQueryService.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AutoQueryService? {
        return AutoQueryService.reflect().fromJson(AutoQueryService(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AutoQueryService? {
        return AutoQueryService.reflect().fromObject(AutoQueryService(), any:any)
    }
    public func toString() -> String {
        return AutoQueryService.reflect().toString(self)
    }
    public class func fromString(string:String) -> AutoQueryService? {
        return AutoQueryService.reflect().fromString(AutoQueryService(), string: string)
    }
}



/* AutoQueryViewer Metadata */

// @Route("/autoquery/metadata")
public class AutoQueryMetadata : IReturn
{
    typealias Return = AutoQueryMetadataResponse
    
    required public init(){}
}

public class AutoQueryMetadataResponse
{
    required public init(){}
    public var config:AutoQueryViewerConfig?
    public var operations:[AutoQueryOperation] = []
    public var types:[MetadataType] = []
    public var responseStatus:ResponseStatus?
}

public class AutoQueryViewerConfig
{
    required public init(){}
    public var serviceBaseUrl:String?
    public var serviceName:String?
    public var serviceDescription:String?
    public var serviceImageUrl:String?

    public var isPublic:Bool?
    public var onlyShowAnnotatedServices:Bool?
    public var implicitConventions:[Property] = []

    public var defaultSearchField:String?
    public var defaultSearchType:String?
    public var defaultSearchText:String?
    
    public var brandUrl:String?
    public var brandImageUrl:String?
    public var textColor:String?
    public var linkColor:String?
    public var backgroundColor:String?
    public var backgroundImageUrl:String?
}

public class AutoQueryOperation
{
    required public init(){}
    public var request:String?
    public var from:String?
    public var to:String?
}

public class MetadataType
{
    required public init(){}
    public var name:String?
    public var namespace:String?
    public var genericArgs:[String] = []
    public var inherits:MetadataTypeName?
    public var displayType:String?
    public var Description:String?
    public var returnVoidMarker:Bool?
    public var isNested:Bool?
    public var isEnum:Bool?
    public var isInterface:Bool?
    public var isAbstract:Bool?
    public var returnMarkerTypeName:MetadataTypeName?
    public var routes:[MetadataRoute] = []
    public var dataContract:MetadataDataContract?
    public var properties:[MetadataPropertyType] = []
    public var attributes:[MetadataAttribute] = []
    public var innerTypes:[MetadataTypeName] = []
    public var enumNames:[String] = []
    public var enumValues:[String] = []
}

public class MetadataTypeName
{
    required public init(){}
    public var name:String?
    public var namespace:String?
    public var genericArgs:[String] = []
}

public class MetadataRoute
{
    required public init(){}
    public var path:String?
    public var verbs:String?
    public var notes:String?
    public var summary:String?
}

public class MetadataDataContract
{
    required public init(){}
    public var name:String?
    public var namespace:String?
}

public class MetadataPropertyType
{
    required public init(){}
    public var name:String?
    public var type:String?
    public var isValueType:Bool?
    public var typeNamespace:String?
    public var genericArgs:[String] = []
    public var value:String?
    public var Description:String?
    public var dataMember:MetadataDataMember?
    public var readOnly:Bool?
    public var paramType:String?
    public var displayType:String?
    public var isRequired:Bool?
    public var allowableValues:[String] = []
    public var allowableMin:Int?
    public var allowableMax:Int?
    public var attributes:[MetadataAttribute] = []
}

public class MetadataAttribute
{
    required public init(){}
    public var name:String?
    public var constructorArgs:[MetadataPropertyType] = []
    public var args:[MetadataPropertyType] = []
}

public class MetadataDataMember
{
    required public init(){}
    public var name:String?
    public var order:Int?
    public var isRequired:Bool?
    public var emitDefaultValue:Bool?
}

// @DataContract
public class Property
{
    required public init(){}
    // @DataMember
    public var name:String?
    
    // @DataMember
    public var value:String?
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

extension AutoQueryMetadata : JsonSerializable
{
    public class var typeName:String { return "AutoQueryMetadata" }
    public class func reflect() -> Type<AutoQueryMetadata> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AutoQueryMetadata>(
            properties: [
            ]))
    }
    public func toJson() -> String {
        return AutoQueryMetadata.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AutoQueryMetadata? {
        return AutoQueryMetadata.reflect().fromJson(AutoQueryMetadata(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AutoQueryMetadata? {
        return AutoQueryMetadata.reflect().fromObject(AutoQueryMetadata(), any:any)
    }
    public func toString() -> String {
        return AutoQueryMetadata.reflect().toString(self)
    }
    public class func fromString(string:String) -> AutoQueryMetadata? {
        return AutoQueryMetadata.reflect().fromString(AutoQueryMetadata(), string: string)
    }
}

extension AutoQueryMetadataResponse : JsonSerializable
{
    public class var typeName:String { return "AutoQueryMetadataResponse" }
    public class func reflect() -> Type<AutoQueryMetadataResponse> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AutoQueryMetadataResponse>(
            properties: [
                Type<AutoQueryMetadataResponse>.optionalObjectProperty("config", get: { $0.config }, set: { $0.config = $1 }),
                Type<AutoQueryMetadataResponse>.arrayProperty("operations", get: { $0.operations }, set: { $0.operations = $1 }),
                Type<AutoQueryMetadataResponse>.arrayProperty("types", get: { $0.types }, set: { $0.types = $1 }),
                Type<AutoQueryMetadataResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AutoQueryMetadataResponse.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AutoQueryMetadataResponse? {
        return AutoQueryMetadataResponse.reflect().fromJson(AutoQueryMetadataResponse(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AutoQueryMetadataResponse? {
        return AutoQueryMetadataResponse.reflect().fromObject(AutoQueryMetadataResponse(), any:any)
    }
    public func toString() -> String {
        return AutoQueryMetadataResponse.reflect().toString(self)
    }
    public class func fromString(string:String) -> AutoQueryMetadataResponse? {
        return AutoQueryMetadataResponse.reflect().fromString(AutoQueryMetadataResponse(), string: string)
    }
}
extension AutoQueryViewerConfig : JsonSerializable
{
    public class var typeName:String { return "AutoQueryViewerConfig" }
    public class func reflect() -> Type<AutoQueryViewerConfig> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AutoQueryViewerConfig>(
            properties: [
                Type<AutoQueryViewerConfig>.optionalProperty("serviceBaseUrl", get: { $0.serviceBaseUrl }, set: { $0.serviceBaseUrl = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("serviceName", get: { $0.serviceName }, set: { $0.serviceName = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("serviceDescription", get: { $0.serviceDescription }, set: { $0.serviceDescription = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("serviceImageUrl", get: { $0.serviceImageUrl }, set: { $0.serviceImageUrl = $1 }),
                Type<AutoQueryViewerConfig>.arrayProperty("implicitConventions", get: { $0.implicitConventions }, set: { $0.implicitConventions = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("isPublic", get: { $0.isPublic }, set: { $0.isPublic = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("onlyShowAnnotatedServices", get: { $0.onlyShowAnnotatedServices }, set: { $0.onlyShowAnnotatedServices = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("defaultSearchField", get: { $0.defaultSearchField }, set: { $0.defaultSearchField = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("defaultSearchType", get: { $0.defaultSearchType }, set: { $0.defaultSearchType = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("defaultSearchText", get: { $0.defaultSearchText }, set: { $0.defaultSearchText = $1 }),                
                Type<AutoQueryViewerConfig>.optionalProperty("brandUrl", get: { $0.brandUrl }, set: { $0.brandUrl = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("brandImageUrl", get: { $0.brandImageUrl }, set: { $0.brandImageUrl = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("textColor", get: { $0.textColor }, set: { $0.textColor = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("linkColor", get: { $0.linkColor }, set: { $0.linkColor = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("backgroundColor", get: { $0.backgroundColor }, set: { $0.backgroundColor = $1 }),
                Type<AutoQueryViewerConfig>.optionalProperty("backgroundImageUrl", get: { $0.backgroundImageUrl }, set: { $0.backgroundImageUrl = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AutoQueryViewerConfig.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AutoQueryViewerConfig? {
        return AutoQueryViewerConfig.reflect().fromJson(AutoQueryViewerConfig(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AutoQueryViewerConfig? {
        return AutoQueryViewerConfig.reflect().fromObject(AutoQueryViewerConfig(), any:any)
    }
    public func toString() -> String {
        return AutoQueryViewerConfig.reflect().toString(self)
    }
    public class func fromString(string:String) -> AutoQueryViewerConfig? {
        return AutoQueryViewerConfig.reflect().fromString(AutoQueryViewerConfig(), string: string)
    }
}

extension AutoQueryOperation : JsonSerializable
{
    public class var typeName:String { return "AutoQueryOperation" }
    public class func reflect() -> Type<AutoQueryOperation> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<AutoQueryOperation>(
            properties: [
                Type<AutoQueryOperation>.optionalProperty("request", get: { $0.request }, set: { $0.request = $1 }),
                Type<AutoQueryOperation>.optionalProperty("from", get: { $0.from }, set: { $0.from = $1 }),
                Type<AutoQueryOperation>.optionalProperty("to", get: { $0.to }, set: { $0.to = $1 }),
            ]))
    }
    public func toJson() -> String {
        return AutoQueryOperation.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> AutoQueryOperation? {
        return AutoQueryOperation.reflect().fromJson(AutoQueryOperation(), json: json)
    }
    public class func fromObject(any:AnyObject) -> AutoQueryOperation? {
        return AutoQueryOperation.reflect().fromObject(AutoQueryOperation(), any:any)
    }
    public func toString() -> String {
        return AutoQueryOperation.reflect().toString(self)
    }
    public class func fromString(string:String) -> AutoQueryOperation? {
        return AutoQueryOperation.reflect().fromString(AutoQueryOperation(), string: string)
    }
}

extension MetadataType : JsonSerializable
{
    public class var typeName:String { return "MetadataType" }
    public class func reflect() -> Type<MetadataType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataType>(
            properties: [
                Type<MetadataType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<MetadataType>.optionalProperty("namespace", get: { $0.namespace }, set: { $0.namespace = $1 }),
                Type<MetadataType>.arrayProperty("genericArgs", get: { $0.genericArgs }, set: { $0.genericArgs = $1 }),
                Type<MetadataType>.optionalObjectProperty("inherits", get: { $0.inherits }, set: { $0.inherits = $1 }),
                Type<MetadataType>.optionalProperty("displayType", get: { $0.displayType }, set: { $0.displayType = $1 }),
                Type<MetadataType>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
                Type<MetadataType>.optionalProperty("returnVoidMarker", get: { $0.returnVoidMarker }, set: { $0.returnVoidMarker = $1 }),
                Type<MetadataType>.optionalProperty("isNested", get: { $0.isNested }, set: { $0.isNested = $1 }),
                Type<MetadataType>.optionalProperty("isEnum", get: { $0.isEnum }, set: { $0.isEnum = $1 }),
                Type<MetadataType>.optionalProperty("isInterface", get: { $0.isInterface }, set: { $0.isInterface = $1 }),
                Type<MetadataType>.optionalProperty("isAbstract", get: { $0.isAbstract }, set: { $0.isAbstract = $1 }),
                Type<MetadataType>.optionalObjectProperty("returnMarkerTypeName", get: { $0.returnMarkerTypeName }, set: { $0.returnMarkerTypeName = $1 }),
                Type<MetadataType>.arrayProperty("routes", get: { $0.routes }, set: { $0.routes = $1 }),
                Type<MetadataType>.optionalObjectProperty("dataContract", get: { $0.dataContract }, set: { $0.dataContract = $1 }),
                Type<MetadataType>.arrayProperty("properties", get: { $0.properties }, set: { $0.properties = $1 }),
                Type<MetadataType>.arrayProperty("attributes", get: { $0.attributes }, set: { $0.attributes = $1 }),
                Type<MetadataType>.arrayProperty("innerTypes", get: { $0.innerTypes }, set: { $0.innerTypes = $1 }),
                Type<MetadataType>.arrayProperty("enumNames", get: { $0.enumNames }, set: { $0.enumNames = $1 }),
                Type<MetadataType>.arrayProperty("enumValues", get: { $0.enumValues }, set: { $0.enumValues = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataType.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataType? {
        return MetadataType.reflect().fromJson(MetadataType(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataType? {
        return MetadataType.reflect().fromObject(MetadataType(), any:any)
    }
    public func toString() -> String {
        return MetadataType.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataType? {
        return MetadataType.reflect().fromString(MetadataType(), string: string)
    }
}

extension MetadataTypeName : JsonSerializable
{
    public class var typeName:String { return "MetadataTypeName" }
    public class func reflect() -> Type<MetadataTypeName> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataTypeName>(
            properties: [
                Type<MetadataTypeName>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<MetadataTypeName>.optionalProperty("namespace", get: { $0.namespace }, set: { $0.namespace = $1 }),
                Type<MetadataTypeName>.arrayProperty("genericArgs", get: { $0.genericArgs }, set: { $0.genericArgs = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataTypeName.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataTypeName? {
        return MetadataTypeName.reflect().fromJson(MetadataTypeName(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataTypeName? {
        return MetadataTypeName.reflect().fromObject(MetadataTypeName(), any:any)
    }
    public func toString() -> String {
        return MetadataTypeName.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataTypeName? {
        return MetadataTypeName.reflect().fromString(MetadataTypeName(), string: string)
    }
}

extension MetadataRoute : JsonSerializable
{
    public class var typeName:String { return "MetadataRoute" }
    public class func reflect() -> Type<MetadataRoute> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataRoute>(
            properties: [
                Type<MetadataRoute>.optionalProperty("path", get: { $0.path }, set: { $0.path = $1 }),
                Type<MetadataRoute>.optionalProperty("verbs", get: { $0.verbs }, set: { $0.verbs = $1 }),
                Type<MetadataRoute>.optionalProperty("notes", get: { $0.notes }, set: { $0.notes = $1 }),
                Type<MetadataRoute>.optionalProperty("summary", get: { $0.summary }, set: { $0.summary = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataRoute.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataRoute? {
        return MetadataRoute.reflect().fromJson(MetadataRoute(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataRoute? {
        return MetadataRoute.reflect().fromObject(MetadataRoute(), any:any)
    }
    public func toString() -> String {
        return MetadataRoute.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataRoute? {
        return MetadataRoute.reflect().fromString(MetadataRoute(), string: string)
    }
}

extension MetadataDataContract : JsonSerializable
{
    public class var typeName:String { return "MetadataDataContract" }
    public class func reflect() -> Type<MetadataDataContract> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataDataContract>(
            properties: [
                Type<MetadataDataContract>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<MetadataDataContract>.optionalProperty("namespace", get: { $0.namespace }, set: { $0.namespace = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataDataContract.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataDataContract? {
        return MetadataDataContract.reflect().fromJson(MetadataDataContract(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataDataContract? {
        return MetadataDataContract.reflect().fromObject(MetadataDataContract(), any:any)
    }
    public func toString() -> String {
        return MetadataDataContract.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataDataContract? {
        return MetadataDataContract.reflect().fromString(MetadataDataContract(), string: string)
    }
}

extension MetadataPropertyType : JsonSerializable
{
    public class var typeName:String { return "MetadataPropertyType" }
    public class func reflect() -> Type<MetadataPropertyType> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataPropertyType>(
            properties: [
                Type<MetadataPropertyType>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<MetadataPropertyType>.optionalProperty("type", get: { $0.type }, set: { $0.type = $1 }),
                Type<MetadataPropertyType>.optionalProperty("isValueType", get: { $0.isValueType }, set: { $0.isValueType = $1 }),
                Type<MetadataPropertyType>.optionalProperty("typeNamespace", get: { $0.typeNamespace }, set: { $0.typeNamespace = $1 }),
                Type<MetadataPropertyType>.arrayProperty("genericArgs", get: { $0.genericArgs }, set: { $0.genericArgs = $1 }),
                Type<MetadataPropertyType>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
                Type<MetadataPropertyType>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
                Type<MetadataPropertyType>.optionalObjectProperty("dataMember", get: { $0.dataMember }, set: { $0.dataMember = $1 }),
                Type<MetadataPropertyType>.optionalProperty("readOnly", get: { $0.readOnly }, set: { $0.readOnly = $1 }),
                Type<MetadataPropertyType>.optionalProperty("paramType", get: { $0.paramType }, set: { $0.paramType = $1 }),
                Type<MetadataPropertyType>.optionalProperty("displayType", get: { $0.displayType }, set: { $0.displayType = $1 }),
                Type<MetadataPropertyType>.optionalProperty("isRequired", get: { $0.isRequired }, set: { $0.isRequired = $1 }),
                Type<MetadataPropertyType>.arrayProperty("allowableValues", get: { $0.allowableValues }, set: { $0.allowableValues = $1 }),
                Type<MetadataPropertyType>.optionalProperty("allowableMin", get: { $0.allowableMin }, set: { $0.allowableMin = $1 }),
                Type<MetadataPropertyType>.optionalProperty("allowableMax", get: { $0.allowableMax }, set: { $0.allowableMax = $1 }),
                Type<MetadataPropertyType>.arrayProperty("attributes", get: { $0.attributes }, set: { $0.attributes = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataPropertyType.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataPropertyType? {
        return MetadataPropertyType.reflect().fromJson(MetadataPropertyType(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataPropertyType? {
        return MetadataPropertyType.reflect().fromObject(MetadataPropertyType(), any:any)
    }
    public func toString() -> String {
        return MetadataPropertyType.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataPropertyType? {
        return MetadataPropertyType.reflect().fromString(MetadataPropertyType(), string: string)
    }
}

extension MetadataAttribute : JsonSerializable
{
    public class var typeName:String { return "MetadataAttribute" }
    public class func reflect() -> Type<MetadataAttribute> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataAttribute>(
            properties: [
                Type<MetadataAttribute>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<MetadataAttribute>.arrayProperty("constructorArgs", get: { $0.constructorArgs }, set: { $0.constructorArgs = $1 }),
                Type<MetadataAttribute>.arrayProperty("args", get: { $0.args }, set: { $0.args = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataAttribute.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataAttribute? {
        return MetadataAttribute.reflect().fromJson(MetadataAttribute(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataAttribute? {
        return MetadataAttribute.reflect().fromObject(MetadataAttribute(), any:any)
    }
    public func toString() -> String {
        return MetadataAttribute.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataAttribute? {
        return MetadataAttribute.reflect().fromString(MetadataAttribute(), string: string)
    }
}

extension MetadataDataMember : JsonSerializable
{
    public class var typeName:String { return "MetadataDataMember" }
    public class func reflect() -> Type<MetadataDataMember> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<MetadataDataMember>(
            properties: [
                Type<MetadataDataMember>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<MetadataDataMember>.optionalProperty("order", get: { $0.order }, set: { $0.order = $1 }),
                Type<MetadataDataMember>.optionalProperty("isRequired", get: { $0.isRequired }, set: { $0.isRequired = $1 }),
                Type<MetadataDataMember>.optionalProperty("emitDefaultValue", get: { $0.emitDefaultValue }, set: { $0.emitDefaultValue = $1 }),
            ]))
    }
    public func toJson() -> String {
        return MetadataDataMember.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> MetadataDataMember? {
        return MetadataDataMember.reflect().fromJson(MetadataDataMember(), json: json)
    }
    public class func fromObject(any:AnyObject) -> MetadataDataMember? {
        return MetadataDataMember.reflect().fromObject(MetadataDataMember(), any:any)
    }
    public func toString() -> String {
        return MetadataDataMember.reflect().toString(self)
    }
    public class func fromString(string:String) -> MetadataDataMember? {
        return MetadataDataMember.reflect().fromString(MetadataDataMember(), string: string)
    }
}

extension Property : JsonSerializable
{
    public class var typeName:String { return "Property" }
    public class func reflect() -> Type<Property> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<Property>(
            properties: [
                Type<Property>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
                Type<Property>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
            ]))
    }
    public func toJson() -> String {
        return Property.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> Property? {
        return Property.reflect().fromJson(Property(), json: json)
    }
    public class func fromObject(any:AnyObject) -> Property? {
        return Property.reflect().fromObject(Property(), any:any)
    }
    public func toString() -> String {
        return Property.reflect().toString(self)
    }
    public class func fromString(string:String) -> Property? {
        return Property.reflect().fromString(Property(), string: string)
    }
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
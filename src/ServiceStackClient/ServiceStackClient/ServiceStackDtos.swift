#if false

// you'd thing referencing common public DTO's in Swift wouldn't segfault right? Sadly no.
    
//
//  ServiceStack.dtos.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 1/31/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation


// @DataContract
public class ResponseStatus : JsonSerializable
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

// @DataContract
public class ResponseError : JsonSerializable
{
    required public init(){}
    // @DataMember(Order=1, EmitDefaultValue=false)
    public var errorCode:String?
    
    // @DataMember(Order=2, EmitDefaultValue=false)
    public var fieldName:String?
    
    // @DataMember(Order=3, EmitDefaultValue=false)
    public var message:String?
    
    
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

public class QueryBase
{
    required public init(){}
    // @DataMember(Order=1)
    public var skip:Int32?
    
    // @DataMember(Order=2)
    public var take:Int32?
    
    // @DataMember(Order=3)
    public var orderBy:String?
    
    // @DataMember(Order=4)
    public var orderByDesc:String?
}

public class QueryBase_1<T : JsonSerializable> : QueryBase
{
    required public init(){}
}


// @DataContract
public class QueryResponse<Technology : JsonSerializable> : JsonSerializable
{
    required public init(){}
    // @DataMember(Order=1)
    public var offset:Int32?
    
    // @DataMember(Order=2)
    public var total:Int32?
    
    // @DataMember(Order=3)
    public var results:[Technology] = []
    
    // @DataMember(Order=4)
    public var meta:[String:String] = [:]
    
    // @DataMember(Order=5)
    public var responseStatus:ResponseStatus?
    
    
    public class var typeName:String { return "QueryResponse<Technology>" }
    public class func reflect() -> Type<QueryResponse<Technology>> {
        return TypeConfig.config() ?? TypeConfig.configure(Type<QueryResponse<Technology>>(
            properties: [
                Type<QueryResponse<Technology>>.optionalProperty("offset", get: { $0.offset }, set: { $0.offset = $1 }),
                Type<QueryResponse<Technology>>.optionalProperty("total", get: { $0.total }, set: { $0.total = $1 }),
                Type<QueryResponse<Technology>>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
                Type<QueryResponse<Technology>>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
                Type<QueryResponse<Technology>>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ]))
    }
    public func toJson() -> String {
        return QueryResponse<Technology>.reflect().toJson(self)
    }
    public class func fromJson(json:String) -> QueryResponse<Technology>? {
        return QueryResponse<Technology>.reflect().fromJson(QueryResponse<Technology>(), json: json)
    }
    public class func fromObject(any:AnyObject) -> QueryResponse<Technology>? {
        return QueryResponse<Technology>.reflect().fromObject(QueryResponse<Technology>(), any:any)
    }
    public func toString() -> String {
        return QueryResponse<Technology>.reflect().toString(self)
    }
    public class func fromString(string:String) -> QueryResponse<Technology>? {
        return QueryResponse<Technology>.reflect().fromString(QueryResponse<Technology>(), string: string)
    }
}


// @Route("/auth")
// @Route("/auth/{provider}")
// @Route("/authenticate")
// @Route("/authenticate/{provider}")
// @DataContract
public class Authenticate : IReturn, JsonSerializable
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

// @DataContract
public class AuthenticateResponse : JsonSerializable
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

// @Route("/assignroles")
public class AssignRoles : IReturn, JsonSerializable
{
    typealias Return = AssignRolesResponse
    
    required public init(){}
    public var userName:String?
    public var permissions:[String] = []
    public var roles:[String] = []
    
    
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

// @Route("/unassignroles")
public class UnAssignRoles : IReturn, JsonSerializable
{
    typealias Return = UnAssignRolesResponse
    
    required public init(){}
    public var userName:String?
    public var permissions:[String] = []
    public var roles:[String] = []
    
    
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

public class AssignRolesResponse : JsonSerializable
{
    required public init(){}
    public var allRoles:[String] = []
    public var allPermissions:[String] = []
    public var responseStatus:ResponseStatus?
    
    
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

public class UnAssignRolesResponse : JsonSerializable
{
    required public init(){}
    public var allRoles:[String] = []
    public var allPermissions:[String] = []
    public var responseStatus:ResponseStatus?
    
    
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

#endif

//
//  JsonServiceClient.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 1/29/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public protocol IReturn
{
    typealias Return : JsonSerializable
}

public protocol IReturnVoid {}

public protocol IGet {}
public protocol IPost {}
public protocol IPut {}
public protocol IDelete {}
public protocol IPatch {}

public protocol ServiceClient
{
    func get<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return
    func get<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void
    func get<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) throws -> T.Return
    func get<T : JsonSerializable>(relativeUrl:String) throws -> T
    func getAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func getAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void>
    func getAsync<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) -> Promise<T.Return>
    func getAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T>
    
    func post<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return
    func post<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void
    func post<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) throws -> Response
    func postAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func postAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void>
    func postAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response>
    
    func put<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return
    func put<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void
    func put<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) throws -> Response
    func putAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func putAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void>
    func putAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response>
    
    func delete<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return
    func delete<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void
    func delete<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) throws -> T.Return
    func delete<T : JsonSerializable>(relativeUrl:String) throws -> T
    func deleteAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func deleteAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void>
    func deleteAsync<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) -> Promise<T.Return>
    func deleteAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T>
    
    func patch<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return
    func patch<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void
    func patch<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) throws -> Response
    func patchAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func patchAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void>
    func patchAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response>
    
    func send<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return
    func send<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void
    func send<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) throws -> T
    func sendAsync<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) -> Promise<T>
    
    func getData(url:String) throws -> NSData
    func getDataAsync(url:String) -> Promise<NSData>
}

public class JsonServiceClient : ServiceClient
{
    var baseUrl:String
    var replyUrl:String
    var domain:String
    var lastError:NSError?
    var lastTask:NSURLSessionDataTask?
    var onError:((NSError) -> Void)?
    var timeout:NSTimeInterval?
    var cachePolicy:NSURLRequestCachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
    
    var requestFilter:(NSMutableURLRequest -> Void)?
    var responseFilter:(NSURLResponse -> Void)?
    
    public struct Global
    {
        static var requestFilter:(NSMutableURLRequest -> Void)?
        static var responseFilter:(NSURLResponse -> Void)?
        static var onError:((NSError) -> Void)?
    }
    
    public init(baseUrl:String)
    {
        self.baseUrl = baseUrl.hasSuffix("/") ? baseUrl : baseUrl + "/"
        self.replyUrl = self.baseUrl + "json/reply/"
        let url = NSURL(string: self.baseUrl)
        self.domain = url!.host!
    }
    
    func createSession() -> NSURLSession {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        return session
    }
    
    func handleError(nsError:NSError) -> NSError {
        return fireErrorCallbacks(NSError(domain: domain, code: nsError.code,
            userInfo:["responseStatus": ["errorCode":nsError.code.toString(), "message":nsError.description]]))
    }
    
    func fireErrorCallbacks(error:NSError) -> NSError {
        lastError = error
        if onError != nil {
            onError!(error)
        }
        if Global.onError != nil {
            Global.onError!(error)
        }
        return error
    }
    
    func getItem(map:NSDictionary, key:String) -> AnyObject? {
        return map[String(key[0]).lowercaseString + key[1..<key.length]] ?? map[String(key[0]).uppercaseString + key[1..<key.length]]
    }
    
    func populateResponseStatusFields(inout errorInfo:[NSObject : AnyObject], withObject:AnyObject) {
        if let status = getItem(withObject as! NSDictionary, key: "ResponseStatus") as? NSDictionary {
            if let errorCode = getItem(status, key: "errorCode") as? NSString {
                errorInfo["errorCode"] = errorCode
            }
            if let message = getItem(status, key: "message") as? NSString {
                errorInfo["message"] = message
            }
            if let stackTrace = getItem(status, key: "stackTrace") as? NSString {
                errorInfo["stackTrace"] = stackTrace
            }
            if let errors: AnyObject = getItem(status, key: "errors") {
                errorInfo["errors"] = errors
            }
        }
    }
    
    func handleResponse<T : JsonSerializable>(intoResponse:T, data:NSData, response:NSURLResponse, error:NSErrorPointer = nil) -> T? {
        if let nsResponse = response as? NSHTTPURLResponse {
            if nsResponse.statusCode >= 400 {
                var errorInfo = [NSObject : AnyObject]()
                
                errorInfo["statusCode"] = nsResponse.statusCode
                errorInfo["statusDescription"] = nsResponse.description
                
                if let _ = nsResponse.allHeaderFields["Content-Type"] as? String {
                    if let obj:AnyObject = parseJsonBytes(data) {
                        errorInfo["response"] = obj
                        errorInfo["errorCode"] = nsResponse.statusCode.toString()
                        errorInfo["message"] = nsResponse.statusDescription
                        populateResponseStatusFields(&errorInfo, withObject:obj)
                    }
                }
                
                let ex = fireErrorCallbacks(NSError(domain:self.domain, code:nsResponse.statusCode, userInfo:errorInfo))
                if error != nil {
                    error.memory = ex
                }
                
                return nil
            }
        }
        
        if (intoResponse is ReturnVoid) {
            return intoResponse
        }
        
        if responseFilter != nil {
            responseFilter!(response)
        }
        if Global.responseFilter != nil {
            Global.responseFilter!(response)
        }
        
        if let json = NSString(data: data, encoding: NSUTF8StringEncoding) {
            if let dto = Type<T>.fromJson(intoResponse, json: json as String) {
                return dto
            }
        }
        return nil
    }
    
    public func createUrl<T : JsonSerializable>(dto:T, query:[String:String] = [:]) -> String {
        var requestUrl = self.replyUrl + T.typeName

        var sb = ""
        for pi in T.properties {
            if let strValue = pi.jsonValueAny(dto)?.stripQuotes() {
                sb += sb.length == 0 ? "?" : "&"
                sb += "\(pi.name.urlEncode()!)=\(strValue.urlEncode()!)"
            }
            else if let strValue = pi.stringValueAny(dto) {
                sb += sb.length == 0 ? "?" : "&"
                sb += "\(pi.name.urlEncode()!)=\(strValue.urlEncode()!)"
            }
        }
        
        for (key,value) in query {
            sb += sb.length == 0 ? "?" : "&"
            sb += "\(key)=\(value.urlEncode()!)"
        }
        
        requestUrl += sb
        
        return requestUrl
    }
    
    public func createRequest<T : JsonSerializable>(url:String, httpMethod:String, request:T? = nil) -> NSMutableURLRequest {
        var contentType:String?
        var requestBody:NSData?
        
        if let dto = request {
            contentType = "application/json"
            requestBody = dto.toJson().dataUsingEncoding(NSUTF8StringEncoding)
        }
        
        return self.createRequest(url, httpMethod: httpMethod, requestType: contentType, requestBody: requestBody)
    }
    
    public func createRequest(url:String, httpMethod:String, requestType:String? = nil, requestBody:NSData? = nil) -> NSMutableURLRequest {
        let nsUrl = NSURL(string: url)!
        
        let req = self.timeout == nil
            ? NSMutableURLRequest(URL: nsUrl)
            : NSMutableURLRequest(URL: nsUrl, cachePolicy: self.cachePolicy, timeoutInterval: self.timeout!)
        
        req.HTTPMethod = httpMethod
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        
        req.HTTPBody = requestBody
        if let contentType = requestType {
            req.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        
        if requestFilter != nil {
            requestFilter!(req)
        }
        
        if Global.requestFilter != nil {
            Global.requestFilter!(req)
        }
        
        return req
    }
    
    public func send<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) throws -> T {
        var response:NSURLResponse? = nil
        
        var data = NSData()
        do {
            data = try NSURLConnection.sendSynchronousRequest(request, returningResponse: &response)
            var error:NSError? = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)
            if response == nil {
                if let e = error {
                    throw e
                }
                return T()
            }
            if let dto = self.handleResponse(intoResponse, data: data, response: response!, error: &error) {
                return dto
            }
            if let e = error {
                throw e
            }
            return T()
        } catch var ex as NSError? {
            if let r = response, let e = self.handleResponse(intoResponse, data: data, response: r, error: &ex) {
                return e
            }
            throw ex!
        }
    }
    
    public func sendAsync<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) -> Promise<T> {
        
        return Promise<T> { (complete, reject) in
            
            let task = self.createSession().dataTaskWithRequest(request) { (data, response, error) in
                if error != nil {
                    reject(self.handleError(error!))
                }
                else {
                    var resposneError:NSError?
                    let response = self.handleResponse(intoResponse, data: data!, response: response!, error: &resposneError)
                    if resposneError != nil {
                        reject(self.fireErrorCallbacks(resposneError!))
                    }
                    else if let dto = response {
                        complete(dto)
                    } else {
                        complete(T()) //return empty dto in promise callbacks
                    }
                }
            }
            
            task.resume()
            self.lastTask = task
        }
    }
    
    func resolveUrl(relativeOrAbsoluteUrl:String) -> String {
        return relativeOrAbsoluteUrl.hasPrefix("http:")
            || relativeOrAbsoluteUrl.hasPrefix("https:")
            ? relativeOrAbsoluteUrl
            : baseUrl.combinePath(relativeOrAbsoluteUrl)
    }
    
    func hasRequestBody(httpMethod:String) -> Bool
    {
        switch httpMethod {
            case HttpMethods.Get, HttpMethods.Delete, HttpMethods.Head, HttpMethods.Options:
                return false
            default:
                return true
        }
    }
    
    func getSendMethod<T : JsonSerializable>(request:T) -> String {
        return request is IGet ?
             HttpMethods.Get
            : request is IPost ?
              HttpMethods.Post
            : request is IPut ?
              HttpMethods.Put
            : request is IDelete ?
              HttpMethods.Delete
            : request is IPatch ?
              HttpMethods.Patch :
              HttpMethods.Post;
    }
    
    public func send<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return {
        let httpMethod = getSendMethod(request)
        return hasRequestBody(httpMethod)
            ? try send(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:httpMethod, request:request))
            : try send(T.Return(), request: self.createRequest(self.createUrl(request), httpMethod:httpMethod))
    }
    
    public func send<T : IReturnVoid where T : JsonSerializable>(request:T) throws {
        let httpMethod = getSendMethod(request)
        if hasRequestBody(httpMethod) {
            try send(ReturnVoid.void, request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:httpMethod, request:request))
        }
        else {
            try send(ReturnVoid.void, request: self.createRequest(self.createUrl(request), httpMethod:httpMethod))
        }
    }
    
    public func sendAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        let httpMethod = getSendMethod(request)
        return hasRequestBody(httpMethod)
            ? sendAsync(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:httpMethod, request:request))
            : sendAsync(T.Return(), request: self.createRequest(self.createUrl(request), httpMethod:httpMethod))
    }
    
    public func sendAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void> {
        let httpMethod = getSendMethod(request)
        return hasRequestBody(httpMethod)
            ? sendAsync(ReturnVoid.void, request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
              .then({ x -> Void in })
            : sendAsync(ReturnVoid.void, request: self.createRequest(self.createUrl(request), httpMethod:HttpMethods.Get))
                .then({ x -> Void in })
    }
   
    
    public func get<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return {
        return try send(T.Return(), request: self.createRequest(self.createUrl(request), httpMethod:HttpMethods.Get))
    }
    
    public func get<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void {
        try send(ReturnVoid.void, request: self.createRequest(self.createUrl(request), httpMethod:HttpMethods.Get))
    }
    
    public func get<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) throws -> T.Return {
        return try send(T.Return(), request: self.createRequest(self.createUrl(request, query:query), httpMethod:HttpMethods.Get))
    }
    
    public func get<T : JsonSerializable>(relativeUrl:String) throws -> T {
        return try send(T(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Get))
    }
    
    public func getAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(request), httpMethod:HttpMethods.Get))
    }
    
    public func getAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void> {
        return sendAsync(ReturnVoid.void, request: self.createRequest(self.createUrl(request), httpMethod:HttpMethods.Get))
            .then({ x -> Void in })
    }
    
    public func getAsync<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(request, query:query), httpMethod:HttpMethods.Get))
    }
    
    public func getAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T> {
        return sendAsync(T(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Get))
    }
    
    
    public func post<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return {
        return try send(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
    }
    
    public func post<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void {
        try send(ReturnVoid.void, request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
    }
    
    public func post<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) throws -> Response {
        return try send(Response(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Post, request:request))
    }
    
    public func postAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
    }
    
    public func postAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void> {
        return sendAsync(ReturnVoid.void, request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
            .then({ x -> Void in })
    }
    
    public func postAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(Response(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Post, request:request))
    }
    
    
    public func put<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return {
        return try send(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request))
    }
    
    public func put<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void {
        try send(ReturnVoid.void, request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request))
    }
    
    public func put<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) throws -> Response {
        return try send(Response(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Put, request:request))
    }
    
    public func putAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request))
    }
    
    public func putAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void> {
        return sendAsync(ReturnVoid.void, request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request))
            .then({ x -> Void in })
    }
    
    public func putAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(Response(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Put, request:request))
    }
    
    
    public func delete<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return {
        return try send(T.Return(), request: self.createRequest(self.createUrl(request), httpMethod:HttpMethods.Delete))
    }
    
    public func delete<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void {
        try send(ReturnVoid.void, request: self.createRequest(self.createUrl(request), httpMethod:HttpMethods.Delete))
    }
    
    public func delete<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) throws -> T.Return {
        return try send(T.Return(), request: self.createRequest(self.createUrl(request, query:query), httpMethod:HttpMethods.Delete))
    }
    
    public func delete<T : JsonSerializable>(relativeUrl:String) throws -> T {
        return try send(T(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Delete))
    }
    
    public func deleteAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(request), httpMethod:HttpMethods.Delete))
    }
    
    public func deleteAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void> {
        return sendAsync(ReturnVoid.void, request: self.createRequest(self.createUrl(request), httpMethod:HttpMethods.Delete))
            .then({ x -> Void in })
    }
    
    public func deleteAsync<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(request, query:query), httpMethod:HttpMethods.Delete))
    }
    
    public func deleteAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T> {
        return sendAsync(T(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Delete))
    }
    
    
    public func patch<T : IReturn where T : JsonSerializable>(request:T) throws -> T.Return {
        return try send(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Patch, request:request))
    }
    
    public func patch<T : IReturnVoid where T : JsonSerializable>(request:T) throws -> Void {
        try send(ReturnVoid.void, request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Patch, request:request))
    }
    
    public func patch<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) throws -> Response {
        return try send(Response(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Patch, request:request))
    }
    
    public func patchAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Patch, request:request))
    }
    
    public func patchAsync<T : IReturnVoid where T : JsonSerializable>(request:T) -> Promise<Void> {
        return sendAsync(ReturnVoid.void, request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Patch, request:request))
            .then({ x -> Void in })
    }
    
    public func patchAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(Response(), request: self.createRequest(resolveUrl(relativeUrl), httpMethod:HttpMethods.Patch, request:request))
    }
    
    
    public func getData(url:String) throws -> NSData {
        var error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        var response:NSURLResponse? = nil
        do {
            let data = try NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: NSURL(string:resolveUrl(url))!), returningResponse: &response)
            return data
        } catch let error1 as NSError {
            error = error1
        }
        throw error
    }
    
    public func getDataAsync(url:String) -> Promise<NSData> {
        return Promise<NSData> { (complete, reject) in
            let task = self.createSession().dataTaskWithURL(NSURL(string: self.resolveUrl(url))!) { (data, response, error) in
                if error != nil {
                    reject(self.handleError(error!))
                }
                complete(data!)
            }
            
            task.resume()
            self.lastTask = task
        }
    }
}


extension NSHTTPURLResponse {

    //Unfortunately no API gives us the real statusDescription so using Status Code descriptions instead
    public var statusDescription:String {
        switch self.statusCode {
        case 200: return "OK"
        case 201: return "Created"
        case 202: return "Accepted"
        case 205: return "No Content"
        case 206: return "Partial Content"

        case 400: return "Bad Request"
        case 401: return "Unauthorized"
        case 403: return "Forbidden"
        case 404: return "Not Found"
        case 405: return "Method Not Allowed"
        case 406: return "Not Acceptable"
        case 407: return "Proxy Authentication Required"
        case 408: return "Request Timeout"
        case 409: return "Conflict"
        case 410: return "Gone"
        case 418: return "I'm a teapot"
            
        case 500: return "Internal Server Error"
        case 501: return "Not Implemented"
        case 502: return "Bad Gateway"
        case 503: return "Service Unavailable"
            
        default: return "\(self.statusCode)"
        }
    }
}

public struct HttpMethods
{
    static let Get = "GET"
    static let Post = "POST"
    static let Put = "PUT"
    static let Delete = "DELETE"
    static let Head = "HEAD"
    static let Options = "OPTIONS"
    static let Patch = "PATCH"
}


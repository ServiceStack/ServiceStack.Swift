/* Url: https://servicestack.net/dist/JsonServiceClient.swift
//
// JsonServiceClient.swift
// ServiceStackClient
//
// Copyright (c) 2017 ServiceStack LLC. All rights reserved.
// License: https://servicestack.net/terms
*/

import Foundation



public protocol IReturn
{
    associatedtype Return : JsonSerializable
}

public protocol IReturnVoid {}

public protocol IGet {}
public protocol IPost {}
public protocol IPut {}
public protocol IDelete {}
public protocol IPatch {}

public protocol ServiceClient
{
    func get<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable
    func get<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable
    func get<T : IReturn>(_ request:T, query:[String:String]) throws -> T.Return where T : JsonSerializable
    func get<T : JsonSerializable>(_ relativeUrl:String) throws -> T
    func getAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable
    func getAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable
    func getAsync<T : IReturn>(_ request:T, query:[String:String]) -> Promise<T.Return> where T : JsonSerializable
    func getAsync<T : JsonSerializable>(_ relativeUrl:String) -> Promise<T>
    
    func post<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable
    func post<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable
    func post<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) throws -> Response
    func postAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable
    func postAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable
    func postAsync<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) -> Promise<Response>
    
    func put<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable
    func put<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable
    func put<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) throws -> Response
    func putAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable
    func putAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable
    func putAsync<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) -> Promise<Response>
    
    func delete<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable
    func delete<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable
    func delete<T : IReturn>(_ request:T, query:[String:String]) throws -> T.Return where T : JsonSerializable
    func delete<T : JsonSerializable>(_ relativeUrl:String) throws -> T
    func deleteAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable
    func deleteAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable
    func deleteAsync<T : IReturn>(_ request:T, query:[String:String]) -> Promise<T.Return> where T : JsonSerializable
    func deleteAsync<T : JsonSerializable>(_ relativeUrl:String) -> Promise<T>
    
    func patch<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable
    func patch<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable
    func patch<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) throws -> Response
    func patchAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable
    func patchAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable
    func patchAsync<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) -> Promise<Response>
    
    func send<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable
    func send<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable
    func send<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) throws -> T
    func sendAsync<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) -> Promise<T>
    
    func getData(_ url:String) throws -> Data
    func getDataAsync(_ url:String) -> Promise<Data>
}

public class JsonServiceClient : ServiceClient
{
    var baseUrl:String
    var replyUrl:String
    var domain:String
    var lastError:NSError?
    var lastTask:URLSessionDataTask?
    var onError:((NSError) -> Void)?
    var timeout:TimeInterval?
    var cachePolicy:NSURLRequest.CachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
    
    var requestFilter:((NSMutableURLRequest) -> Void)?
    var responseFilter:((URLResponse) -> Void)?
    
    public struct Global
    {
        static var requestFilter:((NSMutableURLRequest) -> Void)?
        static var responseFilter:((URLResponse) -> Void)?
        static var onError:((NSError) -> Void)?
    }
    
    public init(baseUrl:String)
    {
        self.baseUrl = baseUrl.hasSuffix("/") ? baseUrl : baseUrl + "/"
        self.replyUrl = self.baseUrl + "json/reply/"
        let url = NSURL(string: self.baseUrl)
        self.domain = url!.host!
    }
    
    func createSession() -> URLSession {
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        return session
    }
    
    func handleError(nsError:NSError) -> NSError {
        return fireErrorCallbacks(error: NSError(domain: domain, code: nsError.code,
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
    
    func getItem(map:NSDictionary, key:String) -> Any? {
        return map[String(key[0]).lowercased() + key[1..<key.length]] ?? map[String(key[0]).uppercased() + key[1..<key.length]]
    }
    
    func populateResponseStatusFields(errorInfo:inout [AnyHashable : Any], withObject:Any) {
        if let status = getItem(map: withObject as! NSDictionary, key: "ResponseStatus") as? NSDictionary {
            if let errorCode = getItem(map: status, key: "errorCode") as? NSString {
                errorInfo["errorCode"] = errorCode
            }
            if let message = getItem(map: status, key: "message") as? NSString {
                errorInfo["message"] = message
            }
            if let stackTrace = getItem(map: status, key: "stackTrace") as? NSString {
                errorInfo["stackTrace"] = stackTrace
            }
            if let errors: Any = getItem(map: status, key: "errors") {
                errorInfo["errors"] = errors
            }
        }
    }
    
    func handleResponse<T : JsonSerializable>(intoResponse:T, data:Data, response:URLResponse, error:NSErrorPointer = nil) -> T? {
        if let nsResponse = response as? HTTPURLResponse {
            if nsResponse.statusCode >= 400 {
                var errorInfo = [AnyHashable : Any]()
                
                errorInfo["statusCode"] = nsResponse.statusCode
                errorInfo["statusDescription"] = nsResponse.description
                
                if let _ = nsResponse.allHeaderFields["Content-Type"] as? String {
                    if let obj:Any = parseJsonBytes(data) {
                        errorInfo["response"] = obj
                        errorInfo["errorCode"] = nsResponse.statusCode.toString()
                        errorInfo["message"] = nsResponse.statusDescription
                        populateResponseStatusFields(errorInfo: &errorInfo, withObject:obj)
                    }
                }
                
                let ex = fireErrorCallbacks(error: NSError(domain:self.domain, code:nsResponse.statusCode, userInfo:errorInfo))
                if error != nil {
                    error?.pointee = ex
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
        
        if let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            if let dto = Type<T>.fromJson(instance: intoResponse, json: json as String) {
                return dto
            }
        }
        return nil
    }
    
    public func createUrl<T : JsonSerializable>(dto:T, query:[String:String] = [:]) -> String {
        var requestUrl = self.replyUrl + T.typeName
        
        var sb = ""
        for pi in T.properties {
            if let strValue = pi.jsonValueAny(instance: dto)?.stripQuotes() {
                sb += sb.length == 0 ? "?" : "&"
                sb += "\(pi.name.urlEncode()!)=\(strValue.urlEncode()!)"
            }
            else if let strValue = pi.stringValueAny(instance: dto) {
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
    
    public func createRequestDto<T : JsonSerializable>(url:String, httpMethod:String, request:T?) -> NSMutableURLRequest {
        var contentType:String?
        var requestBody:Data?
        
        if let dto = request {
            contentType = "application/json"
            requestBody = dto.toJson().data(using: String.Encoding.utf8)
        }
        
        return self.createRequest(url: url, httpMethod: httpMethod, requestType: contentType, requestBody: requestBody)
    }
    
    public func createRequest(url:String, httpMethod:String, requestType:String? = nil, requestBody:Data? = nil) -> NSMutableURLRequest {
        let nsUrl = NSURL(string: url)!
        
        let req = self.timeout == nil
            ? NSMutableURLRequest(url: nsUrl as URL)
            : NSMutableURLRequest(url: nsUrl as URL, cachePolicy: self.cachePolicy, timeoutInterval: self.timeout!)
        
        req.httpMethod = httpMethod
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        
        req.httpBody = requestBody
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
    
    @discardableResult public func send<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) throws -> T {
        var response:URLResponse? = nil
        
        var data = Data()
        do {
            data = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
            var error:NSError? = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)
            if response == nil {
                if let e = error {
                    throw e
                }
                return T()
            }
            if let dto = self.handleResponse(intoResponse: intoResponse, data: data, response: response!, error: &error) {
                return dto
            }
            if let e = error {
                throw e
            }
            return T()
        } catch var ex as NSError? {
            if let r = response, let e = self.handleResponse(intoResponse: intoResponse, data: data, response: r, error: &ex) {
                return e
            }
            throw ex!
        }
    }
    
    @discardableResult public func sendAsync<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) -> Promise<T> {
        
        return Promise<T> { (complete, reject) in
            
            let task = self.createSession().dataTask(with: request as URLRequest) { (data, response, error) in
                if error != nil {
                    reject(self.handleError(nsError: error as! NSError))
                }
                else {
                    var resposneError:NSError?
                    let response = self.handleResponse(intoResponse: intoResponse, data: data!, response: response!, error: &resposneError)
                    if resposneError != nil {
                        reject(self.fireErrorCallbacks(error: resposneError!))
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
    
    func resolveUrl(_ relativeOrAbsoluteUrl:String) -> String {
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
    
    func getSendMethod<T : JsonSerializable>(_ request:T) -> String {
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
    
    public func send<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable {
        let httpMethod = getSendMethod(request)
        if hasRequestBody(httpMethod: httpMethod) {
            return try send(intoResponse: T.Return(), request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:httpMethod, request:request))
        }
        
        return try send(intoResponse: T.Return(), request: self.createRequest(url:self.createUrl(dto: request), httpMethod:httpMethod))
        
    }
    
    public func send<T : IReturnVoid>(_ request:T) throws where T : JsonSerializable {
        let httpMethod = getSendMethod(request)
        if hasRequestBody(httpMethod: httpMethod) {
            try send(intoResponse: ReturnVoid.void, request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:httpMethod, request:request))
        }
        else {
            try send(intoResponse: ReturnVoid.void, request: self.createRequest(url: self.createUrl(dto: request), httpMethod:httpMethod))
        }
    }
    
    public func sendAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable {
        let httpMethod = getSendMethod(request)
        return hasRequestBody(httpMethod: httpMethod)
            ? sendAsync(intoResponse: T.Return(), request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:httpMethod, request:request))
            : sendAsync(intoResponse: T.Return(), request: self.createRequest(url: self.createUrl(dto: request), httpMethod:httpMethod))
    }
    
    public func sendAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable {
        let httpMethod = getSendMethod(request)
        return hasRequestBody(httpMethod: httpMethod)
            ? sendAsync(intoResponse: ReturnVoid.void, request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
                .asVoid()
            : sendAsync(intoResponse: ReturnVoid.void, request: self.createRequest(url: self.createUrl(dto: request), httpMethod:HttpMethods.Get))
                .asVoid()
    }
    
    
    public func get<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable {
        return try send(intoResponse: T.Return(), request: self.createRequest(url: self.createUrl(dto: request), httpMethod:HttpMethods.Get))
    }
    
    @discardableResult public func get<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
        try send(intoResponse: ReturnVoid.void, request: self.createRequest(url: self.createUrl(dto: request), httpMethod:HttpMethods.Get))
    }
    
    public func get<T : IReturn>(_ request:T, query:[String:String]) throws -> T.Return where T : JsonSerializable {
        return try send(intoResponse: T.Return(), request: self.createRequest(url: self.createUrl(dto: request, query:query), httpMethod:HttpMethods.Get))
    }
    
    public func get<T : JsonSerializable>(_ relativeUrl:String) throws -> T {
        return try send(intoResponse: T(), request: self.createRequest(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Get))
    }
    
    public func getAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable {
        return sendAsync(intoResponse: T.Return(), request: self.createRequest(url: self.createUrl(dto: request), httpMethod:HttpMethods.Get))
    }
    
    @discardableResult public func getAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable {
        return sendAsync(intoResponse: ReturnVoid.void, request: self.createRequest(url: self.createUrl(dto: request), httpMethod:HttpMethods.Get))
            .asVoid()
    }
    
    public func getAsync<T : IReturn>(_ request:T, query:[String:String]) -> Promise<T.Return> where T : JsonSerializable {
        return sendAsync(intoResponse: T.Return(), request: self.createRequest(url: self.createUrl(dto: request, query:query), httpMethod:HttpMethods.Get))
    }
    
    public func getAsync<T : JsonSerializable>(_ relativeUrl:String) -> Promise<T> {
        return sendAsync(intoResponse: T(), request: self.createRequest(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Get))
    }
    
    
    @discardableResult public func post<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable {
        return try send(intoResponse: T.Return(), request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
    }
    
    @discardableResult public func post<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
        try send(intoResponse: ReturnVoid.void, request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
    }
    
    @discardableResult public func post<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) throws -> Response {
        return try send(intoResponse: Response(), request: self.createRequestDto(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Post, request:request))
    }
    
    @discardableResult public func postAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable {
        return sendAsync(intoResponse: T.Return(), request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
    }
    
    @discardableResult public func postAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable {
        return sendAsync(intoResponse: ReturnVoid.void, request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
            .asVoid()
    }
    
    @discardableResult public func postAsync<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(intoResponse: Response(), request: self.createRequestDto(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Post, request:request))
    }
    
    
    @discardableResult public func put<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable {
        return try send(intoResponse: T.Return(), request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request))
    }
    
    @discardableResult public func put<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
        try send(intoResponse: ReturnVoid.void, request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request))
    }
    
    @discardableResult public func put<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) throws -> Response {
        return try send(intoResponse: Response(), request: self.createRequestDto(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Put, request:request))
    }
    
    @discardableResult public func putAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable {
        return sendAsync(intoResponse: T.Return(), request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request))
    }
    
    @discardableResult public func putAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable {
        return sendAsync(intoResponse: ReturnVoid.void, request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request))
            .asVoid()
    }
    
    @discardableResult public func putAsync<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(intoResponse: Response(), request: self.createRequestDto(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Put, request:request))
    }
    
    
    @discardableResult public func delete<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable {
        return try send(intoResponse: T.Return(), request: self.createRequest(url: self.createUrl(dto: request), httpMethod:HttpMethods.Delete))
    }
    
    @discardableResult public func delete<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
        try send(intoResponse: ReturnVoid.void, request: self.createRequest(url: self.createUrl(dto: request), httpMethod:HttpMethods.Delete))
    }
    
    @discardableResult public func delete<T : IReturn>(_ request:T, query:[String:String]) throws -> T.Return where T : JsonSerializable {
        return try send(intoResponse: T.Return(), request: self.createRequest(url: self.createUrl(dto: request, query:query), httpMethod:HttpMethods.Delete))
    }
    
    @discardableResult public func delete<T : JsonSerializable>(_ relativeUrl:String) throws -> T {
        return try send(intoResponse: T(), request: self.createRequest(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Delete))
    }
    
    @discardableResult public func deleteAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable {
        return sendAsync(intoResponse: T.Return(), request: self.createRequest(url: self.createUrl(dto: request), httpMethod:HttpMethods.Delete))
    }
    
    @discardableResult public func deleteAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable {
        return sendAsync(intoResponse: ReturnVoid.void, request: self.createRequest(url: self.createUrl(dto: request), httpMethod:HttpMethods.Delete))
            .asVoid()
    }
    
    @discardableResult public func deleteAsync<T : IReturn>(_ request:T, query:[String:String]) -> Promise<T.Return> where T : JsonSerializable {
        return sendAsync(intoResponse: T.Return(), request: self.createRequest(url: self.createUrl(dto: request, query:query), httpMethod:HttpMethods.Delete))
    }
    
    @discardableResult public func deleteAsync<T : JsonSerializable>(_ relativeUrl:String) -> Promise<T> {
        return sendAsync(intoResponse: T(), request: self.createRequest(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Delete))
    }
    
    
    @discardableResult public func patch<T : IReturn>(_ request:T) throws -> T.Return where T : JsonSerializable {
        return try send(intoResponse: T.Return(), request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Patch, request:request))
    }
    
    @discardableResult public func patch<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
        try send(intoResponse: ReturnVoid.void, request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Patch, request:request))
    }
    
    @discardableResult public func patch<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) throws -> Response {
        return try send(intoResponse: Response(), request: self.createRequestDto(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Patch, request:request))
    }
    
    @discardableResult public func patchAsync<T : IReturn>(_ request:T) -> Promise<T.Return> where T : JsonSerializable {
        return sendAsync(intoResponse: T.Return(), request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Patch, request:request))
    }
    
    @discardableResult public func patchAsync<T : IReturnVoid>(_ request:T) -> Promise<Void> where T : JsonSerializable {
        return sendAsync(intoResponse: ReturnVoid.void, request: self.createRequestDto(url: replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Patch, request:request))
            .asVoid()
    }
    
    @discardableResult public func patchAsync<Response : JsonSerializable, Request:JsonSerializable>(_ relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(intoResponse: Response(), request: self.createRequestDto(url: resolveUrl(relativeUrl), httpMethod:HttpMethods.Patch, request:request))
    }
    
    
    public func getData(_ url:String) throws -> Data {
        var error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        var response:URLResponse? = nil
        do {
            let data = try NSURLConnection.sendSynchronousRequest(URLRequest(url: URL(string:resolveUrl(url))!), returning: &response)
            return data
        } catch let error1 as NSError {
            error = error1
        }
        throw error
    }
    
    public func getDataAsync(_ url:String) -> Promise<Data> {
        return Promise<Data> { (complete, reject) in
            let task = self.createSession().dataTask(with: URL(string: self.resolveUrl(url))!) { (data, response, error) in
                if error != nil {
                    reject(self.handleError(nsError: error! as NSError))
                }
                complete(data!)
            }
            
            task.resume()
            self.lastTask = task
        }
    }
}


extension HTTPURLResponse {
    
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


public class JObject
{
    var sb : String
    
    init(string : String? = nil) {
        sb = string ?? String()
    }
    
    func append(name: String, json: String?) {
        if sb.length > 0 {
            sb += ","
        }
        if let s = json {
            sb += "\"\(name)\":\(s)"
        }
        else {
            sb += "\"\(name)\":null"
        }
    }
    
    func toJson() -> String {
        return "{\(sb)}"
    }
    
    static func asJson<K : Hashable, V : JsonSerializable>(map:[K:V]) -> String? where K : StringSerializable {
        let jb = JObject()
        
        for (k,v) in map {
            jb.append(name: k.toString(), json: v.toJson())
        }
        
        return jb.toJson()
    }
}

public class JArray
{
    var sb : String
    
    init(string : String? = nil) {
        sb = string ?? String()
    }
    
    func append(json:String?) {
        if sb.characters.count > 0 {
            sb += ","
        }
        sb += json != nil ? "\(json!)" : "null"
    }
    
    func toJson() -> String {
        return "[\(sb)]"
    }
}

public class JValue
{
    static func unwrap(any:Any) -> Any {
        
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .optional {
            return any
        }
        
        if mi.children.count == 0 { return NSNull() }
        let (_, some) = mi.children.first!
        return some
    }
}

func parseJson(_ json:String) -> Any? {
    do {
        return try parseJsonThrows(json)
    } catch _ {
        return nil
    }
}

func parseJsonThrows(_ json:String) throws -> Any {
    let data = json.data(using: String.Encoding.utf8)!
    return try parseJsonBytesThrows(data)
}

func parseJsonBytes(_ bytes:Data) -> Any? {
    do {
        return try parseJsonBytesThrows(bytes)
    } catch _ {
        return nil
    }
}

func parseJsonBytesThrows(_ bytes:Data) throws -> Any {
    var error: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
    let parsedObject: Any?
    do {
        parsedObject = try JSONSerialization.jsonObject(with: bytes,
                options: JSONSerialization.ReadingOptions.allowFragments)
    } catch let error1 as NSError {
        error = error1
        parsedObject = nil
    }
    if let value = parsedObject {
        return value
    }
    throw error
}

extension NSString : JsonSerializable
{
    public static var typeName:String { return "NSString" }
    
    public static var metadata:Metadata = Metadata.create([])
    
    public func toString() -> String {
        return self as String
    }
    
    public func toJson() -> String {
        return jsonString(self as String)
    }
    
    public static func fromJson(_ json:String) -> NSString? {
        return parseJson(json) as? NSString
    }
    
    public static func fromString(_ string: String) -> NSString? {
        return string as NSString?
    }
    
    public static func fromObject(_ any:Any) -> NSString?
    {
        switch any {
        case let s as NSString: return s
        default:return nil
        }
    }
}

public class ReturnVoid {
    public required init(){}
}

extension ReturnVoid : JsonSerializable
{
    public static let void = ReturnVoid()
    
    public static var typeName:String { return "ReturnVoid" }
    
    public static var metadata:Metadata = Metadata.create([])
    
    public func toString() -> String {
        return ""
    }
    
    public func toJson() -> String {
        return ""
    }
    
    public static func fromJson(_ json:String) -> NSString? {
        return nil
    }
    
    public static func fromString(_ string: String) -> NSString? {
        return nil
    }
    
    public static func fromObject(_ any:Any) -> NSString?
    {
        return nil
    }
}

public class HttpWebResponse {
    required public init(){}
}

extension HttpWebResponse : JsonSerializable
{
    public static let void = HttpWebResponse()
    
    public static var typeName:String { return "HttpWebResponse" }
    
    public static var metadata:Metadata = Metadata.create([])
    
    public func toString() -> String {
        return ""
    }
    
    public func toJson() -> String {
        return ""
    }
    
    public static func fromJson(_ json:String) -> HttpWebResponse? {
        return nil
    }
    
    public static func fromString(_ string: String) -> HttpWebResponse? {
        return nil
    }
    
    public static func fromObject(_ any:Any) -> HttpWebResponse?
    {
        return nil
    }
}

extension Data : JsonSerializable
{
    public static let void = Data()
    
    public static var typeName:String { return "Data" }
    
    public static var metadata:Metadata = Metadata.create([])
    
    public func toString() -> String {
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue) as! String
    }
    
    public func toJson() -> String {
        return toString()
    }
    
    public static func fromJson(_ json:String) -> Data? {
        return fromString(json)
    }
    
    public static func fromString(_ string: String) -> Data? {
        return string.data(using: String.Encoding.utf8)
    }
    
    public static func fromObject(_ any:Any) -> Data?
    {
        switch any {
        case let d as Data: return d
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension String : StringSerializable
{
    public static var typeName:String { return "String" }
    
    public func toString() -> String {
        return self
    }
    
    public func toJson() -> String {
        return jsonString(self)
    }
    
    public static func fromString(_ string: String) -> String? {
        return string
    }
    
    public static func fromObject(_ any:Any) -> String?
    {
        switch any {
        case let s as String: return s
        default:return nil
        }
    }
}

extension String : JsonSerializable
{
    public static var metadata:Metadata = Metadata.create([])
    
    public static func fromJson(_ json:String) -> String? {
        return parseJson(json) as? String
    }
}

extension Character : StringSerializable
{
    public static var typeName:String { return "Character" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return jsonString(toString())
    }
    
    public static func fromString(_ string: String) -> Character? {
        return string.length > 0 ? string[0] : nil
    }
    
    public static func fromObject(_ any:Any) -> Character?
    {
        switch any {
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Date : StringSerializable
{
    public static var typeName:String { return "Date" }
    
    public func toString() -> String {
        return self.dateAndTimeString
    }
    
    public func toJson() -> String {
        return jsonString(self.jsonDate)
    }
    
    public static func fromString(_ string: String) -> Date? {
        let str = string.hasPrefix("\\")
            ? string[1..<string.length]
            : string
        let wcfJsonPrefix = "/Date("
        if str.hasPrefix(wcfJsonPrefix) {
            let body = str.splitOn(first: "(")[1].splitOn(last: ")")[0]
            let unixTime = (
                body
                    .splitOn(first: "-", startIndex:1)[0]
                    .splitOn(first: "+", startIndex:1)[0] as NSString
            ).doubleValue
            return Date(timeIntervalSince1970: unixTime / 1000) //ms -> secs
        }
        
        return Date.fromIsoDateString(string)
    }
    
    public static func fromObject(_ any:Any) -> Date?
    {
        switch any {
        case let s as String: return fromString(s)
        case let d as Date: return d
        default:return nil
        }
    }
}

extension Double : StringSerializable
{
    public static var typeName:String { return "Double" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> Double? {
        return str.hasPrefix("P")
            ? TimeInterval.fromTimeIntervalString(str)
            : (str as NSString).doubleValue
    }
    
    public static func fromObject(_ any:Any) -> Double?
    {
        switch any {
        case let d as Double: return d
        case let i as Int: return Double(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension TimeInterval
{
    public static let ticksPerSecond:Double = 10000000;
    
    public func toXsdDuration() -> String {
        var sb = "P"
        
        let totalSeconds:Double = self
        let wholeSeconds = Int(totalSeconds)
        var seconds = wholeSeconds
        let sec = (seconds >= 60 ? seconds % 60 : seconds)
        seconds = (seconds / 60)
        let min = seconds >= 60 ? seconds % 60 : seconds
        seconds = (seconds / 60)
        let hours = seconds >= 24 ? seconds % 24 : seconds
        let days = seconds / 24
        let remainingSecs:Double = Double(sec) + (totalSeconds - Double(wholeSeconds))
        
        if days > 0 {
            sb += "\(days)D"
        }
        
        if days == 0 || Double(hours + min + sec) + remainingSecs > 0 {

            sb += "T"
            if hours > 0 {
                sb += "\(hours)H";
            }
            if min > 0 {
                sb += "\(min)M";
            }
            
            if remainingSecs > 0 {
                var secFmt = String(format:"%.7f", remainingSecs)
                secFmt = secFmt.trimEnd("0").trimEnd(".")
                sb += "\(secFmt)S"
            }
            else if sb.length == 2 { //PT
                sb += "0S"
            }
        }
        
        return sb
    }
    
    public func toTimeIntervalJson() -> String {
        return jsonString(toString())
    }
    
    public static func fromXsdDuration(_ xsdString:String) -> TimeInterval?  {
        return TimeInterval.fromTimeIntervalString(xsdString)
    }
    
    public static func fromTimeIntervalString(_ string:String) -> TimeInterval? {
        var days = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        var ms = 0.0
  
        let t = string[1..<string.length].splitOn(first: "T") //strip P
        
        let hasTime = t.count == 2
        
        let d = t[0].splitOn(first: "D")
        if d.count == 2 {
            if let day = Int(d[0]) {
                days = day
            }
        }

        if hasTime {
            let h = t[1].splitOn(first: "H")
            if h.count == 2 {
                if let hour = Int(h[0]) {
                    hours = hour
                }
            }
            
            let m = h.last!.splitOn(first: "M")
            if m.count == 2 {
                if let min = Int(m[0]) {
                    minutes = min
                }
            }
            
            let s = m.last!.splitOn(first: "S")
            if s.count == 2 {
                ms = s[0].toDouble()
            }
            
            seconds = Int(ms)
            ms -= Double(seconds)
        }
        
        let totalSecs = 0
            + (days * 24 * 60 * 60)
            + (hours * 60 * 60)
            + (minutes * 60)
            + (seconds)
        
        let interval = Double(totalSecs) + ms
        
        return interval
    }
    
    public static func fromTimeIntervalObject(_ any:AnyObject) -> TimeInterval?
    {
        switch any {
        case let s as String: return fromTimeIntervalString(s)
        case let t as TimeInterval: return t
        default:return nil
        }
    }
}

extension Int : StringSerializable
{
    public static var typeName:String { return "Int" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> Int? {
        return Int(str)
    }
    
    public static func fromObject(_ any:Any) -> Int?
    {
        switch any {
        case let i as Int: return i
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Int8 : StringSerializable
{
    public static var typeName:String { return "Int8" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> Int8? {
        if let int = Int(str) {
            return Int8(int)
        }
        return nil
    }
    
    public static func fromObject(_ any:Any) -> Int8?
    {
        switch any {
        case let i as Int: return Int8(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Int16 : StringSerializable
{
    public static var typeName:String { return "Int16" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> Int16? {
        if let int = Int(str) {
            return Int16(int)
        }
        return nil
    }
    
    public static func fromObject(_ any:Any) -> Int16?
    {
        switch any {
        case let i as Int: return Int16(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Int32 : StringSerializable
{
    public static var typeName:String { return "Int32" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> Int32? {
        if let int = Int(str) {
            return Int32(int)
        }
        return nil
    }
    
    public static func fromObject(_ any:Any) -> Int32?
    {
        switch any {
        case let i as Int: return Int32(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Int64 : StringSerializable
{
    public static var typeName:String { return "Int64" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> Int64? {
        return (str as NSString).longLongValue
    }
    
    public static func fromObject(_ any:Any) -> Int64?
    {
        switch any {
        case let i as Int: return Int64(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension UInt8 : StringSerializable
{
    public static var typeName:String { return "UInt8" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> UInt8? {
        if let int = Int(str) {
            return UInt8(int)
        }
        return nil
    }
    
    public static func fromObject(_ any:Any) -> UInt8?
    {
        switch any {
        case let i as Int: return UInt8(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension UInt16 : StringSerializable
{
    public static var typeName:String { return "UInt16" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> UInt16? {
        if let int = Int(str) {
            return UInt16(int)
        }
        return nil
    }
    
    public static func fromObject(_ any:Any) -> UInt16?
    {
        switch any {
        case let i as Int: return UInt16(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension UInt32 : StringSerializable
{
    public static var typeName:String { return "UInt32" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> UInt32? {
        if let int = Int(str) {
            return UInt32(int)
        }
        return nil
    }
    
    public static func fromObject(_ any:Any) -> UInt32?
    {
        switch any {
        case let i as Int: return UInt32(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension UInt64 : StringSerializable
{
    public static var typeName:String { return "UInt64" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> UInt64? {
        return UInt64((str as NSString).longLongValue)
    }
    
    public static func fromObject(_ any:Any) -> UInt64?
    {
        switch any {
        case let i as Int: return UInt64(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Float : StringSerializable
{
    public static var typeName:String { return "Float" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> Float? {
        return (str as NSString).floatValue
    }
    
    public static func fromObject(_ any:Any) -> Float?
    {
        switch any {
        case let f as Float: return f
        case let i as Int: return Float(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension Bool : StringSerializable
{
    public static var typeName:String { return "Bool" }
    
    public func toString() -> String {
        return "\(self)"
    }
    
    public func toJson() -> String {
        return "\(self)"
    }
    
    public static func fromString(_ str: String) -> Bool? {
        return str.lowercased() == "true"
    }
    
    public static func fromObject(_ any:Any) -> Bool?
    {
        switch any {
        case let b as Bool: return b
        case let i as Int: return i != 0
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

public class ResponseStatus
{
    required public init(){}
    public var errorCode:String?
    public var message:String?
    public var stackTrace:String?
    public var errors:[ResponseError] = []
    public var meta:[String:String] = [:]
}

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

public class ResponseError
{
    required public init(){}
    public var errorCode:String?
    public var fieldName:String?
    public var message:String?
    public var meta:[String:String] = [:]
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

public class ErrorResponse
{
    required public init(){}
    public var responseStatus:ResponseStatus?
}

extension ErrorResponse : JsonSerializable
{
    public static var typeName:String { return "ResponseError" }
    public static var metadata = Metadata.create([
        Type<ErrorResponse>.optionalObjectProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}



public class List<T>
{
    required public init(){}
}

public protocol HasMetadata {
    static var typeName:String { get }
    static var metadata:Metadata { get }
    init()
}

public protocol Convertible {
    associatedtype _T //avoid conflicts when using `T` in generic classes implementing this protocoll
    static var typeName:String { get }
    static func fromObject(_ any:Any) -> _T?
}

public protocol JsonSerializable : HasMetadata, StringSerializable {
    func toJson() -> String
    static func fromJson(_ json:String) -> _T?
}
			
public protocol StringSerializable : Convertible {
    func toJson() -> String
    func toString() -> String
    static func fromString(_ string:String) -> _T?
}


public func populate<T : HasMetadata>(instance:T, map:NSDictionary, propertiesMap:[String:PropertyType]) -> T {
    for (key, obj) in map {
        if let p = propertiesMap[(key as AnyObject).lowercased] {
            p.setValueAny(instance: instance, value: obj)
        }
    }
    return instance
}

public func populateFromDictionary<T : JsonSerializable>(instance:T, map:[AnyHashable: Any], propertiesMap:[String:PropertyType]) -> T {
    for (key, obj) in map {
        if let strKey = key as? String {
            if let p = propertiesMap[strKey.lowercased()] {
                p.setValueAny(instance: instance, value: obj)
            }
        }
    }
    return instance
}

public class Metadata {
    public var properties:[PropertyType] = []
    public var propertyMap:[String:PropertyType] = [:]
   
    public init(properties:[PropertyType]) {
        self.properties = properties
        for p in properties {
            propertyMap[p.name.lowercased()] = p
        }
    }
    
    public static func create(_ properties:[PropertyType]) -> Metadata {
        return Metadata(properties: properties)
    }
}

extension HasMetadata
{
    public static var properties:[PropertyType] {
        return Self.metadata.properties
    }
    
    public static var propertyMap:[String:PropertyType] {
        return Self.metadata.propertyMap
    }
    
    public func toJson() -> String {
        let jb = JObject()
        for p in Self.properties {
            if let value = p.jsonValueAny(instance: self) {
                jb.append(name: p.name, json: value)
            } else {
                jb.append(name: p.name, json: "null")
            }
        }
        return jb.toJson()
    }

    public static func fromJson(_ json:String) -> Self? {
        if let map = parseJson(json) as? NSDictionary {
            return populate(instance: Self(), map: map, propertiesMap: Self.propertyMap) as Self
        }
        return nil
    }

    public static func fromObject(_ any:Any) -> Self? {
        switch any {
        case let s as String: return fromJson(s)
        case let map as NSDictionary: return populate(instance: Self(), map: map, propertiesMap: Self.propertyMap) as Self
        default: return nil
        }
    }

    public func toString() -> String {
        return toJson()
    }

    public static func fromString(_ string:String) -> Self? {
        return fromJson(string)
    }
}

public class TypeAccessor {}

public class Type<T : HasMetadata> : TypeAccessor
{
    var properties: [PropertyType]
    var propertiesMap = [String:PropertyType]()
    
    init(properties:[PropertyType])
    {
        self.properties = properties
        
        for p in properties {
            propertiesMap[p.name.lowercased()] = p
        }
    }
    
    static public func toJson(instance:T) -> String {
        let jb = JObject()
        for p in T.properties {
            if let value = p.jsonValueAny(instance: instance) {
                jb.append(name: p.name, json: value)
            } else {
                jb.append(name: p.name, json: "null")
            }
        }
        return jb.toJson()
    }
    
    static public func toString(instance:T) -> String {
        return toJson(instance: instance)
    }
    
    static func fromJson<T : JsonSerializable>(json:String) -> T? {
        return fromJson(instance: T(), json: json)
    }
    
    static func fromString<T : JsonSerializable>(instance:T, string:String) -> T? {
        return fromJson(instance: instance, json: string)
    }
    
    static func fromObject<T : JsonSerializable>(instance:T, any:AnyObject) -> T? {
        switch any {
        case let s as String: return fromJson(instance: instance, json: s)
        case let map as NSDictionary: return Type<T>.fromDictionary(instance: instance, map: map) as T
        default: return nil
        }
    }
    
    static func fromJson<T : JsonSerializable>(instance:T, json:String) -> T? {
        if instance is NSString || instance is String {
            if let value = json as? T {
                return value
            }
        }
        if let map = parseJson(json) as? NSDictionary {
            return populate(instance: instance, map: map, propertiesMap: T.propertyMap) as T
        }
        return nil
    }
    
    static func fromDictionary<T : HasMetadata>(instance:T, map:NSDictionary) -> T {
        return populate(instance: instance, map: map, propertiesMap: T.propertyMap)
    }
    
    public class func property<P : StringSerializable>(_ name:String, get:@escaping (T) -> P, set:@escaping (T,P) -> Void) -> PropertyType
    {
        return JProperty(name: name, get:get, set:set)
    }
    
    public class func optionalProperty<P : StringSerializable>(_ name:String, get:@escaping (T) -> P?, set:@escaping (T,P?) -> Void) -> PropertyType
    {
        return JOptionalProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<P : JsonSerializable>(_ name:String, get:@escaping (T) -> P, set:@escaping (T,P) -> Void) -> PropertyType
    {
        return JObjectProperty(name: name, get:get, set:set)
    }
    
    public class func optionalObjectProperty<P : JsonSerializable>(_ name:String, get:@escaping (T) -> P?, set:@escaping (T,P?) -> Void) -> PropertyType
    {
        return JOptionalObjectProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : StringSerializable>(_ name:String, get:@escaping (T) -> [K:P], set:@escaping (T,[K:P]) -> Void) -> PropertyType where K : StringSerializable
    {
        return JDictionaryProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : StringSerializable>(_ name:String, get:@escaping (T) -> [K:[P]], set:@escaping (T,[K:[P]]) -> Void) -> PropertyType where K : StringSerializable, K == K._T
    {
        return JDictionaryArrayProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : JsonSerializable>(_ name:String, get:@escaping (T) -> [K:[K:P]], set:@escaping (T,[K:[K:P]]) -> Void) -> PropertyType where K : StringSerializable
    {
        return JDictionaryArrayDictionaryObjectProperty(name: name, get:get, set:set)
    }
    
    public class func arrayProperty<P : StringSerializable>(_ name:String, get:@escaping (T) -> [P], set:@escaping (T,[P]) -> Void) -> PropertyType
    {
        return JArrayProperty(name: name, get:get, set:set)
    }
    
    public class func optionalArrayProperty<P : StringSerializable>(_ name:String, get:@escaping (T) -> [P]?, set:@escaping (T,[P]?) -> Void) -> PropertyType
    {
        return JOptionalArrayProperty(name: name, get:get, set:set)
    }
    
    public class func arrayProperty<P : JsonSerializable>(_ name:String, get:@escaping (T) -> [P], set:@escaping (T,[P]) -> Void) -> PropertyType
    {
        return JArrayObjectProperty(name: name, get:get, set:set)
    }
    
    public class func optionalArrayProperty<P : JsonSerializable>(_ name:String, get:@escaping (T) -> [P]?, set:@escaping (T,[P]?) -> Void) -> PropertyType
    {
        return JOptionalArrayObjectProperty(name: name, get:get, set:set)
    }
}

public class PropertyType {
    public var name:String

    init(name:String) {
        self.name = name
    }
    
    public func jsonValueAny(instance:Any) -> String? {
        return nil
    }
    
    public func setValueAny(instance:Any, value:Any) {
    }
    
    public func getValueAny(instance:Any) -> Any? {
        return nil
    }
    
    public func stringValueAny(instance:Any) -> String? {
        return nil
    }
    
    public func getName() -> String {
        return self.name
    }
}

public class PropertyBase<T : HasMetadata> : PropertyType {

    override init(name:String) {
        super.init(name: name)
    }
    
    public override func jsonValueAny(instance:Any) -> String? {
        return jsonValue(instance: instance as! T)
    }
    
    public func jsonValue(instance:T) -> String? {
        return nil
    }
    
    public override func setValueAny(instance:Any, value:Any) {
        if let t = instance as? T {
            setValue(instance: t, value: value)
        }
    }
    
    public func setValue(instance:T, value:Any) {
    }
    
    public override func getValueAny(instance:Any) -> Any? {
        return getValue(instance: instance as! T)
    }
    
    public func getValue(instance:T) -> Any? {
        return nil
    }
    
    public override func stringValueAny(instance:Any) -> String? {
        return stringValue(instance: instance as! T)
    }
    
    public func stringValue(instance:T) -> String? {
        return nil
    }
}

public class JProperty<T : HasMetadata, P : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> P
    public var set:(T,P) -> Void
    
    init(name:String, get:@escaping (T) -> P, set:@escaping (T,P) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return get(instance).toString()
    }
    
    public override func jsonValue(instance:T) -> String? {
        return get(instance).toJson()
    }
    
    public override func setValue(instance:T, value:Any) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}

public class JOptionalProperty<T : HasMetadata, P : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> P?
    public var set:(T,P?) -> Void
    
    init(name:String, get:@escaping (T) -> P?, set:@escaping (T,P?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func stringValue(instance:T) -> String? {
        if let p = get(instance) {
            return p.toString()
        }
        return super.jsonValue(instance: instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        if let p = get(instance) {
            return p.toJson()
        }
        return super.jsonValue(instance: instance)
    }
    
    public override func getValue(instance:T) -> Any? {
        if let p = get(instance) {
            return p
        }
        return nil
    }
    
    public override func setValue(instance:T, value:Any) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}


public class JObjectProperty<T : HasMetadata, P : JsonSerializable> : PropertyBase<T>
{
    public var get:(T) -> P
    public var set:(T,P) -> Void
    
    init(name:String, get:@escaping (T) -> P, set:@escaping (T,P) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return get(instance).toString()
    }
    
    public override func jsonValue(instance:T) -> String? {
        return get(instance).toJson()
    }
    
    public override func setValue(instance:T, value:Any) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}

public class JOptionalObjectProperty<T : HasMetadata, P : JsonSerializable> : PropertyBase<T> where P : HasMetadata
{
    public var get:(T) -> P?
    public var set:(T,P?) -> Void
    
    init(name:String, get:@escaping (T) -> P?, set:@escaping (T,P?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func jsonValue(instance:T) -> String? {
        if let propValue = get(instance) {
            let strValue = propValue.toJson()
            return strValue
        }
        return super.jsonValue(instance: instance)
    }
    
    public override func setValue(instance:T, value:Any) {
        if let map = value as? NSDictionary {
            let p = Type<P>.fromDictionary(instance: P(), map: map)
            set(instance, p)
        }
    }
}

public class JDictionaryProperty<T : HasMetadata, K : Hashable, P : StringSerializable> : PropertyBase<T> where K : StringSerializable
{
    public var get:(T) -> [K:P]
    public var set:(T,[K:P]) -> Void
    
    init(name:String, get:@escaping (T) -> [K:P], set:@escaping (T,[K:P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance: instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let map = get(instance)
        
        let jb = JObject()
        for (key, value) in map {
            jb.append(name: key.toString(), json:value.toJson())
        }
        return jb.toJson()
    }
    
    public override func setValue(instance:T, value:Any) {
        if let map = value as? NSDictionary {
            var to = [K:P]()
            for (key, obj) in map {
                if let keyK = K.fromObject(key) as? K {
                    if let valueP = P.fromObject(obj) as? P {
                        to[keyK] = valueP
                    }
                }
            }
            set(instance, to)
        }
    }
}

public class JDictionaryArrayProperty<T : HasMetadata, K : Hashable, P : StringSerializable> : PropertyBase<T> where K : StringSerializable, K == K._T
{
    public var get:(T) -> [K:[P]]
    public var set:(T,[K:[P]]) -> Void
    
    init(name:String, get:@escaping (T) -> [K:[P]], set:@escaping (T,[K:[P]]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance: instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let map = get(instance)

        let jb = JObject()
        for (key, values) in map {
            let ja = JArray()
            for v in values {
                ja.append(json: v.toJson())
            }
            jb.append(name: key.toString(), json:ja.toJson())
        }
        return jb.toJson()
    }
    
    public override func setValue(instance:T, value:Any) {
        if let map = value as? NSDictionary {
            var to = [K:[P]]()
            for (key, obj) in map {
                if let keyK = K.fromObject(key) {
                    var valuesP = to[keyK] ?? [P]()
                    if let valuesArray = obj as? NSArray {
                        for item in valuesArray {
                            if let valueP = P.fromObject(item) as? P {
                                valuesP.append(valueP)
                            }
                        }
                    }
                    to[keyK] = valuesP
                }
            }
            set(instance, to)
        }
    }
}

public class JDictionaryArrayDictionaryObjectProperty<T : HasMetadata, K : Hashable, P : JsonSerializable> : PropertyBase<T> where K : StringSerializable
{
    public var get:(T) -> [K:[K:P]]
    public var set:(T,[K:[K:P]]) -> Void
    
    init(name:String, get:@escaping (T) -> [K:[K:P]], set:@escaping (T,[K:[K:P]]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance: instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let map = get(instance)
        
        let jb = JObject()
        for (key, values) in map {
            jb.append(name: key.toString(), json:JObject.asJson(map: values))
        }
        return jb.toJson()
    }
    
    public override func setValue(instance:T, value:Any) {
        if let map = value as? NSDictionary {
            var to = [K:[K:P]]()
            for (k,vArray) in map {
                var values = [K:P]()
                if let array = vArray as? NSArray {
                    for item in array {
                        if let map = item as? NSDictionary {
                            for (subK, subV) in map {
                                values[K.fromObject(subK)! as! K] = P.fromObject(subV) as? P
                            }
                        }
                    }
                }
                to[K.fromObject(k) as! K] = values
            }
            set(instance,to)
        }
    }
}

public class JArrayProperty<T : HasMetadata, P : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> [P]
    public var set:(T,[P]) -> Void
    
    init(name:String, get:@escaping (T) -> [P], set:@escaping (T,[P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance: instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValues = get(instance)
        
        var sb = ""
        
        for item in propValues {
            if sb.length > 0 {
                sb += ","
            }
            var str:String = "null"
            str = item.toJson()
            
            sb += str
        }

        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:Any) {
        if let array = value as? NSArray {
            if array.count == 0 {
                return
            }
            var to = [P]()
            for item in array {
                if let pValue = P.fromObject(item) as? P {
                    to.append(pValue)
                }
            }
            set(instance, to)
        }
    }
}

public class JOptionalArrayProperty<T : HasMetadata, P : StringSerializable> : PropertyBase<T>
{
    public var get:(T) -> [P]?
    public var set:(T,[P]?) -> Void
    
    init(name:String, get:@escaping (T) -> [P]?, set:@escaping (T,[P]?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance: instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        var sb = ""
        if let propValues = get(instance) {
            for item in propValues {
                if sb.length > 0 {
                    sb += ","
                }
                var str:String = "null"
                str = item.toJson()
                
                sb += str
            }
        } else {
            return "null"
        }
        
        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:Any) {
        if let array = value as? NSArray {
            if array.count == 0 {
                return
            }
            var to = [P]()
            for item in array {
                if let pValue = P.fromObject(item) as? P {
                    to.append(pValue)
                }
            }
            set(instance, to)
        }
    }
}

public class JArrayObjectProperty<T : HasMetadata, P : JsonSerializable> : PropertyBase<T>
{
    public var get:(T) -> [P]
    public var set:(T,[P]) -> Void
    
    init(name:String, get:@escaping (T) -> [P], set:@escaping (T,[P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance: instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValues = get(instance)
        
        var sb = ""
        
        for item in propValues {
            if sb.length > 0 {
                sb += ","
            }
            var str:String = "null"
            str = item.toJson()
            
            sb += str
        }
        
        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:Any) {
        if let array = value as? NSArray {
            if array.count == 0 {
                return
            }
            var to = [P]()
            for item in array {
                if let pValue = P.fromObject(item) as? P {
                    to.append(pValue)
                }
            }
            set(instance, to)
        }
    }
}

public class JOptionalArrayObjectProperty<T : HasMetadata, P : JsonSerializable> : PropertyBase<T>
{
    public var get:(T) -> [P]?
    public var set:(T,[P]?) -> Void
    
    init(name:String, get:@escaping (T) -> [P]?, set:@escaping (T,[P]?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance: instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        var sb = ""
        
        if let propValues = get(instance) {
            for item in propValues {
                if sb.length > 0 {
                    sb += ","
                }
                var str:String = "null"
                str = item.toJson()
                
                sb += str
            }
        } else {
            return "null"
        }
        
        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:Any) {
        if let array = value as? NSArray {
            if array.count == 0 {
                return
            }
            var to = [P]()
            for item in array {
                if let pValue = P.fromObject(item) as? P {
                    to.append(pValue)
                }
            }
            set(instance, to)
        }
    }
}

class TypeConfig
{
    struct Config {
        static var types = Dictionary<String, TypeAccessor>()
    }
    
    class func configure<T : Convertible>(typeConfig:Type<T>) -> Type<T> {
        Config.types[T.typeName] = typeConfig
        return typeConfig
    }
    
    class func config<T : Convertible>() -> Type<T>? {
        if let typeInfo = Config.types[T.typeName] {
            return typeInfo as? Type<T>
        }
        return nil
    }
}

public func jsonStringRaw(_ str:String?) -> String {
    if let s = str {
        return "\"\(s)\""
    }
    else {
        return "null"
    }
}

class Utils
{
    class func escapeChars() -> CharacterSet {
        return CharacterSet(charactersIn: "\"\n\r\t\\")
    }
}

func jsonString(_ str:String?) -> String {
    if let s = str {
        if let _ = s.rangeOfCharacter(from: Utils.escapeChars()) {
            do {
                let encodedData = try JSONSerialization.data(withJSONObject: [s], options:JSONSerialization.WritingOptions())
                if let encodedJson = encodedData.toUtf8String() {
                    return encodedJson[1..<encodedJson.length-1] //strip []
                }
            } catch { }
        }        
        return "\"\(s)\""
    }
    else {
        return "null"
    }
}



public extension String
{
    public var length: Int { return self.characters.count }

    func index(_ from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    public func contains(s:String) -> Bool {
        return (self as NSString).contains(s)
    }
    
    public func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    public func trimEnd(_ needle: Character) -> String {
        var i: Int = self.characters.count - 1
        
        while i >= 0 && self[self.index(self.startIndex, offsetBy: i)] == needle {
            i -= 1
        }
        
        let s = self.substring(to: index(i + 1))
        return s
    }
    
    public subscript (i: Int) -> Character {
        return self[index(i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    public subscript (r: Range<Int>) -> String {
        return substring(with: index(r.lowerBound)..<index(r.upperBound))
    }
    
    public func urlEncode() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlHostAllowed)
    }
    
    public func combinePath(_ path:String) -> String {
        return (self.hasSuffix("/") ? self : self + "/") + (path.hasPrefix("/") ? path[1..<path.length] : path)
    }

    public func splitOn(first:String) -> [String] {
        return splitOn(first: first, startIndex: 0)
    }
    
    public func splitOn(first:String, startIndex:Int) -> [String] {
        var to = [String]()
        
        let startRange = index(startIndex)
        if let range = self.range(of: first,
            options: NSString.CompareOptions.literal,
            range: startRange ..< self.endIndex)
        {
            to.append(self[self.startIndex..<range.lowerBound])
            to.append(self[range.upperBound..<endIndex])
        }
        else {
            to.append(self)
        }
        return to
    }
    
    public func splitOn(last:String) -> [String] {
        var to = [String]()
        if let range = self.range(of: last, options:NSString.CompareOptions.backwards) {
            to.append(self[startIndex..<range.lowerBound])
            to.append(self[range.upperBound..<endIndex])
        }
        else {
            to.append(self)
        }
        return to
    }
    
    public func split(_ separator:String) -> [String] {
        return self.components(separatedBy: separator)
    }
    
    public func indexOf(_ needle:String) -> Int {
        if let range = self.range(of: needle) {
            return self.distance(from: startIndex, to: range.lowerBound)
        }
        return -1
    }
    
    public func lastIndexOf(_ needle:String) -> Int {
        if let range = self.range(of: needle, options:NSString.CompareOptions.backwards) {
            return self.distance(from: startIndex, to: range.lowerBound)
        }
        return -1
    }
    
    public func replace(_ needle:String, withString:String) -> String {
        return self.replacingOccurrences(of: needle, with: withString)
    }
    
    public func toDouble() -> Double {
        return (self as NSString).doubleValue
    }
    
    public func print() -> String {
        Swift.print(self)
        return self
    }
    
    public func stripQuotes() -> String {
        return self.hasPrefix("\"") && self.hasSuffix("\"")
            ? self[1..<self.length-1]
            : self
    }
}

extension Array
{
    func print() -> String {
        var sb = ""
        for item in self {
            if sb.length > 0 {
                sb += ","
            }
            sb += "\(item)"
        }
        Swift.print(sb)
        return sb
    }
}

extension Data
{
    func toUtf8String() -> String? {
        if let str = NSString(data: self as Data, encoding: String.Encoding.utf8.rawValue) {
            return str as String
        }
        return nil
    }
    
    func print() -> String {
        return self.toUtf8String()!.print()
    }
}

extension Error
{
    func convertUserInfo<T : JsonSerializable>() -> T? {
        return self.populateUserInfo(instance: T())
    }

    func populateUserInfo<T : JsonSerializable>(instance:T) -> T? {
        let to = populateFromDictionary(instance: T(), map: (self as NSError).userInfo, propertiesMap: T.propertyMap)
        return to
    }

    var responseStatus:ResponseStatus {
        return (self as NSError).responseStatus
    }
}

extension NSError {
    var responseStatus:ResponseStatus {
        let status:ResponseStatus = self.convertUserInfo() ?? ResponseStatus()
        if status.errorCode == nil {
            status.errorCode = self.code.toString()
        }
        if status.message == nil {
            status.message = self.localizedDescription
        }
        return status
    }
}



public extension Date {
    
    public init(dateString:String, format:String="yyyy-MM-dd") {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone.default
        fmt.dateFormat = format
        let d = fmt.date(from: dateString)
        self.init(timeInterval:0, since:d!)
    }
    
    public init(year:Int, month:Int, day:Int) {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        let gregorian = NSCalendar(identifier:NSCalendar.Identifier.gregorian)
        let d = gregorian?.date(from: c as DateComponents)
        self.init(timeInterval:0, since:d!)
    }
    
    public func components() -> DateComponents {
        let components  = NSCalendar.current.dateComponents(
            [Calendar.Component.day, Calendar.Component.month, Calendar.Component.year],
            from: self as Date)
        
        return components
    }
    
    public var year:Int {
        return components().year!
    }
    
    public var month:Int {
        return components().month!
    }
    
    public var day:Int {
        return components().day!
    }
    
    public var shortDateString:String {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone.default
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt.string(from: self as Date)
    }
    
    public var dateAndTimeString:String {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone.default
        fmt.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return fmt.string(from: self as Date)
    }
    
    public var jsonDate:String {
        let unixEpoch = Int64(self.timeIntervalSince1970 * 1000)
        return "/Date(\(unixEpoch)-0000)/"
    }
    
    public var isoDateString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.string(from: self as Date).appendingFormat("Z")
    }
    
    public static func fromIsoDateString(_ string:String) -> Date? {
        let isUtc = string.hasSuffix("Z")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormatter.timeZone = isUtc ? TimeZone(abbreviation: "UTC") : TimeZone.ReferenceType.local
        dateFormatter.dateFormat = string.length == 19 || (isUtc && string.length == 20)
            ? "yyyy-MM-dd'T'HH:mm:ss"
            : "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        
        return isUtc
            ? dateFormatter.date(from: string[0..<string.length-1])
            : dateFormatter.date(from: string)
    }
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedDescending
}
public func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedDescending
        || lhs == rhs
}
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedAscending
}
public func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedAscending
        || lhs == rhs
}
public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs as Date) == ComparisonResult.orderedSame
}

let PMKErrorDomain:String = "PromiseKit"

let PMKFailingPromiseIndexKey:String = "PMKFailingPromiseIndexKey"
let PMKJoinPromisesKey:String = "PMKJoinPromisesKey"

let PMKUnexpectedError:Int = 1
let PMKInvalidUsageError:Int =  3
let PMKAccessDeniedError:Int =  4
let PMKOperationCancelled:Int =  5
let PMKOperationFailed:Int =  8
let PMKTaskError:Int =  9
let PMKJoinError:Int =  10



/**
 - Returns: A new promise that fulfills after the specified duration.
*/
public func after(interval: TimeInterval) -> Promise<Void> {
    return Promise { fulfill, _ in
        let when = DispatchTime.now() + interval
        DispatchQueue.global().asyncAfter(deadline: when, execute: fulfill)
    }
}

/**
 AnyPromise is an Objective-C compatible promise.
*/
@objc(AnyPromise) public class AnyPromise: NSObject {
    let state: State<Any?>

    /**
     - Returns: A new `AnyPromise` bound to a `Promise<Any>`.
    */
    required public init(_ bridge: Promise<Any?>) {
        state = bridge.state
    }

    /// hack to ensure Swift picks the right initializer for each of the below
    private init(force: Promise<Any?>) {
        state = force.state
    }

    /**
     - Returns: A new `AnyPromise` bound to a `Promise<T>`.
    */
    public convenience init<T>(_ bridge: Promise<T?>) {
        self.init(force: bridge.then(on: zalgo) { $0 })
    }

    /**
     - Returns: A new `AnyPromise` bound to a `Promise<T>`.
    */
    convenience public init<T>(_ bridge: Promise<T>) {
        self.init(force: bridge.then(on: zalgo) { $0 })
    }

    /**
     - Returns: A new `AnyPromise` bound to a `Promise<Void>`.
     - Note: A “void” `AnyPromise` has a value of `nil`.
    */
    convenience public init(_ bridge: Promise<Void>) {
        self.init(force: bridge.then(on: zalgo) { nil })
    }

    /**
     Bridge an AnyPromise to a Promise<Any>
     - Note: AnyPromises fulfilled with `PMKManifold` lose all but the first fulfillment object.
     - Remark: Could not make this an initializer of `Promise` due to generics issues.
     */
    public func asPromise() -> Promise<Any?> {
        return Promise(sealant: { resolve in
            state.pipe { resolution in
                switch resolution {
                case .rejected:
                    resolve(resolution)
                case .fulfilled:
                    let obj = (self as AnyObject).value(forKey: "value")
                    resolve(.fulfilled(obj))
                }
            }
        })
    }

    /// - See: `Promise.then()`
    public func then<T>(on q: DispatchQueue = .default, execute body: @escaping (Any?) throws -> T) -> Promise<T> {
        return asPromise().then(on: q, execute: body)
    }

    /// - See: `Promise.then()`
    public func then(on q: DispatchQueue = .default, execute body: @escaping (Any?) throws -> AnyPromise) -> Promise<Any?> {
        return asPromise().then(on: q, execute: body)
    }

    /// - See: `Promise.then()`
    public func then<T>(on q: DispatchQueue = .default, execute body: @escaping (Any?) throws -> Promise<T>) -> Promise<T> {
        return asPromise().then(on: q, execute: body)
    }

    /// - See: `Promise.always()`
    public func always(on q: DispatchQueue = .default, execute body: @escaping () -> Void) -> Promise<Any?> {
        return asPromise().always(execute: body)
    }

    /// - See: `Promise.tap()`
    public func tap(on q: DispatchQueue = .default, execute body: @escaping (Result<Any?>) -> Void) -> Promise<Any?> {
        return asPromise().tap(execute: body)
    }

    /// - See: `Promise.recover()`
    public func recover(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) throws -> Promise<Any?>) -> Promise<Any?> {
        return asPromise().recover(on: q, policy: policy, execute: body)
    }

    /// - See: `Promise.recover()`
    public func recover(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) throws -> Any?) -> Promise<Any?> {
        return asPromise().recover(on: q, policy: policy, execute: body)
    }

    /// - See: `Promise.catch()`
    public func `catch`(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) -> Void) {
        state.catch(on: q, policy: policy, else: { _ in }, execute: body)
    }


    /**
     A promise starts pending and eventually resolves.
     - Returns: `true` if the promise has not yet resolved.
     */
    @objc public var pending: Bool {
        return state.get() == nil
    }

    /**
     A promise starts pending and eventually resolves.
     - Returns: `true` if the promise has resolved.
     */
    @objc public var resolved: Bool {
        return !pending
    }

    /**
     The value of the asynchronous task this promise represents.

     A promise has `nil` value if the asynchronous task it represents has not finished. If the value is `nil` the promise is still `pending`.

     - Warning: *Note* Our Swift variant’s value property returns nil if the promise is rejected where AnyPromise will return the error object. This fits with the pattern where AnyPromise is not strictly typed and is more dynamic, but you should be aware of the distinction.
     
     - Note: If the AnyPromise was fulfilled with a `PMKManifold`, returns only the first fulfillment object.

     - Returns If `resolved`, the object that was used to resolve this promise; if `pending`, nil.
     */
    @objc private var __value: Any? {
        switch state.get() {
        case nil:
            return nil
        case .rejected(let error, _)?:
            return error
        case .fulfilled(let obj)?:
            return obj
        }
    }

    /**
     Creates a resolved promise.

     When developing your own promise systems, it is ocassionally useful to be able to return an already resolved promise.

     - Parameter value: The value with which to resolve this promise. Passing an `NSError` will cause the promise to be rejected, passing an AnyPromise will return a new AnyPromise bound to that promise, otherwise the promise will be fulfilled with the value passed.

     - Returns: A resolved promise.
     */
    @objc public class func promiseWithValue(_ value: Any?) -> AnyPromise {
        let state: State<Any?>
        switch value {
        case let promise as AnyPromise:
            state = promise.state
        case let err as Error:
            state = SealedState(resolution: Resolution(err))
        default:
            state = SealedState(resolution: .fulfilled(value))
        }
        return AnyPromise(state: state)
    }

    private init(state: State<Any?>) {
        self.state = state
    }

    /**
     Create a new promise that resolves with the provided block.

     Use this method when wrapping asynchronous code that does *not* use promises so that this code can be used in promise chains.

     If `resolve` is called with an `NSError` object, the promise is rejected, otherwise the promise is fulfilled.

     Don’t use this method if you already have promises! Instead, just return your promise.

     Should you need to fulfill a promise but have no sensical value to use: your promise is a `void` promise: fulfill with `nil`.

     The block you pass is executed immediately on the calling thread.

     - Parameter block: The provided block is immediately executed, inside the block call `resolve` to resolve this promise and cause any attached handlers to execute. If you are wrapping a delegate-based system, we recommend instead to use: initWithResolver:

     - Returns: A new promise.
     - Warning: Resolving a promise with `nil` fulfills it.
     - SeeAlso: http://promisekit.org/sealing-your-own-promises/
     - SeeAlso: http://promisekit.org/wrapping-delegation/
     */
    @objc public class func promiseWithResolverBlock(_ body: (@escaping (Any?) -> Void) -> Void) -> AnyPromise {
        return AnyPromise(sealant: { resolve in
            body { obj in
                makeHandler({ _ in obj }, resolve)(obj)
            }
        })
    }

    private init(sealant: (@escaping (Resolution<Any?>) -> Void) -> Void) {
        var resolve: ((Resolution<Any?>) -> Void)!
        state = UnsealedState(resolver: &resolve)
        sealant(resolve)
    }

    @objc func __thenOn(_ q: DispatchQueue, execute body: @escaping (Any?) -> Any?) -> AnyPromise {
        return AnyPromise(sealant: { resolve in
            state.then(on: q, else: resolve, execute: makeHandler(body, resolve))
        })
    }

    func __catchWithPolicy(_ policy: CatchPolicy, execute body: @escaping (Any?) -> Any?) -> AnyPromise {
        return AnyPromise(sealant: { resolve in
            state.catch(on: .default, policy: policy, else: resolve) { err in
                makeHandler(body, resolve)(err as NSError)
            }
        })
    }

    @objc func __alwaysOn(_ q: DispatchQueue, execute body: @escaping () -> Void) -> AnyPromise {
        return AnyPromise(sealant: { resolve in
            state.always(on: q) { resolution in
                body()
                resolve(resolution)
            }
        })
    }

    /**
     Convert an `AnyPromise` to `Promise<T>`.

         anyPromise.toPromise(T).then { (t: T) -> U in ... }
     
     - Returns: A `Promise<T>` with the requested type.
     - Throws: `CastingError.CastingAnyPromiseFailed(T)` if self's value cannot be downcasted to the given type.
     */
    public func asPromise<T>(type: T.Type) -> Promise<T> {
        return self.then(on: zalgo) { (value: Any?) -> T in
            if let value = value as? T {
                return value
            }
            throw PMKError.castError(type)
        }
    }

    /// used by PMKWhen and PMKJoin
    @objc func __pipe(_ body: @escaping (Any?) -> Void) {
        state.pipe { resolution in
            switch resolution {
            case .rejected(let error, let token):
                token.consumed = true  // when and join will create a new parent error that is unconsumed
                body(error as Error)
            case .fulfilled(let value):
                body(value)
            }
        }
    }
}


extension AnyPromise {
    override public var description: String {
        return "AnyPromise: \(state)"
    }
}

private func makeHandler(_ body: @escaping (Any?) -> Any?, _ resolve: @escaping (Resolution<Any?>) -> Void) -> (Any?) -> Void {
    return { obj in
        let obj = body(obj)
        switch obj {
        case let err as Error:
            resolve(Resolution(err))
        case let promise as AnyPromise:
            promise.state.pipe(resolve)
        default:
            resolve(.fulfilled(obj))
        }
    }
}

/**
 ```
 DispatchQueue.global().promise {
     try md5(input)
 }.then { md5 in
     //…
 }
 ```

 - Parameter body: The closure that resolves this promise.
 - Returns: A new promise resolved by the result of the provided closure.
*/
extension DispatchQueue {
    /**
     - SeeAlso: `dispatch_promise()`
     - SeeAlso: `dispatch_promise_on()`
     */
    public final func promise<T>(group: DispatchGroup? = nil, qos: DispatchQoS = .default, flags: DispatchWorkItemFlags = [], execute body: @escaping () throws -> T) -> Promise<T> {

        return Promise(sealant: { resolve in
            async(group: group, qos: qos, flags: flags) {
                do {
                    resolve(.fulfilled(try body()))
                } catch {
                    resolve(Resolution(error))
                }
            }
        })
    }

    /// Unavailable due to Swift compiler issues
    @available(*, unavailable)
    public final func promise<T>(group: DispatchGroup? = nil, qos: DispatchQoS = .default, flags: DispatchWorkItemFlags = [], execute body: () throws -> Promise<T>) -> Promise<T> { fatalError() }

    /**
     - SeeAlso: `PMKDefaultDispatchQueue()`
     - SeeAlso: `PMKSetDefaultDispatchQueue()`
     */
    class public final var `default`: DispatchQueue {
        get {
            return __PMKDefaultDispatchQueue()
        }
        set {
            __PMKSetDefaultDispatchQueue(newValue)
        }
    }
}

public enum PMKError: Error {
    /**
     The ErrorType for a rejected `join`.
     - Parameter 0: The promises passed to this `join` that did not *all* fulfill.
     - Note: The array is untyped because Swift generics are fussy with enums.
    */
    case join([AnyObject])

    /**
     The completionHandler with form (T?, ErrorType?) was called with (nil, nil)
     This is invalid as per Cocoa/Apple calling conventions.
    */
    case invalidCallingConvention

    /**
     A handler returned its own promise. 99% of the time, this is likely a 
     programming error. It is also invalid per Promises/A+.
    */
    case returnedSelf

    /** `when()` was called with a concurrency of <= 0 */
    case whenConcurrentlyZero

    /** AnyPromise.toPromise failed to cast as requested */
    case castError(Any.Type)
}

public enum PMKURLError: Error {
    /**
     The URLRequest succeeded but a valid UIImage could not be decoded from
     the data that was received.
    */
    case invalidImageData(URLRequest, Data)

    /**
     The HTTP request returned a non-200 status code.
    */
    case badResponse(URLRequest, Data?, URLResponse?)

    /**
     The data could not be decoded using the encoding specified by the HTTP
     response headers.
    */
    case stringEncoding(URLRequest, Data, URLResponse)

    /**
     Usually the `NSURLResponse` is actually an `NSHTTPURLResponse`, if so you
     can access it using this property. Since it is returned as an unwrapped
     optional: be sure.
    */
    public var NSHTTPURLResponse: Foundation.HTTPURLResponse! {
        switch self {
        case .invalidImageData:
            return nil
        case .badResponse(_, _, let rsp):
            return rsp as! Foundation.HTTPURLResponse
        case .stringEncoding(_, _, let rsp):
            return rsp as! Foundation.HTTPURLResponse
        }
    }
}

public enum JSONError: Error {
    /// The JSON response was different to that requested
    case unexpectedRootNode(Any)
}



public protocol CancellableError: Error {
    var isCancelled: Bool { get }
}

#if !SWIFT_PACKAGE

private struct ErrorPair: Hashable {
    let domain: String
    let code: Int
    init(_ d: String, _ c: Int) {
        domain = d; code = c
    }
    var hashValue: Int {
        return "\(domain):\(code)".hashValue
    }
}

private func ==(lhs: ErrorPair, rhs: ErrorPair) -> Bool {
    return lhs.domain == rhs.domain && lhs.code == rhs.code
}

extension NSError {
    @objc public class func cancelledError() -> NSError {
        let info = [NSLocalizedDescriptionKey: "The operation was cancelled"]
        return NSError(domain: PMKErrorDomain, code: PMKOperationCancelled, userInfo: info)
    }

    /**
      - Warning: You must call this method before any promises in your application are rejected. Failure to ensure this may lead to concurrency crashes.
      - Warning: You must call this method on the main thread. Failure to do this may lead to concurrency crashes.
     */
    @objc public class func registerCancelledErrorDomain(_ domain: String, code: Int) {
        cancelledErrorIdentifiers.insert(ErrorPair(domain, code))
    }

    /// - Returns: true if the error represents cancellation.
    @objc public var isCancelled: Bool {
        return (self as Error).isCancelledError
    }
}

private var cancelledErrorIdentifiers = Set([
    ErrorPair(PMKErrorDomain, PMKOperationCancelled),
    ErrorPair(NSURLErrorDomain, NSURLErrorCancelled),
])

#endif


extension Error {
    public var isCancelledError: Bool {
        if let ce = self as? CancellableError {
            return ce.isCancelled
        } else {
          #if SWIFT_PACKAGE
            return false
          #else
            let ne = self as NSError
            return cancelledErrorIdentifiers.contains(ErrorPair(ne.domain, ne.code))
          #endif
        }
    }
}


class ErrorConsumptionToken {
    var consumed = false
    let error: Error

    init(_ error: Error) {
        self.error = error
    }

    deinit {
        if !consumed {
            PMKUnhandledErrorHandler(error as NSError)
        }
    }
}

/**
 Waits on all provided promises.

 `when` rejects as soon as one of the provided promises rejects. `join` waits on all provided promises, then rejects if any of those promises rejected, otherwise it fulfills with values from the provided promises.

     join(promise1, promise2, promise3).then { results in
         //…
     }.catch { error in
         switch error {
         case Error.Join(let promises):
             //…
         }
     }

 - Returns: A new promise that resolves once all the provided promises resolve.
 - SeeAlso: `PromiseKit.Error.join`
*/
@available(*, deprecated: 4.0, message: "Use when(resolved:)")
public func join<T>(_ promises: Promise<T>...) -> Promise<[T]> {
    return join(promises)
}

@available(*, deprecated: 4.0, message: "Use when(resolved:)")
public func join(_ promises: [Promise<Void>]) -> Promise<Void> {
    return join(promises).then(on: zalgo) { (_: [Void]) in return Promise(value: ()) }
}

@available(*, deprecated: 4.0, message: "Use when(resolved:)")
public func join<T>(_ promises: [Promise<T>]) -> Promise<[T]> {
    guard !promises.isEmpty else { return Promise(value: []) }
  
    var countdown = promises.count
    let barrier = DispatchQueue(label: "org.promisekit.barrier.join", attributes: .concurrent)
    var rejected = false

    return Promise { fulfill, reject in
        for promise in promises {
            promise.state.pipe { resolution in
                __dispatch_barrier_sync(barrier) {
                    if case .rejected(_, let token) = resolution {
                        token.consumed = true  // the parent Error.Join consumes all
                        rejected = true
                    }
                    countdown -= 1
                    if countdown == 0 {
                        if rejected {
                            reject(PMKError.join(promises))
                        } else {
                            fulfill(promises.map{ $0.value! })
                        }
                    }
                }
            }
        }
    }
}
extension Promise {
    /**
     - Returns: The error with which this promise was rejected; `nil` if this promise is not rejected.
    */
    public var error: Error? {
        switch state.get() {
        case .none:
            return nil
        case .some(.fulfilled):
            return nil
        case .some(.rejected(let error, _)):
            return error
        }
    }

    /**
     - Returns: `true` if the promise has not yet resolved.
    */
    public var isPending: Bool {
        return state.get() == nil
    }

    /**
     - Returns: `true` if the promise has resolved.
    */
    public var isResolved: Bool {
        return !isPending
    }

    /**
     - Returns: `true` if the promise was fulfilled.
    */
    public var isFulfilled: Bool {
        return value != nil
    }

    /**
     - Returns: `true` if the promise was rejected.
    */
    public var isRejected: Bool {
        return error != nil
    }

    /**
     - Returns: The value with which this promise was fulfilled or `nil` if this promise is pending or rejected.
    */
    public var value: T? {
        switch state.get() {
        case .none:
            return nil
        case .some(.fulfilled(let value)):
            return value
        case .some(.rejected):
            return nil
        }
    }
}


/**
 A *promise* represents the future value of a (usually) asynchronous task.

 To obtain the value of a promise we call `then`.

 Promises are chainable: `then` returns a promise, you can call `then` on
 that promise, which returns a promise, you can call `then` on that
 promise, et cetera.

 Promises start in a pending state and *resolve* with a value to become
 *fulfilled* or an `Error` to become rejected.

 - SeeAlso: [PromiseKit `then` Guide](http://promisekit.org/docs/)
 */
open class Promise<T> {
    let state: State<T>

    /**
     Create a new, pending promise.

         func fetchAvatar(user: String) -> Promise<UIImage> {
             return Promise { fulfill, reject in
                 MyWebHelper.GET("\(user)/avatar") { data, err in
                     guard let data = data else { return reject(err) }
                     guard let img = UIImage(data: data) else { return reject(MyError.InvalidImage) }
                     guard let img.size.width > 0 else { return reject(MyError.ImageTooSmall) }
                     fulfill(img)
                 }
             }
         }

     - Parameter resolvers: The provided closure is called immediately on the active thread; commence your asynchronous task, calling either fulfill or reject when it completes.
      - Parameter fulfill: Fulfills this promise with the provided value.
      - Parameter reject: Rejects this promise with the provided error.

     - Returns: A new promise.

     - Note: If you are wrapping a delegate-based system, we recommend
     to use instead: `Promise.pending()`

     - SeeAlso: http://promisekit.org/docs/sealing-promises/
     - SeeAlso: http://promisekit.org/docs/cookbook/wrapping-delegation/
     - SeeAlso: pending()
     */
    required public init(resolvers: (_ fulfill: @escaping (T) -> Void, _ reject: @escaping (Error) -> Void) throws -> Void) {
        var resolve: ((Resolution<T>) -> Void)!
        do {
            state = UnsealedState(resolver: &resolve)
            try resolvers({ resolve(.fulfilled($0)) }, { error in
                #if !PMKDisableWarnings
                    if self.isPending {
                        resolve(Resolution(error))
                    } else {
                        NSLog("PromiseKit: warning: reject called on already rejected Promise: \(error)")
                    }
                #else
                    resolve(Resolution(error))
                #endif
            })
        } catch {
            resolve(Resolution(error))
        }
    }

    /**
     Create an already fulfilled promise.
     */
    required public init(value: T) {
        state = SealedState(resolution: .fulfilled(value))
    }

    /**
     Create an already rejected promise.
     */
    required public init(error: Error) {
        state = SealedState(resolution: Resolution(error))
    }

    /**
     Careful with this, it is imperative that sealant can only be called once
     or you will end up with spurious unhandled-errors due to possible double
     rejections and thus immediately deallocated ErrorConsumptionTokens.
     */
    init(sealant: (@escaping (Resolution<T>) -> Void) -> Void) {
        var resolve: ((Resolution<T>) -> Void)!
        state = UnsealedState(resolver: &resolve)
        sealant(resolve)
    }

    /**
     A `typealias` for the return values of `pending()`. Simplifies declaration of properties that reference the values' containing tuple when this is necessary. For example, when working with multiple `pendingPromise(value: ())`s within the same scope, or when the promise initialization must occur outside of the caller's initialization.

         class Foo: BarDelegate {
            var task: Promise<Int>.PendingTuple?
         }

     - SeeAlso: pending()
     */
    public typealias PendingTuple = (promise: Promise, fulfill: (T) -> Void, reject: (Error) -> Void)

    /**
     Making promises that wrap asynchronous delegation systems or other larger asynchronous systems without a simple completion handler is easier with pending.

         class Foo: BarDelegate {
             let (promise, fulfill, reject) = Promise<Int>.pending()
    
             func barDidFinishWithResult(result: Int) {
                 fulfill(result)
             }
    
             func barDidError(error: NSError) {
                 reject(error)
             }
         }

     - Returns: A tuple consisting of: 
       1) A promise
       2) A function that fulfills that promise
       3) A function that rejects that promise
     */
    public final class func pending() -> PendingTuple {
        var fulfill: ((T) -> Void)!
        var reject: ((Error) -> Void)!
        let promise = self.init { fulfill = $0; reject = $1 }
        return (promise, fulfill, reject)
    }

    /**
     The provided closure is executed when this promise is resolved.

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter body: The closure that is executed when this Promise is fulfilled.
     - Returns: A new promise that is resolved with the value returned from the provided closure. For example:

           NSURLSession.GET(url).then { data -> Int in
               //…
               return data.length
           }.then { length in
               //…
           }
     */
    @discardableResult public func then<U>(on q: DispatchQueue = .default, execute body: @escaping (T) throws -> U) -> Promise<U> {
        return Promise<U> { resolve in
            state.then(on: q, else: resolve) { value in
                resolve(.fulfilled(try body(value)))
            }
        }
    }

    /**
     The provided closure executes when this promise resolves.
     
     This variant of `then` allows chaining promises, the promise returned by the provided closure is resolved before the promise returned by this closure resolves.

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter execute: The closure that executes when this promise fulfills.
     - Returns: A new promise that resolves when the promise returned from the provided closure resolves. For example:

           URLSession.GET(url1).then { data in
               return CLLocationManager.promise()
           }.then { location in
               //…
           }
     */
    public func then<U>(on q: DispatchQueue = .default, execute body: @escaping (T) throws -> Promise<U>) -> Promise<U> {
        var rv: Promise<U>!
        rv = Promise<U> { resolve in
            state.then(on: q, else: resolve) { value in
                let promise = try body(value)
                guard promise !== rv else { throw PMKError.returnedSelf }
                promise.state.pipe(resolve)
            }
        }
        return rv
    }

    /**
     The provided closure executes when this promise rejects.

     Rejecting a promise cascades: rejecting all subsequent promises (unless
     recover is invoked) thus you will typically place your catch at the end
     of a chain. Often utility promises will not have a catch, instead
     delegating the error handling to the caller.

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter policy: The default policy does not execute your handler for cancellation errors.
     - Parameter execute: The handler to execute if this promise is rejected.
     - Returns: `self`
     - SeeAlso: [Cancellation](http://promisekit.org/docs/)
     - Important: The promise that is returned is `self`. `catch` cannot affect the chain, in PromiseKit 3 no promise was returned to strongly imply this, however for PromiseKit 4 we started returning a promise so that you can `always` after a catch or return from a function that has an error handler.
     */
    @discardableResult
    public func `catch`(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) -> Void) -> Promise {
        state.catch(on: q, policy: policy, else: { _ in }, execute: body)
        return self
    }

    /**
     The provided closure executes when this promise rejects.
     
     Unlike `catch`, `recover` continues the chain provided the closure does not throw. Use `recover` in circumstances where recovering the chain from certain errors is a possibility. For example:
     
         CLLocationManager.promise().recover { error in
             guard error == CLError.unknownLocation else { throw error }
             return CLLocation.Chicago
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter policy: The default policy does not execute your handler for cancellation errors.
     - Parameter execute: The handler to execute if this promise is rejected.
     - SeeAlso: [Cancellation](http://promisekit.org/docs/)
     */
    public func recover(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) throws -> Promise) -> Promise {
        var rv: Promise!
        rv = Promise { resolve in
            state.catch(on: q, policy: policy, else: resolve) { error in
                let promise = try body(error)
                guard promise !== rv else { throw PMKError.returnedSelf }
                promise.state.pipe(resolve)
            }
        }
        return rv
    }

    /**
     The provided closure executes when this promise rejects.

     Unlike `catch`, `recover` continues the chain provided the closure does not throw. Use `recover` in circumstances where recovering the chain from certain errors is a possibility. For example:

         CLLocationManager.promise().recover { error in
             guard error == CLError.unknownLocation else { throw error }
             return CLLocation.Chicago
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter policy: The default policy does not execute your handler for cancellation errors.
     - Parameter execute: The handler to execute if this promise is rejected.
     - SeeAlso: [Cancellation](http://promisekit.org/docs/)
     */
    public func recover(on q: DispatchQueue = .default, policy: CatchPolicy = .allErrorsExceptCancellation, execute body: @escaping (Error) throws -> T) -> Promise {
        return Promise { resolve in
            state.catch(on: q, policy: policy, else: resolve) { error in
                resolve(.fulfilled(try body(error)))
            }
        }
    }

    /**
     The provided closure executes when this promise resolves.

         firstly {
             UIApplication.shared.networkActivityIndicatorVisible = true
         }.then {
             //…
         }.always {
             UIApplication.shared.networkActivityIndicatorVisible = false
         }.catch {
             //…
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter execute: The closure that executes when this promise resolves.
     - Returns: A new promise, resolved with this promise’s resolution.
     */
    public func always(on q: DispatchQueue = .default, execute body: @escaping () -> Void) -> Promise {
        state.always(on: q) { resolution in
            body()
        }
        return self
    }

    /**
     `tap` allows you to “tap” into a promise chain and inspect its result.
     
     The function you provide cannot mutate the chain.
 
         NSURLSession.GET(/*…*/).tap { result in
             print(result)
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter execute: The closure that executes when this promise resolves.
     - Returns: A new promise, resolved with this promise’s resolution.
     */
    @discardableResult
    public func tap(on q: DispatchQueue = .default, execute body: @escaping (Result<T>) -> Void) -> Promise {
        state.always(on: q) { resolution in
            body(Result(resolution))
        }
        return self
    }

    /**
     Void promises are less prone to generics-of-doom scenarios.
     - SeeAlso: when.swift contains enlightening examples of using `Promise<Void>` to simplify your code.
     */
    public func asVoid() -> Promise<Void> {
        return then(on: zalgo) { _ in return }
    }


    @available(*, unavailable, renamed: "always()")
    public func finally(on: DispatchQueue = DispatchQueue.main, execute body: () -> Void) -> Promise { fatalError() }

    @available(*, unavailable, renamed: "always()")
    public func ensure(on: DispatchQueue = DispatchQueue.main, execute body: () -> Void) -> Promise { fatalError() }

    @available(*, unavailable, renamed: "pending()")
    public class func `defer`() -> PendingTuple { fatalError() }

    @available(*, unavailable, renamed: "pending()")
    public class func `pendingPromise`() -> PendingTuple { fatalError() }

    @available(*, unavailable, message: "deprecated: use then(on: .global())")
    public func thenInBackground<U>(execute body: (T) throws -> U) -> Promise<U> { fatalError() }

    @available(*, unavailable, renamed: "catch")
    public func onError(policy: CatchPolicy = .allErrors, execute body: (Error) -> Void) { fatalError() }

    @available(*, unavailable, renamed: "catch")
    public func errorOnQueue(_ on: DispatchQueue, policy: CatchPolicy = .allErrors, execute body: (Error) -> Void) { fatalError() }

    @available(*, unavailable, renamed: "catch")
    public func error(policy: CatchPolicy, execute body: (Error) -> Void) { fatalError() }

    @available(*, unavailable, renamed: "catch")
    public func report(policy: CatchPolicy = .allErrors, execute body: (Error) -> Void) { fatalError() }

    @available(*, unavailable, renamed: "init(value:)")
    public init(_ value: T) { fatalError() }


    @available(*, unavailable, message: "cannot instantiate Promise<Error>")
    public init<T: Error>(resolvers: (_ fulfill: (T) -> Void, _ reject: (Error) -> Void) throws -> Void) { fatalError() }

    @available(*, unavailable, message: "cannot instantiate Promise<Error>")
    public class func pending<T: Error>() -> (promise: Promise, fulfill: (T) -> Void, reject: (Error) -> Void) { fatalError() }


    @available (*, unavailable, message: "instead of returning the error; throw")
    public func then<U: Error>(on: DispatchQueue = .default, execute body: (T) throws -> U) -> Promise<U> { fatalError() }

    @available (*, unavailable, message: "instead of returning the error; throw")
    public func recover<T: Error>(on: DispatchQueue = .default, execute body: (Error) throws -> T) -> Promise { fatalError() }


    @available(*, unavailable, message: "unwrap the promise")
    public func then<U>(on: DispatchQueue = .default, execute body: (T) throws -> Promise<U>?) -> Promise<U> { fatalError() }

    @available(*, unavailable, message: "unwrap the promise")
    public func recover(on: DispatchQueue = .default, execute body: (Error) throws -> Promise?) -> Promise { fatalError() }
}

extension Promise: CustomStringConvertible {
    public var description: String {
        return "Promise: \(state)"
    }
}

/**
 Judicious use of `firstly` *may* make chains more readable.

 Compare:

     NSURLSession.GET(url1).then {
         NSURLSession.GET(url2)
     }.then {
         NSURLSession.GET(url3)
     }

 With:

     firstly {
         NSURLSession.GET(url1)
     }.then {
         NSURLSession.GET(url2)
     }.then {
         NSURLSession.GET(url3)
     }
 */
public func firstly<T>(execute body: () throws -> Promise<T>) -> Promise<T> {
    do {
        return try body()
    } catch {
        return Promise(error: error)
    }
}

@available(*, unavailable, message: "instead of returning the error; throw")
public func firstly<T: Error>(execute body: () throws -> T) -> Promise<T> { fatalError() }

@available(*, unavailable, message: "use DispatchQueue.promise")
public func firstly<T>(on: DispatchQueue, execute body: () throws -> Promise<T>) -> Promise<T> { fatalError() }

@available(*, deprecated: 4.0, renamed: "DispatchQueue.promise")
public func dispatch_promise<T>(_ on: DispatchQueue, _ body: @escaping () throws -> T) -> Promise<T> {
    return Promise(value: ()).then(on: on, execute: body)
}


/**
 The underlying resolved state of a promise.
 - remark: Same as `Resolution<T>` but without the associated `ErrorConsumptionToken`.
*/
public enum Result<T> {
    /// Fulfillment
    case fulfilled(T)
    /// Rejection
    case rejected(Error)

    init(_ resolution: Resolution<T>) {
        switch resolution {
        case .fulfilled(let value):
            self = .fulfilled(value)
        case .rejected(let error, _):
            self = .rejected(error)
        }
    }

    public var boolValue: Bool {
        switch self {
        case .fulfilled:
            return true
        case .rejected:
            return false
        }
    }
}


public class PMKJoint<T> {
    fileprivate var resolve: ((Resolution<T>) -> Void)!
}

extension Promise {
    public final class func joint() -> (Promise<T>, (PMKJoint<T>)) {
        let pipe = PMKJoint<T>()
        let promise = Promise(sealant: { pipe.resolve = $0 })
        return (promise, pipe)
    }

    public func join(_ joint: PMKJoint<T>) {
        state.pipe(joint.resolve)
    }
}


extension Promise where T: Collection {
    /**
     `map` transforms a `Promise` where `T` is a `Collection`, eg. an `Array` returning a `Promise<[U]>`

         URLSession.shared.dataTask(url: /*…*/).asArray().map { result in
             return download(result)
         }.then { images in
             // images is `[UIImage]`
         }

     - Parameter on: The queue to which the provided closure dispatches.
     - Parameter transform: The closure that executes when this promise resolves.
     - Returns: A new promise, resolved with this promise’s resolution.
     */
    public func map<U>(on: DispatchQueue = .default, transform: @escaping (T.Iterator.Element) throws -> Promise<U>) -> Promise<[U]> {
        return Promise<[U]> { resolve in
            return state.then(on: zalgo, else: resolve) { tt in
                when(fulfilled: try tt.map(transform)).state.pipe(resolve)
            }
        }
    }
}
/**
 Resolves with the first resolving promise from a set of promises.

 ```
 race(promise1, promise2, promise3).then { winner in
     //…
 }
 ```

 - Returns: A new promise that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Warning: aborts if the array is empty.
*/
public func race<T>(promises: [Promise<T>]) -> Promise<T> {
    guard promises.count > 0 else {
        fatalError("Cannot race with an empty array of promises")
    }
    return _race(promises: promises)
}

/**
 Resolves with the first resolving promise from a set of promises.

 ```
 race(promise1, promise2, promise3).then { winner in
     //…
 }
 ```

 - Returns: A new promise that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Warning: aborts if the array is empty.
*/
public func race<T>(_ promises: Promise<T>...) -> Promise<T> {
    return _race(promises: promises)
}

private func _race<T>(promises: [Promise<T>]) -> Promise<T> {
    return Promise(sealant: { resolve in
        for promise in promises {
            promise.state.pipe(resolve)
        }
    })
}

enum Seal<T> {
    case pending(Handlers<T>)
    case resolved(Resolution<T>)
}

enum Resolution<T> {
    case fulfilled(T)
    case rejected(Error, ErrorConsumptionToken)

    init(_ error: Error) {
        self = .rejected(error, ErrorConsumptionToken(error))
    }
}

class State<T> {

    // would be a protocol, but you can't have typed variables of “generic”
    // protocols in Swift 2. That is, I couldn’t do var state: State<R> when
    // it was a protocol. There is no work around. Update: nor Swift 3

    func get() -> Resolution<T>? { fatalError("Abstract Base Class") }
    func get(body: @escaping (Seal<T>) -> Void) { fatalError("Abstract Base Class") }

    final func pipe(_ body: @escaping (Resolution<T>) -> Void) {
        get { seal in
            switch seal {
            case .pending(let handlers):
                handlers.append(body)
            case .resolved(let resolution):
                body(resolution)
            }
        }
    }

    final func then<U>(on q: DispatchQueue, else rejecter: @escaping (Resolution<U>) -> Void, execute body: @escaping (T) throws -> Void) {
        pipe { resolution in
            switch resolution {
            case .fulfilled(let value):
                contain_zalgo(q, rejecter: rejecter) {
                    try body(value)
                }
            case .rejected(let error, let token):
                rejecter(.rejected(error, token))
            }
        }
    }

    final func always(on q: DispatchQueue, body: @escaping (Resolution<T>) -> Void) {
        pipe { resolution in
            contain_zalgo(q) {
                body(resolution)
            }
        }
    }

    final func `catch`(on q: DispatchQueue, policy: CatchPolicy, else resolve: @escaping (Resolution<T>) -> Void, execute body: @escaping (Error) throws -> Void) {
        pipe { resolution in
            switch (resolution, policy) {
            case (.fulfilled, _):
                resolve(resolution)
            case (.rejected(let error, _), .allErrorsExceptCancellation) where error.isCancelledError:
                resolve(resolution)
            case (let .rejected(error, token), _):
                contain_zalgo(q, rejecter: resolve) {
                    token.consumed = true
                    try body(error)
                }
            }
        }
    }
}

class UnsealedState<T>: State<T> {
    private let barrier = DispatchQueue(label: "org.promisekit.barrier", attributes: .concurrent)
    private var seal: Seal<T>

    /**
     Quick return, but will not provide the handlers array because
     it could be modified while you are using it by another thread.
     If you need the handlers, use the second `get` variant.
    */
    override func get() -> Resolution<T>? {
        var result: Resolution<T>?
        barrier.sync {
            if case .resolved(let resolution) = self.seal {
                result = resolution
            }
        }
        return result
    }

    override func get(body: @escaping (Seal<T>) -> Void) {
        var sealed = false
        barrier.sync {
            switch self.seal {
            case .resolved:
                sealed = true
            case .pending:
                sealed = false
            }
        }
        if !sealed {
            __dispatch_barrier_sync(barrier) {
                switch (self.seal) {
                case .pending:
                    body(self.seal)
                case .resolved:
                    sealed = true  // welcome to race conditions
                }
            }
        }
        if sealed {
            body(seal)  // as much as possible we do things OUTSIDE the barrier_sync
        }
    }

    required init(resolver: inout ((Resolution<T>) -> Void)!) {
        seal = .pending(Handlers<T>())
        super.init()
        resolver = { resolution in
            var handlers: Handlers<T>?
            __dispatch_barrier_sync(self.barrier) {
                if case .pending(let hh) = self.seal {
                    self.seal = .resolved(resolution)
                    handlers = hh
                }
            }
            if let handlers = handlers {
                for handler in handlers {
                    handler(resolution)
                }
            }
        }
    }
#if !PMKDisableWarnings
    deinit {
        if case .pending = seal {
            NSLog("PromiseKit: Pending Promise deallocated! This is usually a bug")
        }
    }
#endif
}

class SealedState<T>: State<T> {
    fileprivate let resolution: Resolution<T>
    
    init(resolution: Resolution<T>) {
        self.resolution = resolution
    }
    
    override func get() -> Resolution<T>? {
        return resolution
    }

    override func get(body: @escaping (Seal<T>) -> Void) {
        body(.resolved(resolution))
    }
}


class Handlers<T>: Sequence {
    var bodies: [(Resolution<T>) -> Void] = []

    func append(_ body: @escaping (Resolution<T>) -> Void) {
        bodies.append(body)
    }

    func makeIterator() -> IndexingIterator<[(Resolution<T>) -> Void]> {
        return bodies.makeIterator()
    }

    var count: Int {
        return bodies.count
    }
}


extension Resolution: CustomStringConvertible {
    var description: String {
        switch self {
        case .fulfilled(let value):
            return "Fulfilled with value: \(value)"
        case .rejected(let error):
            return "Rejected with error: \(error)"
        }
    }
}

extension UnsealedState: CustomStringConvertible {
    var description: String {
        var rv: String!
        get { seal in
            switch seal {
            case .pending(let handlers):
                rv = "Pending with \(handlers.count) handlers"
            case .resolved(let resolution):
                rv = "\(resolution)"
            }
        }
        return "UnsealedState: \(rv)"
    }
}

extension SealedState: CustomStringConvertible {
    var description: String {
        return "SealedState: \(resolution)"
    }
}
public enum CatchPolicy {
    case allErrorsExceptCancellation
    case allErrors
}

func PMKUnhandledErrorHandler(_ error: Error)
{}


func __PMKDefaultDispatchQueue() -> DispatchQueue {
    return DispatchQueue.main
}

func __PMKSetDefaultDispatchQueue(_: DispatchQueue)
{}

private func _when<T>(_ promises: [Promise<T>]) -> Promise<Void> {
    let root = Promise<Void>.pending()
    var countdown = promises.count
    guard countdown > 0 else {
        root.fulfill()
        return root.promise
    }

#if !PMKDisableProgress
    let progress = Progress(totalUnitCount: Int64(promises.count))
    progress.isCancellable = false
    progress.isPausable = false
#else
    var progress: (completedUnitCount: Int, totalUnitCount: Int) = (0, 0)
#endif
    
    let barrier = DispatchQueue(label: "org.promisekit.barrier.when", attributes: .concurrent)

    for promise in promises {
        promise.state.pipe { resolution in
            __dispatch_barrier_sync(barrier) {
                switch resolution {
                case .rejected(let error, let token):
                    token.consumed = true
                    if root.promise.isPending {
                        progress.completedUnitCount = progress.totalUnitCount
                        root.reject(error)
                    }
                case .fulfilled:
                    guard root.promise.isPending else { return }
                    progress.completedUnitCount += 1
                    countdown -= 1
                    if countdown == 0 {
                        root.fulfill()
                    }
                }
            }
        }
    }

    return root.promise
}

/**
 Wait for all promises in a set to fulfill.

 For example:

     when(fulfilled: promise1, promise2).then { results in
         //…
     }.catch { error in
         switch error {
         case NSURLError.NoConnection:
             //…
         case CLError.NotAuthorized:
             //…
         }
     }

 - Note: If *any* of the provided promises reject, the returned promise is immediately rejected with that error.
 - Warning: In the event of rejection the other promises will continue to resolve and, as per any other promise, will either fulfill or reject. This is the right pattern for `getter` style asynchronous tasks, but often for `setter` tasks (eg. storing data on a server), you most likely will need to wait on all tasks and then act based on which have succeeded and which have failed, in such situations use `when(resolved:)`.
 - Parameter promises: The promises upon which to wait before the returned promise resolves.
 - Returns: A new promise that resolves when all the provided promises fulfill or one of the provided promises rejects.
 - Note: `when` provides `NSProgress`.
 - SeeAlso: `when(resolved:)`
*/
public func when<T>(fulfilled promises: [Promise<T>]) -> Promise<[T]> {
    return _when(promises).then(on: zalgo) { promises.map{ $0.value! } }
}

public func when(fulfilled promises: Promise<Void>...) -> Promise<Void> {
    return _when(promises)
}

public func when(fulfilled promises: [Promise<Void>]) -> Promise<Void> {
    return _when(promises)
}

public func when<U, V>(fulfilled pu: Promise<U>, _ pv: Promise<V>) -> Promise<(U, V)> {
    return _when([pu.asVoid(), pv.asVoid()]).then(on: zalgo) { (pu.value!, pv.value!) }
}

public func when<U, V, X>(fulfilled pu: Promise<U>, _ pv: Promise<V>, _ px: Promise<X>) -> Promise<(U, V, X)> {
    return _when([pu.asVoid(), pv.asVoid(), px.asVoid()]).then(on: zalgo) { (pu.value!, pv.value!, px.value!) }
}

/**
 Generate promises at a limited rate and wait for all to fulfill.

 For example:
 
     func downloadFile(url: URL) -> Promise<Data> {
         // ...
     }
 
     let urls: [URL] = /*…*/
     let urlGenerator = urls.makeIterator()

     let generator = AnyIterator<Promise<Data>> {
         guard url = urlGenerator.next() else {
             return nil
         }

         return downloadFile(url)
     }

     when(generator, concurrently: 3).then { datum: [Data] -> Void in
         // ...
     }

 - Warning: Refer to the warnings on `when(fulfilled:)`
 - Parameter promiseGenerator: Generator of promises.
 - Returns: A new promise that resolves when all the provided promises fulfill or one of the provided promises rejects.
 - SeeAlso: `when(resolved:)`
 */

public func when<T, PromiseIterator: IteratorProtocol>(fulfilled promiseIterator: PromiseIterator, concurrently: Int) -> Promise<[T]> where PromiseIterator.Element == Promise<T> {

    guard concurrently > 0 else {
        return Promise(error: PMKError.whenConcurrentlyZero)
    }

    var generator = promiseIterator
    var root = Promise<[T]>.pending()
    var pendingPromises = 0
    var promises: [Promise<T>] = []

    let barrier = DispatchQueue(label: "org.promisekit.barrier.when", attributes: [.concurrent])

    func dequeue() {
        guard root.promise.isPending else { return }  // don’t continue dequeueing if root has been rejected

        var shouldDequeue = false
        barrier.sync {
            shouldDequeue = pendingPromises < concurrently
        }
        guard shouldDequeue else { return }

        var index: Int!
        var promise: Promise<T>!

        __dispatch_barrier_sync(barrier) {
            guard let next = generator.next() else { return }

            promise = next
            index = promises.count

            pendingPromises += 1
            promises.append(next)
        }

        func testDone() {
            barrier.sync {
                if pendingPromises == 0 {
                    root.fulfill(promises.flatMap{ $0.value })
                }
            }
        }

        guard promise != nil else {
            return testDone()
        }

        promise.state.pipe { resolution in
            __dispatch_barrier_sync(barrier) {
                pendingPromises -= 1
            }

            switch resolution {
            case .fulfilled:
                dequeue()
                testDone()
            case .rejected(let error, let token):
                token.consumed = true
                root.reject(error)
            }
        }

        dequeue()
    }
        
    dequeue()

    return root.promise
}

/**
 Waits on all provided promises.

 `when(fulfilled:)` rejects as soon as one of the provided promises rejects. `when(resolved:)` waits on all provided promises and **never** rejects.

     when(resolved: promise1, promise2, promise3).then { results in
         for result in results where case .fulfilled(let value) {
            //…
         }
     }.catch { error in
         // invalid! Never rejects
     }

 - Returns: A new promise that resolves once all the provided promises resolve.
 - Warning: The returned promise can *not* be rejected.
 - Note: Any promises that error are implicitly consumed, your UnhandledErrorHandler will not be called.
*/
public func when<T>(resolved promises: Promise<T>...) -> Promise<[Result<T>]> {
    return when(resolved: promises)
}

public func when<T>(resolved promises: [Promise<T>]) -> Promise<[Result<T>]> {
    guard !promises.isEmpty else { return Promise(value: []) }

    var countdown = promises.count
    let barrier = DispatchQueue(label: "org.promisekit.barrier.join", attributes: .concurrent)

    return Promise { fulfill, reject in
        for promise in promises {
            promise.state.pipe { resolution in
                if case .rejected(_, let token) = resolution {
                    token.consumed = true  // all errors are implicitly consumed
                }
                var done = false
                __dispatch_barrier_sync(barrier) {
                    countdown -= 1
                    done = countdown == 0
                }
                if done {
                    fulfill(promises.map { Result($0.state.get()!) })
                }
            }
        }
    }
}
/**
 Create a new pending promise by wrapping another asynchronous system.

 This initializer is convenient when wrapping asynchronous systems that
 use common patterns. For example:

     func fetchKitten() -> Promise<UIImage> {
         return PromiseKit.wrap { resolve in
             KittenFetcher.fetchWithCompletionBlock(resolve)
         }
     }

 - SeeAlso: Promise.init(resolvers:)
*/
public func wrap<T>(_ body: (@escaping (T?, Error?) -> Void) throws -> Void) -> Promise<T> {
    return Promise { fulfill, reject in
        try body { obj, err in
            if let obj = obj {
                fulfill(obj)
            } else if let err = err {
                reject(err)
            } else {
                reject(PMKError.invalidCallingConvention)
            }
        }
    }
}

public func wrap<T>(_ body: (@escaping (T, Error?) -> Void) throws -> Void) -> Promise<T>  {
    return Promise { fulfill, reject in
        try body { obj, err in
            if let err = err {
                reject(err)
            } else {
                fulfill(obj)
            }
        }
    }
}

public func wrap<T>(_ body: (@escaping (Error?, T?) -> Void) throws -> Void) -> Promise<T> {
    return Promise { fulfill, reject in
        try body { err, obj in
            if let obj = obj {
                fulfill(obj)
            } else if let err = err {
                reject(err)
            } else {
                reject(PMKError.invalidCallingConvention)
            }
        }
    }
}

public func wrap(_ body: (@escaping (Error?) -> Void) throws -> Void) -> Promise<Void> {
    return Promise { fulfill, reject in
        try body { error in
            if let error = error {
                reject(error)
            } else {
                fulfill()
            }
        }
    }
}

public func wrap<T>(_ body: (@escaping (T) -> Void) throws -> Void) -> Promise<T> {
    return Promise { fulfill, _ in
        try body(fulfill)
    }
}

/**
 `zalgo` causes your handlers to be executed as soon as their promise resolves.

 Usually all handlers are dispatched to a queue (the main queue by default); the `on:` parameter of `then` configures this. Its default value is `DispatchQueue.main`.

 - Important: `zalgo` is dangerous.

    Compare:

       var x = 0
       foo.then {
           print(x)  // => 1
       }
       x++

    With:

       var x = 0
       foo.then(on: zalgo) {
           print(x)  // => 0 or 1
       }
       x++
 
    In the latter case the value of `x` may be `0` or `1` depending on whether `foo` is resolved. This is a race-condition that is easily avoided by not using `zalgo`.

 - Important: you cannot control the queue that your handler executes if using `zalgo`.

 - Note: `zalgo` is provided for libraries providing promises that have good tests that prove “Unleashing Zalgo” is safe. You can also use it in your application code in situations where performance is critical, but be careful: read the essay liked below to understand the risks.

 - SeeAlso: [Designing APIs for Asynchrony](http://blog.izs.me/post/59142742143/designing-apis-for-asynchrony)
 - SeeAlso: `waldo`
 */
public let zalgo = DispatchQueue(label: "Zalgo")

/**
 `waldo` is dangerous.

 `waldo` is `zalgo`, unless the current queue is the main thread, in which
 case we dispatch to the default background queue.

 If your block is likely to take more than a few milliseconds to execute,
 then you should use waldo: 60fps means the main thread cannot hang longer
 than 17 milliseconds: don’t contribute to UI lag.

 Conversely if your then block is trivial, use zalgo: GCD is not free and
 for whatever reason you may already be on the main thread so just do what
 you are doing quickly and pass on execution.

 It is considered good practice for asynchronous APIs to complete onto the
 main thread. Apple do not always honor this, nor do other developers.
 However, they *should*. In that respect waldo is a good choice if your
 then is going to take some time and doesn’t interact with the UI.

 Please note (again) that generally you should not use `zalgo` or `waldo`.
 The performance gains are neglible and we provide these functions only out
 of a misguided sense that library code should be as optimized as possible.
 If you use either without tests proving their correctness you may
 unwillingly introduce horrendous, near-impossible-to-trace bugs.

 - SeeAlso: `zalgo`
 */
public let waldo = DispatchQueue(label: "Waldo")


@inline(__always) func contain_zalgo(_ q: DispatchQueue, body: @escaping () -> Void) {
    if q === zalgo || q === waldo && !Thread.isMainThread {
        body()
    } else {
        q.async(execute: body)
    }
}

@inline(__always) func contain_zalgo<T>(_ q: DispatchQueue, rejecter reject: @escaping (Resolution<T>) -> Void, block: @escaping () throws -> Void) {
    contain_zalgo(q) {
        do { try block() } catch { reject(Resolution(error)) }
    }
}

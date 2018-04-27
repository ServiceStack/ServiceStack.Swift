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
    
    func populateResponseStatusFields(errorInfo:inout [String : Any], withObject:Any) {
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
                var errorInfo: [String : Any] = [:]
                
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
    
    @discardableResult public func send<T : JsonSerializable>(intoResponse: T, request: NSMutableURLRequest) throws -> T {
        let dataTaskSync = self.createSession().dataTaskSync(request: request as URLRequest)
        self.lastTask = dataTaskSync.task
        
        if dataTaskSync.callback?.response == nil {
            if let error = dataTaskSync.callback?.error {
                throw error
            }
            return T()
        }
        var error: NSError? = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)
        if let data = dataTaskSync.callback?.data,
            let response = dataTaskSync.callback?.response,
            let dto = self.handleResponse(intoResponse: intoResponse, data: data, response: response, error: &error) {
            return dto
        }
        if let e = error {
            throw e
        }
        return T()
    }
    
    @discardableResult public func sendAsync<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) -> Promise<T> {
        let pendingPromise = Promise<T>.pending()
        let task = self.createSession().dataTask(with: request as URLRequest) { (data, response, error) in
            if error != nil {
                pendingPromise.resolver.reject(self.handleError(nsError: error! as NSError))
            }
            else {
                var resposneError:NSError?
                let response = self.handleResponse(intoResponse: intoResponse, data: data!, response: response!, error: &resposneError)
                if resposneError != nil {
                    pendingPromise.resolver.reject(self.fireErrorCallbacks(error: resposneError!))
                }
                else if let dto = response {
                    pendingPromise.resolver.fulfill(dto)
                } else {
                    pendingPromise.resolver.fulfill(T()) //return empty dto in promise callbacks
                }
            }
        }
        
        task.resume()
        self.lastTask = task
        return pendingPromise.promise
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
    
    public func get<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
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
    
    public func post<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
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
    
    public func put<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
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
    
    public func delete<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
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
    
    public func patch<T : IReturnVoid>(_ request:T) throws -> Void where T : JsonSerializable {
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
        let dataTaskSync = self.createSession().dataTaskSync(request: URLRequest(url: URL(string:resolveUrl(url))!))
        self.lastTask = dataTaskSync.task
        
        if let data = dataTaskSync.callback?.data {
            return data
        }
        
        if let error = dataTaskSync.callback?.error {
            throw error
        }
        throw NSError(domain: "Migrator", code: 0, userInfo: nil)
    }
    
    public func getDataAsync(_ url:String) -> Promise<Data> {
        let pendingPromise = Promise<Data>.pending()
        
        let task = self.createSession().dataTask(with: URL(string: self.resolveUrl(url))!) { (data, response, error) in
            if error != nil {
                pendingPromise.resolver.reject(self.handleError(nsError: error! as NSError))
            }
            pendingPromise.resolver.fulfill(data!)
        }
        
        task.resume()
        self.lastTask = task
        
        return pendingPromise.promise
    }
}

extension URLSession {
    public typealias URLSessionDataCallback = (data: Data?, response: URLResponse?, error: Error?)
    public typealias URLSessionDataTaskSync = (task: URLSessionDataTask, callback: URLSessionDataCallback?)
    
    public func dataTaskSync(request: URLRequest) -> URLSessionDataTaskSync {
        var callback: URLSessionDataCallback?
        let ds = DispatchSemaphore(value: 0)
        let task = self.dataTask(with: request as URLRequest) { data, response, error in
            callback = (data: data, response: response, error: error)
            ds.signal()
        }
        
        task.resume()
        ds.wait()
        return (task: task, callback: callback)
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
    
    static func asJson<K, V : JsonSerializable>(map:[K:V]) -> String? where K : StringSerializable {
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
        if sb.count > 0 {
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
        return NSString(data: self, encoding: String.Encoding.utf8.rawValue)! as String
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
    
    public class func objectProperty<K, P : StringSerializable>(_ name:String, get:@escaping (T) -> [K:P], set:@escaping (T,[K:P]) -> Void) -> PropertyType where K : StringSerializable
    {
        return JDictionaryProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K, P : StringSerializable>(_ name:String, get:@escaping (T) -> [K:[P]], set:@escaping (T,[K:[P]]) -> Void) -> PropertyType where K : StringSerializable, K == K._T
    {
        return JDictionaryArrayProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K, P : JsonSerializable>(_ name:String, get:@escaping (T) -> [K:[K:P]], set:@escaping (T,[K:[K:P]]) -> Void) -> PropertyType where K : StringSerializable
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

public class JOptionalObjectProperty<T : HasMetadata, P : JsonSerializable> : PropertyBase<T>
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
    public var length: Int { return self.count }

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
        var i: Int = self.count - 1
        
        while i >= 0 && self[self.index(self.startIndex, offsetBy: i)] == needle {
            i -= 1
        }
        
        let s = String(self.prefix(upTo: index(i + 1)))
        return s
    }
    
    public subscript (i: Int) -> Character {
        return self[index(i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript(r: Range<Int>) -> String {
        let range = index(r.lowerBound) ..< index(r.upperBound)
        return String(self[range])
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
            to.append(String(self[self.startIndex..<range.lowerBound]))
            to.append(String(self[range.upperBound..<endIndex]))
        }
        else {
            to.append(self)
        }
        return to
    }
    
    public func splitOn(last:String) -> [String] {
        var to = [String]()
        if let range = self.range(of: last, options:NSString.CompareOptions.backwards) {
            to.append(String(self[startIndex..<range.lowerBound]))
            to.append(String(self[range.upperBound..<endIndex]))
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
     after(.seconds(2)).then {
         //…
     }

- Returns: A new promise that fulfills after the specified duration.
*/
public func after(seconds: TimeInterval) -> Guarantee<Void> {
    let (rg, seal) = Guarantee<Void>.pending()
    let when = DispatchTime.now() + seconds
#if swift(>=4.0)
    DispatchQueue.global().asyncAfter(deadline: when) { seal(()) }
#else
    DispatchQueue.global().asyncAfter(deadline: when, execute: seal)
#endif
    return rg
}

/**
     after(seconds: 1.5).then {
         //…
     }

 - Returns: A new promise that fulfills after the specified duration.
*/
public func after(_ interval: DispatchTimeInterval) -> Guarantee<Void> {
    let (rg, seal) = Guarantee<Void>.pending()
    let when = DispatchTime.now() + interval
#if swift(>=4.0)
    DispatchQueue.global().asyncAfter(deadline: when) { seal(()) }
#else
    DispatchQueue.global().asyncAfter(deadline: when, execute: seal)
#endif
    return rg
}

/**
 AnyPromise is an Objective-C compatible promise.
*/
@objc(AnyPromise) public class AnyPromise: NSObject, Thenable, CatchMixin {
    fileprivate let box: Box<Any?>

    /// - Returns: A new `AnyPromise` bound to a `Promise<Any>`.
    public init<U: Thenable>(_ bridge: U) {
        box = EmptyBox()
        super.init()
        bridge.pipe {
            switch $0 {
            case .rejected(let error):
                self.box.seal(error)
            case .fulfilled(let value):
                self.box.seal(value)
            }
        }
    }

    fileprivate init(box: Box<Any?>) {
        self.box = box
    }

    public func pipe(to body: @escaping (Result<Any?>) -> Void) {
        sewer {
            switch $0 {
            case .fulfilled:
                // calling through to the ObjC `value` property unwraps (any) PMKManifold
                body(.fulfilled(self.value(forKey: "value")))
            case .rejected:
                body($0)
            }
        }
    }

    public var result: Result<Any?>? {
        switch box.inspect() {
        case .pending:
            return nil
        case .resolved(let obj as Error):
            return .rejected(obj)
        case .resolved(let value):
            return .fulfilled(value)
        }
    }

    fileprivate func sewer(to body: @escaping (Result<Any?>) -> Void) {
        switch box.inspect() {
        case .pending:
            box.inspect {
                switch $0 {
                case .pending(let handlers):
                    handlers.append {
                        if let error = $0 as? Error {
                            body(.rejected(error))
                        } else {
                            body(.fulfilled($0))
                        }
                    }
                case .resolved(let error as Error):
                    body(.rejected(error))
                case .resolved(let value):
                    body(.fulfilled(value))
                }
            }
        case .resolved(let error as Error):
            body(.rejected(error))
        case .resolved(let value):
            body(.fulfilled(value))
        }
    }
}

internal extension AnyPromise {
    @objc private var __value: Any? {
        switch box.inspect() {
        case .pending:
            return nil
        case .resolved(let obj):
            return obj
        }
    }

    @objc private var __pending: Bool {
        switch box.inspect() {
        case .pending:
            return true
        case .resolved:
            return false
        }
    }

    /**
     Creates a resolved promise.

     When developing your own promise systems, it is occasionally useful to be able to return an already resolved promise.

     - Parameter value: The value with which to resolve this promise. Passing an `NSError` will cause the promise to be rejected, passing an AnyPromise will return a new AnyPromise bound to that promise, otherwise the promise will be fulfilled with the value passed.

     - Returns: A resolved promise.
     */
    @objc class func promiseWithValue(_ value: Any?) -> AnyPromise {
        switch value {
        case let promise as AnyPromise:
            return promise
        default:
            return AnyPromise(box: SealedBox(value: value))
        }
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
    @objc class func promiseWithResolverBlock(_ body: (@escaping (Any?) -> Void) -> Void) -> AnyPromise {
        let box = EmptyBox<Any?>()
        let rap = AnyPromise(box: box)
        body { AnyPromise.apply($0, box) }
        return rap
    }

    private static func apply(_ value: Any?, _ box: Box<Any?>) {
        switch value {
        case let p as AnyPromise:
            p.__pipe{ apply($0, box) }
        default:
            box.seal(value)
        }
    }

    @objc private func __thenOn(_ q: DispatchQueue, execute body: @escaping (Any?) -> Any?) -> AnyPromise {
        let box = EmptyBox<Any?>()
        let rap = AnyPromise(box: box)
        ___pipe {
            switch $0 {
            case .rejected(let error):
                box.seal(error)
            case .fulfilled(let value):
                q.async {
                    AnyPromise.apply(body(value), box)
                }
            }
        }
        return rap

    }

    @objc private func __catchOn(_ q: DispatchQueue, execute body: @escaping (Any?) -> Any?) -> AnyPromise {
        let box = EmptyBox<Any?>()
        let rap = AnyPromise(box: box)
        ___pipe {
            switch $0 {
            case .rejected(let error):
                q.async {
                    AnyPromise.apply(body(error), box)
                }
            case .fulfilled(let value):
                box.seal(value)
            }
        }
        return rap
    }

    @objc private func __alwaysOn(_ q: DispatchQueue, execute body: @escaping () -> Void) -> AnyPromise {
        let box = EmptyBox<Any?>()
        let rap = AnyPromise(box: box)
        __pipe { obj in
            q.async {
                body()
                box.seal(obj)
            }
        }
        return rap
    }

    /// converts NSErrors, feeds raw PMKManifolds
    /// exposed to ObjC for use in a few places
    @objc private func __pipe(_ body: @escaping (Any?) -> Void) {
        sewer {
            switch $0 {
            case .fulfilled(let value):
                body(value)
            case .rejected(let error):
                body(error as NSError)
            }
        }
    }

    /// converts NSErrors, feeds raw PMKManifolds
    private func ___pipe(to body: @escaping (Result<Any?>) -> Void) {
        sewer {
            switch $0 {
            case .fulfilled:
                body($0)
            case .rejected(let error):
                body(.rejected(error as NSError))
            }
        }
    }
}


extension AnyPromise {
    /// - Returns: A description of the state of this promise.
    override public var description: String {
        switch box.inspect() {
        case .pending:
            return "AnyPromise(…)"
        case .resolved(let obj?):
            return "AnyPromise(\(obj))"
        case .resolved(nil):
            return "AnyPromise(nil)"
        }
    }
}


#if swift(>=3.1)
public extension Promise where T == Any? {
    convenience init(_ anyPromise: AnyPromise) {
        self.init(.pending) {
            anyPromise.pipe(to: $0.resolve)
        }
    }
}
#else
extension AnyPromise {
    public func asPromise() -> Promise<Any?> {
        return Promise(.pending, resolver: { resolve in
            pipe { result in
                switch result {
                case .rejected(let error):
                    resolve.reject(error)
                case .fulfilled(let obj):
                    resolve.fulfill(obj)
                }
            }
        })
    }
}
#endif

enum Sealant<R> {
    case pending(Handlers<R>)
    case resolved(R)
}

class Handlers<R> {
    var bodies: [(R) -> Void] = []
    func append(_ item: @escaping(R) -> Void) { bodies.append(item) }
}

class Box<T> {
    func inspect() -> Sealant<T> { fatalError() }
    func inspect(_: (Sealant<T>) -> Void) { fatalError() }
    func seal(_: T) {}
}

class SealedBox<T>: Box<T> {
    let value: T

    init(value: T) {
        self.value = value
    }

    override func inspect() -> Sealant<T> {
        return .resolved(value)
    }
}

class EmptyBox<T>: Box<T> {
    private var sealant = Sealant<T>.pending(.init())
    private let barrier = DispatchQueue(label: "org.promisekit.barrier", attributes: .concurrent)

    override func seal(_ value: T) {
        var handlers: Handlers<T>!
        barrier.sync(flags: .barrier) {
            guard case .pending(let _handlers) = self.sealant else {
                return  // already fulfilled!
            }
            handlers = _handlers
            self.sealant = .resolved(value)
        }

        //FIXME we are resolved so should `pipe(to:)` be called at this instant, “thens are called in order” would be invalid
        //NOTE we don’t do this in the above `sync` because that could potentially deadlock
        //THOUGH since `then` etc. typically invoke after a run-loop cycle, this issue is somewhat less severe

        if let handlers = handlers {
            handlers.bodies.forEach{ $0(value) }
        }

        //TODO solution is an unfortunate third state “sealed” where then's get added
        // to a separate handler pool for that state
        // any other solution has potential races
    }

    override func inspect() -> Sealant<T> {
        var rv: Sealant<T>!
        barrier.sync {
            rv = self.sealant
        }
        return rv
    }

    override func inspect(_ body: (Sealant<T>) -> Void) {
        var sealed = false
        barrier.sync(flags: .barrier) {
            switch sealant {
            case .pending:
                // body will append to handlers, so we must stay barrier’d
                body(sealant)
            case .resolved:
                sealed = true
            }
        }
        if sealed {
            // we do this outside the barrier to prevent potential deadlocks
            // it's safe because we never transition away from this state
            body(sealant)
        }
    }
}


extension Optional where Wrapped: DispatchQueue {
    func async(_ body: @escaping() -> Void) {
        switch self {
        case .none:
            body()
        case .some(let q):
            q.async(execute: body)
        }
    }
}

public protocol CatchMixin: Thenable
{}

public extension CatchMixin {
    @discardableResult
    func `catch`(on: DispatchQueue? = conf.Q.return, policy: CatchPolicy = conf.catchPolicy, _ body: @escaping(Error) -> Void) -> PMKFinalizer {
        let finalizer = PMKFinalizer()
        pipe {
            switch $0 {
            case .rejected(let error):
                guard policy == .allErrors || !error.isCancelled else {
                    fallthrough
                }
                on.async {
                    body(error)
                    finalizer.pending.resolve(())
                }
            case .fulfilled:
                finalizer.pending.resolve(())
            }
        }
        return finalizer
    }
}

public class PMKFinalizer {
    let pending = Guarantee<Void>.pending()

    public func finally(_ body: @escaping () -> Void) {
        pending.guarantee.done(body)
    }
}


public extension CatchMixin {
    func recover<U: Thenable>(on: DispatchQueue? = conf.Q.map, policy: CatchPolicy = conf.catchPolicy, _ body: @escaping(Error) throws -> U) -> Promise<T> where U.T == T {
        let rp = Promise<U.T>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                rp.box.seal(.fulfilled(value))
            case .rejected(let error):
                if policy == .allErrors || !error.isCancelled {
                    on.async {
                        do {
                            let rv = try body(error)
                            guard rv !== rp else { throw PMKError.returnedSelf }
                            rv.pipe(to: rp.box.seal)
                        } catch {
                            rp.box.seal(.rejected(error))
                        }
                    }
                } else {
                    rp.box.seal(.rejected(error))
                }
            }
        }
        return rp
    }

    /// recover into a Guarantee, note it is logically impossible for this to take a catchPolicy, thus allErrors are handled
    @discardableResult
    func recover(on: DispatchQueue? = conf.Q.map, _ body: @escaping(Error) -> Guarantee<T>) -> Guarantee<T> {
        let rg = Guarantee<T>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                rg.box.seal(value)
            case .rejected(let error):
                on.async {
                    body(error).pipe(to: rg.box.seal)
                }
            }
        }
        return rg
    }

    func ensure(on: DispatchQueue? = conf.Q.return, _ body: @escaping () -> Void) -> Promise<T> {
        let rp = Promise<T>(.pending)
        pipe { result in
            on.async {
                body()
                rp.box.seal(result)
            }
        }
        return rp
    }

    func cauterize() {
        self.catch {
            print("PromiseKit:cauterized-error:", $0)
        }
    }
}


public extension CatchMixin where T == Void {
    @discardableResult
    func recover(on: DispatchQueue? = conf.Q.map, _ body: @escaping(Error) -> Void) -> Guarantee<Void> {
        let rg = Guarantee<Void>(.pending)
        pipe {
            switch $0 {
            case .fulfilled:
                rg.box.seal(())
            case .rejected(let error):
                on.async {
                    body(error)
                    rg.box.seal(())
                }
            }
        }
        return rg
    }

    func recover(on: DispatchQueue? = conf.Q.map, _ body: @escaping(Error) throws -> Void) -> Promise<Void> {
        let rg = Promise<Void>(.pending)
        pipe {
            switch $0 {
            case .fulfilled:
                rg.box.seal(.fulfilled(()))
            case .rejected(let error):
                on.async {
                    do {
                        rg.box.seal(.fulfilled(try body(error)))
                    } catch {
                        rg.box.seal(.rejected(error))
                    }
                }
            }
        }
        return rg
    }
}

public struct PMKConfiguration {
    /// the default queues that promises handlers dispatch to
    public var Q = (map: DispatchQueue.main, return: DispatchQueue.main)

    public var catchPolicy = CatchPolicy.allErrorsExceptCancellation
}

public var conf = PMKConfiguration()

extension Promise: CustomStringConvertible {
    public var description: String {
        switch result {
        case nil:
            return "Promise(…\(T.self))"
        case .rejected(let error)?:
            return "Promise(\(error))"
        case .fulfilled(let value)?:
            return "Promise(\(value))"
        }
    }
}

extension Promise: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch box.inspect() {
        case .pending(let handlers):
            return "Promise<\(T.self)>.pending(handlers: \(handlers.bodies.count))"
        case .resolved(.rejected(let error)):
            return "Promise<\(T.self)>.rejected(\(type(of: error)).\(error))"
        case .resolved(.fulfilled(let value)):
            return "Promise<\(T.self)>.fulfilled(\(value))"
        }
    }
}

public enum PMKError: Error {
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

    /** `when()`, `race()` etc. were called with invalid parameters, eg. an empty array. */
    case badInput

    /// The operation was cancelled
    case cancelled

    /// `nil` was returned from `flatMap`
    case flatMap(Any, Any.Type)
}

extension PMKError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .flatMap(let obj, let type):
            return "Could not `flatMap<\(type)>`: \(obj)"
        case .invalidCallingConvention:
            return "A closure was called with an invalid calling convention, probably (nil, nil)"
        case .returnedSelf:
            return "A promise handler returned itself"
        case .badInput:
            return "Bad input was provided to a PromiseKit function"
        case .cancelled:
            return "The asynchronous sequence was cancelled"
        }
    }
}

extension PMKError: LocalizedError {
    public var errorDescription: String? {
        return debugDescription
    }
}



public protocol CancellableError: Error {
    var isCancelled: Bool { get }
}

extension Error {
    public var isCancelled: Bool {
        do {
            throw self
        } catch PMKError.cancelled {
            return true
        } catch let error as CancellableError {
            return error.isCancelled
        } catch let error as NSError {
            switch (error.domain, error.code) {
            case (NSCocoaErrorDomain, CocoaError.userCancelled.rawValue):
                return true
            case (NSURLErrorDomain, URLError.cancelled.rawValue):
                return true
            default:
                return false
            }
        } catch {
            return false  // Linux requires this
        }
    }
}

public enum CatchPolicy {
    case allErrors
    case allErrorsExceptCancellation
}

/**
 Judicious use of `firstly` *may* make chains more readable.

 Compare:

     URLSession.shared.dataTask(url: url1).then {
         URLSession.shared.dataTask(url: url2)
     }.then {
         URLSession.shared.dataTask(url: url3)
     }

 With:

     firstly {
         URLSession.shared.dataTask(url: url1)
     }.then {
         URLSession.shared.dataTask(url: url2)
     }.then {
         URLSession.shared.dataTask(url: url3)
     }
 */
public func firstly<U: Thenable>(execute body: () throws -> U) -> Promise<U.T> {
    do {
        let rp = Promise<U.T>(.pending)
        try body().pipe(to: rp.box.seal)
        return rp
    } catch {
        return Promise(error: error)
    }
}

public func firstly<T>(execute body: () -> Guarantee<T>) -> Guarantee<T> {
    return body()
}

public class Guarantee<T>: Thenable {
    let box: Box<T>

    public init(value: T) {
        box = SealedBox(value: value)
    }

    public init(_: PMKUnambiguousInitializer, resolver body: (@escaping(T) -> Void) -> Void) {
        box = EmptyBox()
        body(box.seal)
    }

    public func pipe(to: @escaping(Result<T>) -> Void) {
        pipe{ to(.fulfilled($0)) }
    }

    func pipe(to: @escaping(T) -> Void) {
        switch box.inspect() {
        case .pending:
            box.inspect {
                switch $0 {
                case .pending(let handlers):
                    handlers.append(to)
                case .resolved(let value):
                    to(value)
                }
            }
        case .resolved(let value):
            to(value)
        }
    }

    public var result: Result<T>? {
        switch box.inspect() {
        case .pending:
            return nil
        case .resolved(let value):
            return .fulfilled(value)
        }
    }

    init(_: PMKUnambiguousInitializer) {
        box = EmptyBox()
    }

    public class func pending() -> (guarantee: Guarantee<T>, resolve: (T) -> Void) {
        return { ($0, $0.box.seal) }(Guarantee<T>(.pending))
    }
}

public extension Guarantee {
    @discardableResult
    func done(on: DispatchQueue? = conf.Q.return, _ body: @escaping(T) -> Void) -> Guarantee<Void> {
        let rg = Guarantee<Void>(.pending)
        pipe { (value: T) in
            on.async {
                body(value)
                rg.box.seal(())
            }
        }
        return rg
    }

    func map<U>(on: DispatchQueue? = conf.Q.map, _ body: @escaping(T) -> U) -> Guarantee<U> {
        let rg = Guarantee<U>(.pending)
        pipe { value in
            on.async {
                rg.box.seal(body(value))
            }
        }
        return rg
    }

	@discardableResult
    func then<U>(on: DispatchQueue? = conf.Q.map, _ body: @escaping(T) -> Guarantee<U>) -> Guarantee<U> {
        let rg = Guarantee<U>(.pending)
        pipe { value in
            on.async {
                body(value).pipe(to: rg.box.seal)
            }
        }
        return rg
    }

    public func asVoid() -> Guarantee<Void> {
        return map(on: nil) { _ in }
    }
    
    /**
     Blocks this thread, so you know, don’t call this on a serial thread that
     any part of your chain may use. Like the main thread for example.
     */
    public func wait() -> T {

        if Thread.isMainThread {
            print("PromiseKit: warning: `wait()` called on main thread!")
        }

        var result = value

        if result == nil {
            let group = DispatchGroup()
            group.enter()
            pipe { (foo: T) in result = foo; group.leave() }
            group.wait()
        }
        
        return result!
    }
}

#if swift(>=3.1)
public extension Guarantee where T == Void {
    convenience init() {
        self.init(value: Void())
    }
}
#endif


public extension DispatchQueue {
    /**
     Asynchronously executes the provided closure on a dispatch queue.

         DispatchQueue.global().async(.promise) {
             md5(input)
         }.done { md5 in
             //…
         }

     - Parameter body: The closure that resolves this promise.
     - Returns: A new `Guarantee` resolved by the result of the provided closure.
     - Note: There is no Promise/Thenable version of this due to Swift compiler ambiguity issues.
     */
    final func async<T>(_: PMKNamespacer, group: DispatchGroup? = nil, qos: DispatchQoS = .default, flags: DispatchWorkItemFlags = [], execute body: @escaping () -> T) -> Guarantee<T> {
        let rg = Guarantee<T>(.pending)
        async(group: group, qos: qos, flags: flags) {
            rg.box.seal(body())
        }
        return rg
    }
}

/**
 Suspends the active thread waiting on the provided promise.

 Useful when an application's main thread should not terminate before the promise is resolved
 (e.g. commandline applications).

 - Returns: The value of the provided promise once resolved.
 - Throws: An error, should the promise be resolved with an error.
 - SeeAlso: `wait()`
*/
public func hang<T>(_ promise: Promise<T>) throws -> T {
#if os(Linux)
    // isMainThread is not yet implemented on Linux.
    let runLoopModeRaw = RunLoopMode.defaultRunLoopMode.rawValue._bridgeToObjectiveC()
    let runLoopMode: CFString = unsafeBitCast(runLoopModeRaw, to: CFString.self)
#else
    guard Thread.isMainThread else {
        // hang doesn't make sense on threads that aren't the main thread.
        // use `.wait()` on those threads.
        fatalError("Only call hang() on the main thread.")
    }
    let runLoopMode: CFRunLoopMode = CFRunLoopMode.defaultMode
#endif

    if promise.isPending {
        var context = CFRunLoopSourceContext()
        let runLoop = CFRunLoopGetCurrent()
        let runLoopSource = CFRunLoopSourceCreate(nil, 0, &context)
        CFRunLoopAddSource(runLoop, runLoopSource, runLoopMode)

        _ = promise.ensure {
            CFRunLoopStop(runLoop)
        }

        while promise.isPending {
            CFRunLoopRun()
        }
        CFRunLoopRemoveSource(runLoop, runLoopSource, runLoopMode)
    }

    switch promise.result! {
    case .rejected(let error):
        throw error
    case .fulfilled(let value):
        return value
    }
}

public class Promise<T>: Thenable, CatchMixin {
    let box: Box<Result<T>>

    public init(value: T) {
        box = SealedBox(value: .fulfilled(value))
    }

    public init(error: Error) {
        box = SealedBox(value: .rejected(error))
    }

    public init<U: Thenable>(_ bridge: U) where U.T == T {
        box = EmptyBox()
        bridge.pipe(to: box.seal)
    }

    public init(_: PMKUnambiguousInitializer, resolver body: (Resolver<T>) throws -> Void) {
        box = EmptyBox()
        do {
            try body(Resolver(box))
        } catch {
            box.seal(.rejected(error))
        }
    }

    public class func pending() -> (promise: Promise<T>, resolver: Resolver<T>) {
        return { ($0, Resolver($0.box)) }(Promise<T>(.pending))
    }

    public func pipe(to: @escaping(Result<T>) -> Void) {
        switch box.inspect() {
        case .pending:
            box.inspect {
                switch $0 {
                case .pending(let handlers):
                    handlers.append(to)
                case .resolved(let value):
                    to(value)
                }
            }
        case .resolved(let value):
            to(value)
        }
    }

    public var result: Result<T>? {
        switch box.inspect() {
        case .pending:
            return nil
        case .resolved(let result):
            return result
        }
    }

    init(_: PMKUnambiguousInitializer) {
        box = EmptyBox()
    }
}

public extension Promise {
    func tap(_ body: @escaping(Result<T>) -> Void) -> Promise {
        pipe(to: body)
        return self
    }

    public func asVoid() -> Promise<Void> {
        return map(on: nil) { _ in }
    }
    
    /**
     Blocks this thread, so you know, don’t call this on a serial thread that
     any part of your chain may use. Like the main thread for example.
     */
    public func wait() throws -> T {

        if Thread.isMainThread {
            print("PromiseKit: warning: `wait()` called on main thread!")
        }

        var result = self.result

        if result == nil {
            let group = DispatchGroup()
            group.enter()
            pipe { result = $0; group.leave() }
            group.wait()
        }

        switch result! {
        case .rejected(let error):
            throw error
        case .fulfilled(let value):
            return value
        }
    }
}

#if swift(>=3.1)
extension Promise where T == Void {
    public convenience init() {
        self.init(value: Void())
    }
}
#endif


public extension DispatchQueue {
    /**
     Asynchronously executes the provided closure on a dispatch queue.

         DispatchQueue.global().async(.promise) {
             try md5(input)
         }.done { md5 in
             //…
         }

     - Parameter body: The closure that resolves this promise.
     - Returns: A new `Promise` resolved by the result of the provided closure.
     - Note: There is no Promise/Thenable version of this due to Swift compiler ambiguity issues.
     */
    final func async<T>(_: PMKNamespacer, group: DispatchGroup? = nil, qos: DispatchQoS = .default, flags: DispatchWorkItemFlags = [], execute body: @escaping () throws -> T) -> Promise<T> {
        let promise = Promise<T>(.pending)
        async(group: group, qos: qos, flags: flags) {
            do {
                promise.box.seal(.fulfilled(try body()))
            } catch {
                promise.box.seal(.rejected(error))
            }
        }
        return promise
    }
}


public enum PMKNamespacer {
    case promise
}

public enum PMKUnambiguousInitializer {
    case pending
}
@inline(__always)
private func _race<U: Thenable>(_ thenables: [U]) -> Promise<U.T> {
    let rp = Promise<U.T>(.pending)
    for thenable in thenables {
        thenable.pipe(to: rp.box.seal)
    }
    return rp
}

/**
 Resolves with the first resolving promise from a set of promises.

     race(promise1, promise2, promise3).then { winner in
         //…
     }

 - Returns: A new promise that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Warning: aborts if the array is empty.
*/
public func race<U: Thenable>(_ thenables: U...) -> Promise<U.T> {
    return _race(thenables)
}

/**
 Resolves with the first resolving promise from a set of promises.

     race(promise1, promise2, promise3).then { winner in
         //…
     }

 - Returns: A new promise that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Remark: Returns promise rejected with PMKError.badInput if empty array provided
*/
public func race<U: Thenable>(_ thenables: [U]) -> Promise<U.T> {
    guard !thenables.isEmpty else {
        return Promise(error: PMKError.badInput)
    }
    return _race(thenables)
}

/**
 Resolves with the first resolving Guarantee from a set of promises.

     race(promise1, promise2, promise3).then { winner in
         //…
     }

 - Returns: A new guarantee that resolves when the first promise in the provided promises resolves.
 - Warning: If any of the provided promises reject, the returned promise is rejected.
 - Remark: Returns promise rejected with PMKError.badInput if empty array provided
*/
public func race<T>(_ guarantees: Guarantee<T>...) -> Guarantee<T> {
    let rg = Guarantee<T>(.pending)
    for guarantee in guarantees {
        guarantee.pipe(to: rg.box.seal)
    }
    return rg
}
public class Resolver<T> {
    let box: Box<Result<T>>

    init(_ box: Box<Result<T>>) {
        self.box = box
    }

    deinit {
        if case .pending = box.inspect() {
            print("PromiseKit: warning: pending promise deallocated")
        }
    }
}

public extension Resolver {
    func fulfill(_ value: T) {
        box.seal(.fulfilled(value))
    }

    func reject(_ error: Error) {
        box.seal(.rejected(error))
    }

    public func resolve(_ result: Result<T>) {
        box.seal(result)
    }

    public func resolve(_ obj: T?, _ error: Error?) {
        if let error = error {
            reject(error)
        } else if let obj = obj {
            fulfill(obj)
        } else {
            reject(PMKError.invalidCallingConvention)
        }
    }

    public func resolve(_ obj: T, _ error: Error?) {
        if let error = error {
            reject(error)
        } else {
            fulfill(obj)
        }
    }

    public func resolve(_ error: Error?, _ obj: T?) {
        resolve(obj, error)
    }
}

#if swift(>=3.1)
extension Resolver where T == Void {
    public func resolve(_ error: Error?) {
        if let error = error {
            reject(error)
        } else {
            fulfill(())
        }
    }
}
#endif

public enum Result<T> {
    case fulfilled(T)
    case rejected(Error)
}

public extension Result {
    var isFulfilled: Bool {
        switch self {
        case .fulfilled:
            return true
        case .rejected:
            return false
        }
    }
}




public protocol Thenable: class {
    associatedtype T
    func pipe(to: @escaping(Result<T>) -> Void)
    var result: Result<T>? { get }
}

public extension Thenable {
    public func then<U: Thenable>(on: DispatchQueue? = conf.Q.map, file: StaticString = #file, line: UInt = #line, _ body: @escaping(T) throws -> U) -> Promise<U.T> {
        let rp = Promise<U.T>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                on.async {
                    do {
                        let rv = try body(value)
                        guard rv !== rp else { throw PMKError.returnedSelf }
                        rv.pipe(to: rp.box.seal)
                    } catch {
                        rp.box.seal(.rejected(error))
                    }
                }
            case .rejected(let error):
                rp.box.seal(.rejected(error))
            }
        }
        return rp
    }

    func map<U>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T) throws -> U) -> Promise<U> {
        let rp = Promise<U>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                on.async {
                    do {
                        rp.box.seal(.fulfilled(try transform(value)))
                    } catch {
                        rp.box.seal(.rejected(error))
                    }
                }
            case .rejected(let error):
                rp.box.seal(.rejected(error))
            }
        }
        return rp
    }

    func flatMap<U>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T) throws -> U?) -> Promise<U> {
        let rp = Promise<U>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                on.async {
                    do {
                        if let rv = try transform(value) {
                            rp.box.seal(.fulfilled(rv))
                        } else {
                            throw PMKError.flatMap(value, U.self)
                        }
                    } catch {
                        rp.box.seal(.rejected(error))
                    }
                }
            case .rejected(let error):
                rp.box.seal(.rejected(error))
            }
        }
        return rp
    }

    func done(on: DispatchQueue? = conf.Q.return, _ body: @escaping(T) throws -> Void) -> Promise<Void> {
        let rp = Promise<Void>(.pending)
        pipe {
            switch $0 {
            case .fulfilled(let value):
                on.async {
                    do {
                        try body(value)
                        rp.box.seal(.fulfilled(()))
                    } catch {
                        rp.box.seal(.rejected(error))
                    }
                }
            case .rejected(let error):
                rp.box.seal(.rejected(error))
            }
        }
        return rp
    }

    /// Immutably access the fulfilled value; the returned Promise maintains that value.
    func get(_ body: @escaping (T) throws -> Void) -> Promise<T> {
        return map(on: conf.Q.return) {
            try body($0)
            return $0
        }
    }

    public func asVoid() -> Promise<Void> {
        return map(on: nil) { _ in }
    }
}

public extension Thenable {
    /**
     - Returns: The error with which this promise was rejected; `nil` if this promise is not rejected.
     */
    var error: Error? {
        switch result {
        case .none:
            return nil
        case .some(.fulfilled):
            return nil
        case .some(.rejected(let error)):
            return error
        }
    }

    /**
     - Returns: `true` if the promise has not yet resolved.
     */
    var isPending: Bool {
        return result == nil
    }

    /**
     - Returns: `true` if the promise has resolved.
     */
    var isResolved: Bool {
        return !isPending
    }

    /**
     - Returns: `true` if the promise was fulfilled.
     */
    var isFulfilled: Bool {
        return value != nil
    }

    /**
     - Returns: `true` if the promise was rejected.
     */
    var isRejected: Bool {
        return error != nil
    }

    /**
     - Returns: The value with which this promise was fulfilled or `nil` if this promise is pending or rejected.
     */
    var value: T? {
        switch result {
        case .none:
            return nil
        case .some(.fulfilled(let value)):
            return value
        case .some(.rejected):
            return nil
        }
    }
}

public extension Thenable where T: Sequence {
    func map<U>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T.Iterator.Element) throws -> U) -> Promise<[U]> {
        return map(on: on){ try $0.map(transform) }
    }

    func thenMap<U: Thenable>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T.Iterator.Element) throws -> U) -> Promise<[U.T]> {
        return then(on: on) {
            when(fulfilled: try $0.map(transform))
        }
    }

    func flatMap<U>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T.Iterator.Element) throws -> U?) -> Promise<[U]> {
        return map(on: on){ try $0.flatMap(transform) }
    }

    func thenFlatMap<U: Thenable>(on: DispatchQueue? = conf.Q.map, _ transform: @escaping(T.Iterator.Element) throws -> U) -> Promise<[U.T.Iterator.Element]> where U.T: Sequence {
        return then(on: on){
            when(fulfilled: try $0.map(transform))
        }.map(on: nil) {
            $0.flatMap{ $0 }
        }
    }

    func filter(on: DispatchQueue? = conf.Q.map, test: @escaping (T.Iterator.Element) -> Bool) -> Promise<[T.Iterator.Element]> {
        return map(on: on) { $0.filter(test) }
    }
}

public extension Thenable where T: Collection {
    var first: Promise<T.Iterator.Element> {
        return map(on: nil) { aa in
            if let a1 = aa.first {
                return a1
            } else {
                throw PMKError.badInput
            }
        }
    }

    var last: Promise<T.Iterator.Element> {
        return map(on: nil) { aa in
            if aa.isEmpty {
                throw PMKError.badInput
            } else {
                let i = aa.index(aa.endIndex, offsetBy: -1)
                return aa[i]
            }
        }
    }
}

public extension Thenable where T: Sequence, T.Iterator.Element: Comparable {
    func sorted(on: DispatchQueue? = conf.Q.map) -> Promise<[T.Iterator.Element]> {
        return map(on: on){ $0.sorted() }
    }
}

private func _when<U: Thenable>(_ thenables: [U]) -> Promise<Void> {
    var countdown = thenables.count
    guard countdown > 0 else {
        return Promise(value: Void())
    }

    let rp = Promise<Void>(.pending)

#if PMKDisableProgress || os(Linux)
    var progress: (completedUnitCount: Int, totalUnitCount: Int) = (0, 0)
#else
    let progress = Progress(totalUnitCount: Int64(thenables.count))
    progress.isCancellable = false
    progress.isPausable = false
#endif

    let barrier = DispatchQueue(label: "org.promisekit.barrier.when", attributes: .concurrent)

    for promise in thenables {
        promise.pipe { result in
            barrier.sync(flags: .barrier) {
                switch result {
                case .rejected(let error):
                    if rp.isPending {
                        progress.completedUnitCount = progress.totalUnitCount
                        rp.box.seal(.rejected(error))
                    }
                case .fulfilled:
                    guard rp.isPending else { return }
                    progress.completedUnitCount += 1
                    countdown -= 1
                    if countdown == 0 {
                        rp.box.seal(.fulfilled(()))
                    }
                }
            }
        }
    }

    return rp
}

/**
 Wait for all promises in a set to fulfill.

 For example:

     when(fulfilled: promise1, promise2).then { results in
         //…
     }.catch { error in
         switch error {
         case URLError.notConnectedToInternet:
             //…
         case CLError.denied:
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
public func when<U: Thenable>(fulfilled thenables: [U]) -> Promise<[U.T]> {
    return _when(thenables).map(on: nil) { thenables.map{ $0.value! } }
}

public func when<U: Thenable>(fulfilled promises: U...) -> Promise<Void> where U.T == Void {
    return _when(promises)
}

public func when<U: Thenable>(fulfilled promises: [U]) -> Promise<Void> where U.T == Void {
    return _when(promises)
}

public func when<U: Thenable, V: Thenable>(fulfilled pu: U, _ pv: V) -> Promise<(U.T, V.T)> {
    return _when([pu.asVoid(), pv.asVoid()]).map(on: nil) { (pu.value!, pv.value!) }
}

public func when<U: Thenable, V: Thenable, W: Thenable>(fulfilled pu: U, _ pv: V, _ pw: W) -> Promise<(U.T, V.T, W.T)> {
    return _when([pu.asVoid(), pv.asVoid(), pw.asVoid()]).map(on: nil) { (pu.value!, pv.value!, pw.value!) }
}

public func when<U: Thenable, V: Thenable, W: Thenable, X: Thenable>(fulfilled pu: U, _ pv: V, _ pw: W, _ px: X) -> Promise<(U.T, V.T, W.T, X.T)> {
    return _when([pu.asVoid(), pv.asVoid(), pw.asVoid(), px.asVoid()]).map(on: nil) { (pu.value!, pv.value!, pw.value!, px.value!) }
}

public func when<U: Thenable, V: Thenable, W: Thenable, X: Thenable, Y: Thenable>(fulfilled pu: U, _ pv: V, _ pw: W, _ px: X, _ py: Y) -> Promise<(U.T, V.T, W.T, X.T, Y.T)> {
    return _when([pu.asVoid(), pv.asVoid(), pw.asVoid(), px.asVoid(), py.asVoid()]).map(on: nil) { (pu.value!, pv.value!, pw.value!, px.value!, py.value!) }
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

     when(generator, concurrently: 3).done { datas in
         // ...
     }
 
 No more than three downloads will occur simultaneously.

 - Note: The generator is called *serially* on a *background* queue.
 - Warning: Refer to the warnings on `when(fulfilled:)`
 - Parameter promiseGenerator: Generator of promises.
 - Returns: A new promise that resolves when all the provided promises fulfill or one of the provided promises rejects.
 - SeeAlso: `when(resolved:)`
 */

public func when<It: IteratorProtocol>(fulfilled promiseIterator: It, concurrently: Int) -> Promise<[It.Element.T]> where It.Element: Thenable {

    guard concurrently > 0 else {
        return Promise(error: PMKError.badInput)
    }

    var generator = promiseIterator
    var root = Promise<[It.Element.T]>.pending()
    var pendingPromises = 0
    var promises: [It.Element] = []

    let barrier = DispatchQueue(label: "org.promisekit.barrier.when", attributes: [.concurrent])

    func dequeue() {
        guard root.promise.isPending else { return }  // don’t continue dequeueing if root has been rejected

        var shouldDequeue = false
        barrier.sync {
            shouldDequeue = pendingPromises < concurrently
        }
        guard shouldDequeue else { return }

        var index: Int!
        var promise: It.Element!

        barrier.sync(flags: .barrier) {
            guard let next = generator.next() else { return }

            promise = next
            index = promises.count

            pendingPromises += 1
            promises.append(next)
        }

        func testDone() {
            barrier.sync {
                if pendingPromises == 0 {
                    root.resolver.fulfill(promises.flatMap{ $0.value })
                }
            }
        }

        guard promise != nil else {
            return testDone()
        }

        promise.pipe { resolution in
            barrier.sync(flags: .barrier) {
                pendingPromises -= 1
            }

            switch resolution {
            case .fulfilled:
                dequeue()
                testDone()
            case .rejected(let error):
                root.resolver.reject(error)
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

 - Returns: A new promise that resolves once all the provided promises resolve. The array is ordered the same as the input, ie. the result order is *not* resolution order.
 - Warning: The returned promise can *not* be rejected.
 - Note: Any promises that error are implicitly consumed, your UnhandledErrorHandler will not be called.
 - Remark: Doesn't take Thenable due to protocol associatedtype paradox
*/
public func when<T>(resolved promises: Promise<T>...) -> Guarantee<[Result<T>]> {
    return when(resolved: promises)
}

public func when<T>(resolved promises: [Promise<T>]) -> Guarantee<[Result<T>]> {
    guard !promises.isEmpty else {
        return Guarantee(value: [])
    }

    var countdown = promises.count
    let barrier = DispatchQueue(label: "org.promisekit.barrier.join", attributes: .concurrent)

    let rg = Guarantee<[Result<T>]>(.pending)
    for promise in promises {
        promise.pipe { result in
            barrier.sync(flags: .barrier) {
                countdown -= 1
            }
            barrier.sync {
                if countdown == 0 {
                    rg.box.seal(promises.map{ $0.result! })
                }
            }
        }
    }
    return rg
}

public func when(_ guarantees: Guarantee<Void>...) -> Guarantee<Void> {
    return when(guarantees: guarantees)
}

public func when(guarantees: [Guarantee<Void>]) -> Guarantee<Void> {
    return when(fulfilled: guarantees).recover{ _ in }.asVoid()
}

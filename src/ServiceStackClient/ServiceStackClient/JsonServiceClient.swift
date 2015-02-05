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

public protocol ServiceClient
{
    func get<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer) -> T.Return?
    func get<T : IReturn where T : JsonSerializable>(request:T, query:[String:String], error:NSErrorPointer) -> T.Return?
    func get<T : JsonSerializable>(relativeUrl:String, error:NSErrorPointer) -> T?
    func getAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func getAsync<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) -> Promise<T.Return>
    func getAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T>
    
    func post<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer) -> T.Return?
    func post<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?, error:NSErrorPointer) -> Response?
    func postAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    
    func put<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer) -> T.Return?
    func put<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?, error:NSErrorPointer) -> Response?
    func putAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func putAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response>
    
    func delete<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer) -> T.Return?
    func delete<T : IReturn where T : JsonSerializable>(request:T, query:[String:String], error:NSErrorPointer) -> T.Return?
    func delete<T : JsonSerializable>(relativeUrl:String, error:NSErrorPointer) -> T?
    func deleteAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func deleteAsync<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) -> Promise<T.Return>
    func deleteAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T>
    
    func send<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest, error:NSErrorPointer) -> T?
    func sendAsync<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) -> Promise<T>
    
    func getData(url:String, error:NSErrorPointer) -> NSData?
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
    
    public struct HttpMethods {
        static let Get = "GET"
        static let Post = "POST"
        static let Put = "PUT"
        static let Delete = "DELTE"
        static let Head = "HEAD"
        static let Option = "OPTION"
        static let Path = "PATCH"
    }
    
    public init(baseUrl:String)
    {
        self.baseUrl = baseUrl.hasSuffix("/") ? baseUrl : baseUrl + "/"
        self.replyUrl = self.baseUrl + "json/reply/"
        var url = NSURL(string: self.baseUrl)
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
        return map[String(key[0]).lowercaseString + key[1..<key.count]] ?? map[String(key[0]).uppercaseString + key[1..<key.count]]
    }
    
    func populateResponseStatusFields(inout errorInfo:[NSObject : AnyObject], withObject:AnyObject) {
        if let status = getItem(withObject as NSDictionary, key: "ResponseStatus") as? NSDictionary {
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
    
    func handleResponse<T : JsonSerializable>(intoResponse:T, data:NSData, response:NSURLResponse, error:NSErrorPointer) -> T? {
        
        if let nsResponse = response as? NSHTTPURLResponse {
            if nsResponse.statusCode >= 400 {
                var errorInfo = [NSObject : AnyObject]()
                
                errorInfo["statusCode"] = nsResponse.statusCode
                errorInfo["statusDescription"] = nsResponse.description
                
                if let contentType = nsResponse.allHeaderFields["Content-Type"] as? String {
                    if let obj:AnyObject = parseJsonBytes(data) {
                        errorInfo["response"] = obj
                        errorInfo["errorCode"] = nsResponse.statusCode.toString()
                        errorInfo["message"] = nsResponse.statusDescription
                        populateResponseStatusFields(&errorInfo, withObject:obj)
                    }
                }
                
                var ex = fireErrorCallbacks(NSError(domain:self.domain, code:nsResponse.statusCode, userInfo:errorInfo))
                if error != nil {
                    error.memory = ex
                }
                
                return nil
            }
        }
        
        if responseFilter != nil {
            responseFilter!(response)
        }
        if Global.responseFilter != nil {
            Global.responseFilter!(response)
        }
        
        if let json = NSString(data: data, encoding: NSUTF8StringEncoding) {
            if let dto = T.reflect().fromJson(intoResponse, json: json, error:error) {
                return dto
            }
        }
        return nil
    }
    
    public func createUrl<T : IReturn where T : JsonSerializable>(typeInfo:Type<T.T>, dto:T, query:[String:String] = [:]) -> String {
        var requestUrl = self.replyUrl + T.typeName
        
        var sb = ""
        for pi in typeInfo.properties {
            if let strValue = pi.stringValue(dto) {
                sb += sb.count == 0 ? "?" : "&"
                sb += "\(pi.name)=\(strValue.urlEncode()!)"
            }
        }
        
        for (key,value) in query {
            sb += sb.count == 0 ? "?" : "&"
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
        
        var req = self.timeout == nil
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
    
    public func send<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest, error:NSErrorPointer = nil) -> T? {
        
        var response:NSURLResponse? = nil
        
        if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: error) {
            return self.handleResponse(intoResponse, data: data, response: response!, error: error)
        }
        
        return nil
    }
    
    public func sendAsync<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) -> Promise<T> {
        
        return Promise<T> { (complete, reject) in
            
            var task = self.createSession().dataTaskWithRequest(request) { (data, response, error) in
                if error != nil {
                    reject(self.handleError(error))
                }
                else {
                    var resposneError:NSError?
                    let response = self.handleResponse(intoResponse, data: data, response: response, error: &resposneError)
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
    
    public func get<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request), httpMethod:HttpMethods.Get), error:error)
    }
    
    public func get<T : IReturn where T : JsonSerializable>(request:T, query:[String:String], error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request, query:query), httpMethod:HttpMethods.Get), error:error)
    }
    
    public func get<T : JsonSerializable>(relativeUrl:String, error:NSErrorPointer = nil) -> T? {
        return send(T(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Get), error:error)
    }
    
    public func getAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request), httpMethod:HttpMethods.Get))
    }
    
    public func getAsync<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request, query:query), httpMethod:HttpMethods.Get))
    }
    
    public func getAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T> {
        return sendAsync(T(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Get))
    }
    
    
    public func post<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request), error:error)
    }
    
    public func post<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?, error:NSErrorPointer = nil) -> Response? {
        return send(Response(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Post, request:request), error:error)
    }
    
    public func postAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Post, request:request))
    }
    
    public func postAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(Response(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Post, request:request))
    }
    
    
    public func put<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request), error:error)
    }
    
    public func put<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?, error:NSErrorPointer = nil) -> Response? {
        return send(Response(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Put, request:request), error:error)
    }
    
    public func putAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(replyUrl.combinePath(T.typeName), httpMethod:HttpMethods.Put, request:request))
    }
    
    public func putAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(Response(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Put, request:request))
    }
    
    
    public func delete<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request), httpMethod:HttpMethods.Delete), error:error)
    }
    
    public func delete<T : IReturn where T : JsonSerializable>(request:T, query:[String:String], error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request, query:query), httpMethod:HttpMethods.Delete), error:error)
    }
    
    public func delete<T : JsonSerializable>(relativeUrl:String, error:NSErrorPointer = nil) -> T? {
        return send(T(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Delete), error:error)
    }
    
    public func deleteAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request), httpMethod:HttpMethods.Delete))
    }
    
    public func deleteAsync<T : IReturn where T : JsonSerializable>(request:T, query:[String:String]) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request, query:query), httpMethod:HttpMethods.Delete))
    }
    
    public func deleteAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T> {
        return sendAsync(T(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Delete))
    }
    
    public func getData(url:String, error:NSErrorPointer = nil) -> NSData? {
        var response:NSURLResponse? = nil
        if let data = NSURLConnection.sendSynchronousRequest(NSURLRequest(URL: NSURL(string:url)!), returningResponse: &response, error: error) {
            return data
        }
        return nil
    }
    
    public func getDataAsync(url:String) -> Promise<NSData> {
        return Promise<NSData> { (complete, reject) in
            var task = self.createSession().dataTaskWithURL(NSURL(string: url)!) { (data, response, error) in
                if error != nil {
                    reject(self.handleError(error))
                }
                complete(data)
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



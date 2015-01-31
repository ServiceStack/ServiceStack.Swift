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
    func get<T : JsonSerializable>(relativeUrl:String, error:NSErrorPointer) -> T?
    func getAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func getAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T>
    
    func post<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer) -> T.Return?
    func post<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?, error:NSErrorPointer) -> Response?
    func postAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    
    func put<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer) -> T.Return?
    func put<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?, error:NSErrorPointer) -> Response?
    func putAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func putAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response>
    
    func delete<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer) -> T.Return?
    func delete<T : JsonSerializable>(relativeUrl:String, error:NSErrorPointer) -> T?
    func deleteAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
    func deleteAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T>
    
    func send<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest, error:NSErrorPointer) -> T?
    func sendAsync<T : JsonSerializable>(intoResponse:T, request:NSMutableURLRequest) -> Promise<T>
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
        lastError = NSError(domain: domain, code: nsError.code,
            userInfo:["responseStatus": "TODO"])
        
        if lastError != nil {
            if onError != nil {
                onError!(lastError!)
            }
            if Global.onError != nil {
                Global.onError!(lastError!)
            }
        }
        
        return lastError!
    }
    
    func handleResponse<T : JsonSerializable>(intoResponse:T, data:NSData, response:NSURLResponse, error:NSErrorPointer) -> T {
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
        return intoResponse
    }

    public func createUrl<T : IReturn where T : JsonSerializable>(typeInfo:Type<T.T>, dto:T) -> String {
        var requestUrl = self.replyUrl + typeInfo.name
        
        var sb = ""
        
        for pi in typeInfo.properties {
            if let strValue = pi.stringValue(dto) {
                sb += sb.count == 0 ? "?" : "&"
                sb += "\(pi.name)=\(strValue.urlEncode()!)"
            }
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
                    var parseError:NSError?
                    let dto = self.handleResponse(intoResponse, data: data, response: response, error: &parseError)
                    if error == nil {
                        complete(dto)
                    } else {
                        reject(self.handleError(error))
                    }
                }
            }
            
            task.resume()
            self.lastTask = task
        }
    }
    
    public func get<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request), httpMethod:HttpMethods.Get))
    }
    
    public func get<T : JsonSerializable>(relativeUrl:String, error:NSErrorPointer = nil) -> T? {
        return send(T(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Get))
    }
    
    public func getAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request), httpMethod:HttpMethods.Get))
    }
    
    public func getAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T> {
        return sendAsync(T(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Get))
    }
    
    
    public func post<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(replyUrl.combinePath(T.reflect().name), httpMethod:HttpMethods.Post, request:request))
    }
    
    public func post<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?, error:NSErrorPointer = nil) -> Response? {
        return send(Response(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Post, request:request))
    }
    
    public func postAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(replyUrl.combinePath(T.reflect().name), httpMethod:HttpMethods.Post, request:request))
    }
    
    public func postAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(Response(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Post, request:request))
    }
    
    
    public func put<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(replyUrl.combinePath(T.reflect().name), httpMethod:HttpMethods.Put, request:request))
    }
    
    public func put<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?, error:NSErrorPointer = nil) -> Response? {
        return send(Response(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Put, request:request))
    }
    
    public func putAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(replyUrl.combinePath(T.reflect().name), httpMethod:HttpMethods.Put, request:request))
    }
    
    public func putAsync<Response : JsonSerializable, Request:JsonSerializable>(relativeUrl:String, request:Request?) -> Promise<Response> {
        return sendAsync(Response(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Put, request:request))
    }
    
    
    public func delete<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request), httpMethod:HttpMethods.Delete))
    }
    
    public func delete<T : JsonSerializable>(relativeUrl:String, error:NSErrorPointer = nil) -> T? {
        return send(T(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Delete))
    }
    
    public func deleteAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), request: self.createRequest(self.createUrl(T.reflect(), dto: request), httpMethod:HttpMethods.Delete))
    }
    
    public func deleteAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T> {
        return sendAsync(T(), request: self.createRequest(baseUrl.combinePath(relativeUrl), httpMethod:HttpMethods.Delete))
    }
}






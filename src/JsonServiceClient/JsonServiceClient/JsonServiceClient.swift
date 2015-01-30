//
//  JsonServiceClient.swift
//  JsonServiceClient
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
    func getAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return>
}

public class JsonServiceClient : ServiceClient
{
    var baseUrl:String
    var replyUrl:String
    var domain:String
    var lastError:NSError?
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
    
    func createUrl<T : IReturn where T : JsonSerializable>(typeInfo:Type<T.T>, dto:T) -> String {
        var requestUrl = self.replyUrl + typeInfo.name

        var sb = ""
        
        for pi in typeInfo.properties {
            if let strValue = pi.stringValue(dto) {
                sb += sb.length == 0 ? "?" : "&"
                sb += "\(pi.name)=\(strValue.urlEncode()!)"
            }
        }
        
        requestUrl += sb
        
        return requestUrl
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
    
    func createRequest(url:String, httpMethod:String, requestBody:NSData? = nil) -> NSMutableURLRequest {
        let nsUrl = NSURL(string: url)!
        
        var req = self.timeout == nil
            ? NSMutableURLRequest(URL: nsUrl)
            : NSMutableURLRequest(URL: nsUrl, cachePolicy: self.cachePolicy, timeoutInterval: self.timeout!)
        
        req.HTTPMethod = httpMethod
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if requestFilter != nil {
            requestFilter!(req)
        }
        
        if Global.requestFilter != nil {
            Global.requestFilter!(req)
        }
        
        return req
    }
    
    public func send<T : JsonSerializable>(intoResponse:T, httpMethod:String, url:String, requestBody:NSData? = nil, error:NSErrorPointer = nil) -> T? {
        
        var response:NSURLResponse? = nil
        let req = self.createRequest(url, httpMethod: httpMethod, requestBody: requestBody)
        
        if let data = NSURLConnection.sendSynchronousRequest(req, returningResponse: &response, error: error) {
            return self.handleResponse(intoResponse, data: data, response: response!, error: error)
        }
        
        return nil
    }
    
    public func sendAsync<T : JsonSerializable>(intoResponse:T, httpMethod:String, url:String, requestBody:NSData? = nil)
        -> Promise<T> {

        return Promise<T> { (complete, reject) in
            
            let req = self.createRequest(url, httpMethod: httpMethod, requestBody: requestBody)
            
            let task = self.createSession().dataTaskWithRequest(req) { (data, response, error) in
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
        }
    }
    
    public func get<T : IReturn where T : JsonSerializable>(request:T, error:NSErrorPointer = nil) -> T.Return? {
        return send(T.Return(), httpMethod: HttpMethods.Get, url: self.createUrl(T.reflect(), dto: request))
    }
    
    public func get<T : JsonSerializable>(relativeUrl:String, error:NSErrorPointer = nil) -> T? {
        return send(T(), httpMethod: HttpMethods.Get, url: baseUrl.combinePath(relativeUrl))
    }
    
    public func getAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return sendAsync(T.Return(), httpMethod: HttpMethods.Get, url: self.createUrl(T.reflect(), dto: request))
    }
    
    public func getAsync<T : JsonSerializable>(relativeUrl:String) -> Promise<T> {
        return sendAsync(T(), httpMethod: HttpMethods.Get, url: baseUrl.combinePath(relativeUrl))
    }

}






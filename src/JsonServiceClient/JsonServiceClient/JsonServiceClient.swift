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

public class JsonServiceClient
{
    var baseUrl:String
    var replyUrl:String
    
    public init(baseUrl:String)
    {
        self.baseUrl = baseUrl.hasSuffix("/") ? baseUrl : baseUrl + "/"
        self.replyUrl = self.baseUrl + "json/reply/"
    }
    
    func createUrl<T : IReturn where T : JsonSerializable>(typeInfo:Type<T.T>, dto:T) -> String {
        var requestUrl = self.replyUrl + typeInfo.name

        var sb = ""
        
        for pi in typeInfo.properties {
            if let strValue = pi.stringValue(dto) {
                sb += countElements(sb) == 0 ? "?" : "&"
                sb += "\(pi.name)=\(strValue)"
            }
        }
        
        requestUrl += sb
        
        println("REQUEST URL: \(requestUrl)")
        
        return requestUrl
    }
    
    public func getAsync<T : IReturn where T : JsonSerializable>(request:T) -> Promise<T.Return> {
        return Promise<T.Return> { (complete, reject) in
            let typeInfo = T.reflect()
            let url = NSURL(string: self.createUrl(typeInfo, dto: request))!

            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            config.HTTPAdditionalHeaders = ["Accept" : "application/json"]
            
            let session = NSURLSession(configuration: config)
            
            let task = session.dataTaskWithURL(url) { (data, response, error) in
                if error != nil {
                    reject(error)
                }
                else if let json = NSString(data: data, encoding: NSUTF8StringEncoding) {
                    if let dto = T.Return.reflect().fromJson(T.Return(), json: json) {
                        complete(dto)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    public func get<T : JsonSerializable>() -> T? {
        return nil
    }
}
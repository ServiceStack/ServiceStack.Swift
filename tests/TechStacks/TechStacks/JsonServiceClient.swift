/* Url: https://raw.githubusercontent.com/ServiceStack/ServiceStack.Swift/master/dist/JsonServiceClient.swift
//
// JsonServiceClient.swift
// ServiceStackClient
//
// Copyright (c) 2015 ServiceStack LLC. All rights reserved.
// License: https://servicestack.net/terms
*/

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




public class JObject
{
    var sb : String
    
    init(string : String? = nil) {
        sb = string ?? String()
    }
    
    func append(name: String, json: String?) {
        if sb.count > 0 {
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
    
    class func toJson<K : Hashable, V : JsonSerializable where K : StringSerializable>(map:[K:V]) -> String? {
        var jb = JObject()
        
        for (k,v) in map {
            jb.append(k.toString(), json: v.toJson())
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
        if countElements(sb) > 0 {
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
    class func unwrap(any:Any) -> Any? {
        let mi:MirrorType = reflect(any)
        if mi.disposition != .Optional {
            return any
        }
        if mi.count == 0 { return nil } // Optional.None
        let (name,some) = mi[0]
        return some.value
    }
}

func parseJson(json:String) -> AnyObject? {
    var error: NSError?
    return parseJson(json, &error)
}

func parseJson(json:String, error:NSErrorPointer) -> AnyObject? {
    let data = json.dataUsingEncoding(NSUTF8StringEncoding)!
    return parseJsonBytes(data, error)
}

func parseJsonBytes(bytes:NSData) -> AnyObject? {
    var error: NSError?
    return parseJsonBytes(bytes, &error)
}

func parseJsonBytes(bytes:NSData, error:NSErrorPointer) -> AnyObject? {
    let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(bytes,
        options: NSJSONReadingOptions.AllowFragments,
        error:error)
    return parsedObject
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
    
    public static func fromString(string: String) -> String? {
        return string
    }
    
    public static func fromObject(any:AnyObject) -> String?
    {
        switch any {
        case let s as String: return s
        default:return nil
        }
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
    
    public static func fromString(string: String) -> Character? {
        return string.count > 0 ? string[0] : nil
    }
    
    public static func fromObject(any:AnyObject) -> Character?
    {
        switch any {
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension NSDate : StringSerializable
{
    public class var typeName:String { return "NSDate" }
    
    public func toString() -> String {
        return self.isoDateString
    }
    
    public func toJson() -> String {
        return jsonString(self.isoDateString)
    }
    
    public class func fromString(string: String) -> NSDate? {
        var str = string.hasPrefix("\\")
            ? string[1..<string.count]
            : string
        let wcfJsonPrefix = "/Date("
        if str.hasPrefix(wcfJsonPrefix) {
            let unixTime = (str.splitOnFirst("(")[1].splitOnLast(")")[0].splitOnFirst("-")[0].splitOnFirst("+")[0] as NSString).doubleValue
            return NSDate(timeIntervalSince1970: unixTime / 1000) //ms -> secs
        }
        
        return NSDate.fromIsoDateString(string)
    }
    
    public class func fromObject(any:AnyObject) -> NSDate?
    {
        switch any {
        case let s as String: return fromString(s)
        case let d as NSDate: return d
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
    
    public static func fromString(str: String) -> Double? {
        return str.hasPrefix("P")
            ? NSTimeInterval.fromTimeIntervalString(str)
            : (str as NSString).doubleValue
    }
    
    public static func fromObject(any:AnyObject) -> Double?
    {
        switch any {
        case let d as Double: return d
        case let i as Int: return Double(i)
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}

extension NSTimeInterval
{
    
    public func toTimeIntervalString() -> String {
        var sb = "P"
        
        let d = NSDate(timeIntervalSinceNow: self)
        let now = NSDate()
        let diff = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitDay,fromDate:now,toDate:d,options:NSCalendarOptions(0))
        
        if diff.day > 0 {
            sb += "\(diff.day)D"
        }
        
        let c = d.components()
        if c.hour > 0 {
            sb += "\(c.hour)H"
        }
        if c.minute > 0 {
            sb += "\(c.minute)M"
        }
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "SSS"
        let strMs = dateFormatter.stringFromDate(d)
        
        sb += strMs != "000"
            ? "\(c.second).\(strMs)S"
            : c.second > 0 ? "\(c.second)S" : ""
        
        return sb
    }
    
    public func toTimeIntervalJson() -> String {
        return jsonString(toString())
    }
    
    public static func fromTimeIntervalString(string:String) -> NSTimeInterval? {
        var days = 0
        var hours = 0
        var minutes = 0
        var seconds = 0
        var ms = 0.0
        
        let t = string[1..<string.count].splitOnFirst("T") //strip P
        
        let hasTime = t.count == 2
        
        let d = t[0].splitOnFirst("D")
        if d.count == 2 {
            if let day = d[0].toInt() {
                days = day
            }
        }
        
        if hasTime {
            let h = t[1].splitOnFirst("H")
            if h.count == 2 {
                if let hour = h[0].toInt() {
                    hours = hour
                }
            }
            
            let m = h.last!.splitOnFirst("M")
            if m.count == 2 {
                if let min = m[0].toInt() {
                    minutes = min
                }
            }
            
            let s = m.last!.splitOnFirst("S")
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
    
    public static func fromTimeIntervalObject(any:AnyObject) -> NSTimeInterval?
    {
        switch any {
        case let s as String: return fromTimeIntervalString(s)
        case let t as NSTimeInterval: return t
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
    
    public static func fromString(str: String) -> Int? {
        return str.toInt()
    }
    
    public static func fromObject(any:AnyObject) -> Int?
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
    
    public static func fromString(str: String) -> Int8? {
        if let int = str.toInt() {
            return Int8(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> Int8?
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
    
    public static func fromString(str: String) -> Int16? {
        if let int = str.toInt() {
            return Int16(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> Int16?
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
    
    public static func fromString(str: String) -> Int32? {
        if let int = str.toInt() {
            return Int32(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> Int32?
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
    
    public static func fromString(str: String) -> Int64? {
        return (str as NSString).longLongValue
    }
    
    public static func fromObject(any:AnyObject) -> Int64?
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
    
    public static func fromString(str: String) -> UInt8? {
        if let int = str.toInt() {
            return UInt8(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> UInt8?
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
    
    public static func fromString(str: String) -> UInt16? {
        if let int = str.toInt() {
            return UInt16(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> UInt16?
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
    
    public static func fromString(str: String) -> UInt32? {
        if let int = str.toInt() {
            return UInt32(int)
        }
        return nil
    }
    
    public static func fromObject(any:AnyObject) -> UInt32?
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
    
    public static func fromString(str: String) -> UInt64? {
        return UInt64((str as NSString).longLongValue)
    }
    
    public static func fromObject(any:AnyObject) -> UInt64?
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
    
    public static func fromString(str: String) -> Float? {
        return (str as NSString).floatValue
    }
    
    public static func fromObject(any:AnyObject) -> Float?
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
    
    public static func fromString(str: String) -> Bool? {
        return str.lowercaseString == "true"
    }
    
    public static func fromObject(any:AnyObject) -> Bool?
    {
        switch any {
        case let b as Bool: return b
        case let i as Int: return i != 0
        case let s as String: return fromString(s)
        default:return nil
        }
    }
}


public class List<T>
{
    required public init(){}
}

public protocol HasReflect {
    typealias T : HasReflect
    class func reflect() -> Type<T>
    init()
}

public protocol Convertible {
    typealias T
    class var typeName:String { get }
    class func fromObject(any:AnyObject) -> T?
}

public protocol JsonSerializable : HasReflect, StringSerializable {
    func toJson() -> String
    class func fromJson(json:String) -> T?
}

public protocol StringSerializable : Convertible {
    func toJson() -> String
    func toString() -> String
    class func fromString(string:String) -> T?
}


public func populate<T>(instance:T, map:NSDictionary, propertiesMap:[String:PropertyType]) -> T {
    for (key, obj) in map {
        if let p = propertiesMap[key.lowercaseString] {
            //insanely this prevents a EXC_BAD_INSTRUCTION when accessing parent.doubleOptional! with a value!
            //"\(obj)"
            p.setValue(instance, value: obj)
        }
    }
    return instance
}

public func populateFromDictionary<T : JsonSerializable>(instance:T, map:[NSObject : AnyObject], propertiesMap:[String:PropertyType]) -> T {
    for (key, obj) in map {
        if let strKey = key as? String {
            if let p = propertiesMap[strKey.lowercaseString] {
                p.setValue(instance, value: obj)
            }
        }
    }
    return instance
}

public class TypeAccessor {}

public class Type<T : HasReflect> : TypeAccessor
{
    var properties: [PropertyType]
    var propertiesMap = [String:PropertyType]()
    
    init(properties:[PropertyType])
    {
        self.properties = properties
        
        for p in properties {
            propertiesMap[p.name.lowercaseString] = p
        }
    }
    
    public func toJson<T>(instance:T) -> String {
        var jb = JObject()
        for p in properties {
            if let value = p.jsonValue(instance) {
                jb.append(p.name, json: value)
            } else {
                jb.append(p.name, json: "null")
            }
        }
        return jb.toJson()
    }
    
    public func toString<T>(instance:T) -> String {
        return toJson(instance)
    }
    
    func fromJson<T : JsonSerializable>(json:String) -> T? {
        return fromJson(T(), json: json)
    }
    
    func fromJson<T>(instance:T, json:String, error:NSErrorPointer) -> T? {
        if let map = parseJson(json,error) as? NSDictionary {
            return populate(instance, map, propertiesMap)
        }
        return nil
    }
    
    func fromJson<T>(instance:T, json:String) -> T? {
        if let map = parseJson(json, nil) as? NSDictionary {
            return populate(instance, map, propertiesMap)
        }
        return nil
    }
    
    func fromString(instance:T, string:String) -> T? {
        return fromJson(instance, json: string)
    }
    
    func fromObject(instance:T, any:AnyObject) -> T? {
        switch any {
        case let s as String: return fromJson(instance, json: s)
        case let map as NSDictionary: return Type<T>.fromDictionary(instance, map: map)
        default: return nil
        }
    }
    
    class func fromDictionary(instance:T, map:NSDictionary) -> T {
        return populate(instance, map, T.reflect().propertiesMap)
    }
    
    public class func property<P : StringSerializable>(name:String, get:(T) -> P, set:(T,P) -> Void) -> PropertyType
    {
        return Property(name: name, get:get, set:set)
    }
    
    public class func optionalProperty<P : StringSerializable>(name:String, get:(T) -> P?, set:(T,P?) -> Void) -> PropertyType
    {
        return OptionalProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<P : JsonSerializable>(name:String, get:(T) -> P, set:(T,P) -> Void) -> PropertyType
    {
        return ObjectProperty(name: name, get:get, set:set)
    }
    
    public class func optionalObjectProperty<P : JsonSerializable>(name:String, get:(T) -> P?, set:(T,P?) -> Void) -> PropertyType
    {
        return OptionalObjectProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : StringSerializable where K : StringSerializable>(name:String, get:(T) -> [K:P], set:(T,[K:P]) -> Void) -> PropertyType
    {
        return DictionaryProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : StringSerializable where K : StringSerializable, K == K.T>(name:String, get:(T) -> [K:[P]], set:(T,[K:[P]]) -> Void) -> PropertyType
    {
        return DictionaryArrayProperty(name: name, get:get, set:set)
    }
    
    public class func objectProperty<K : Hashable, P : JsonSerializable where K : StringSerializable>(name:String, get:(T) -> [K:[K:P]], set:(T,[K:[K:P]]) -> Void) -> PropertyType
    {
        return DictionaryArrayDictionaryObjectProperty(name: name, get:get, set:set)
    }
    
    public class func arrayProperty<P : StringSerializable>(name:String, get:(T) -> [P], set:(T,[P]) -> Void) -> PropertyType
    {
        return ArrayProperty(name: name, get:get, set:set)
    }
    
    public class func optionalArrayProperty<P : StringSerializable>(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void) -> PropertyType
    {
        return OptionalArrayProperty(name: name, get:get, set:set)
    }
    
    public class func arrayProperty<P : JsonSerializable>(name:String, get:(T) -> [P], set:(T,[P]) -> Void) -> PropertyType
    {
        return ArrayObjectProperty(name: name, get:get, set:set)
    }
    
    public class func optionalArrayProperty<P : JsonSerializable>(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void) -> PropertyType
    {
        return OptionalArrayObjectProperty(name: name, get:get, set:set)
    }
}

public class PropertyType {
    public var name:String
    
    init(name:String) {
        self.name = name
    }
    
    public func jsonValue<T>(instance:T) -> String? {
        return nil
    }
    
    public func setValue<T>(instance:T, value:AnyObject) {
    }
    
    public func getValue<T>(instance:T) -> Any? {
        return nil
    }
    
    public func stringValue<T>(instance:T) -> String? {
        return nil
    }
}

public class Property<T : HasReflect, P : StringSerializable> : PropertyType
{
    public var get:(T) -> P
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P, set:(T,P) -> Void)
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
    
    public override func setValue(instance:T, value:AnyObject) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}

public class OptionalProperty<T : HasReflect, P : StringSerializable> : PropertyType
{
    public var get:(T) -> P?
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P?, set:(T,P?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func stringValue(instance:T) -> String? {
        if let p = get(instance) {
            return p.toString()
        }
        return super.jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        if let p = get(instance) {
            return p.toJson()
        }
        return super.jsonValue(instance)
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}


public class ObjectProperty<T : HasReflect, P : JsonSerializable> : PropertyType
{
    public var get:(T) -> P
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P, set:(T,P) -> Void)
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
    
    public override func setValue(instance:T, value:AnyObject) {
        if let p = value as? P {
            set(instance, p)
        }
        else if let p = P.fromObject(value) as? P {
            set(instance, p)
        }
    }
}

public class OptionalObjectProperty<T : HasReflect, P : JsonSerializable where P : HasReflect> : PropertyType
{
    public var get:(T) -> P?
    public var set:(T,P) -> Void
    
    init(name:String, get:(T) -> P?, set:(T,P?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func jsonValue(instance:T) -> String? {
        if let propValue = get(instance) {
            var strValue = propValue.toJson()
            return strValue
        }
        return super.jsonValue(instance)
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let map = value as? NSDictionary {
            let p = Type<P>.fromDictionary(P(), map: map)
            set(instance, p)
        }
    }
}

public class DictionaryProperty<T : HasReflect, K : Hashable, P : StringSerializable where K : StringSerializable> : PropertyType
{
    public var get:(T) -> [K:P]
    public var set:(T,[K:P]) -> Void
    
    init(name:String, get:(T) -> [K:P], set:(T,[K:P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let map = get(instance)
        
        var jb = JObject()
        for (key, value) in map {
            jb.append(key.toString(), json:value.toJson())
        }
        return jb.toJson()
    }
    
    public override func setValue(instance:T, value:AnyObject) {
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

public class DictionaryArrayProperty<T : HasReflect, K : Hashable, P : StringSerializable where K : StringSerializable, K == K.T> : PropertyType
{
    public var get:(T) -> [K:[P]]
    public var set:(T,[K:[P]]) -> Void
    
    init(name:String, get:(T) -> [K:[P]], set:(T,[K:[P]]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let map = get(instance)
        
        var jb = JObject()
        for (key, values) in map {
            var ja = JArray()
            for v in values {
                ja.append(v.toJson())
            }
            jb.append(key.toString(), json:ja.toJson())
        }
        return jb.toJson()
    }
    
    public override func setValue(instance:T, value:AnyObject) {
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

public class DictionaryArrayDictionaryObjectProperty<T : HasReflect, K : Hashable, P : JsonSerializable where K : StringSerializable> : PropertyType
{
    public var get:(T) -> [K:[K:P]]
    public var set:(T,[K:[K:P]]) -> Void
    
    init(name:String, get:(T) -> [K:[K:P]], set:(T,[K:[K:P]]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let map = get(instance)
        
        var jb = JObject()
        for (key, values:[K:P]) in map {
            jb.append(key.toString(), json:JObject.toJson(values))
        }
        return jb.toJson()
    }
    
    public override func setValue(instance:T, value:AnyObject) {
        if let map = value as? NSDictionary {
            var to = [K:[K:P]]()
            for (k,vArray) in map {
                var values = [K:P]()
                if let array = vArray as? NSArray {
                    for item in array {
                        if let map = item as? NSDictionary {
                            for (subK, subV) in map {
                                values[K.fromObject(subK)! as K] = P.fromObject(subV) as? P
                            }
                        }
                    }
                }
                to[K.fromObject(k) as K] = values
            }
            set(instance,to)
        }
    }
}

public class ArrayProperty<T : HasReflect, P : StringSerializable> : PropertyType
{
    public var get:(T) -> [P]
    public var set:(T,[P]) -> Void
    
    init(name:String, get:(T) -> [P], set:(T,[P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValues = get(instance)
        
        var sb = ""
        
        for item in propValues {
            if sb.count > 0 {
                sb += ","
            }
            var str:String = "null"
            str = item.toJson()
            
            sb += str
        }
        
        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:AnyObject) {
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

public class OptionalArrayProperty<T : HasReflect, P : StringSerializable> : PropertyType
{
    public var get:(T) -> [P]?
    public var set:(T,[P]?) -> Void
    
    init(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        var sb = ""
        if let propValues = get(instance) {
            for item in propValues {
                if sb.count > 0 {
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
    
    public override func setValue(instance:T, value:AnyObject) {
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

public class ArrayObjectProperty<T : HasReflect, P : JsonSerializable> : PropertyType
{
    public var get:(T) -> [P]
    public var set:(T,[P]) -> Void
    
    init(name:String, get:(T) -> [P], set:(T,[P]) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValues = get(instance)
        
        var sb = ""
        
        for item in propValues {
            if sb.count > 0 {
                sb += ","
            }
            var str:String = "null"
            str = item.toJson()
            
            sb += str
        }
        
        return "[\(sb)]"
    }
    
    public override func setValue(instance:T, value:AnyObject) {
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

public class OptionalArrayObjectProperty<T : HasReflect, P : JsonSerializable> : PropertyType
{
    public var get:(T) -> [P]?
    public var set:(T,[P]?) -> Void
    
    init(name:String, get:(T) -> [P]?, set:(T,[P]?) -> Void)
    {
        self.get = get
        self.set = set
        super.init(name: name)
    }
    
    public override func getValue(instance: T) -> Any? {
        return get(instance) as Any
    }
    
    public override func stringValue(instance:T) -> String? {
        return jsonValue(instance)
    }
    
    public override func jsonValue(instance:T) -> String? {
        let propValues = get(instance)
        
        var sb = ""
        
        if let propValues = get(instance) {
            for item in propValues {
                if sb.count > 0 {
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
    
    public override func setValue(instance:T, value:AnyObject) {
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

func jsonStringRaw(str:String?) -> String {
    if let s = str {
        return "\"\(s)\""
    }
    else {
        return "null"
    }
}

class Utils
{
    class func escapeChars() -> NSCharacterSet {
        return NSCharacterSet(charactersInString: "\"\n\r\t\\")
    }
}

func jsonString(str:String?) -> String {
    if let s = str {
        if let stringWithEscapeChars = s.rangeOfCharacterFromSet(Utils.escapeChars()) {
            //TODO: rewrite to encode manually to avoid unnecessary conversions
            var error:NSError?
            if let encodedData = NSJSONSerialization.dataWithJSONObject([s], options:NSJSONWritingOptions.allZeros, error:&error) {
                if let encodedJson = encodedData.toUtf8String() {
                    return encodedJson[1..<encodedJson.count-1] //strip []
                }
            }
        }
        return "\"\(s)\""
    }
    else {
        return "null"
    }
}



public extension String
{
    public var count: Int { return countElements(self) }
    
    public func contains(s:String) -> Bool {
        return (self as NSString).containsString(s)
    }
    
    public func trim() -> String {
        return (self as String).stringByTrimmingCharactersInSet(.whitespaceCharacterSet())
    }
    
    public subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
    
    public func urlEncode() -> String? {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
    }
    
    public func combinePath(path:String) -> String {
        return (self.hasSuffix("/") ? self : self + "/") + (path.hasPrefix("/") ? path[1..<path.count] : path)
    }
    
    public func splitOnFirst(separator:String) -> [String] {
        var to = [String]()
        if let range = self.rangeOfString(separator) {
            to.append(self[startIndex..<range.startIndex])
            to.append(self[range.endIndex..<endIndex])
        }
        else {
            to.append(self)
        }
        return to
    }
    
    public func splitOnLast(separator:String) -> [String] {
        var to = [String]()
        if let range = self.rangeOfString(separator, options:NSStringCompareOptions.BackwardsSearch) {
            to.append(self[startIndex..<range.startIndex])
            to.append(self[range.endIndex..<endIndex])
        }
        else {
            to.append(self)
        }
        return to
    }
    
    public func split(separator:String) -> [String] {
        return self.componentsSeparatedByString(separator)
    }
    
    public func indexOf(needle:String) -> Int {
        if let range = self.rangeOfString(needle) {
            return distance(startIndex, range.startIndex)
        }
        return -1
    }
    
    public func lastIndexOf(needle:String) -> Int {
        if let range = self.rangeOfString(needle, options:NSStringCompareOptions.BackwardsSearch) {
            return distance(startIndex, range.startIndex)
        }
        return -1
    }
    
    public func replace(needle:String, withString:String) -> String {
        return self.stringByReplacingOccurrencesOfString(needle, withString: withString)
    }
    
    public func toDouble() -> Double {
        return (self as NSString).doubleValue
    }
    
    public func print() -> String {
        println(self)
        return self
    }
}

extension Array
{
    func print() -> String {
        var sb = ""
        for item in self {
            if sb.count > 0 {
                sb += ","
            }
            sb += "\(item)"
        }
        println(sb)
        return sb
    }
}

extension NSData
{
    func toUtf8String() -> String? {
        if let str = NSString(data: self, encoding: NSUTF8StringEncoding) {
            return str as String
        }
        return nil
    }
    
    func print() -> String {
        return self.toUtf8String()!.print()
    }
}

extension NSError
{
    func convertUserInfo<T : JsonSerializable>() -> T? {
        return self.populateUserInfo(T())
    }
    
    func populateUserInfo<T : JsonSerializable>(instance:T) -> T? {
        if let userInfo = self.userInfo {
            let to = populateFromDictionary(T(), userInfo, T.reflect().propertiesMap)
            return to
        }
        return nil
    }
}


public extension NSDate {
    
    public convenience init(dateString:String, format:String="yyyy-MM-dd") {
        let fmt = NSDateFormatter()
        fmt.timeZone = NSTimeZone.defaultTimeZone()
        fmt.dateFormat = format
        let d = fmt.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    public convenience init(year:Int, month:Int, day:Int) {
        var c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        
        let gregorian = NSCalendar(identifier:NSGregorianCalendar)
        let d = gregorian?.dateFromComponents(c)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    public func components() -> NSDateComponents {
        let components  = NSCalendar.currentCalendar().components(
            NSCalendarUnit.DayCalendarUnit | NSCalendarUnit.MonthCalendarUnit | NSCalendarUnit.YearCalendarUnit,
            fromDate: self)
        
        return components
    }
    
    public var year:Int {
        return components().year
    }
    
    public var month:Int {
        return components().month
    }
    
    public var day:Int {
        return components().day
    }
    
    public var shortDateString:String {
        let fmt = NSDateFormatter()
        fmt.timeZone = NSTimeZone.defaultTimeZone()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt.stringFromDate(self)
    }
    
    public var isoDateString:String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        return dateFormatter.stringFromDate(self).stringByAppendingString("Z")
    }
    
    public class func fromIsoDateString(string:String) -> NSDate? {
        let isUtc = string.hasSuffix("Z")
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = isUtc ? NSTimeZone(abbreviation: "UTC") : NSTimeZone.localTimeZone()
        dateFormatter.dateFormat = string.count == 19
            ? "yyyy-MM-dd'T'HH:mm:ss"
            : "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
        
        return isUtc
            ? dateFormatter.dateFromString(string[0..<string.count-1])
            : dateFormatter.dateFromString(string)
    }
}

public func >(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedDescending
}
public func >=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedDescending
        || lhs == rhs
}
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
}
public func <=(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedAscending
        || lhs == rhs
}
public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == NSComparisonResult.OrderedSame
}
/*
Copyright 2014 Max Howell <mxcl@me.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/


let Q = NSOperationQueue()

private var asskey = "PMKSfjadfl"
private let policy = UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC) as objc_AssociationPolicy

func PMKRetain(obj: AnyObject) {
    objc_setAssociatedObject(obj, &asskey, obj, policy)
}

func PMKRelease(obj: AnyObject) {
    objc_setAssociatedObject(obj, &asskey, nil, policy)
}

func noop() {}

public let PMKErrorDomain = "PMKErrorDomain"
public let PMKURLErrorFailingDataKey = "PMKURLErrorFailingDataKey"
public let PMKURLErrorFailingStringKey = "PMKURLErrorFailingStringKey"
public let PMKURLErrorFailingURLResponseKey = "PMKURLErrorFailingURLResponseKey"
public let PMKJSONErrorJSONObjectKey = "PMKJSONErrorJSONObjectKey"
public let PMKJSONError = 1

public let NoSuchRecord = 2

private enum State<T> {
    case Pending(Handlers)
    case Fulfilled(@autoclosure () -> T) //TODO use plain T, once Swift compiler matures
    case Rejected(Error)
}

public class Promise<T> {
    private let barrier = dispatch_queue_create("org.promisekit.barrier", DISPATCH_QUEUE_CONCURRENT)
    private var _state: State<T>
    
    private var state: State<T> {
        var result: State<T>?
        dispatch_sync(barrier) { result = self._state }
        return result!
    }
    
    public var rejected: Bool {
        switch state {
        case .Fulfilled, .Pending: return false
        case .Rejected: return true
        }
    }
    public var fulfilled: Bool {
        switch state {
        case .Rejected, .Pending: return false
        case .Fulfilled: return true
        }
    }
    public var pending: Bool {
        switch state {
        case .Rejected, .Fulfilled: return false
        case .Pending: return true
        }
    }
    
    /**
    returns the fulfilled value unless the Promise is pending
    or rejected in which case returns `nil`
    */
    public var value: T? {
        switch state {
        case .Fulfilled(let value):
            return value()
        default:
            return nil
        }
    }
    
    /**
    returns the rejected error unless the Promise is pending
    or fulfilled in which case returns `nil`
    */
    public var error: NSError? {
        switch state {
        case .Rejected(let error):
            return error
        default:
            return nil
        }
    }
    
    public init(_ body:(fulfill:(T) -> Void, reject:(NSError) -> Void) -> Void) {
        _state = .Pending(Handlers())
        
        let resolver = { (newstate: State<T>) -> Void in
            var handlers = Array<()->()>()
            dispatch_barrier_sync(self.barrier) {
                switch self._state {
                case .Pending(let Ω):
                    self._state = newstate
                    handlers = Ω.bodies
                    Ω.bodies.removeAll(keepCapacity: false)
                default:
                    noop()
                }
            }
            for handler in handlers { handler() }
        }
        
        body({ resolver(.Fulfilled($0)) }, { error in
            if let pmkerror = error as? Error {
                pmkerror.consumed = false
                resolver(.Rejected(pmkerror))
            } else {
                resolver(.Rejected(Error(domain: error.domain, code: error.code, userInfo: error.userInfo)))
            }
        })
    }
    
    public class func defer() -> (promise:Promise, fulfill:(T) -> Void, reject:(NSError) -> Void) {
        var f: ((T) -> Void)?
        var r: ((NSError) -> Void)?
        let p = Promise{ f = $0; r = $1 }
        return (p, f!, r!)
    }
    
    public init(value: T) {
        _state = .Fulfilled(value)
    }
    
    public init(error: NSError) {
        _state = .Rejected(Error(domain: error.domain, code: error.code, userInfo: error.userInfo))
    }
    
    public func then<U>(onQueue q:dispatch_queue_t = dispatch_get_main_queue(), body:(T) -> U) -> Promise<U> {
        return Promise<U>{ (fulfill, reject) in
            let handler = { ()->() in
                switch self.state {
                case .Rejected(let error):
                    reject(error)
                case .Fulfilled(let value):
                    dispatch_async(q) { fulfill(body(value())) }
                case .Pending:
                    abort()
                }
            }
            switch self.state {
            case .Rejected, .Fulfilled:
                handler()
            case .Pending(let handlers):
                dispatch_barrier_sync(self.barrier) {
                    handlers.append(handler)
                }
            }
        }
    }
    
    public func then<U>(onQueue q:dispatch_queue_t = dispatch_get_main_queue(), body:(T) -> Promise<U>) -> Promise<U> {
        return Promise<U>{ (fulfill, reject) in
            let handler = { ()->() in
                switch self.state {
                case .Rejected(let error):
                    reject(error)
                case .Fulfilled(let value):
                    dispatch_async(q) {
                        let promise = body(value())
                        switch promise.state {
                        case .Rejected(let error):
                            reject(error)
                        case .Fulfilled(let value):
                            fulfill(value())
                        case .Pending(let handlers):
                            dispatch_barrier_sync(promise.barrier) {
                                handlers.append {
                                    switch promise.state {
                                    case .Rejected(let error):
                                        reject(error)
                                    case .Fulfilled(let value):
                                        fulfill(value())
                                    case .Pending:
                                        abort()
                                    }
                                }
                            }
                        }
                    }
                case .Pending:
                    abort()
                }
            }
            
            switch self.state {
            case .Rejected, .Fulfilled:
                handler()
            case .Pending(let handlers):
                dispatch_barrier_sync(self.barrier) {
                    handlers.append(handler)
                }
            }
            
        }
    }
    
    public func catch(onQueue q:dispatch_queue_t = dispatch_get_main_queue(), body:(NSError) -> T) -> Promise<T> {
        return Promise<T>{ (fulfill, _) in
            let handler = { ()->() in
                switch self.state {
                case .Rejected(let error):
                    dispatch_async(q) {
                        error.consumed = true
                        fulfill(body(error))
                    }
                case .Fulfilled(let value):
                    fulfill(value())
                case .Pending:
                    abort()
                }
            }
            switch self.state {
            case .Fulfilled, .Rejected:
                handler()
            case .Pending(let handlers):
                dispatch_barrier_sync(self.barrier) {
                    handlers.append(handler)
                }
            }
        }
    }
    
    public func catch(onQueue q:dispatch_queue_t = dispatch_get_main_queue(), body:(NSError) -> Void) -> Void {
        let handler = { ()->() in
            switch self.state {
            case .Rejected(let error):
                dispatch_async(q) {
                    error.consumed = true
                    body(error)
                }
            case .Fulfilled:
                noop()
            case .Pending:
                abort()
            }
        }
        switch self.state {
        case .Fulfilled, .Rejected:
            handler()
        case .Pending(let handlers):
            dispatch_barrier_sync(self.barrier) {
                handlers.append(handler)
            }
        }
    }
    
    public func catch(onQueue q:dispatch_queue_t = dispatch_get_main_queue(), body:(NSError) -> Promise<T>) -> Promise<T> {
        return Promise<T>{ (fulfill, reject) in
            
            let handler = { ()->() in
                switch self.state {
                case .Fulfilled(let value):
                    fulfill(value())
                case .Rejected(let error):
                    dispatch_async(q) {
                        error.consumed = true
                        let promise = body(error)
                        switch promise.state {
                        case .Fulfilled(let value):
                            fulfill(value())
                        case .Rejected(let error):
                            dispatch_async(q) { reject(error) }
                        case .Pending(let handlers):
                            dispatch_barrier_sync(promise.barrier) {
                                handlers.append {
                                    switch promise.state {
                                    case .Rejected(let error):
                                        reject(error)
                                    case .Fulfilled(let value):
                                        fulfill(value())
                                    case .Pending:
                                        abort()
                                    }
                                }
                            }
                        }
                    }
                case .Pending:
                    abort()
                }
            }
            
            switch self.state {
            case .Fulfilled, .Rejected:
                handler()
            case .Pending(let handlers):
                dispatch_barrier_sync(self.barrier) {
                    handlers.append(handler)
                }
            }
        }
    }
    
    //FIXME adding the queue parameter prevents compilation with Xcode 6.0.1
    public func finally(/*onQueue q:dispatch_queue_t = dispatch_get_main_queue(),*/ body:()->()) -> Promise<T> {
        let q = dispatch_get_main_queue()
        
        return Promise<T>{ (fulfill, reject) in
            let handler = { ()->() in
                switch self.state {
                case .Fulfilled(let value):
                    dispatch_async(q) {
                        body()
                        fulfill(value())
                    }
                case .Rejected(let error):
                    dispatch_async(q) {
                        body()
                        reject(error)
                    }
                case .Pending:
                    abort()
                }
            }
            switch self.state {
            case .Fulfilled, .Rejected:
                handler()
            case .Pending(let handlers):
                dispatch_barrier_sync(self.barrier) {
                    handlers.append(handler)
                }
            }
        }
    }
    
    /**
    Immediate resolution of body if the promise is fulfilled.
    
    Please note, there are good reasons that `then` does not call `body`
    immediately if the promise is already fulfilled. If you don’t understand
    the implications of unleashing zalgo, you should not under any
    cirumstances use this function!
    */
    public func thenUnleashZalgo(body:(T)->Void) -> Void {
        if let obj = value {
            body(obj)
        } else {
            then(body)
        }
    }
    
    public func voidify() -> Promise<Void> {
        // there is no body parameter, so we zalgo it
        
        let d = Promise<Void>.defer()
        
        let handler = { ()->() in
            switch self.state {
            case .Fulfilled:
                d.fulfill()
            case .Rejected(let error):
                d.reject(error)
            case .Pending:
                abort()
            }
        }
        
        switch state {
        case .Fulfilled, .Rejected:
            handler()
        case .Pending(let handlers):
            dispatch_barrier_sync(self.barrier) {
                handlers.append(handler)
            }
        }
        
        return d.promise
    }
}

public var PMKUnhandledErrorHandler = { (error: NSError) in
    NSLog("%@", "PromiseKit: Unhandled error: \(error)")
}

private class Error : NSError {
    var consumed: Bool = false  //TODO strictly, should be atomic
    
    deinit {
        if !consumed {
            PMKUnhandledErrorHandler(self)
        }
    }
}

/**
When accessing handlers from the State enum, the array
must not be a copy or we stop being thread-safe. Hence
this class.
*/
private class Handlers: SequenceType {
    var bodies: [()->()] = []
    
    func append(body: ()->()) {
        bodies.append(body)
    }
    
    func generate() -> IndexingGenerator<[()->()]> {
        return bodies.generate()
    }
    
    var count: Int {
        return bodies.count
    }
}

extension Promise: DebugPrintable {
    public var debugDescription: String {
        var state: State<T>?
        dispatch_sync(barrier) {
            state = self._state
        }
        
        switch state! {
        case .Pending(let handlers):
            var count: Int?
            dispatch_sync(barrier) {
                count = handlers.count
            }
            return "Promise: Pending with \(count!) handlers"
        case .Fulfilled(let value):
            return "Promise: Fulfilled with value: \(value())"
        case .Rejected(let error):
            return "Promise: Rejected with error: \(error)"
        }
    }
}

func dispatch_promise<T>(/*to q:dispatch_queue_t = dispatch_get_global_queue(0, 0),*/ body:() -> AnyObject) -> Promise<T> {
    let q = dispatch_get_global_queue(0, 0)
    return Promise<T> { (fulfill, reject) in
        dispatch_async(q) {
            let obj: AnyObject = body()
            if obj is NSError {
                reject(obj as NSError)
            } else {
                fulfill(obj as T)
            }
        }
    }
}

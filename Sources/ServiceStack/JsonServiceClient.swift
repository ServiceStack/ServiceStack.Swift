//
//  JsonServiceClient.swift
//  ServiceStack
//
//  Created by Demis Bellot on 1/29/15.
//  Copyright (c) 2021 ServiceStack, Inc. All rights reserved.
//

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Foundation
import PromiseKit

public protocol ServiceClient {
    func get<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func get<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func get<T: IReturn>(_ request: T, query: [String: String]) throws -> T.Return where T: Codable
    func get<T: Codable>(_ relativeUrl: String) throws -> T
    func getAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable
    func getAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable
    func getAsync<T: IReturn>(_ request: T, query: [String: String]) -> Promise<T.Return> where T: Codable
    func getAsync<T: Codable>(_ relativeUrl: String) -> Promise<T>

    func post<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func post<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func post<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response
    func postAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable
    func postAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable
    func postAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) -> Promise<Response>

    func put<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func put<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func put<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response
    func putAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable
    func putAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable
    func putAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) -> Promise<Response>

    func delete<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func delete<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func delete<T: IReturn>(_ request: T, query: [String: String]) throws -> T.Return where T: Codable
    func delete<T: Codable>(_ relativeUrl: String) throws -> T
    func deleteAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable
    func deleteAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable
    func deleteAsync<T: IReturn>(_ request: T, query: [String: String]) -> Promise<T.Return> where T: Codable
    func deleteAsync<T: Codable>(_ relativeUrl: String) -> Promise<T>

    func patch<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func patch<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func patch<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response
    func patchAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable
    func patchAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable
    func patchAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) -> Promise<Response>

    func send<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func send<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func send<T: Codable>(intoResponse: T, request: NSMutableURLRequest) throws -> T
    func sendAsync<T: Codable>(intoResponse: T, request: NSMutableURLRequest) -> Promise<T>

    func getData(url: String) throws -> (Data, HTTPURLResponse)
    func getDataAsync(url: String) -> Promise<(Data, HTTPURLResponse)>
    func getData(request: URLRequest, retryIf:((HTTPURLResponse) -> Bool)?) throws -> (Data, HTTPURLResponse)
    func getDataAsync(request: URLRequest, retryIf:((HTTPURLResponse) -> Promise<Bool>)?) -> Promise<(Data, HTTPURLResponse)>

    func getCookies() -> [String:String]
    func getTokenCookie() -> String?
    func getRefreshTokenCookie() -> String?
}

open class JsonServiceClient: NSObject, ServiceClient, IHasBearerToken, IHasSessionId, IHasVersion {
    open var baseUrl: String
    open var replyUrl: String
    open var domain: String
    open var lastError: NSError?
    open var lastTask: URLSessionDataTask?
    open var onError: ((NSError) -> Void)?
    open var timeout: TimeInterval?
    open var cachePolicy: NSURLRequest.CachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData

    open var urlSessionFactory: (() -> URLSession)?
    open var requestFilter: ((NSMutableURLRequest) -> Void)?
    open var responseFilter: ((URLResponse) -> Void)?

    open var bearerToken: String?
    open var refreshToken: String?
    open var sessionId: String?
    open var version: Int?

    open var ignoreCertificatesFor: [String] = []

    open var ignoreCert: Bool {
        set { ignoreCertificatesFor.append(baseUrl) }
        get { ignoreCertificatesFor.contains(baseUrl) }
    }

    public struct Global {
        static var requestFilter: ((NSMutableURLRequest) -> Void)?
        static var responseFilter: ((URLResponse) -> Void)?
        static var onError: ((NSError) -> Void)?
    }

    public init(baseUrl: String) {
        self.baseUrl = baseUrl.hasSuffix("/") ? baseUrl : baseUrl + "/"
        replyUrl = self.baseUrl + "json/reply/"
        let url = NSURL(string: self.baseUrl)
        domain = url!.host!
    }

    open func createSession() -> URLSession {
        let session = urlSessionFactory != nil
            ? urlSessionFactory!()
            : URLSession(configuration: .default, delegate: self, delegateQueue: nil)

        return session
    }

    open func handleError(nsError: NSError) -> NSError {
        return fireErrorCallbacks(
            error: NSError(domain: domain, code: nsError.code,
                           userInfo: ["errorCode": "\(nsError.code)", "message": nsError.description])
        )
    }

    open func fireErrorCallbacks(error: NSError) -> NSError {
        lastError = error
        if onError != nil {
            onError!(error)
        }
        if Global.onError != nil {
            Global.onError!(error)
        }
        return error
    }

    func getItem(map: [String: Any], key: String) -> Any? {
        return map[key.firstLowercased()] ?? map[key.firstUppercased()]
    }

    func populateResponseStatusFields(errorInfo: inout [String: Any], withObject: Any) {
        guard let withObject = withObject as? [String: Any] else { return }
        guard let status = getItem(map: withObject, key: "ResponseStatus") as? [String: Any] else { return }
        if let errorCode = getItem(map: status, key: "errorCode") as? String {
            errorInfo["errorCode"] = errorCode
        }
        if let message = getItem(map: status, key: "message") as? String {
            errorInfo["message"] = message
        }
        if let stackTrace = getItem(map: status, key: "stackTrace") as? String {
            errorInfo["stackTrace"] = stackTrace
        }
        if let errors: Any = getItem(map: status, key: "errors") {
            errorInfo["errors"] = errors
        }
    }

    open func handleResponse<T: Codable>(intoResponse: T, data: Data, response: URLResponse, error: NSErrorPointer = nil) throws -> T {
        if let nsResponse = response as? HTTPURLResponse {
            if let ex = createIfError(nsResponse, data, error: error) {
                throw ex
            }
        }
        return try handleResponse(intoResponse: intoResponse, data: data, response: response)
    }

    open func handleResponse<T: Codable>(intoResponse: T, data: Data, response: URLResponse) throws -> T {
        if intoResponse is ReturnVoid {
            return intoResponse
        }
        if responseFilter != nil {
            responseFilter!(response)
        }
        if Global.responseFilter != nil {
            Global.responseFilter!(response)
        }

        let dto = try fromJsonDataThrows(T.self, data)
        return dto
    }
    
    open func createIfError(_ nsResponse:HTTPURLResponse, _ data: Data, error:NSErrorPointer = nil) -> Error? {
        if nsResponse.statusCode >= 400 {
            var errorInfo: [String: Any] = [:]

            errorInfo["statusCode"] = nsResponse.statusCode
            errorInfo["statusDescription"] = nsResponse.description

            if let _ = nsResponse.allHeaderFields["Content-Type"] as? String {
                if let obj: Any = parseJsonBytes(data) {
                    errorInfo["response"] = obj
                    errorInfo["errorCode"] = "\(nsResponse.statusCode)"
                    errorInfo["message"] = nsResponse.statusDescription
                    populateResponseStatusFields(errorInfo: &errorInfo, withObject: obj)
                }
            }

            let ex = fireErrorCallbacks(error: NSError(domain: domain, code: nsResponse.statusCode, userInfo: errorInfo))
            if error != nil {
                error?.pointee = ex
            }
            return ex
        }
        return nil
    }

    open func createUrl<T: Codable>(dto: T, query: [String: String] = [:]) -> String {
        var requestUrl = replyUrl + String(describing: T.self)

        populateRequestDto(dto)

        var sb = ""
        for prop in AnyEncodable.properties(dto) {
            sb += sb.count == 0 ? "?" : "&"
            let val = try! toJsv(prop.value)?.urlEncode()
            sb += "\(prop.key)=\(val ?? "")"
        }

        for (key, value) in query {
            sb += sb.count == 0 ? "?" : "&"
            sb += "\(key)=\(value.urlEncode()!)"
        }

        requestUrl += sb

        return requestUrl
    }

    func populateRequestDto<T: Codable>(_ request: T) {
        if let token = self.bearerToken, var hasToken = request as? IHasBearerToken {
            if hasToken.bearerToken == nil {
                hasToken.bearerToken = token
            }
        }
        if let session = self.sessionId, var hasSession = request as? IHasSessionId {
            if hasSession.sessionId == nil {
                hasSession.sessionId = session
            }
        }
        if let version = self.version, var hasVersion = request as? IHasVersion {
            if hasVersion.version == nil {
                hasVersion.version = version
            }
        }
    }

    open func createRequestDto<T: Codable>(url: String, httpMethod: String, request: T?) -> NSMutableURLRequest {
        var contentType: String?
        var requestBody: Data?

        if let dto = request {
            populateRequestDto(dto)
            contentType = "application/json"
            requestBody = toJsonData(dto)
        }

        return createRequest(url: url, httpMethod: httpMethod, requestType: contentType, requestBody: requestBody)
    }

    open func createRequest(url: String, httpMethod: String, requestType: String? = nil, requestBody: Data? = nil) -> NSMutableURLRequest {
        let nsUrl = NSURL(string: url)!

        let req = timeout == nil
            ? NSMutableURLRequest(url: nsUrl as URL)
            : NSMutableURLRequest(url: nsUrl as URL, cachePolicy: cachePolicy, timeoutInterval: timeout!)

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
    
    func retryAfterReauth(response: HTTPURLResponse) -> Bool {
        if response.statusCode == 401 {
            let hasRefreshTokenCookie = self.getRefreshTokenCookie() != nil
            if self.refreshToken != nil || hasRefreshTokenCookie {
                return self.fetchNewAccessToken()
            }
        }
        return false
    }

    func retryAfterReauthAsync(response: HTTPURLResponse) -> Promise<Bool> {
        if response.statusCode == 401 {
            let hasRefreshTokenCookie = self.getRefreshTokenCookie() != nil
            if self.refreshToken != nil || hasRefreshTokenCookie {
                return self.fetchNewAccessTokenAsync()
            }
        }
        return Promise<Bool> { seal in seal.fulfill(false) }
    }

    @discardableResult
    open func send<T: Codable>(intoResponse: T, request: NSMutableURLRequest) throws -> T {
        let (data, response) = try getData(request: request as URLRequest, retryIf: retryAfterReauth)
        if data.isEmpty {
            return Factory<T>.create()
        }
        let dto = try handleResponse(intoResponse: intoResponse, data: data, response: response)
        return dto
    }
    
    open func getData(url: String) throws -> (Data, HTTPURLResponse) {
        let urlRequest = createRequest(url: resolveUrl(url), httpMethod: HttpMethods.Get)
        return try getData(request: urlRequest as URLRequest)
    }

    open func getData(request: URLRequest, retryIf:((HTTPURLResponse) -> Bool)? = nil) throws -> (Data, HTTPURLResponse) {
        let dataTaskSync = createSession().dataTaskSync(request: request as URLRequest)
        lastTask = dataTaskSync.task
        let cb = dataTaskSync.callback

        if cb?.response == nil {
            if let error = cb?.error {
                throw error
            }
            return (Data(), HTTPURLResponse())
        }

        var error: NSError? = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)
        if let data = cb?.data, let response = cb?.response as? HTTPURLResponse {
            if let ex = self.createIfError(response, data, error: &error) {
                if let fn = retryIf {
                    let success = fn(response)
                    if success {
                        return try getData(request: request)
                    }
                }
                throw ex
            }
            return (data, response)
        }

        return (Data(), HTTPURLResponse())
    }
    
    open func fetchNewAccessToken() -> Bool {
        let jwtRequest = GetAccessToken()
        jwtRequest.refreshToken = self.refreshToken
        let request = self.createRequestDto(
            url: self.replyUrl.combinePath(Reflect<GetAccessToken>.typeName),
            httpMethod: HttpMethods.Post,
            request: jwtRequest)
        do {
            let (data, response) = try getData(request: request as URLRequest)
            let dto = try handleResponse(intoResponse: GetAccessTokenResponse(), data: data, response: response)
            self.bearerToken = dto.accessToken
            return true
        } catch let e {
            Log.debug("\(e)")
            return false
        }
    }

    @discardableResult
    open func sendAsync<T: Codable>(intoResponse: T, request: NSMutableURLRequest) -> Promise<T> {
        return getDataAsync(request: request as URLRequest, retryIf: retryAfterReauthAsync)
            .map { (data,response) in
                let dto = try self.handleResponse(intoResponse: intoResponse, data: data, response: response)
                return dto
            }
    }
    
    open func getDataAsync(request: URLRequest, retryIf:((HTTPURLResponse) -> Promise<Bool>)? = nil) -> Promise<(Data, HTTPURLResponse)> {
        return Promise { seal in
            let task = createSession().dataTask(with: request as URLRequest) { data, response, error in
                if let error = error {
                    seal.reject(self.handleError(nsError: error as NSError))
                } else if let response = response as? HTTPURLResponse, let data = data {
                    var error: NSError? = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)
                    if let ex = self.createIfError(response, data, error: &error) {
                        if let fn = retryIf {
                            _ = fn(response).done { success in
                                if success {
                                    self.getDataAsync(request: request)
                                        .done { (response,data) in
                                            seal.fulfill((response,data))
                                        }.catch { retryEx in
                                            seal.reject(retryEx)
                                        }
                                } else {
                                    seal.reject(ex)
                                }
                            }
                        } else {
                            seal.reject(ex)
                        }
                    } else {
                        seal.fulfill((data, response))
                    }
                } else {
                    seal.fulfill((Data(), response as? HTTPURLResponse ?? HTTPURLResponse()))
                }
            }
            lastTask = task
            task.resume()
        }
    }

    open func getDataAsync(url: String) -> Promise<(Data, HTTPURLResponse)> {
        let urlRequest = createRequest(url: resolveUrl(url), httpMethod: HttpMethods.Get)
        return getDataAsync(request: urlRequest as URLRequest)
    }

    open func fetchNewAccessTokenAsync() -> Promise<Bool> {
        return Promise<Bool> { seal in
            let jwtRequest = GetAccessToken()
            jwtRequest.refreshToken = self.refreshToken
            let request = self.createRequestDto(
                url: self.replyUrl.combinePath(Reflect<GetAccessToken>.typeName),
                httpMethod: HttpMethods.Post,
                request: jwtRequest)
           
            getDataAsync(request: request as URLRequest)
                .done { (data, response) in
                    let dto = try self.handleResponse(intoResponse: GetAccessTokenResponse(), data: data, response: response)
                    self.bearerToken = dto.accessToken
                    seal.fulfill(true)
                }
                .catch { e in
                    Log.debug("\(e)")
                    seal.fulfill(false)
                }
        }
    }

    open func getCookies() -> [String:String] {
        let ret = urlCookies(URL(string: baseUrl)!)
        return ret
    }
    
    open func getTokenCookie() -> String? {
        let cookies = getCookies()
        return cookies["ss-tok"]
    }
    
    open func getRefreshTokenCookie() -> String? {
        let cookies = getCookies()
        return cookies["ss-reftok"]
    }

    open func resolveUrl(_ relativeOrAbsoluteUrl: String) -> String {
        return relativeOrAbsoluteUrl.hasPrefix("http:")
            || relativeOrAbsoluteUrl.hasPrefix("https:")
            ? relativeOrAbsoluteUrl
            : baseUrl.combinePath(relativeOrAbsoluteUrl)
    }

    open func hasRequestBody(httpMethod: String) -> Bool {
        switch httpMethod {
        case HttpMethods.Get, HttpMethods.Delete, HttpMethods.Head, HttpMethods.Options:
            return false
        default:
            return true
        }
    }

    open func getSendMethod<T>(_ request: T) -> String {
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
            HttpMethods.Post
    }

    open func send<T: IReturn>(_ request: T) throws -> T.Return where T: Codable {
        let httpMethod = getSendMethod(request)
        if hasRequestBody(httpMethod: httpMethod) {
            return try send(intoResponse: Factory<T.Return>.create(), request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: httpMethod, request: request))
        }

        return try send(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: httpMethod))
    }

    open func send<T: IReturnVoid>(_ request: T) throws where T: Codable {
        let httpMethod = getSendMethod(request)
        if hasRequestBody(httpMethod: httpMethod) {
            try send(intoResponse: ReturnVoid.void, request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: httpMethod, request: request))
        } else {
            try send(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: httpMethod))
        }
    }

    open func sendAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable {
        let httpMethod = getSendMethod(request)
        return hasRequestBody(httpMethod: httpMethod)
            ? sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: httpMethod, request: request))
            : sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: httpMethod))
    }

    open func sendAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable {
        let httpMethod = getSendMethod(request)
        return hasRequestBody(httpMethod: httpMethod)
            ? sendAsync(intoResponse: ReturnVoid.void, request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Post, request: request))
            .asVoid()
            : sendAsync(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Get))
            .asVoid()
    }

    open func get<T: IReturn>(_ request: T) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Get))
    }

    open func get<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable {
        try send(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Get))
    }

    open func get<T: IReturn>(_ request: T, query: [String: String]) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request, query: query), httpMethod: HttpMethods.Get))
    }

    open func get<T: Codable>(_ relativeUrl: String) throws -> T {
        return try send(intoResponse: Factory<T>.create(), request: createRequest(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Get))
    }

    open func getAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable {
        return sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Get))
    }

    @discardableResult
    open func getAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable {
        return sendAsync(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Get))
            .asVoid()
    }

    open func getAsync<T: IReturn>(_ request: T, query: [String: String]) -> Promise<T.Return> where T: Codable {
        return sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request, query: query), httpMethod: HttpMethods.Get))
    }

    open func getAsync<T: Codable>(_ relativeUrl: String) -> Promise<T> {
        return sendAsync(intoResponse: Factory<T>.create(), request: createRequest(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Get))
    }

    @discardableResult
    open func post<T: IReturn>(_ request: T) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Post, request: request))
    }

    open func post<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable {
        try send(intoResponse: ReturnVoid.void, request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Post, request: request))
    }

    @discardableResult
    open func post<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response {
        return try send(intoResponse: Factory<Response>.create(), request: createRequestDto(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Post, request: request))
    }

    @discardableResult
    open func postAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable {
        return sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Post, request: request))
    }

    @discardableResult
    open func postAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable {
        return sendAsync(intoResponse: ReturnVoid.void, request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Post, request: request))
            .asVoid()
    }

    @discardableResult
    open func postAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) -> Promise<Response> {
        return sendAsync(intoResponse: Factory<Response>.create(), request: createRequestDto(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Post, request: request))
    }

    @discardableResult
    open func put<T: IReturn>(_ request: T) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Put, request: request))
    }

    open func put<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable {
        try send(intoResponse: ReturnVoid.void, request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Put, request: request))
    }

    @discardableResult
    open func put<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response {
        return try send(intoResponse: Factory<Response>.create(), request: createRequestDto(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Put, request: request))
    }

    @discardableResult
    open func putAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable {
        return sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Put, request: request))
    }

    @discardableResult
    open func putAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable {
        return sendAsync(intoResponse: ReturnVoid.void, request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Put, request: request))
            .asVoid()
    }

    @discardableResult
    open func putAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) -> Promise<Response> {
        return sendAsync(intoResponse: Factory<Response>.create(), request: createRequestDto(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Put, request: request))
    }

    @discardableResult
    open func delete<T: IReturn>(_ request: T) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Delete))
    }

    open func delete<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable {
        try send(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func delete<T: IReturn>(_ request: T, query: [String: String]) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request, query: query), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func delete<T: Codable>(_ relativeUrl: String) throws -> T {
        return try send(intoResponse: Factory<T>.create(), request: createRequest(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func deleteAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable {
        return sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func deleteAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable {
        return sendAsync(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Delete))
            .asVoid()
    }

    @discardableResult
    open func deleteAsync<T: IReturn>(_ request: T, query: [String: String]) -> Promise<T.Return> where T: Codable {
        return sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request, query: query), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func deleteAsync<T: Codable>(_ relativeUrl: String) -> Promise<T> {
        return sendAsync(intoResponse: Factory<T>.create(), request: createRequest(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func patch<T: IReturn>(_ request: T) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Patch, request: request))
    }

    open func patch<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable {
        try send(intoResponse: ReturnVoid.void, request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Patch, request: request))
    }

    @discardableResult
    open func patch<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response {
        return try send(intoResponse: Factory<Response>.create(), request: createRequestDto(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Patch, request: request))
    }

    @discardableResult
    open func patchAsync<T: IReturn>(_ request: T) -> Promise<T.Return> where T: Codable {
        return sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Patch, request: request))
    }

    @discardableResult
    open func patchAsync<T: IReturnVoid>(_ request: T) -> Promise<Void> where T: Codable {
        return sendAsync(intoResponse: ReturnVoid.void, request: createRequestDto(url: replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Patch, request: request))
            .asVoid()
    }

    @discardableResult
    open func patchAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) -> Promise<Response> {
        return sendAsync(intoResponse: Factory<Response>.create(), request: createRequestDto(url: resolveUrl(relativeUrl), httpMethod: HttpMethods.Patch, request: request))
    }
}

extension JsonServiceClient: URLSessionDelegate {
    public static func toHostsMap(_ urls: [String]) -> [String: Int] {
        var to: [String: Int] = [:]
        for hostname in urls {
            var host = hostname
            var port = -1
            if host.contains("://") {
                host = host.rightPart("://")
            }
            if host.indexOf("/") >= 0 {
                host = host.leftPart("/")
            }
            if host.indexOf("?") >= 0 {
                host = host.leftPart("?")
            }
            if host.indexOf(":") >= 0 {
                port = Int(host.rightPart(":")) ?? -1
                host = host.leftPart(":")
            }
            to[host] = port
        }
        return to
    }

    func allowHost(domain: String, port: Int) -> Bool {
        let ignoreCerts = JsonServiceClient.toHostsMap(ignoreCertificatesFor)
        if let allowPort = ignoreCerts[domain] {
            return allowPort == -1 || port == allowPort
        }
        return false
    }

    public func urlSession(_: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if allowHost(domain: challenge.protectionSpace.host,
                     port: challenge.protectionSpace.port) {
            completionHandler(.useCredential,
                              URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

extension URLSession {
    public typealias URLSessionDataCallback = (data: Data?, response: URLResponse?, error: Error?)
    public typealias URLSessionDataTaskSync = (task: URLSessionDataTask, callback: URLSessionDataCallback?)

    open func dataTaskSync(request: URLRequest) -> URLSessionDataTaskSync {
        var callback: URLSessionDataCallback?
        let ds = DispatchSemaphore(value: 0)
        let task = dataTask(with: request as URLRequest) { data, response, error in
            callback = (data: data, response: response, error: error)
            ds.signal()
        }

        task.resume()
        ds.wait()
        return (task: task, callback: callback)
    }
}

extension HTTPURLResponse {
    // Unfortunately no API gives us the real statusDescription so using Status Code descriptions instead
    public var statusDescription: String {
        switch statusCode {
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

        default: return "\(statusCode)"
        }
    }
}

public struct HttpMethods {
    public static let Get = "GET"
    public static let Post = "POST"
    public static let Put = "PUT"
    public static let Delete = "DELETE"
    public static let Head = "HEAD"
    public static let Options = "OPTIONS"
    public static let Patch = "PATCH"
}

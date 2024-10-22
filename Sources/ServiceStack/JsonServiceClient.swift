//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Foundation

public protocol ServiceClient {
    func get<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func get<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func get<T: IReturn>(_ request: T, query: [String: String]) throws -> T.Return where T: Codable
    func get<T: Codable>(_ relativeUrl: String) throws -> T
    func getAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func getAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func getAsync<T: IReturn>(_ request: T, query: [String: String]) async throws -> T.Return where T: Codable
    func getAsync<T: Codable>(_ relativeUrl: String) async throws -> T

    func post<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func post<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func post<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response
    func postAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func postAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func postAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) async throws -> Response

    func put<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func put<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func put<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response
    func putAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func putAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func putAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) async throws -> Response

    func delete<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func delete<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func delete<T: IReturn>(_ request: T, query: [String: String]) throws -> T.Return where T: Codable
    func delete<T: Codable>(_ relativeUrl: String) throws -> T
    func deleteAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func deleteAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func deleteAsync<T: IReturn>(_ request: T, query: [String: String]) async throws -> T.Return where T: Codable
    func deleteAsync<T: Codable>(_ relativeUrl: String) async throws -> T

    func patch<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func patch<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func patch<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response
    func patchAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable
    func patchAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable
    func patchAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) async throws -> Response

    func send<T: IReturn>(_ request: T) throws -> T.Return where T: Codable
    func send<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable
    func send<T: Codable>(intoResponse: T, request: NSMutableURLRequest) throws -> T
    func sendAsync<T: Codable>(intoResponse: T, request: NSMutableURLRequest) async throws -> T

    func postFileWithRequest<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func postFileWithRequestAsync<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func postFileWithRequest<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func postFileWithRequestAsync<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func postFilesWithRequest<T: IReturn & Codable>(request:T, files:[UploadFile]) throws -> T.Return
    func postFilesWithRequestAsync<T: IReturn & Codable>(request:T, files:[UploadFile]) async throws -> T.Return
    func postFilesWithRequest<T: IReturn>(url:URL, request:T, files:[UploadFile]) throws -> T.Return
    func postFilesWithRequestAsync<T: IReturn>(url:URL, request:T, files:[UploadFile]) async throws -> T.Return
    func putFileWithRequest<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func putFileWithRequestAsync<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func putFileWithRequest<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func putFileWithRequestAsync<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func putFilesWithRequest<T: IReturn & Codable>(request:T, files:[UploadFile]) throws -> T.Return
    func putFilesWithRequestAsync<T: IReturn & Codable>(request:T, files:[UploadFile]) async throws -> T.Return
    func putFilesWithRequest<T: IReturn>(url:URL, request:T, files:[UploadFile]) throws -> T.Return
    func putFilesWithRequestAsync<T: IReturn>(url:URL, request:T, files:[UploadFile]) async throws -> T.Return
    func sendFileWithRequest<T: IReturn>(_ req:inout URLRequest, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) throws -> T.Return
    func sendFileWithRequestAsync<T: IReturn>(_ req:inout URLRequest, request:T, fileName:String, data:Data, mimeType:String?, fieldName:String?) async throws -> T.Return
    func sendFilesWithRequest<T: IReturn>(_ req:inout URLRequest, request:T, files:[UploadFile]) throws -> T.Return
    func sendFilesWithRequestAsync<T: IReturn>(_ req:inout URLRequest, request:T, files:[UploadFile]) async throws -> T.Return

    func getData(url: String) throws -> (Data, HTTPURLResponse)?
    func getDataAsync(url: String) async throws -> (Data, HTTPURLResponse)?
    func getData(request: URLRequest, retryIf:((HTTPURLResponse) -> Bool)?) throws -> (Data, HTTPURLResponse)?
    func getDataAsync(request: URLRequest, retryIf:((HTTPURLResponse) async throws -> Bool)?) async throws -> (Data, HTTPURLResponse)? 

    func getCookies() -> [String:String]
    func getTokenCookie() -> String?
    func getRefreshTokenCookie() -> String?
}

func toURL(_ url:String) -> URL {
    return URL(string: url)!
}

@available(macOS 13.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
open class JsonServiceClient : NSObject, @unchecked Sendable, ServiceClient, IHasBearerToken, IHasSessionId, IHasVersion {
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
        nonisolated(unsafe) public static var requestFilter: ((NSMutableURLRequest) -> Void)?
        nonisolated(unsafe) public static var responseFilter: ((URLResponse) -> Void)?
        nonisolated(unsafe) public static var onError: ((NSError) -> Void)?
        public static func reset() {
            requestFilter = nil
            responseFilter = nil
            onError = nil
        }
    }

    public init(baseUrl: String) {
        self.baseUrl = baseUrl.hasSuffix("/") ? baseUrl : baseUrl + "/"
        replyUrl = self.baseUrl + "json/reply/"
        let url = toURL(self.baseUrl)
        domain = url.host!
        super.init()
        self.basePath = "api"
    }
    
    open var basePath: String? {
        get {
            return self.replyUrl[self.baseUrl.count...]
        }
        set {
            guard let path = newValue, !path.isEmpty else {
                self.replyUrl = self.baseUrl.combinePath("json/reply") + "/"
                self.replyUrl = self.baseUrl.combinePath("json/oneway") + "/"
                return
            }
            self.replyUrl = self.baseUrl.combinePath(newValue!) + "/"
            self.replyUrl = self.baseUrl.combinePath(newValue!) + "/"
        }
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

    open func handleResponse<T: Codable>(intoResponse: T, data: Data, response: URLResponse) throws -> T {
        if let nsResponse = response as? HTTPURLResponse {
            if let ex = createIfError(nsResponse, data) {
                throw ex
            }
        }
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
    
    open func createIfError(_ nsResponse:HTTPURLResponse, _ data: Data) -> Error? {
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

            //var error: NSError? = NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil)
            let ex = fireErrorCallbacks(error: NSError(domain: domain, code: nsResponse.statusCode, userInfo: errorInfo))
            return ex
        }
        return nil
    }

    open func createUrl<T: Codable>(dto: T, query: [String: String] = [:]) -> URL {
        let requestUrl = replyUrl + String(describing: T.self)

        populateRequestDto(dto)
        
        var queryItems:[URLQueryItem] = []

        for prop in AnyEncodable.properties(dto) {
            do {
                var rawValue = prop.value.value as? String
                if rawValue == nil {
                    rawValue = try toJsv(prop.value)
                }
                if let jsvValue = rawValue {
                    if jsvValue != "[]" && jsvValue != "{}" {
                        queryItems.append(URLQueryItem(name:prop.key, value:jsvValue))
                    }
                }
            } catch let e {
                Log.error("createUrl(): \(prop.key):\(prop.value)", error: e)
            }
        }

        for (key, value) in query {
            queryItems.append(URLQueryItem(name:key, value:value))
        }

        let url = URL(string:requestUrl)!.appending(queryItems: queryItems)
        return url
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

    open func createRequestDto<T: Codable>(_ url: String, httpMethod: String, request: T?) -> NSMutableURLRequest {
        return createRequestDto(url: toURL(url), httpMethod: httpMethod, request: request)
    }

    open func createRequestDto<T: Codable>(url: URL, httpMethod: String, request: T?) -> NSMutableURLRequest {
        var contentType: String?
        var requestBody: Data?

        if let dto = request {
            populateRequestDto(dto)
            contentType = "application/json"
            requestBody = toJsonData(dto)
        }

        return createRequest(url: url, httpMethod: httpMethod, requestType: contentType, requestBody: requestBody)
    }

    open func createRequest(_ url: String, httpMethod: String, requestType: String? = nil, requestBody: Data? = nil) -> NSMutableURLRequest {
        return createRequest(url: toURL(url), httpMethod: httpMethod, requestType: requestType, requestBody: requestBody)
    }

    open func createRequest(url: URL, httpMethod: String, requestType: String? = nil, requestBody: Data? = nil) -> NSMutableURLRequest {

        let req = timeout == nil
            ? NSMutableURLRequest(url: url)
            : NSMutableURLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout!)

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

    func retryAfterReauthAsync(response: HTTPURLResponse) async throws -> Bool {
        if response.statusCode == 401 {
            let hasRefreshTokenCookie = self.getRefreshTokenCookie() != nil
            if self.refreshToken != nil || hasRefreshTokenCookie {
                return try await self.fetchNewAccessTokenAsync()
            }
        }
        return false
    }

    @discardableResult
    open func send<T: Codable>(intoResponse: T, request: NSMutableURLRequest) throws -> T {
        guard let (data, response) = try getData(request: request as URLRequest, retryIf: retryAfterReauth) else {
            return Factory<T>.create()
        }
        if data.isEmpty {
            return Factory<T>.create()
        }
        let dto = try handleResponse(intoResponse: intoResponse, data: data, response: response)
        return dto
    }
    
    @discardableResult
    open func sendAsync<T: Codable>(intoResponse: T, request: NSMutableURLRequest) async throws-> T {
        guard let (data, response) = try await getDataAsync(request: request as URLRequest, retryIf: retryAfterReauth) else {
            return Factory<T>.create()
        }
        if data.isEmpty {
            return Factory<T>.create()
        }
        let dto = try handleResponse(intoResponse: intoResponse, data: data, response: response)
        return dto
    }
    
    open func getData(url: String) throws -> (Data, HTTPURLResponse)? {
        let urlRequest = createRequest(url: toURL(resolveUrl(url)), httpMethod: HttpMethods.Get)
        return try getData(request: urlRequest as URLRequest)
    }

    open func getDataAsync(url: String) async throws -> (Data, HTTPURLResponse)? {
        let urlRequest = createRequest(url: toURL(resolveUrl(url)), httpMethod: HttpMethods.Get)
        return try await getDataAsync(request: urlRequest as URLRequest)
    }

    open func getData(request: URLRequest, retryIf:((HTTPURLResponse) -> Bool)? = nil) throws -> (Data, HTTPURLResponse)? {
        print("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        let dataTaskSync = createSession().dataTaskSync(request: request as URLRequest)
        lastTask = dataTaskSync.task
        let cb = dataTaskSync.callback

        if cb?.response == nil {
            if let error = cb?.error {
                throw error
            }
            return nil
        }

        if let data = cb?.data, let response = cb?.response as? HTTPURLResponse {
            if let ex = self.createIfError(response, data) {
                if let fn = retryIf {
                    let success = fn(response)
                    if success {
                        return try getData(request: request)
                    }
                }
                throw ex
            }
            return (data,response)
        }

        return nil
    }
    
    open func getDataAsync(request: URLRequest, retryIf:((HTTPURLResponse) async throws -> Bool)? = nil) async throws -> (Data, HTTPURLResponse)? {
        print("\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        let (data, res) = try await createSession().data(for: request)

        if let response = res as? HTTPURLResponse {
            if let ex = self.createIfError(response, data) {
                if let fn = retryIf {
                    let success = try await fn(response)
                    if success {
                        return try await getDataAsync(request: request)
                    }
                }
                throw ex
            }
            return (data,response)
        }
        return nil
    }

    open func fetchNewAccessToken() -> Bool {
        let jwtRequest = GetAccessToken()
        jwtRequest.refreshToken = self.refreshToken
        let request = self.createRequestDto(
            url: toURL(self.replyUrl.combinePath(Reflect<GetAccessToken>.typeName)),
            httpMethod: HttpMethods.Post,
            request: jwtRequest)
        do {
            guard let (data, response) = try getData(request: request as URLRequest) else {
                return false
            }
            let dto = try handleResponse(intoResponse: GetAccessTokenResponse(), data: data, response: response)
            self.bearerToken = dto.accessToken
            return true
        } catch let e {
            Log.debug("\(e)")
            return false
        }
    }

    open func fetchNewAccessTokenAsync() async throws -> Bool {
        let jwtRequest = GetAccessToken()
        jwtRequest.refreshToken = self.refreshToken
        let request = self.createRequestDto(
            url: toURL(self.replyUrl.combinePath(Reflect<GetAccessToken>.typeName)),
            httpMethod: HttpMethods.Post,
            request: jwtRequest)
        
        do {
            let result = try await getDataAsync(request: request as URLRequest)
            if let (data, response) = result {
                let dto = try self.handleResponse(intoResponse: GetAccessTokenResponse(), data: data, response: response)
                self.bearerToken = dto.accessToken
                return true
            } else {
                return false
            }
        } catch {
            Log.debug("\(error)")
            return false
        }
    }

    open func getCookies() -> [String:String] {
        let ret = urlCookies(toURL(baseUrl))
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
            return try send(intoResponse: Factory<T.Return>.create(), request: createRequestDto(url: toURL(replyUrl.combinePath(Reflect<T>.typeName)), httpMethod: httpMethod, request: request))
        }

        return try send(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: httpMethod))
    }

    open func send<T: IReturnVoid>(_ request: T) throws where T: Codable {
        let httpMethod = getSendMethod(request)
        if hasRequestBody(httpMethod: httpMethod) {
            try send(intoResponse: ReturnVoid.void, request: createRequestDto(url: toURL(replyUrl.combinePath(Reflect<T>.typeName)), httpMethod: httpMethod, request: request))
        } else {
            try send(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: httpMethod))
        }
    }

    open func sendAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable {
        let httpMethod = getSendMethod(request)
        return hasRequestBody(httpMethod: httpMethod)
            ? try await sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequestDto( replyUrl.combinePath(Reflect<T>.typeName), httpMethod: httpMethod, request: request))
            : try await sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: httpMethod))
    }

    open func sendAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable {
        let httpMethod = getSendMethod(request)
        _ = hasRequestBody(httpMethod: httpMethod)
        ? try await sendAsync(intoResponse: ReturnVoid.void, request: createRequestDto(url: toURL(replyUrl.combinePath(Reflect<T>.typeName)), httpMethod: HttpMethods.Post, request: request))
            : try await sendAsync(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Get))
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
        return try send(intoResponse: Factory<T>.create(), request: createRequest(resolveUrl(relativeUrl), httpMethod: HttpMethods.Get))
    }

    open func get<T: Codable>(url: URL) throws -> T {
        return try send(intoResponse: Factory<T>.create(), request: createRequest(url:url, httpMethod: HttpMethods.Get))
    }

    open func getAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable {
        return try await sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Get))
    }

    open func getAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable {
        _ = try await sendAsync(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Get))
    }

    open func getAsync<T: IReturn>(_ request: T, query: [String: String]) async throws -> T.Return where T: Codable {
        return try await sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request, query: query), httpMethod: HttpMethods.Get))
    }

    open func getAsync<T: Codable>(_ relativeUrl: String) async throws -> T {
        return try await sendAsync(intoResponse: Factory<T>.create(), request: createRequest( resolveUrl(relativeUrl), httpMethod: HttpMethods.Get))
    }

    open func getAsync<T: Codable>(url: URL) async throws -> T {
        return try await sendAsync(intoResponse: Factory<T>.create(), request: createRequest(
            url:url, httpMethod: HttpMethods.Get))
    }

    @discardableResult
    open func post<T: IReturn>(_ request: T) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequestDto( replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Post, request: request))
    }

    open func post<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable {
        try send(intoResponse: ReturnVoid.void, request: createRequestDto( replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Post, request: request))
    }

    @discardableResult
    open func post<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response {
        return try send(intoResponse: Factory<Response>.create(), request: createRequestDto( resolveUrl(relativeUrl), httpMethod: HttpMethods.Post, request: request))
    }

    @discardableResult
    open func postAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable {
        return try await sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequestDto(
            replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Post, request: request))
    }

    open func postAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable {
        _ = try await sendAsync(intoResponse: ReturnVoid.void, request: createRequestDto( replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Post, request: request))
    }

    @discardableResult
    open func postAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) async throws -> Response {
        return try await sendAsync(intoResponse: Factory<Response>.create(), request: createRequestDto( resolveUrl(relativeUrl), httpMethod: HttpMethods.Post, request: request))
    }

    @discardableResult
    open func put<T: IReturn>(_ request: T) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequestDto(
            replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Put, request: request))
    }

    open func put<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable {
        try send(intoResponse: ReturnVoid.void, request: createRequestDto(replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Put, request: request))
    }

    @discardableResult
    open func put<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response {
        return try send(intoResponse: Factory<Response>.create(), request: createRequestDto(
            resolveUrl(relativeUrl), httpMethod: HttpMethods.Put, request: request))
    }

    @discardableResult
    open func put<Response: Codable, Request: Codable>(url: URL, request: Request?) throws -> Response {
        return try send(intoResponse: Factory<Response>.create(), request: createRequestDto(
            url:url, httpMethod: HttpMethods.Put, request: request))
    }

    @discardableResult
    open func putAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable {
        return try await sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequestDto(
            replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Put, request: request))
    }

    open func putAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable {
        _ = try await sendAsync(intoResponse: ReturnVoid.void, request: createRequestDto( replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Put, request: request))
    }

    @discardableResult
    open func putAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) async throws -> Response {
        return try await sendAsync(intoResponse: Factory<Response>.create(), request: createRequestDto( resolveUrl(relativeUrl), httpMethod: HttpMethods.Put, request: request))
    }

    @discardableResult
    open func putAsync<Response: Codable, Request: Codable>(url: URL, request: Request?) async throws -> Response {
        return try await sendAsync(intoResponse: Factory<Response>.create(), request: createRequestDto(url: url, httpMethod: HttpMethods.Put, request: request))
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
        return try send(intoResponse: Factory<T>.create(), request: createRequest(resolveUrl(relativeUrl), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func delete<T: Codable>(url: URL) throws -> T {
        return try send(intoResponse: Factory<T>.create(), request: createRequest(url:url, httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func deleteAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable {
        return try await sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Delete))
    }

    open func deleteAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable {
        _ = try await sendAsync(intoResponse: ReturnVoid.void, request: createRequest(url: createUrl(dto: request), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func deleteAsync<T: IReturn>(_ request: T, query: [String: String]) async throws -> T.Return where T: Codable {
        return try await sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequest(url: createUrl(dto: request, query: query), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func deleteAsync<T: Codable>(_ relativeUrl: String) async throws -> T {
        return try await sendAsync(intoResponse: Factory<T>.create(), request: createRequest(resolveUrl(relativeUrl), httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func deleteAsync<T: Codable>(url:URL) async throws -> T {
        return try await sendAsync(intoResponse: Factory<T>.create(), request: createRequest(
            url:url, httpMethod: HttpMethods.Delete))
    }

    @discardableResult
    open func patch<T: IReturn>(_ request: T) throws -> T.Return where T: Codable {
        return try send(intoResponse: Factory<T.Return>.create(), request: createRequestDto(
            replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Patch, request: request))
    }

    open func patch<T: IReturnVoid>(_ request: T) throws -> Void where T: Codable {
        try send(intoResponse: ReturnVoid.void, request: createRequestDto( replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Patch, request: request))
    }

    @discardableResult
    open func patch<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) throws -> Response {
        return try send(intoResponse: Factory<Response>.create(), request: createRequestDto( resolveUrl(relativeUrl), httpMethod: HttpMethods.Patch, request: request))
    }

    @discardableResult
    open func patch<Response: Codable, Request: Codable>(url:URL, request: Request?) throws -> Response {
        return try send(intoResponse: Factory<Response>.create(), request: createRequestDto(
            url:url, httpMethod: HttpMethods.Patch, request: request))
    }

    @discardableResult
    open func patchAsync<T: IReturn>(_ request: T) async throws -> T.Return where T: Codable {
        return try await sendAsync(intoResponse: Factory<T.Return>.create(), request: createRequestDto( replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Patch, request: request))
    }

    open func patchAsync<T: IReturnVoid>(_ request: T) async throws -> Void where T: Codable {
        _ = try await sendAsync(intoResponse: ReturnVoid.void, request: createRequestDto( replyUrl.combinePath(Reflect<T>.typeName), httpMethod: HttpMethods.Patch, request: request))
    }

    @discardableResult
    open func patchAsync<Response: Codable, Request: Codable>(_ relativeUrl: String, request: Request?) async throws -> Response {
        return try await sendAsync(intoResponse: Factory<Response>.create(), request: createRequestDto( resolveUrl(relativeUrl), httpMethod: HttpMethods.Patch, request: request))
    }

    @discardableResult
    open func patchAsync<Response: Codable, Request: Codable>(url:URL, request: Request?) async throws -> Response {
        return try await sendAsync(intoResponse: Factory<Response>.create(), request: createRequestDto( url:url, httpMethod: HttpMethods.Patch, request: request))
    }
    
    open func postFileWithRequest<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") throws -> T.Return {
        return try postFileWithRequest(url:toURL(resolveUrl(relativeUrl)), request: request, fileName: fileName, data: data, mimeType: mimeType, fieldName: fieldName)
    }

    open func postFileWithRequestAsync<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") async throws -> T.Return {
        return try await postFileWithRequestAsync(url:toURL(resolveUrl(relativeUrl)), request: request, fileName: fileName, data: data, mimeType: mimeType, fieldName: fieldName)
    }

    open func postFileWithRequest<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") throws -> T.Return {
        var req = URLRequest(url: url)
        req.httpMethod = HttpMethods.Post
        return try sendFileWithRequest(&req, request: request, fileName: fileName, data: data, mimeType: mimeType, fieldName: fieldName)
    }

    open func postFileWithRequestAsync<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") async throws -> T.Return {
        var req = URLRequest(url: url)
        req.httpMethod = HttpMethods.Post
        return try await sendFileWithRequestAsync(&req, request: request, fileName: fileName, data: data, mimeType: mimeType, fieldName: fieldName)
    }

    open func postFilesWithRequest<T: IReturn & Codable>(request:T, files:[UploadFile]) throws -> T.Return {
        var req = URLRequest(url: createUrl(dto:request))
        req.httpMethod = HttpMethods.Post
        return try sendFilesWithRequest(&req, request: request, files:files)
    }

    open func postFilesWithRequestAsync<T: IReturn & Codable>(request:T, files:[UploadFile]) async throws -> T.Return {
        var req = URLRequest(url: createUrl(dto:request))
        req.httpMethod = HttpMethods.Post
        return try await sendFilesWithRequestAsync(&req, request: request, files:files)
    }

    open func postFilesWithRequest<T: IReturn>(url:URL, request:T, files:[UploadFile]) throws -> T.Return {
        var req = URLRequest(url: url)
        req.httpMethod = HttpMethods.Post
        return try sendFilesWithRequest(&req, request: request, files:files)
    }

    open func postFilesWithRequestAsync<T: IReturn>(url:URL, request:T, files:[UploadFile]) async throws -> T.Return {
        var req = URLRequest(url: url)
        req.httpMethod = HttpMethods.Post
        return try await sendFilesWithRequestAsync(&req, request: request, files:files)
    }

    open func putFileWithRequest<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") throws -> T.Return {
        return try putFileWithRequest(url:toURL(resolveUrl(relativeUrl)), request: request, fileName: fileName, data: data, mimeType: mimeType, fieldName: fieldName)
    }

    open func putFileWithRequestAsync<T: IReturn>(_ relativeUrl: String, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") async throws -> T.Return {
        return try await putFileWithRequestAsync(url:toURL(resolveUrl(relativeUrl)), request: request, fileName: fileName, data: data, mimeType: mimeType, fieldName: fieldName)
    }

    open func putFileWithRequest<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") throws -> T.Return {
        var req = URLRequest(url: url)
        req.httpMethod = HttpMethods.Put
        return try sendFileWithRequest(&req, request: request, fileName: fileName, data: data, mimeType: mimeType, fieldName: fieldName)
    }

    open func putFileWithRequestAsync<T: IReturn>(url:URL, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") async throws -> T.Return {
        var req = URLRequest(url: url)
        req.httpMethod = HttpMethods.Put
        return try await sendFileWithRequestAsync(&req, request: request, fileName: fileName, data: data, mimeType: mimeType, fieldName: fieldName)
    }

    open func putFilesWithRequest<T: IReturn & Codable>(request:T, files:[UploadFile]) throws -> T.Return {
        var req = URLRequest(url: createUrl(dto:request))
        req.httpMethod = HttpMethods.Put
        return try sendFilesWithRequest(&req, request: request, files:files)
    }

    open func putFilesWithRequestAsync<T: IReturn & Codable>(request:T, files:[UploadFile]) async throws -> T.Return {
        var req = URLRequest(url: createUrl(dto:request))
        req.httpMethod = HttpMethods.Put
        return try await sendFilesWithRequestAsync(&req, request: request, files:files)
    }

    open func putFilesWithRequest<T: IReturn>(url:URL, request:T, files:[UploadFile]) throws -> T.Return {
        var req = URLRequest(url: url)
        req.httpMethod = HttpMethods.Put
        return try sendFilesWithRequest(&req, request: request, files:files)
    }

    open func putFilesWithRequestAsync<T: IReturn>(url:URL, request:T, files:[UploadFile]) async throws -> T.Return {
        var req = URLRequest(url: url)
        req.httpMethod = HttpMethods.Put
        return try await sendFilesWithRequestAsync(&req, request: request, files:files)
    }

    open func sendFileWithRequest<T: IReturn>(_ req:inout URLRequest, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") throws -> T.Return {
        return try sendFilesWithRequest(&req, request: request, files:[UploadFile(fileName: fileName, data: data, fieldName: fieldName)])
    }

    open func sendFileWithRequestAsync<T: IReturn>(_ req:inout URLRequest, request:T, fileName:String, data:Data, mimeType:String? = nil, fieldName:String? = "file") async throws -> T.Return {
        return try await sendFilesWithRequestAsync(&req, request: request, files:[UploadFile(fileName: fileName, data: data, fieldName: fieldName)])
    }

    open func sendFilesWithRequest<T: IReturn>(_ req:inout URLRequest, request:T, files:[UploadFile]) throws -> T.Return {
        let boundary = "FormBoundary\(UUID().uuidString)"
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        req.httpBody = createMultipartFormData(request: request, files: files, boundary: boundary)

        guard let (data, response) = try getData(request: req, retryIf: retryAfterReauth) else {
            return Factory<T.Return>.create()
        }
        if data.isEmpty {
            return Factory<T.Return>.create()
        }
        let dto = try handleResponse(intoResponse: Factory<T.Return>.create(), data: data, response: response)
        return dto
    }

    open func sendFilesWithRequestAsync<T: IReturn>(_ req:inout URLRequest, request:T, files:[UploadFile]) async throws -> T.Return {
        let boundary = "FormBoundary\(UUID().uuidString)"
        req.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        req.httpBody = createMultipartFormData(request: request, files: files, boundary: boundary)

        guard let (data, response) = try await getDataAsync(request: req, retryIf: retryAfterReauth) else {
            return Factory<T.Return>.create()
        }
        if data.isEmpty {
            return Factory<T.Return>.create()
        }
        let dto = try handleResponse(intoResponse: Factory<T.Return>.create(), data: data, response: response)
        return dto
    }
}

public func createMultipartFormData<T: IReturn>(request:T, files:[UploadFile], boundary:String) -> Data {
    var body = Data()
    for prop in AnyEncodable.properties(request) {
        do {
            var rawValue = prop.value.value as? String
            if rawValue == nil {
                rawValue = try toJsv(prop.value)
            }
            if let jsvValue = rawValue {
                if jsvValue != "[]" && jsvValue != "{}" {
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(prop.key)\"\r\n\r\n".data(using: .utf8)!)
                    body.append("\(jsvValue)\r\n".data(using: .utf8)!)
                }
            }
        } catch let e {
            Log.error("sendFileWithRequest(): \(prop.key):\(prop.value)", error: e)
        }
    }

    files.enumerated().forEach { (i: Int, file: UploadFile) in
        let fieldName = file.fieldName ?? "upload\(i)"
        let contentType = file.contentType ?? getMimeType(for: file.fileName)
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(file.fileName)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(contentType)\r\n\r\n".data(using: .utf8)!)
        body.append(file.data)
        body.append("\r\n".data(using: .utf8)!)
    }
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    return body
}

@available(macOS 13.0, iOS 15.0, watchOS 8.0, tvOS 15.0, *)
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
#if !os(Linux)
            completionHandler(.useCredential,
                URLCredential(trust: challenge.protectionSpace.serverTrust!))
#endif
        } else {
            completionHandler(.performDefaultHandling, nil)
        }
    }
}

extension URLSession {
    public typealias URLSessionDataCallback = (data: Data?, response: URLResponse?, error: Error?)
    public typealias URLSessionDataTaskSync = (task: URLSessionDataTask, callback: URLSessionDataCallback?)

    public func dataTaskSync(request: URLRequest) -> URLSessionDataTaskSync {
        nonisolated(unsafe) var callback: URLSessionDataCallback?
        let ds: DispatchSemaphore = DispatchSemaphore(value: 0)
        let task: URLSessionDataTask = dataTask(with: request as URLRequest) { 
            data, response, error in
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

extension NSMutableURLRequest {
    public var method: String {
        get {
#if os(Linux)
        return httpMethod!
#else
        return httpMethod
#endif
        }
    }
}

public struct UploadFile
{
    public var fileName: String
    public var data: Data
    public var fieldName: String?
    public var contentType: String?

    public init(fileName: String, data: Data, fieldName: String?=nil, contentType: String?=nil) {
        self.fileName = fileName
        self.data = data
        self.fieldName = fieldName
        self.contentType = contentType
    }
}

public func getMimeType(for fileNameOrExt: String) -> String {

    let ext = fileNameOrExt.lastRightPart(".")
    switch ext {
        case "jpg", "jpeg", "jif", "jfif": return "image/jpeg"
        case "webp", "png", "gif", "bmp", "tiff": return "image/\(ext)"
        case "svg": return "image/svg+xml"
        case "ico": return "image/x-icon"
        case "mp3", "wav", "aiff", "aac", "m4a", "ogg", "oga": return "audio/\(ext)"
        case "mp4", "mpeg", "mpg", "mpe", "mpv", "ogv", "avi", "mov", "wmv", "mkv": return "video/\(ext)"                
        case "pdf": return "application/pdf"
        case "zip", "gz", "bz2", "rar", "tar", "7z", "tgz", "lzh", "z": return "application/x-compressed"
        case "exe", "com", "bat", "dll", "sys", "drv", "ocx", "oxt", "xoox", "apk", "app": return "application/octet-stream"
        case "html", "htm", "shtml": return "text/html"
        case "js", "mjs", "cjs": return "text/javascript"
        case "jsx", "csv", "jsonl", "css", "yaml", "xml": return "text/\(ext)"
        case "txt", "ps1": return "text/plain"
        case "md": return "text/markdown"
        case "doc", "dot": return "application/msword"
        case "xls", "xlt", "xla", "xlsx", "xltx": return "application/vnd.ms-excel"
        case "ppt", "pps", "pot", "ppa", "ppz", "ppsa", "ppsm", "pptx", "pptm", "ppsx", "odt": return "application/vnd.ms-powerpoint"
        case "dmg": return "application/x-apple-diskimage"
        case "pkg": return "application/x-newton-compatible-pkg"
        case "jar": return "application/java-archive"

        default: return "application/\(ext)"
    }
}

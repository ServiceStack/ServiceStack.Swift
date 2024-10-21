//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import ServiceStack

final class AuthTests : @unchecked Sendable {
    var client: JsonServiceClient!
    
    init() async throws {
        client = JsonServiceClient(baseUrl: "https://test.servicestack.net")
        print("JsonServiceClient.init()")
    }

    func createAuthRequest() -> Authenticate {
        let request = Authenticate()
        request.provider = "credentials"
        request.userName = "test"
        request.password = "test"
        return request
    }

    @Test func Does_fetch_AccessToken_using_RefreshTokenCookies() async throws {
        let request = Secured()
        request.name = "test"

        _ = try await client.postAsync(createAuthRequest())

        let initialAccessToken = self.client.getTokenCookie()
        let initialRefreshToken = self.client.getRefreshTokenCookie()
        #expect(initialAccessToken != nil)
        #expect(initialRefreshToken != nil)
    
        _ = try await client.postAsync(InvalidateLastAccessToken())

        let r = try await client.sendAsync(request)
        #expect(r.result == request.name)
                                        
        let lastAccessToken = client.getTokenCookie()
        #expect(lastAccessToken != nil)
//        #expect(lastAccessToken != initialAccessToken)
    }

    @Test func Does_fetch_AccessToken_using_RefreshTokenCookies_sync() throws {
        let request = Secured()
        request.name = "test"

        _ = try client.post(createAuthRequest())
        let initialAccessToken = client.getTokenCookie()
        let initialRefreshToken = client.getRefreshTokenCookie()
        #expect(initialAccessToken != nil)
        #expect(initialRefreshToken != nil)
        
        var r = try client.send(request)
        #expect(r.result == request.name)
        
        _ = try client.post(InvalidateLastAccessToken())
        
        r = try client.send(request)
        #expect(r.result == request.name)

        let lastAccessToken = self.client.getTokenCookie()
        #expect(lastAccessToken != nil)
//        #expect(lastAccessToken != initialAccessToken)
    }
}

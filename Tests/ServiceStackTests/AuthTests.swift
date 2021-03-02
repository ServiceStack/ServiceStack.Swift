//
//  File.swift
//
//
//  Created by Demis Bellot on 3/2/21.
//

@testable import ServiceStack
import XCTest
import Foundation
import PromiseKit

class AuthTests: XCTestCase {
    var client: JsonServiceClient!

    override func setUp() {
        super.setUp()
        client = JsonServiceClient(baseUrl: "http://test.servicestack.net")
    }
    
    func createAuthRequest() -> Authenticate {
        let request = Authenticate()
        request.provider = "credentials"
        request.userName = "test"
        request.password = "test"
        return request
    }

    func test_Does_fetch_AccessToken_using_RefreshTokenCookies() {
        let asyncTest = expectation(description: "asyncTest")
        
        let request = Secured()
        request.name = "test"

        _ = client.postAsync(createAuthRequest())
            .done { r in
                let initialAccessToken = self.client.getTokenCookie()
                let initialRefreshToken = self.client.getRefreshTokenCookie()
                XCTAssertNotNil(initialAccessToken)
                XCTAssertNotNil(initialRefreshToken)
                
                _ = self.client.sendAsync(request)
                    .done { r in
                        XCTAssertEqual(r.result, request.name)
                        _ = self.client.postAsync(InvalidateLastAccessToken())
                            .done { r in
                                _ = self.client.sendAsync(request)
                                    .done { r in
                                        XCTAssertEqual(r.result, request.name)
                                        
                                        let lastAccessToken = self.client.getTokenCookie()
                                        XCTAssertNotEqual(lastAccessToken, initialAccessToken)

                                        asyncTest.fulfill()
                                    }
                            }
                    }
            }

        waitForExpectations(timeout: 10, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func test_Does_fetch_AccessToken_using_RefreshTokenCookies_sync() throws {
        let request = Secured()
        request.name = "test"

        try client.post(createAuthRequest())
        let initialAccessToken = client.getTokenCookie()
        let initialRefreshToken = client.getRefreshTokenCookie()
        XCTAssertNotNil(initialAccessToken)
        XCTAssertNotNil(initialRefreshToken)
        
        var r = try client.send(request)
        XCTAssertEqual(r.result, request.name)
        
        _ = try client.post(InvalidateLastAccessToken())
        
        r = try client.send(request)
        XCTAssertEqual(r.result, request.name)

        let lastAccessToken = self.client.getTokenCookie()
        XCTAssertNotEqual(lastAccessToken, initialAccessToken)
    }
}


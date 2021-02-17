//
//  SSLTests.swift
//  ServiceStack
//
//  Created by Demis Bellot on 10/8/20.
//  Copyright © 2020 ServiceStack. All rights reserved.
//

@testable import ServiceStack
import XCTest

class SSLTests: XCTestCase {
    var client: JsonServiceClient!

    func rename_test_selfSignedHost() throws {
        let client = JsonServiceClient(baseUrl: "https://dev.servicestack.com:5001")
        client.ignoreCert = true

        let asyncTest = expectation(description: "asyncTest")

        let request = Hello()
        request.name = "Test"

        client.postAsync(request)
            .done { r in
                XCTAssertEqual(r.result!, "Hello, Test!")
                asyncTest.fulfill()
            }.catch { _ in }

        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func test_ignoreCert() throws {
        let client = JsonServiceClient(baseUrl: "https://dev.servicestack.com:5001")
        client.ignoreCert = true
        let hostMap = JsonServiceClient.toHostsMap(client.ignoreCertificatesFor)
        XCTAssertEqual(hostMap.count, 1)
        XCTAssertNotNil(hostMap["dev.servicestack.com"])
        XCTAssertEqual(hostMap["dev.servicestack.com"], 5001)
    }

    func test_ignoreCertificatesFor() throws {
        let client = JsonServiceClient(baseUrl: "https://baseUrl.com")
        client.ignoreCert = true
        client.ignoreCertificatesFor.append(contentsOf: ["https://dev.servicestack.com:5001", "https://local.servicestack.com"])
        let hostMap = JsonServiceClient.toHostsMap(client.ignoreCertificatesFor)
        XCTAssertEqual(hostMap.count, 3)
        XCTAssertNotNil(hostMap["baseUrl.com"])
        XCTAssertEqual(hostMap["baseUrl.com"], -1)
        XCTAssertNotNil(hostMap["dev.servicestack.com"])
        XCTAssertEqual(hostMap["dev.servicestack.com"], 5001)
        XCTAssertNotNil(hostMap["local.servicestack.com"])
        XCTAssertEqual(hostMap["local.servicestack.com"], -1)
        XCTAssertNil(hostMap["notexists.servicestack.com"])
    }
}

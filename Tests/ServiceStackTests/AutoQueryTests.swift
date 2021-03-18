//
//  AutoQueryTests.swift
//  ServiceStack
//
//  Created by Demis Bellot on 11/8/16.
//
//

@testable import ServiceStack
import XCTest

class AutoQueryTests: XCTestCase {
    var client: JsonServiceClient!

    override func setUp() {
        super.setUp()
        client = JsonServiceClient(baseUrl: "https://techstacks.io")
    }

    func test_Can_call_empty_FindTechnologies() {
        let request = FindTechnologies()

        do {
            let response = try client.get(request)

            XCTAssertEqual(response.total, 0)
        } catch let e {
            XCTFail("\(e)")
        }
    }

    func test_Can_call_query_FindTechnologies_VendorName() {
        let request = FindTechnologies()
        request.vendorName = "Google"
        request.take = 3
        request.orderByDesc = "ViewCount"
        request.fields = "Id,Name,VendorName,Tier,ProductUrl"

        do {
            let response = try client.get(request)

            XCTAssertEqual(response.total, 15)
            XCTAssertEqual(response.results.count, 3)
            let names = response.results.map { $0.name! }.joined(separator: ",")
            XCTAssertEqual(names,"AngularJS,Go,Protocol Buffers")
            let ids = response.results.map { "\($0.id!)" }.joined(separator: ",")
            XCTAssertEqual(ids,"7,18,77")
            let tiers = response.results.map { "\($0.tier!)" }.joined(separator: ",")
            XCTAssertEqual(tiers,"Client,ProgrammingLanguage,Server")
        } catch let e {
            XCTFail("\(e)")
        }
    }


    func test_Can_call_FindTechnologies_ServiceStack() {
        let request = FindTechnologies()
        request.name = "ServiceStack"

        do {
            let url = client.createUrl(dto: request)
            print("Request URL: \(url)")
            let response = try client.get(request)

            XCTAssertEqual(response.total, 1)
            let dto = response.results[0]
            XCTAssertEqual(dto.id, 1)
            XCTAssertEqual(dto.name, "ServiceStack")
            XCTAssertEqual(dto.slug, "servicestack")
            XCTAssertEqual(dto.logoApproved, true)
            XCTAssertEqual(dto.isLocked, false)
            XCTAssertEqual(dto.tier, TechnologyTier.Server)
        } catch let e {
            XCTFail("\(e)")
        }
    }
    
    
}

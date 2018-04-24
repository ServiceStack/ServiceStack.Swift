//
//  AutoQueryTests.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 11/8/16.
//
//

import XCTest
@testable import ServiceStackClient

class AutoQueryTests: XCTestCase {

    var client:JsonServiceClient!
    
    override func setUp() {
        super.setUp()
        client = JsonServiceClient(baseUrl: "http://techstacks.io")
    }
    
    func test_Can_call_empty_FindTechnologies() {
        let request = FindTechnologies<Technology>()
        
        do {
            let response = try client.get(request)
            
            XCTAssertEqual(response.total, 0)
        } catch let e {
            XCTFail("\(e)")
        }
    }
    
    func test_Can_call_FindTechnologies_ServiceStack() {
        let request = FindTechnologies<Technology>()
        request.name = "ServiceStack"
        
        do {
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


//
//  JsonHttpClientTests.swift
//  JsonHttpClientTests
//
//  Created by Demis Bellot on 1/22/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import JsonServiceClient
import XCTest

class JsonHttpClientTests: XCTestCase {
    var client:JsonServiceClient!
    
    override func setUp() {
        super.setUp()
        client = JsonServiceClient(baseUrl: "http://techstacks.io")
    }
    
    func assertOverviewResponse(r:OverviewResponse) {
        XCTAssertNotNil(r)
        XCTAssertGreaterThan(r.topUsers.count, 0)
        XCTAssertGreaterThan(r.topTechnologies.count, 0)
        XCTAssertGreaterThan(r.latestTechStacks.count, 0)
        XCTAssertGreaterThan(r.latestTechStacks[0].technologyChoices.count, 0)
        XCTAssertGreaterThan(r.topTechnologiesByTier.count, 0)
    }
    
    func test_Can_GET_TechStacks_Overview() {
        let asyncTest = expectationWithDescription("asyncTest")
        
        client.getAsync(Overview())
            .then(body: {(r:OverviewResponse) -> Void in
                self.assertOverviewResponse(r)
                asyncTest.fulfill()
            })

        waitForExpectationsWithTimeout(5, { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_GET_TechStacks_Overview_Sync() {
        let response = client.get(Overview())
        self.assertOverviewResponse(response!)
    }
    
    func test_Can_GET_TechStacks_Overview_with_url_Sync() {
        let response:OverviewResponse? = client.get("/overview")
        self.assertOverviewResponse(response!)
    }
    
    func assertGetTechnologyResponse(r:GetTechnologyResponse) {
        XCTAssertNotNil(r)
        XCTAssertEqual(r.technology!.name!, "ServiceStack")
        XCTAssertGreaterThan(r.technologyStacks.count, 0)
    }
    
    func test_Can_GET_GetTechnology_with_params() {
        
        let asyncTest = expectationWithDescription("asyncTest")
        
        var requestDto = GetTechnology()
        requestDto.slug = "servicestack"
        
        client.getAsync(requestDto)
            .then(body: {(r:GetTechnologyResponse) -> Void in
                self.assertGetTechnologyResponse(r)
                asyncTest.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_GET_GetTechnology_with_params_Sync() {
        var requestDto = GetTechnology()
        requestDto.slug = "servicestack"
        let response = client.get(requestDto)
        self.assertGetTechnologyResponse(response!)
    }
    
    func test_Can_GET_GetTechnology_with_url_Sync() {
        let response:GetTechnologyResponse? = client.get("/technology/servicestack")
        self.assertGetTechnologyResponse(response!)
    }
    
}

#if true
//
//  ServiceClientTechStacksTests.swift
//  ServiceStackClient
//
//  Created by Demis Bellot on 9/21/15.
//  Copyright © 2015 ServiceStack LLC. All rights reserved.
//

import XCTest


class ServiceClientTechStacksTests: XCTestCase {
    var client:JsonServiceClient!
    
    override func setUp() {
        super.setUp()
        client = JsonServiceClient(baseUrl: "http://techstacks.io")
    }
    
    func test_Can_GET_TechStacks_Overview() {
        do {
            let response = try client.get(Overview())
            self.assertOverviewResponse(response)
        } catch {
            XCTFail()
        }
    }
    
    func test_Can_GET_TechStacks_Overview_Aync() {
        let asyncTest = expectation(description:"asyncTest")
        
        client.getAsync(Overview())
            .map { (r: OverviewResponse) in
                self.assertOverviewResponse(r)
                asyncTest.fulfill()
            }.catch { _ in }
        
        waitForExpectations(timeout: 5, handler: { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_GET_TechStacks_Overview_with_relative_url() {
        do {
            let response:OverviewResponse = try client.get("/overview")
            self.assertOverviewResponse(response)
        } catch {
            XCTFail()
        }
    }
    
    func test_Can_GET_TechStacks_Overview_with_absolute_url() {
        do {
            let response:OverviewResponse = try client.get("http://techstacks.io/overview")
            self.assertOverviewResponse(response)
        } catch {
            XCTFail()
        }
    }
    
    func test_Can_GET_GetTechnology_with_params() {
        do {
            let requestDto = GetTechnology()
            requestDto.slug = "servicestack"
            let response = try client.get(requestDto)
            self.assertGetTechnologyResponse(response)
        } catch {
            XCTFail()
        }
    }
    
    func test_Can_GET_GetTechnology_with_params_Async() {
        
        let asyncTest = expectation(description:"asyncTest")
        
        let requestDto = GetTechnology()
        requestDto.slug = "servicestack"
        
        client.getAsync(requestDto)
            .map { (r: GetTechnologyResponse) in
                self.assertGetTechnologyResponse(r)
                asyncTest.fulfill()
            }.catch { _ in }
        
        waitForExpectations(timeout: 5, handler: { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_GET_GetTechnology_with_url() {
        do {
            let response:GetTechnologyResponse = try client.get("/technology/servicestack")
            self.assertGetTechnologyResponse(response)
        } catch {
            XCTFail()
        }
    }
    
    #if false //AutoQuery
    func test_Can_call_FindTechnologies_AutoQuery_Service() {
        let request = FindTechnologies<Technology>()
        request.name = "ServiceStack"
        
        let response = client.get(request)!
        
        XCTAssertEqual(response.results.count, 1)
    }
    
    func test_Can_call_FindTechnologies_AutoQuery_Service_Async() {
    let asyncTest = expectation(description:"asyncTest")
    
        let request = FindTechnologies<Technology>()
        request.name = "ServiceStack"
        
        let response = client.getAsync(request)
            .then(body:{(r:QueryResponse<Technology>) -> Void in
                XCTAssertEqual(r.results.count, 1)
                asyncTest.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, handler: { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_call_FindTechnologies_AutoQuery_Implicit_Service() {
        let request = FindTechnologies<Technology>()
        request.take = 5
        
        let response = client.get(request, query:["DescriptionContains":"framework"])!
        
        XCTAssertEqual(response.results.count, 5)
    }
    #endif

    /*
    * TEST HELPERS
    */
    
    func assertGetTechnologyResponse(_ r:GetTechnologyResponse) {
        XCTAssertNotNil(r)
        XCTAssertEqual(r.technology!.name!, "ServiceStack")
        XCTAssertGreaterThan(r.technologyStacks.count, 0)
    }
    
    func assertOverviewResponse(_ r:OverviewResponse) {
        XCTAssertNotNil(r)
        XCTAssertGreaterThan(r.topUsers.count, 0)
        XCTAssertGreaterThan(r.topTechnologies.count, 0)
        XCTAssertGreaterThan(r.latestTechStacks.count, 0)
        XCTAssertGreaterThan(r.latestTechStacks[0].technologyChoices.count, 0)
        XCTAssertGreaterThan(r.topTechnologiesByTier.count, 0)
    }
}

#endif

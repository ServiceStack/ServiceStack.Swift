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

    func test_Can_GET_TechStacks_Overview() {
        
        let asyncTest = expectationWithDescription("asyncTest")
        
        let client = JsonServiceClient(baseUrl: "http://techstacks.io")
        
        client.getAsync(Overview())
            .then(body: {(r:OverviewResponse) -> Void in
                XCTAssertNotNil(r)
//                println("RESPONSE: \(r.toJson())")
                asyncTest.fulfill()
            })

        waitForExpectationsWithTimeout(5, { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_GET_GetTechnology_with_params() {
        
        let asyncTest = expectationWithDescription("asyncTest")
        
        let client = JsonServiceClient(baseUrl:"http://techstacks.io")
        
        var requestDto = GetTechnology()
        requestDto.slug = "servicestack"
        
        client.getAsync(requestDto)
            .then(body: {(r:GetTechnologyResponse) -> Void in
                XCTAssertNotNil(r)
//                println("RESPONSE: \(r.toJson())")
                asyncTest.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
}

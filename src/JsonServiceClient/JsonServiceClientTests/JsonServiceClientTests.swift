//
//  JsonHttpClientTests.swift
//  JsonHttpClientTests
//
//  Created by Demis Bellot on 1/22/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import JsonServiceClient
import XCTest

class JsonServiceClientTests: XCTestCase {
    var client:JsonServiceClient!
    var testClient:JsonServiceClient!
    
    override func setUp() {
        super.setUp()
        client = JsonServiceClient(baseUrl: "http://techstacks.io")
        testClient = JsonServiceClient(baseUrl: "http://test.servicestack.net")
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
    
    func createAllTypes() -> AllTypes {
        var to = AllTypes()
        to.id = 1
        to.byte = Int8(2)
        to.short = Int16(3)
        to.int = 4
        to.long = Int64(5)
        to.uShort = UInt16(6)
        to.uInt = UInt32(7)
        to.uLong = UInt64(8)
        to.float = 1.1 as Float
        to.double = 2.2
        to.decimal = 3.0
        to.string = "string"
        to.dateTime = "2001-01-01"
        to.timeSpan = "00:00:01"
        to.stringList = ["A","B","C"]
        to.stringArray = ["D","E","F"]
        to.stringMap = ["A":"D","B":"E","C":"F"]
        to.intStringMap = [1:"A",2:"B",3:"C"]
        
        var subType = SubType()
        subType.id = 1
        subType.name = "name"
        to.subType = subType
        
        return to
    }
    
    func createPoco(name:String?="name") -> Poco {
        var to = Poco()
        to.name = name
        return to
    }
    
    func createAllCollectionTypes() -> AllCollectionTypes {
        var to = AllCollectionTypes()
        to.intArray = [1,2,3]
        to.intList = [4,5,6]
        to.stringArray = ["A","B","C"]
        to.stringList = ["D","E","F"]
        to.pocoArray.append(createPoco(name: "pocoArray"))
        to.pocoList.append(createPoco(name: "pocoList"))
        to.pocoLookup["A"] = [createPoco(name: "B"),createPoco(name: "C")]
        to.pocoLookup["D"] = [createPoco(name: "E"),createPoco(name: "F")]
        to.pocoLookupMap["A"] = ["B":createPoco(name: "C"),"D":createPoco(name: "E")]
        
        return to
    }
    
    func assertDictionary<K : Hashable, V : Equatable>(actual:[K:V],expected:[K:V]) {
        XCTAssertEqual(actual.count, expected.count)
        for (k,v) in actual {
            XCTAssertEqual(v, expected[k]!)
        }
    }
    
    func assertLookup<K : Hashable, V : Equatable>(actual:[K:[V]],expected:[K:[V]]) {
        XCTAssertEqual(actual.count, expected.count)
        for (k,values) in actual {
            XCTAssertEqual(values.count, expected[k]!.count)
            for i in 0..<values.count {
                XCTAssertEqual(values[i], expected[k]![i])
            }
        }
    }
    
    func assertLookupMap<K : Hashable, V : Equatable>(actual:[K:[K:V]],expected:[K:[K:V]]) {
        XCTAssertEqual(actual.count, expected.count)
        for (k,values) in actual {
            XCTAssertEqual(values.count, expected[k]!.count)
            for (subK,subV) in values {
                XCTAssertEqual(values[subK]!, expected[k]![subK]!)
            }
        }
    }
    
    func assertAllTypes(actual:AllTypes, expected:AllTypes) {
        XCTAssertEqual(actual.id!, expected.id!)
        XCTAssertEqual(actual.byte!, expected.byte!)
        XCTAssertEqual(actual.short!, expected.short!)
        XCTAssertEqual(actual.int!, expected.int!)
        XCTAssertEqual(actual.long!, expected.long!)
        XCTAssertEqual(actual.uShort!, expected.uShort!)
        XCTAssertEqual(actual.uLong!, expected.uLong!)
        XCTAssertEqual(actual.float!, expected.float!)
        XCTAssertEqual(actual.double!, expected.double!)
        XCTAssertEqual(actual.decimal!, expected.decimal!)
        XCTAssertEqual(actual.string!, expected.string!)
//        XCTAssertEqual(actual.dateTime!, expected.dateTime!)  //TODO
//        XCTAssertEqual(actual.timeSpan!, expected.timeSpan!)  //TODO
        XCTAssertEqual(actual.stringList, expected.stringList)
        XCTAssertEqual(actual.stringArray, expected.stringArray)

        assertDictionary(actual.stringMap, expected: expected.stringMap)
        assertDictionary(actual.intStringMap, expected: expected.intStringMap)

        XCTAssertEqual(actual.subType!.id!, expected.subType!.id!)
        XCTAssertEqual(actual.subType!.name!, expected.subType!.name!)
    }
    
    func assertAllCollectionTypes(actual:AllCollectionTypes, expected:AllCollectionTypes) {
        XCTAssertEqual(actual.intArray, expected.intArray)
        XCTAssertEqual(actual.intList, expected.intList)
        XCTAssertEqual(actual.stringArray, expected.stringArray)
        XCTAssertEqual(actual.stringList, expected.stringList)
        XCTAssertEqual(actual.pocoArray, expected.pocoArray)
        XCTAssertEqual(actual.pocoList, expected.pocoList)
        assertLookup(actual.pocoLookup, expected: expected.pocoLookup)
        assertLookupMap(actual.pocoLookupMap, expected: expected.pocoLookupMap)
    }
    
    func createHelloAllTypes() -> HelloAllTypes {
        var dto = HelloAllTypes()
        dto.name = "name"
        dto.allTypes = createAllTypes()
        dto.allCollectionTypes = createAllCollectionTypes()
        return dto
    }
    
    func assertHelloAllTypesResponse(actual:HelloAllTypesResponse, expected:HelloAllTypes) {
        XCTAssertNotNil(actual)
        self.assertAllTypes(actual.allTypes!, expected: expected.allTypes!)
        self.assertAllCollectionTypes(actual.allCollectionTypes!, expected: expected.allCollectionTypes!)
    }
    
    func test_Can_POST_Test_HelloAllTypes() {
        let asyncTest = expectationWithDescription("asyncTest")
        
        let request = createHelloAllTypes()
        
        testClient.postAsync(request)
            .then(body: {(r:HelloAllTypesResponse) -> Void in
                self.assertHelloAllTypesResponse(r, expected: request)
                asyncTest.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_POST_Test_HelloAllTypes_sync() {
        let request = createHelloAllTypes()
        
        var response = testClient.post(request)!
        
        self.assertHelloAllTypesResponse(response, expected: request)
    }
    
    func test_Can_PUT_Test_HelloAllTypes() {
        let asyncTest = expectationWithDescription("asyncTest")
        
        let request = createHelloAllTypes()
        
        testClient.putAsync(request)
            .then(body: {(r:HelloAllTypesResponse) -> Void in
                self.assertHelloAllTypesResponse(r, expected: request)
                asyncTest.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_PUT_Test_HelloAllTypes_sync() {
        let request = createHelloAllTypes()
        
        var response = testClient.put(request)!
        
        self.assertHelloAllTypesResponse(response, expected: request)
    }
    
}

extension Poco : Equatable {}

public func == (lhs: Poco, rhs: Poco) -> Bool {
    return lhs.name == rhs.name
}

#if true
//
//  JsonServiceClientTests.swift
//  ServiceStackClientTests
//
//  Created by Demis Bellot on 1/22/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

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
        let response = client.get(Overview())
        self.assertOverviewResponse(response!)
    }
    
    func test_Can_GET_TechStacks_Overview_Aync() {
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
    
    func test_Can_GET_TechStacks_Overview_with_relative_url() {
        let response:OverviewResponse? = client.get("/overview")
        self.assertOverviewResponse(response!)
    }
    
    func test_Can_GET_TechStacks_Overview_with_absolute_url() {
        let response:OverviewResponse? = client.get("http://techstacks.io/overview")
        self.assertOverviewResponse(response!)
    }
    
    func assertGetTechnologyResponse(r:GetTechnologyResponse) {
        XCTAssertNotNil(r)
        XCTAssertEqual(r.technology!.name!, "ServiceStack")
        XCTAssertGreaterThan(r.technologyStacks.count, 0)
    }
    
    func test_Can_GET_GetTechnology_with_params() {
        var requestDto = GetTechnology()
        requestDto.slug = "servicestack"
        let response = client.get(requestDto)
        self.assertGetTechnologyResponse(response!)
    }
    
    func test_Can_GET_GetTechnology_with_params_Async() {
        
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
    
    func test_Can_GET_GetTechnology_with_url() {
        let response:GetTechnologyResponse? = client.get("/technology/servicestack")
        self.assertGetTechnologyResponse(response!)
    }
    
    func test_Can_call_FindTechnologies_AutoQuery_Service() {
        let request = FindTechnologies<Technology>()
        request.name = "ServiceStack"
        
        let response = client.get(request)!
        
        XCTAssertEqual(response.results.count, 1)
    }
    
    func test_Can_call_FindTechnologies_AutoQuery_Service_Async() {
        let asyncTest = expectationWithDescription("asyncTest")

        let request = FindTechnologies<Technology>()
        request.name = "ServiceStack"
        
        let response = client.getAsync(request)
        .then(body:{(r:QueryResponse<Technology>) -> Void in
                XCTAssertEqual(r.results.count, 1)
                asyncTest.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_call_FindTechnologies_AutoQuery_Implicit_Service() {
        let request = FindTechnologies<Technology>()
        request.take = 5
        
        let response = client.get(request, query:["DescriptionContains":"framework"])!
        
        XCTAssertEqual(response.results.count, 5)
    }
    
    func test_Can_POST_Test_HelloAllTypes_async() {
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
    
    func test_Can_POST_Test_HelloAllTypes() {
        let request = createHelloAllTypes()
        
        var response = testClient.post(request)!
        
        self.assertHelloAllTypesResponse(response, expected: request)
    }
    
    func test_Can_PUT_Test_HelloAllTypes() {
        let request = createHelloAllTypes()
        
        var response = testClient.put(request)!
        
        self.assertHelloAllTypesResponse(response, expected: request)
    }
    
    func test_Can_PUT_Test_HelloAllTypes_Async() {
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
    
    func test_Does_handle_404_Error() {
        var testClient = JsonServiceClient(baseUrl: "http://test.servicestack.net")
        
        var globalError:NSError?
        JsonServiceClient.Global.onError = { globalError = $0 }
        
        var localError:NSError?
        testClient.onError = { localError = $0 }
        
        var request = ThrowType()
        request.type = "NotFound"
        request.message = "not here"
        
        var responseError:NSError?
        let response = testClient.put(request, error: &responseError)
        XCTAssertNil(response)
        
        XCTAssertNotNil(responseError)
        XCTAssertNotNil(localError)
        XCTAssertNotNil(globalError)
        
        let status:ResponseStatus = responseError!.convertUserInfo()!
        XCTAssertEqual(status.errorCode!, "not here")
        XCTAssertEqual(status.message!, "not here")
        XCTAssertNotNil(status.stackTrace!)
    }
    
    func test_Does_handle_404_Error_Async() {
        let asyncTest = expectationWithDescription("asyncTest")

        let testClient = JsonServiceClient(baseUrl: "http://test.servicestack.net")
        
        var globalError:NSError?
        JsonServiceClient.Global.onError = { globalError = $0 }
        
        var localError:NSError?
        testClient.onError = { localError = $0 }
        
        var request = ThrowType()
        request.type = "NotFound"
        request.message = "not here"
        
        testClient.putAsync(request)
            .catch({ (responseError:NSError) -> Void in
                XCTAssertNotNil(responseError)
                XCTAssertNotNil(localError)
                XCTAssertNotNil(globalError)
                
                let status:ResponseStatus = responseError.convertUserInfo()!
                XCTAssertEqual(status.errorCode!, "not here")
                XCTAssertEqual(status.message!, "not here")
                XCTAssertNotNil(status.stackTrace!)
                
                asyncTest.fulfill()
            })

        waitForExpectationsWithTimeout(5, { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Does_handle_ValidationException() {
        
        let testClient = JsonServiceClient(baseUrl: "http://test.servicestack.net")
        
        var request = ThrowValidation()
        request.email = "invalidemail"
        var responseError:NSError?
        let response = testClient.post(request, error: &responseError)
        XCTAssertNil(response)
        
        XCTAssertNotNil(responseError)
        
        let status:ResponseStatus = responseError!.convertUserInfo()!
        XCTAssertEqual(status.errors.count, 3)
        
        XCTAssertEqual(status.errorCode!, status.errors[0].errorCode!)
        XCTAssertEqual(status.message!, status.errors[0].message!)
        
        XCTAssertEqual(status.errors[0].errorCode!, "InclusiveBetween")
        XCTAssertEqual(status.errors[0].message!, "'Age' must be between 1 and 120. You entered 0.")
        XCTAssertEqual(status.errors[0].fieldName!, "Age")
        
        XCTAssertEqual(status.errors[1].errorCode!, "NotEmpty")
        XCTAssertEqual(status.errors[1].message!, "'Required' should not be empty.")
        XCTAssertEqual(status.errors[1].fieldName!, "Required")
        
        XCTAssertEqual(status.errors[2].errorCode!, "Email")
        XCTAssertEqual(status.errors[2].message!, "'Email' is not a valid email address.")
        XCTAssertEqual(status.errors[2].fieldName!, "Email")
    }
    
    func test_Does_handle_ValidationException_Async() {
        let asyncTest = expectationWithDescription("asyncTest")

        let testClient = JsonServiceClient(baseUrl: "http://test.servicestack.net")
        
        var request = ThrowValidation()
        request.email = "invalidemail"

        testClient.postAsync(request)
            .catch({ (responseError:NSError) -> Void in

                XCTAssertNotNil(responseError)
                
                let status:ResponseStatus = responseError.convertUserInfo()!
                XCTAssertEqual(status.errors.count, 3)
                
                XCTAssertEqual(status.errorCode!, status.errors[0].errorCode!)
                XCTAssertEqual(status.message!, status.errors[0].message!)
                
                XCTAssertEqual(status.errors[0].errorCode!, "InclusiveBetween")
                XCTAssertEqual(status.errors[0].message!, "'Age' must be between 1 and 120. You entered 0.")
                XCTAssertEqual(status.errors[0].fieldName!, "Age")
                
                XCTAssertEqual(status.errors[1].errorCode!, "NotEmpty")
                XCTAssertEqual(status.errors[1].message!, "'Required' should not be empty.")
                XCTAssertEqual(status.errors[1].fieldName!, "Required")
                
                XCTAssertEqual(status.errors[2].errorCode!, "Email")
                XCTAssertEqual(status.errors[2].message!, "'Email' is not a valid email address.")
                XCTAssertEqual(status.errors[2].fieldName!, "Email")
                
                asyncTest.fulfill()
            })
        
        waitForExpectationsWithTimeout(5, { (error) in
            XCTAssertNil(error, "Error")
        })
    }
    
    func test_Can_POST_valid_ThrowValidation_request() {
        let testClient = JsonServiceClient(baseUrl: "http://test.servicestack.net")
        
        var request = ThrowValidation()
        request.age = 21
        request.required = "foo"
        request.email = "my@gmail.com"

        var responseError:NSError?
        let response = testClient.post(request, error: &responseError)!
        XCTAssertNil(responseError)
        
        XCTAssertEqual(response.age!, request.age!)
        XCTAssertEqual(response.required!, request.required!)
        XCTAssertEqual(response.email!, request.email!)
    }

    
    /* 
     * TEST HELPERS 
     */
    
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
    
    func createAllTypes() -> AllTypes {
        var to = AllTypes()
        to.id = 1
        to.char = Character("c")
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
        to.dateTime = NSDate(year: 2001, month: 1, day: 1)
        to.timeSpan = 1
        to.guid = "25892e1780f6415f9c657395632f0223"
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
        XCTAssertEqual(actual.dateTime!, expected.dateTime!)
        XCTAssertEqual(actual.timeSpan!, expected.timeSpan!)
        XCTAssertEqual(actual.guid!, expected.guid!)
        XCTAssertEqual(actual.char!, expected.char!)
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
}
    
extension Poco : Equatable {}

public func == (lhs: Poco, rhs: Poco) -> Bool {
    return lhs.name == rhs.name
}

#endif

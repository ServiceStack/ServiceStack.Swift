//
//  JsonServiceClientTests.swift
//  ServiceStackClientTests
//
//  Created by Demis Bellot on 1/22/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

@testable import ServiceStackClient
import XCTest

class JsonServiceClientTests: XCTestCase {
    var client: JsonServiceClient!

    override func setUp() {
        super.setUp()
        client = JsonServiceClient(baseUrl: "http://test.servicestack.net")
    }

    func test_Can_POST_Test_HelloAllTypes_async() {
        let asyncTest = expectation(description: "asyncTest")

        let request = createHelloAllTypes()

        client.postAsync(request)
            .map { (r: HelloAllTypesResponse) in
                self.assertHelloAllTypesResponse(r, expected: request)
                asyncTest.fulfill()
            }.catch { _ in }

        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func test_Can_POST_Test_HelloAllTypes() {
        let request = createHelloAllTypes()

        do {
            let response = try client.post(request)

            assertHelloAllTypesResponse(response, expected: request)
        } catch let e as NSError {
            XCTFail("\(e)")
        }
    }

    func test_Can_GET_Test_AllTypes() {
        let request = createAllTypes()
        request.subType = nil
        request.dateTime = nil

        do {
            let response: AllTypes = try client.get(client.createUrl(dto: request))

            assertAllTypes(response, expected: request)
        } catch let e as NSError {
            XCTFail("\(e)")
        }
    }

    func test_Can_PUT_Test_HelloAllTypes() {
        let request = createHelloAllTypes()

        do {
            let response = try client.put(request)

            assertHelloAllTypesResponse(response, expected: request)
        } catch {
            XCTFail()
        }
    }

    func test_Can_PUT_Test_HelloAllTypes_Async() {
        let asyncTest = expectation(description: "asyncTest")

        let request = createHelloAllTypes()

        client.putAsync(request)
            .map { (r: HelloAllTypesResponse) in
                self.assertHelloAllTypesResponse(r, expected: request)
                asyncTest.fulfill()
            }.catch { _ in }

        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func test_Does_handle_404_Error() {
        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")

        var globalError: NSError?
        JsonServiceClient.Global.onError = { globalError = $0 }

        var localError: NSError?
        client.onError = { localError = $0 }

        let request = ThrowType()
        request.type = "NotFound"
        request.message = "not here"

        do {
            let response = try client.put(request)
            XCTAssertNil(response)
        } catch let responseError as NSError {
            XCTAssertNotNil(responseError)
            XCTAssertNotNil(localError)
            XCTAssertNotNil(globalError)

            let status: ResponseStatus = responseError.convertUserInfo()!
            XCTAssertEqual(status.errorCode!, "NotFound")
            XCTAssertEqual(status.message!, "not here")
            XCTAssertNotNil(status.stackTrace!)
        }
    }

    func test_Does_handle_404_Error_Async() {
        let asyncTest = expectation(description: "asyncTest")

        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")

        var globalError: NSError?
        JsonServiceClient.Global.onError = { globalError = $0 }

        var localError: NSError?
        client.onError = { localError = $0 }

        let request = ThrowType()
        request.type = "NotFound"
        request.message = "not here"

        client.putAsync(request)
            .catch { responseError in
                XCTAssertNotNil(responseError)
                XCTAssertNotNil(localError)
                XCTAssertNotNil(globalError)

                let status: ResponseStatus = responseError.convertUserInfo()!
                XCTAssertEqual(status.errorCode!, "NotFound")
                XCTAssertEqual(status.message!, "not here")
                XCTAssertNotNil(status.stackTrace!)

                asyncTest.fulfill()
            }

        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func test_Does_handle_ValidationException() {
        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")

        let request = ThrowValidation()
        request.email = "invalidemail"

        do {
            let response = try client.post(request)
            XCTAssertNil(response)
            XCTFail("Should throw")
        } catch let responseError as NSError {
            XCTAssertNotNil(responseError)

            let status: ResponseStatus = responseError.convertUserInfo()!
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
    }

    func test_Does_handle_ValidationException_Async() {
        let asyncTest = expectation(description: "asyncTest")

        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")

        let request = ThrowValidation()
        request.email = "invalidemail"

        client.postAsync(request)
            .catch { responseError in

                XCTAssertNotNil(responseError)

                let status: ResponseStatus = responseError.convertUserInfo()!
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
            }

        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func test_Can_POST_valid_ThrowValidation_request() {
        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")

        let request = ThrowValidation()
        request.age = 21
        request.required = "foo"
        request.email = "my@gmail.com"

        do {
            let response = try client.post(request)
            XCTAssertEqual(response.age!, request.age!)
            XCTAssertEqual(response.required!, request.required!)
            XCTAssertEqual(response.email!, request.email!)
        } catch {
            XCTFail()
        }
    }

    func test_Can_send_ReturnVoid() {
        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")

        var methods = [String]()

        client.requestFilter = { (req: NSMutableURLRequest) in methods.append(req.httpMethod) }

        do {
            try client.get(HelloReturnVoid())
            XCTAssertEqual(methods.last, HttpMethods.Get)
            try client.post(HelloReturnVoid())
            XCTAssertEqual(methods.last, HttpMethods.Post)
            try client.put(HelloReturnVoid())
            XCTAssertEqual(methods.last, HttpMethods.Put)
            try client.delete(HelloReturnVoid())
            XCTAssertEqual(methods.last, HttpMethods.Delete)
        } catch {
            XCTFail()
        }
    }

    func test_Can_send_ReturnVoid_Async() {
        let asyncTest = expectation(description: "asyncTest")

        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")

        var methods = [String]()

        client.requestFilter = { (req: NSMutableURLRequest) in methods.append(req.httpMethod) }

        client.getAsync(HelloReturnVoid())
            .map {
                XCTAssertEqual(methods.last, HttpMethods.Get)

                client.postAsync(HelloReturnVoid())
                    .map {
                        XCTAssertEqual(methods.last, HttpMethods.Post)
                        asyncTest.fulfill()
                    }.catch { _ in }
            }.catch { _ in }

        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    func test_Can_handle_failed_Auth() {
        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")

        do {
            let request = Authenticate()
            request.provider = "credentials"
            request.userName = "test"
            request.password = "invalid"
            try client.post(request)
        } catch let responseError as NSError {
            XCTAssertNotNil(responseError)

            // Swift Bug: 401 returns null response
            if let status: ResponseStatus = responseError.convertUserInfo() {
                XCTAssertEqual(status.errorCode, "Unauthorized")
                // XCTAssertNil(status.errorCode)
            }
        }
    }

    func test_Can_handle_failed_Auth_Async() {
        let asyncTest = expectation(description: "asyncTest")

        let client = JsonServiceClient(baseUrl: "http://test.servicestack.net")

        let request = Authenticate()
        request.provider = "credentials"
        request.userName = "test"
        request.password = "invalid"
        client.postAsync(request)
            .catch { responseError in

                XCTAssertNotNil(responseError)

                let status: ResponseStatus = responseError.convertUserInfo()!

                XCTAssertEqual(status.errorCode, "Unauthorized")
                asyncTest.fulfill()
            }

        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    /*
     * TEST HELPERS
     */

    func createHelloAllTypes() -> HelloAllTypes {
        let dto = HelloAllTypes()
        dto.name = "name"
        dto.allTypes = createAllTypes()
        dto.allCollectionTypes = createAllCollectionTypes()
        return dto
    }

    func assertHelloAllTypesResponse(_ actual: HelloAllTypesResponse, expected: HelloAllTypes) {
        XCTAssertNotNil(actual)
        assertAllTypes(actual.allTypes!, expected: expected.allTypes!)
        assertAllCollectionTypes(actual.allCollectionTypes!, expected: expected.allCollectionTypes!)
    }

    func createAllTypes() -> AllTypes {
        let to = AllTypes()
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
        to.dateTime = Date(year: 2001, month: 1, day: 1)
        to.timeSpan = 1
        to.guid = "25892e1780f6415f9c657395632f0223"
        to.stringList = ["A", "B", "C"]
        to.stringArray = ["D", "E", "F"]
        to.stringMap = ["A": "D", "B": "E", "C": "F"]
        to.intStringMap = [1: "A", 2: "B", 3: "C"]

        let subType = SubType()
        subType.id = 1
        subType.name = "name"
        to.subType = subType

        return to
    }

    func createPoco(_ name: String? = "name") -> Poco {
        let to = Poco()
        to.name = name
        return to
    }

    func createAllCollectionTypes() -> AllCollectionTypes {
        let to = AllCollectionTypes()
        to.intArray = [1, 2, 3]
        to.intList = [4, 5, 6]
        to.stringArray = ["A", "B", "C"]
        to.stringList = ["D", "E", "F"]
        to.pocoArray.append(createPoco("pocoArray"))
        to.pocoList.append(createPoco("pocoList"))
        to.pocoLookup["A"] = [createPoco("B"), createPoco("C")]
        to.pocoLookup["D"] = [createPoco("E"), createPoco("F")]
        to.pocoLookupMap["A"] = ["B": createPoco("C"), "D": createPoco("E")]

        return to
    }

    func assertDictionary<K, V: Equatable>(_ actual: [K: V], expected: [K: V]) {
        XCTAssertEqual(actual.count, expected.count)
        for (k, v) in actual {
            XCTAssertEqual(v, expected[k]!)
        }
    }

    func assertLookup<K, V: Equatable>(_ actual: [K: [V]], expected: [K: [V]]) {
        XCTAssertEqual(actual.count, expected.count)
        for (k, values) in actual {
            XCTAssertEqual(values.count, expected[k]!.count)
            for i in 0 ..< values.count {
                XCTAssertEqual(values[i], expected[k]![i])
            }
        }
    }

    func assertLookupMap<K, V: Equatable>(_ actual: [K: [K: V]], expected: [K: [K: V]]) {
        XCTAssertEqual(actual.count, expected.count)
        for (k, values) in actual {
            XCTAssertEqual(values.count, expected[k]!.count)
            for (subK, _) in values {
                XCTAssertEqual(values[subK]!, expected[k]![subK]!)
            }
        }
    }

    func assertAllTypes(_ actual: AllTypes, expected: AllTypes) {
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
        XCTAssertEqual(actual.timeSpan!, expected.timeSpan!)
        XCTAssertEqual(actual.guid!, expected.guid!)
        XCTAssertEqual(actual.char!, expected.char!)
        XCTAssertEqual(actual.stringList, expected.stringList)
        XCTAssertEqual(actual.stringArray, expected.stringArray)

        assertDictionary(actual.stringMap, expected: expected.stringMap)
        assertDictionary(actual.intStringMap, expected: expected.intStringMap)

        if expected.dateTime != nil {
            XCTAssertEqual(actual.dateTime!, expected.dateTime!)
        }

        if expected.subType != nil {
            XCTAssertEqual(actual.subType!.id!, expected.subType!.id!)
            XCTAssertEqual(actual.subType!.name!, expected.subType!.name!)
        }
    }

    func assertAllCollectionTypes(_ actual: AllCollectionTypes, expected: AllCollectionTypes) {
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

extension Poco: Equatable {}

public func == (lhs: Poco, rhs: Poco) -> Bool {
    return lhs.name == rhs.name
}

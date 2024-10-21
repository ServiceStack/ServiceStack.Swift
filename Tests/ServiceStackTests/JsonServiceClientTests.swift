//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import ServiceStack

final class JsonServiceClientTests : @unchecked Sendable {
    var client: JsonServiceClient!
    
    init() async throws {
        print("JsonServiceClientTests.init()")
        client = JsonServiceClient(baseUrl: "https://test.servicestack.net")
    }

    @Test func Can_GET_Hello() throws {
        let request = Hello()
        request.name = "World"

        let response = try client.post(request)
        print(response.result!)
    }

    @Test func Can_GET_Hello_async() async throws {
        let request = Hello()
        request.name = "World"

        let response = try await client.postAsync(request)
        print(response.result!)
    }

    @Test func Can_POST_Test_HelloAllTypes_async() async throws {
        let request = createHelloAllTypes()

        let response = try await client.postAsync(request)
        self.assertHelloAllTypesResponse(response, expected: request)
    }

    @Test func test_Can_POST_Test_HelloAllTypes() {
        let request = createHelloAllTypes()

        do {
            let response = try client.post(request)

            assertHelloAllTypesResponse(response, expected: request)
        } catch {
            Issue.record("Error: \(error)")
        }
    }
    
    @Test func test_Can_encode_and_decode_AllTypes() {
        let request = createAllTypes()
        request.subType = nil
        request.dateTime = nil
        
        let json = toJsonData(request)!
        
        print(String(data: json, encoding: .utf8)!)
        
        let fromJson = fromJsonData(AllTypes.self, json)!
        
        assertAllTypes(fromJson, expected: request)
    }

    @Test func test_Can_GET_Test_AllTypes() {
        let request = createAllTypes()
        request.subType = nil
        request.dateTime = nil

        do {
            let url = client.createUrl(dto: request)
            print("url: \(url)")
            let response: AllTypes = try client.get(url:url)

            assertAllTypes(response, expected: request)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func test_Can_PUT_Test_HelloAllTypes() {
        let request = createHelloAllTypes()

        do {
            let response = try client.put(request)

            assertHelloAllTypesResponse(response, expected: request)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func test_Can_PUT_Test_HelloAllTypes_Async() async throws {
        let request = createHelloAllTypes()

        let r = try await client.putAsync(request)
        self.assertHelloAllTypesResponse(r, expected: request)
    }

    func test_Does_handle_404_Error() {
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")

        var globalError: NSError? = nil

        var localError: NSError?
        client.onError = { localError = $0 }

        let request = ThrowType()
        request.type = "NotFound"
        request.message = "not here"

        do {
            JsonServiceClient.Global.onError = { globalError = $0 }
            defer { JsonServiceClient.Global.reset() }

            let response = try client.put(request)
            #expect(response == nil)
        } catch let responseError as NSError {
            #expect(responseError != nil)
            #expect(localError != nil)
            #expect(globalError != nil)

            let status: ResponseStatus = responseError.responseStatus
            #expect(status.errorCode! == "NotFound")
            #expect(status.message! == "not here")
            // XCTAssertNotNil(status.stackTrace!)
        }
    }

    @Test func test_Does_handle_404_Error_Async() async throws {
        test_Does_handle_404_Error() // Race condition with parallel tests and Global.onError
        
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")

        var globalError: NSError?

        var localError: NSError?
        client.onError = { localError = $0 }

        let request = ThrowType()
        request.type = "NotFound"
        request.message = "not here"

        do {
            JsonServiceClient.Global.onError = { globalError = $0 }
            defer { JsonServiceClient.Global.reset() }
            
            let response = try await client.putAsync(request)
            #expect(response == nil)
        } catch let responseError as NSError {
            #expect(responseError != nil)
            #expect(localError != nil)
            #expect(globalError != nil)

            let status: ResponseStatus = responseError.responseStatus
            #expect(status.errorCode! == "NotFound")
            #expect(status.message! == "not here")
            // XCTAssertNotNil(status.stackTrace!)
        }
    }

    @Test func test_Does_handle_ValidationException() {
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")

        let request = ThrowValidation()
        request.email = "invalidemail"

        do {
            let response = try client.post(request)
            #expect(response == nil)
            Issue.record("Should throw")
        } catch let responseError as NSError {
            #expect(responseError != nil)

            let status: ResponseStatus = responseError.responseStatus
            #expect(status.errors.count == 3)

            #expect(status.errorCode! == status.errors[0].errorCode!)
            #expect(status.message! == status.errors[0].message!)

            #expect(status.errors[0].errorCode! == "InclusiveBetween")
            #expect(status.errors[0].message! == "'Age' must be between 1 and 120. You entered 0.")
            #expect(status.errors[0].fieldName! == "Age")

            #expect(status.errors[1].errorCode! == "NotEmpty")
            #expect(status.errors[1].message! == "'Required' must not be empty.")
            #expect(status.errors[1].fieldName! == "Required")

            #expect(status.errors[2].errorCode! == "Email")
            #expect(status.errors[2].message! == "'Email' is not a valid email address.")
            #expect(status.errors[2].fieldName! == "Email")
        }
    }

    @Test func test_Does_handle_ValidationException_Async() async throws {
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")

        let request = ThrowValidation()
        request.email = "invalidemail"

        do {
            let response = try await client.postAsync(request)
            #expect(response == nil)
            Issue.record("Should throw")
        } catch let responseError as NSError {
            #expect(responseError != nil)

            let status: ResponseStatus = responseError.responseStatus
            #expect(status.errors.count == 3)

            #expect(status.errorCode! == status.errors[0].errorCode!)
            #expect(status.message! == status.errors[0].message!)

            #expect(status.errors[0].errorCode! == "InclusiveBetween")
            #expect(status.errors[0].message! == "'Age' must be between 1 and 120. You entered 0.")
            #expect(status.errors[0].fieldName! == "Age")

            #expect(status.errors[1].errorCode! == "NotEmpty")
            #expect(status.errors[1].message! == "'Required' must not be empty.")
            #expect(status.errors[1].fieldName! == "Required")

            #expect(status.errors[2].errorCode! == "Email")
            #expect(status.errors[2].message! == "'Email' is not a valid email address.")
            #expect(status.errors[2].fieldName! == "Email")
        }
    }

    @Test func test_Can_POST_valid_ThrowValidation_request() {
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")

        let request = ThrowValidation()
        request.age = 21
        request.required = "foo"
        request.email = "my@gmail.com"

        do {
            let response = try client.post(request)
            #expect(response.age! == request.age!)
            #expect(response.required! == request.required!)
            #expect(response.email! == request.email!)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func test_Can_send_ReturnVoid() {
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")

        var methods = [String]()

        client.requestFilter = { (req: NSMutableURLRequest) in methods.append(req.method) }

        do {
            try client.get(HelloReturnVoid())
            #expect(methods.last == HttpMethods.Get)
            try client.post(HelloReturnVoid())
            #expect(methods.last == HttpMethods.Post)
            try client.put(HelloReturnVoid())
            #expect(methods.last == HttpMethods.Put)
            try client.delete(HelloReturnVoid())
            #expect(methods.last == HttpMethods.Delete)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func test_Can_send_ReturnVoid_Async() async throws {
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")

        var methods = [String]()

        client.requestFilter = { (req: NSMutableURLRequest) in methods.append(req.method) }

        _ = try await client.getAsync(HelloReturnVoid())
        #expect(methods.last == HttpMethods.Get)

        _ = try await client.postAsync(HelloReturnVoid())
        #expect(methods.last == HttpMethods.Post)
    }

    @Test func test_Can_handle_failed_Auth() {
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")

        do {
            let request = Authenticate()
            request.provider = "credentials"
            request.userName = "test"
            request.password = "invalid"
            try client.post(request)
        } catch let responseError as NSError {
            #expect(responseError != nil)

            // Swift Bug: 401 returns null response
            #expect(responseError.responseStatus.errorCode == "Unauthorized")
        }
    }

    @Test func test_Can_handle_failed_Auth_Async() async throws {
        let client = JsonServiceClient(baseUrl: "https://test.servicestack.net")

        let request = Authenticate()
        request.provider = "credentials"
        request.userName = "test"
        request.password = "invalid"
        do {
            let response = try await client.postAsync(request)
            Inspect.printDump(response)
            Issue.record("Should throw")
        } catch let responseError as NSError {
            #expect(responseError != nil)

            // Swift Bug: 401 returns null response
            #expect(responseError.responseStatus.errorCode == "Unauthorized")
        }
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
        #expect(actual != nil)
        // assertAllTypes(actual.allTypes!, expected: expected.allTypes!)
        // assertAllCollectionTypes(actual.allCollectionTypes!, expected: expected.allCollectionTypes!)
    }

    func createAllTypes() -> AllTypes {
        let to = AllTypes()
        to.id = 1
        to.char = "c"
        to.byte = UInt8(65)
        to.short = Int16(3)
        to.int = 4
        to.long = Int(5)
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
        to.name = name!
        return to
    }

    func createAllCollectionTypes() -> AllCollectionTypes {
        let to = AllCollectionTypes()
        to.intArray = [1, 2, 3]
        to.intList = [4, 5, 6]
        to.stringArray = ["A", "B", "C"]
        to.stringList = ["D", "E", "F"]
        to.byteArray = fromByteArray("QUJD") //base64(ABC)
        to.pocoArray.append(createPoco("pocoArray"))
        to.pocoList.append(createPoco("pocoList"))
        to.pocoLookup["A"] = [createPoco("B"), createPoco("C")]
        to.pocoLookup["D"] = [createPoco("E"), createPoco("F")]
        to.pocoLookupMap["A"] = [["B": createPoco("C"), "D": createPoco("E")]]

        return to
    }

    func assertDictionary<K, V: Equatable>(_ actual: [K: V]?, expected: [K: V]?) {
        if actual == nil {
            #expect(expected == nil)
            return
        }
        
        #expect(actual!.count == expected!.count)
        for (k, v) in actual! {
            #expect(v == expected![k]!)
        }
    }

    func assertLookup<K, V: Equatable>(_ actual: [K: [V]]?, expected: [K: [V]]?) {
        if actual == nil {
            #expect(expected == nil)
            return
        }
        
        #expect(actual!.count == expected!.count)
        for (k, values) in actual! {
            #expect(values.count == expected![k]!.count)
            for i in 0 ..< values.count {
                #expect(values[i] == expected![k]![i])
            }
        }
    }

    //[String:[[String:Poco]]]
    func assertLookupMap<K, V: Equatable>(_ actual: [K: [[K: V]]]?, expected: [K: [[K: V]]]?) {
        if actual == nil {
            #expect(expected == nil)
            return
        }
        
        #expect(actual!.count == expected!.count)
        for (k, list) in actual! {
            list.enumerated().forEach { (i,values) in
                #expect(values.count == expected![k]![i].count)
                for (subK, _) in values {
                    #expect(values[subK] == expected![k]![i][subK])
                }
            }
        }
    }

    func assertAllTypes(_ actual: AllTypes, expected: AllTypes) {
        #expect(actual.id! == expected.id!)
        #expect(actual.byte! == expected.byte!)
        #expect(actual.short! == expected.short!)
        #expect(actual.int! == expected.int!)
        #expect(actual.long! == expected.long!)
        #expect(actual.uShort! == expected.uShort!)
        #expect(actual.uLong! == expected.uLong!)
        #expect(actual.float! == expected.float!)
        #expect(actual.double! == expected.double!)
        #expect(actual.decimal! == expected.decimal!)
        #expect(actual.string! == expected.string!)
        #expect(actual.timeSpan! == expected.timeSpan!)
        #expect(actual.guid! == expected.guid!)
        #expect(actual.char! == expected.char!)
        #expect(actual.stringList == expected.stringList)
        #expect(actual.stringArray == expected.stringArray)

        assertDictionary(actual.stringMap, expected: expected.stringMap)
        assertDictionary(actual.intStringMap, expected: expected.intStringMap)

        if expected.dateTime != nil {
            #expect(actual.dateTime! == expected.dateTime!)
        }

        if expected.subType != nil {
            #expect(actual.subType!.id! == expected.subType!.id!)
            #expect(actual.subType!.name! == expected.subType!.name!)
        }
    }

    func assertAllCollectionTypes(_ actual: AllCollectionTypes, expected: AllCollectionTypes) {
        #expect(actual.intArray == expected.intArray)
        #expect(actual.intList == expected.intList)
        #expect(actual.stringArray == expected.stringArray)
        #expect(actual.stringList == expected.stringList)
        #expect(actual.byteArray == expected.byteArray)
        #expect(actual.pocoArray == expected.pocoArray)
        #expect(actual.pocoList == expected.pocoList)
        assertLookup(actual.pocoLookup, expected: expected.pocoLookup)
        assertLookupMap(actual.pocoLookupMap, expected: expected.pocoLookupMap)
    }

}

 extension Poco: Equatable {}

 public func == (lhs: Poco, rhs: Poco) -> Bool {
    return lhs.name == rhs.name
 }

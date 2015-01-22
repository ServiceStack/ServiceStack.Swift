//
//  SerializePersonTests.swift
//  SerializationUtils
//
//  Created by Demis Bellot on 1/17/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

//Note: Look at https://github.com/mxcl/PromiseKit

//Closures in Model extensions hurt Swift compiler (6.1.1) performance
#if false

import UIKit
import XCTest

class Person {
    required init(){}
    var id:Int = 1
    var type:String = "type"
    var name:String?
    var age:Int?
    var primaryNumber: PhoneNumber?
    var phoneNumbers:[PhoneNumber] = []
}

class PhoneNumber {
    required init(){}
    var number:String?
    var type:String?
}

extension Person : JsonSerializable
{
    class func typeConfig() -> JsConfigType<Person>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Person>(
            writers: [
                ("id", { (x:Person, map:NSDictionary) in setValue(&x.id, map, "id") }),
                ("type", { (x:Person, map:NSDictionary) in setValue(&x.type, map, "type") }),
                ("name", { (x:Person, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
                ("age", { (x:Person, map:NSDictionary) in setOptionalValue(&x.age, map, "age") }),
                ("primaryNumber", { (x:Person, map:NSDictionary) in setOptionalValue(&x.primaryNumber, map, "primaryNumber") }),
                ("phoneNumbers", { (x:Person, map:NSDictionary) in setValue(&x.phoneNumbers, map, "phoneNumbers") }),
            ],
            readers: [
                ("id", { (x:Person) in x.id as Any }),
                ("type", { (x:Person) in x.type as Any }),
                ("name", { (x:Person) in x.name as Any }),
                ("age", { (x:Person) in x.age as Any }),
                ("primaryNumber", { (x:Person) in x.primaryNumber as Any }),
                ("phoneNumbers", { (x:Person) in x.phoneNumbers as Any }),
            ]
        ))
    }
    
    func toJson() -> String {
        return serializeToJson(self, Person.typeConfig())
    }
    
    class func fromDictionary(map: NSDictionary) -> Person {
        return populate(Person(), map, Person.typeConfig())
    }
    
    class func fromJson(json:String) -> Person {
        return populate(Person(), json, Person.typeConfig())
    }
}

extension PhoneNumber : JsonSerializable
{
    class func typeConfig() -> JsConfigType<PhoneNumber>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<PhoneNumber>(
            writers: [
                ("number", { (x:PhoneNumber, map:NSDictionary) in setOptionalValue(&x.number, map, "number") }),
                ("type", { (x:PhoneNumber, map:NSDictionary) in setOptionalValue(&x.type, map, "type") }),
            ],
            readers: [
                ("number", { (x:PhoneNumber) in x.number as Any }),
                ("type", { (x:PhoneNumber) in x.type as Any }),
            ]
        ))
    }
    
    func toJson() -> String {
        return serializeToJson(self, PhoneNumber.typeConfig())
    }
    
    class func fromDictionary(map: NSDictionary) -> PhoneNumber {
        return populate(PhoneNumber(), map, PhoneNumber.typeConfig())
    }
    
    class func fromJson(json:String) -> PhoneNumber {
        return populate(PhoneNumber(), json, PhoneNumber.typeConfig())
    }
}

class SerializePersonTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func test_Can_serialize_Person_with_codegen(){
        var person = Person()
        person.name = "foo"
        
        var home = PhoneNumber()
        home.type = "Home"
        home.number = "123-456"
        person.phoneNumbers.append(home)
        
        var work = PhoneNumber()
        work.type = "Work"
        work.number = "555-555"
        person.phoneNumbers.append(work)
        

        XCTAssertEqual(person.toJson(),
            "{\"id\":1,\"type\":\"type\",\"name\":\"foo\",\"age\":null,\"primaryNumber\":null,\"phoneNumbers\":["
                + "{\"number\":\"123-456\",\"type\":\"Home\"},"
                + "{\"number\":\"555-555\",\"type\":\"Work\"}"
            + "]}")
    }
    
    func test_Can_deserialize_Person_from_NSDictionary_using_codegen() {
        var json = "{\"id\":1,\"type\":\"Person\",\"name\":\"foo\",\"age\":null}"
        
        var person = Person.fromJson(json)
        
        XCTAssertEqual(person.id, 1)
        XCTAssertEqual(person.type, "Person")
        XCTAssertEqual(person.name!, "foo")
        XCTAssertNil(person.age)
    }
    
    func test_Can_deserialize_Person_with_ArrayObjects_using_codegen() {
        var json = "{\"id\":1,\"type\":\"Person\",\"name\":\"foo\",\"age\":null,\"primaryNumber\":{\"number\":\"007\",\"type\":\"Mobile\"},\"phoneNumbers\":["
            + "{\"number\":\"123-456\",\"type\":\"Home\"},"
            + "{\"number\":\"555-555\",\"type\":\"Work\"}"
        + "]}"
        
        var person = Person.fromJson(json)
    
        XCTAssertEqual(person.id, 1)
        XCTAssertEqual(person.type, "Person")
        XCTAssertEqual(person.name!, "foo")
        XCTAssertNil(person.age)
        XCTAssertEqual(person.primaryNumber!.number!, "007")
        XCTAssertEqual(person.primaryNumber!.type!, "Mobile")
        
        XCTAssertEqual(person.phoneNumbers.count, 2)
        XCTAssertEqual(person.phoneNumbers[0].number!, "123-456")
        XCTAssertEqual(person.phoneNumbers[0].type!, "Home")
        XCTAssertEqual(person.phoneNumbers[1].number!, "555-555")
        XCTAssertEqual(person.phoneNumbers[1].type!, "Work")
    }
    
}


#endif









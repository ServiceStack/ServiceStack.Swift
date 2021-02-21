//
//  ParentChildTests.swift
//  SerializationUtils
//
//  Created by Demis Bellot on 1/21/15.
//  Copyright (c) 2021 ServiceStack, Inc. All rights reserved.
//

 @testable import ServiceStack
 import XCTest

 public class Parent: Codable {
    public required init() {}
    public var int: Int = 1
    public var intOptional: Int?
    public var string: String = "A"
    public var stringOptional: String?
    public var bool: Bool = true
    public var boolOptional: Bool?
    public var double: Double = 1.0
    public var doubleOptional: Double?

    public var child: Child = Child()
    public var childOptional: Child?

    public var ints: [Int] = [Int]()
    public var intsOptional: [Int]?
    public var strings: [String] = [String]()
    public var stringsOptional: [String]?
    public var bools: [Bool] = [Bool]()
    public var boolsOptional: [Bool]?
    public var doubles: [Double] = [Double]()
    public var doublesOptional: [Double]?

    public var children: [Child] = [Child]()
    public var childrenOptional: [Child]?
 }

 public class Child: Codable {
    public required init() {}
    public var id: Int = 1
    public var name: String?
 }

 public enum Suit: String, Codable {
    case Hearts, Clubs, Diamonds, Spades
 }

 extension Child: Equatable {}

 public func == (lhs: Child, rhs: Child) -> Bool {
    return lhs.id == rhs.id
        && lhs.name == rhs.name
 }

 class SerializeParentChildTests: XCTestCase {
    func testCan_serialize_Empty_Parent() {
        let dto = Parent()

        let json = toJson(dto)

        print(json!)

        XCTAssertEqual(json,
                       "{\"string\":\"A\",\"double\":1,\"int\":1,\"ints\":[],\"doubles\":[],\"bools\":[],\"children\":[],\"bool\":true,\"child\":{\"id\":1},\"strings\":[]}")
    }

    func createChild(id: Int) -> Child {
        let to = Child()
        to.id = id
        to.name = "name" + String(id)
        return to
    }

    func test_Can_serialize_full_Parent() {
        let dto = Parent()
        dto.intOptional = 2
        dto.stringOptional = "B"
        dto.boolOptional = false
        dto.doubleOptional = 2.0
        dto.childOptional = createChild(id: 1)
        dto.ints = [1, 2, 3]
        dto.intsOptional = [4, 5, 6]
        dto.strings = ["A", "B", "C"]
        dto.stringsOptional = ["D", "E", "F"]
        dto.bools = [true, false]
        dto.boolsOptional = [false, true]
        dto.doubles = [1.1, 2.2, 3.3]
        dto.doublesOptional = [4.4, 5.5, 6.6]
        dto.children = [createChild(id: 1), createChild(id: 2)]
        dto.childrenOptional = [createChild(id: 3), createChild(id: 4)]

        let json = toJson(dto)

        print(json!)

        XCTAssertEqual(json,
                       "{\"ints\":[1,2,3],\"intOptional\":2,\"boolsOptional\":[false,true],\"doubles\":[1.1000000000000001,2.2000000000000002,3.2999999999999998],\"strings\":[\"A\",\"B\",\"C\"],\"bools\":[true,false],\"stringOptional\":\"B\",\"bool\":true,\"double\":1,\"children\":[{\"id\":1,\"name\":\"name1\"},{\"id\":2,\"name\":\"name2\"}],\"int\":1,\"childOptional\":{\"id\":1,\"name\":\"name1\"},\"stringsOptional\":[\"D\",\"E\",\"F\"],\"doubleOptional\":2,\"childrenOptional\":[{\"id\":3,\"name\":\"name3\"},{\"id\":4,\"name\":\"name4\"}],\"doublesOptional\":[4.4000000000000004,5.5,6.5999999999999996],\"intsOptional\":[4,5,6],\"boolOptional\":false,\"string\":\"A\",\"child\":{\"id\":1}}")
    }

    func test_Can_deserialize_full_Parent() {
        let json = "{\"int\":1,\"intOptional\":2,\"string\":\"A\",\"stringOptional\":\"B\",\"bool\":true,\"boolOptional\":false,\"double\":1.0,\"doubleOptional\":2.0,\"child\":{\"id\":1,\"name\":null},\"childOptional\":{\"id\":1,\"name\":\"name1\"},\"ints\":[1,2,3],\"intsOptional\":[4,5,6],\"strings\":[\"A\",\"B\",\"C\"],\"stringsOptional\":[\"D\",\"E\",\"F\"],\"bools\":[true,false],\"boolsOptional\":[false,true],\"doubles\":[1.1,2.2,3.3],\"doublesOptional\":[4.4,5.5,6.6],\"children\":[{\"id\":1,\"name\":\"name1\"},{\"id\":2,\"name\":\"name2\"}],\"childrenOptional\":[{\"id\":3,\"name\":\"name3\"},{\"id\":4,\"name\":\"name4\"}]}"

        let parent = fromJson(Parent.self, json)!

//        println("TO JSON:")
//        println(parent.toJson())

        XCTAssertEqual(parent.int, 1)
        XCTAssertEqual(parent.intOptional!, 2)
        XCTAssertEqual(parent.string, "A")
        XCTAssertEqual(parent.stringOptional!, "B")
        XCTAssertEqual(parent.bool, true)
        XCTAssertEqual(parent.boolOptional!, false)
        XCTAssertEqual(parent.double, 1.0)
        XCTAssertEqual(parent.doubleOptional!, 2.0)

        XCTAssertEqual(parent.child, Child())
        XCTAssertEqual(parent.childOptional!, createChild(id: 1))

        XCTAssertEqual(parent.ints, [1, 2, 3])
        XCTAssertEqual(parent.intsOptional!, [4, 5, 6])
        XCTAssertEqual(parent.strings, ["A", "B", "C"])
        XCTAssertEqual(parent.stringsOptional!, ["D", "E", "F"])
        XCTAssertEqual(parent.bools, [true, false])
        XCTAssertEqual(parent.boolsOptional!, [false, true])
        XCTAssertEqual(parent.doubles, [1.1, 2.2, 3.3])
        XCTAssertEqual(parent.doublesOptional!, [4.4, 5.5, 6.6])

        XCTAssertEqual(parent.children, [createChild(id: 1), createChild(id: 2)])
        XCTAssertEqual(parent.childrenOptional!, [createChild(id: 3), createChild(id: 4)])
    }
 }

#if true
//
//  ParentChildTests.swift
//  SerializationUtils
//
//  Created by Demis Bellot on 1/21/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import XCTest
@testable import ServiceStackClient

public class Parent
{
    required public init(){}
    public var int:Int = 1
    public var intOptional:Int?
    public var string:String = "A"
    public var stringOptional:String?
    public var bool:Bool = true
    public var boolOptional:Bool?
    public var double:Double = 1.0
    public var doubleOptional:Double?
    
    public var child:Child = Child()
    public var childOptional:Child?
    
    public var ints:[Int] = [Int]()
    public var intsOptional:[Int]?
    public var strings:[String] = [String]()
    public var stringsOptional:[String]?
    public var bools:[Bool] = [Bool]()
    public var boolsOptional:[Bool]?
    public var doubles:[Double] = [Double]()
    public var doublesOptional:[Double]?
    
    public var children:[Child] = [Child]()
    public var childrenOptional:[Child]?
}

public class Child
{
    required public init(){}
    public var id:Int = 1
    public var name:String?
}
    
public enum Suit
{
    case Hearts, Clubs, Diamonds, Spades
}
    
extension Parent : JsonSerializable
{
    public static var typeName:String { return "Parent" }

    public static var metadata = Metadata.create([
        Type<Parent>.property("int", get: { $0.int }, set: { $0.int = $1 }),
        Type<Parent>.optionalProperty("intOptional", get: { $0.intOptional }, set: { $0.intOptional = $1 }),
        Type<Parent>.property("string", get: { $0.string }, set: { $0.string = $1 }),
        Type<Parent>.optionalProperty("stringOptional", get: { $0.stringOptional }, set: { $0.stringOptional = $1 }),
        Type<Parent>.property("bool", get: { $0.bool }, set: { $0.bool = $1 }),
        Type<Parent>.optionalProperty("boolOptional", get: { $0.boolOptional }, set: { $0.boolOptional = $1 }),
        Type<Parent>.property("double", get: { $0.double }, set: { $0.double = $1 }),
        Type<Parent>.optionalProperty("doubleOptional", get: { $0.doubleOptional }, set: { $0.doubleOptional = $1 }),
        Type<Parent>.property("child", get: { $0.child }, set: { $0.child = $1 }),
        Type<Parent>.optionalProperty("childOptional", get: { $0.childOptional }, set: { $0.childOptional = $1 }),
        Type<Parent>.arrayProperty("ints", get: { $0.ints }, set: { $0.ints = $1 }),
        Type<Parent>.optionalArrayProperty("intsOptional", get: { $0.intsOptional }, set: { $0.intsOptional = $1 }),
        Type<Parent>.arrayProperty("strings", get: { $0.strings }, set: { $0.strings = $1 }),
        Type<Parent>.optionalArrayProperty("stringsOptional", get: { $0.stringsOptional }, set: { $0.stringsOptional = $1 }),
        Type<Parent>.arrayProperty("bools", get: { $0.bools }, set: { $0.bools = $1 }),
        Type<Parent>.optionalArrayProperty("boolsOptional", get: { $0.boolsOptional }, set: { $0.boolsOptional = $1 }),
        Type<Parent>.arrayProperty("doubles", get: { $0.doubles }, set: { $0.doubles = $1 }),
        Type<Parent>.optionalArrayProperty("doublesOptional", get: { $0.doublesOptional }, set: { $0.doublesOptional = $1 }),
        Type<Parent>.arrayProperty("children", get: { $0.children }, set: { $0.children = $1 }),
        Type<Parent>.optionalArrayProperty("childrenOptional", get: { $0.childrenOptional }, set: { $0.childrenOptional = $1 }),
    ])
}

extension Child : JsonSerializable
{
    public class var typeName:String { return "Child" }

    public static var metadata = Metadata.create([
        Type<Child>.property("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<Child>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
    ])
}

    
    
    
extension Child : Equatable {}

public func == (lhs: Child, rhs: Child) -> Bool {
    return lhs.id == rhs.id
        && lhs.name == rhs.name
}

class SerializeParentChildTests: XCTestCase
{
    func testCan_serialize_Empty_Parent() {
        let dto = Parent()
        
        let json = dto.toJson()
        
        print(json)
        
        XCTAssertEqual(json,
            "{\"int\":1,\"intOptional\":null,\"string\":\"A\",\"stringOptional\":null,\"bool\":true,\"boolOptional\":null,\"double\":1.0,\"doubleOptional\":null,\"child\":{\"id\":1,\"name\":null},\"childOptional\":null,\"ints\":[],\"intsOptional\":null,\"strings\":[],\"stringsOptional\":null,\"bools\":[],\"boolsOptional\":null,\"doubles\":[],\"doublesOptional\":null,\"children\":[],\"childrenOptional\":null}")
    }
    
    func createChild(id:Int) -> Child {
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
        dto.ints = [1,2,3]
        dto.intsOptional = [4,5,6]
        dto.strings = ["A","B","C"]
        dto.stringsOptional = ["D","E","F"]
        dto.bools = [true,false]
        dto.boolsOptional = [false,true]
        dto.doubles = [1.1,2.2,3.3]
        dto.doublesOptional = [4.4,5.5,6.6]
        dto.children = [createChild(id: 1),createChild(id: 2)]
        dto.childrenOptional = [createChild(id: 3),createChild(id: 4)]

        let json = dto.toJson()
        
        print(json)
        
        XCTAssertEqual(json,
            "{\"int\":1,\"intOptional\":2,\"string\":\"A\",\"stringOptional\":\"B\",\"bool\":true,\"boolOptional\":false,\"double\":1.0,\"doubleOptional\":2.0,\"child\":{\"id\":1,\"name\":null},\"childOptional\":{\"id\":1,\"name\":\"name1\"},\"ints\":[1,2,3],\"intsOptional\":[4,5,6],\"strings\":[\"A\",\"B\",\"C\"],\"stringsOptional\":[\"D\",\"E\",\"F\"],\"bools\":[true,false],\"boolsOptional\":[false,true],\"doubles\":[1.1,2.2,3.3],\"doublesOptional\":[4.4,5.5,6.6],\"children\":[{\"id\":1,\"name\":\"name1\"},{\"id\":2,\"name\":\"name2\"}],\"childrenOptional\":[{\"id\":3,\"name\":\"name3\"},{\"id\":4,\"name\":\"name4\"}]}")
    }
    
    func test_Can_deserialize_full_Parent() {
        let json = "{\"int\":1,\"intOptional\":2,\"string\":\"A\",\"stringOptional\":\"B\",\"bool\":true,\"boolOptional\":false,\"double\":1.0,\"doubleOptional\":2.0,\"child\":{\"id\":1,\"name\":null},\"childOptional\":{\"id\":1,\"name\":\"name1\"},\"ints\":[1,2,3],\"intsOptional\":[4,5,6],\"strings\":[\"A\",\"B\",\"C\"],\"stringsOptional\":[\"D\",\"E\",\"F\"],\"bools\":[true,false],\"boolsOptional\":[false,true],\"doubles\":[1.1,2.2,3.3],\"doublesOptional\":[4.4,5.5,6.6],\"children\":[{\"id\":1,\"name\":\"name1\"},{\"id\":2,\"name\":\"name2\"}],\"childrenOptional\":[{\"id\":3,\"name\":\"name3\"},{\"id\":4,\"name\":\"name4\"}]}"
        
        let parent = Parent.fromJson(json)!
        
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
        
        assertEquals(parent.ints, actual: [1,2,3])
        assertEquals(parent.intsOptional!, actual: [4,5,6])
        assertEquals(parent.strings, actual: ["A","B","C"])
        assertEquals(parent.stringsOptional!, actual: ["D","E","F"])
        assertEquals(parent.bools, actual: [true,false])
        assertEquals(parent.boolsOptional!, actual: [false,true])
        assertEquals(parent.doubles, actual: [1.1,2.2,3.3])
        assertEquals(parent.doublesOptional!, actual: [4.4,5.5,6.6])

        assertEquals(parent.children, actual: [createChild(id: 1),createChild(id: 2)])
        assertEquals(parent.childrenOptional!, actual: [createChild(id: 3),createChild(id: 4)])
    }
}


#endif

//
//  ParentChildTests.swift
//  SerializationUtils
//
//  Created by Demis Bellot on 1/21/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

#if true

import UIKit
import XCTest

class Parent
{
    required init(){}
    var int:Int = 1
    var intOptional:Int?
    var string:String = "A"
    var stringOptional:String?
    var bool:Bool = true
    var boolOptional:Bool?
    var double:Double = 1.0
    var doubleOptional:Double?
    
    var child:Child = Child()
    var childOptional:Child?
    
    var ints:[Int] = [Int]()
    var intsOptional:[Int]?
    var strings:[String] = [String]()
    var stringsOptional:[String]?
    var bools:[Bool] = [Bool]()
    var boolsOptional:[Bool]?
    var doubles:[Double] = [Double]()
    var doublesOptional:[Double]?
    
    var children:[Child] = [Child]()
    var childrenOptional:[Child]?
}

class Child
{
    required init(){}
    var id:Int = 1
    var name:String?
}
    
//class Child<T> {
//    
//}


extension Parent : JsonSerializable
{
    class func typeConfig() -> JsConfigType<Parent>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Parent>(
            writers: [
                ("int", { (x:Parent, map:NSDictionary) in setValue(&x.int, map, "int") }),
                ("intOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.intOptional, map, "intOptional") }),
                ("string", { (x:Parent, map:NSDictionary) in setValue(&x.string, map, "string") }),
                ("stringOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.stringOptional, map, "stringOptional") }),
                ("bool", { (x:Parent, map:NSDictionary) in setValue(&x.bool, map, "bool") }),
                ("boolOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.boolOptional, map, "boolOptional") }),
                ("double", { (x:Parent, map:NSDictionary) in setValue(&x.double, map, "double") }),
                ("doubleOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.doubleOptional, map, "doubleOptional") }),
                ("child", { (x:Parent, map:NSDictionary) in setValue(&x.child, map, "child") }),
                ("childOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.childOptional, map, "childOptional") }),
                ("ints", { (x:Parent, map:NSDictionary) in setValue(&x.ints, map, "ints") }),
                ("intsOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.intsOptional, map, "intsOptional") }),
                ("strings", { (x:Parent, map:NSDictionary) in setValue(&x.strings, map, "strings") }),
                ("stringsOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.stringsOptional, map, "stringsOptional") }),
                ("bools", { (x:Parent, map:NSDictionary) in setValue(&x.bools, map, "bools") }),
                ("boolsOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.boolsOptional, map, "boolsOptional") }),
                ("doubles", { (x:Parent, map:NSDictionary) in setValue(&x.doubles, map, "doubles") }),
                ("doublesOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.doublesOptional, map, "doublesOptional") }),
                ("children", { (x:Parent, map:NSDictionary) in setValue(&x.children, map, "children") }),
                ("childrenOptional", { (x:Parent, map:NSDictionary) in setOptionalValue(&x.childrenOptional, map, "childrenOptional") }),
            ],
            readers: [
                ("int", { (x:Parent) in x.int as Any }),
                ("intOptional", { (x:Parent) in x.intOptional as Any }),
                ("string", { (x:Parent) in getValue(x.string) }),
                ("stringOptional", { (x:Parent) in x.stringOptional as Any }),
                ("bool", { (x:Parent) in getValue(x.bool) }),
                ("boolOptional", { (x:Parent) in x.boolOptional as Any }),
                ("double", { (x:Parent) in getValue(x.double) }),
                ("doubleOptional", { (x:Parent) in x.doubleOptional as Any }),
                ("child", { (x:Parent) in x.child as Any }),
                ("childOptional", { (x:Parent) in x.childOptional as Any }),
                ("ints", { (x:Parent) in x.ints as Any }),
                ("intsOptional", { (x:Parent) in x.intsOptional as Any }),
                ("strings", { (x:Parent) in x.strings as Any }),
                ("stringsOptional", { (x:Parent) in x.stringsOptional as Any }),
                ("bools", { (x:Parent) in x.bools as Any }),
                ("boolsOptional", { (x:Parent) in x.boolsOptional as Any }),
                ("doubles", { (x:Parent) in x.doubles as Any }),
                ("doublesOptional", { (x:Parent) in x.doublesOptional as Any }),
                ("children", { (x:Parent) in x.children as Any }),
                ("childrenOptional", { (x:Parent) in x.childrenOptional as Any }),
            ]
        ))
    }
    
    func toJson() -> String {
        return serializeToJson(self, Parent.typeConfig())
    }
    
    class func fromDictionary(map: NSDictionary) -> Parent {
        return populate(Parent(), map, Parent.typeConfig())
    }
    
    class func fromJson(json:String) -> Parent {
        return populate(Parent(), json, Parent.typeConfig())
    }
}

extension Child : JsonSerializable
{
    class func typeConfig() -> JsConfigType<Child>
    {
        return JsConfig.typeConfig() ?? JsConfig.configure(JsConfigType<Child>(
            writers: [
                ("id", { (x:Child, map:NSDictionary) in setValue(&x.id, map, "id") }),
                ("name", { (x:Child, map:NSDictionary) in setOptionalValue(&x.name, map, "name") }),
            ],
            readers: [
                ("id", { (x:Child) in getValue(x.id) }),
                ("name", { (x:Child) in getOptionalValue(x.name) }),
            ]
        ))
    }
    
    func toJson() -> String {
        return serializeToJson(self, Child.typeConfig())
    }
    
    class func fromDictionary(map: NSDictionary) -> Child {
        return populate(Child(), map, Child.typeConfig())
    }
    
    class func fromJson(json:String) -> Child {
        return populate(Child(), json, Child.typeConfig())
    }
}
    
extension Child : Equatable {}

func == (lhs: Child, rhs: Child) -> Bool {
    return lhs.id == rhs.id
        && lhs.name == rhs.name
}

class SerializeParentChildTests: XCTestCase
{
    func testCan_serialize_Empty_Parent() {
        var dto = Parent()
        
        var json = dto.toJson()
        
        println(json)
        
        XCTAssertEqual(json,
            "{\"int\":1,\"intOptional\":null,\"string\":\"A\",\"stringOptional\":null,\"bool\":true,\"boolOptional\":null,\"double\":1.0,\"doubleOptional\":null,\"child\":{\"id\":1,\"name\":null},\"childOptional\":null,\"ints\":[],\"intsOptional\":null,\"strings\":[],\"stringsOptional\":null,\"bools\":[],\"boolsOptional\":null,\"doubles\":[],\"doublesOptional\":null,\"children\":[],\"childrenOptional\":null}")
    }
    
    func createChild(id:Int) -> Child {
        var to = Child()
        to.id = id
        to.name = "name" + String(id)
        return to
    }
    
    func test_Can_serialize_full_Parent() {
        var dto = Parent()
        dto.intOptional = 2
        dto.stringOptional = "B"
        dto.boolOptional = false
        dto.doubleOptional = 2.0
        dto.childOptional = createChild(1)
        dto.ints = [1,2,3]
        dto.intsOptional = [4,5,6]
        dto.strings = ["A","B","C"]
        dto.stringsOptional = ["D","E","F"]
        dto.bools = [true,false]
        dto.boolsOptional = [false,true]
        dto.doubles = [1.1,2.2,3.3]
        dto.doublesOptional = [4.4,5.5,6.6]
        dto.children = [createChild(1),createChild(2)]
        dto.childrenOptional = [createChild(3),createChild(4)]

        var json = dto.toJson()
        
        println(json)
        
        XCTAssertEqual(json,
            "{\"int\":1,\"intOptional\":2,\"string\":\"A\",\"stringOptional\":\"B\",\"bool\":true,\"boolOptional\":false,\"double\":1.0,\"doubleOptional\":2.0,\"child\":{\"id\":1,\"name\":null},\"childOptional\":{\"id\":1,\"name\":\"name1\"},\"ints\":[1,2,3],\"intsOptional\":[4,5,6],\"strings\":[\"A\",\"B\",\"C\"],\"stringsOptional\":[\"D\",\"E\",\"F\"],\"bools\":[true,false],\"boolsOptional\":[false,true],\"doubles\":[1.1,2.2,3.3],\"doublesOptional\":[4.4,5.5,6.6],\"children\":[{\"id\":1,\"name\":\"name1\"},{\"id\":2,\"name\":\"name2\"}],\"childrenOptional\":[{\"id\":3,\"name\":\"name3\"},{\"id\":4,\"name\":\"name4\"}]}")
    }
    
    func test_Can_deserialize_full_Parent() {
        let json = "{\"int\":1,\"intOptional\":2,\"string\":\"A\",\"stringOptional\":\"B\",\"bool\":true,\"boolOptional\":false,\"double\":1.0,\"doubleOptional\":2.0,\"child\":{\"id\":1,\"name\":null},\"childOptional\":{\"id\":1,\"name\":\"name1\"},\"ints\":[1,2,3],\"intsOptional\":[4,5,6],\"strings\":[\"A\",\"B\",\"C\"],\"stringsOptional\":[\"D\",\"E\",\"F\"],\"bools\":[true,false],\"boolsOptional\":[false,true],\"doubles\":[1.1,2.2,3.3],\"doublesOptional\":[4.4,5.5,6.6],\"children\":[{\"id\":1,\"name\":\"name1\"},{\"id\":2,\"name\":\"name2\"}],\"childrenOptional\":[{\"id\":3,\"name\":\"name3\"},{\"id\":4,\"name\":\"name4\"}]}"
        
        var parent = Parent.fromJson(json)
        
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
        XCTAssertEqual(parent.childOptional!, createChild(1))
        
        assertEquals(parent.ints, [1,2,3])
        assertEquals(parent.intsOptional!, [4,5,6])
        assertEquals(parent.strings, ["A","B","C"])
        assertEquals(parent.stringsOptional!, ["D","E","F"])
        assertEquals(parent.bools, [true,false])
        assertEquals(parent.boolsOptional!, [false,true])
        assertEquals(parent.doubles, [1.1,2.2,3.3])
        assertEquals(parent.doublesOptional!, [4.4,5.5,6.6])

        assertEquals(parent.children, [createChild(1),createChild(2)])
        assertEquals(parent.childrenOptional!, [createChild(3),createChild(4)])
    }
}


#endif

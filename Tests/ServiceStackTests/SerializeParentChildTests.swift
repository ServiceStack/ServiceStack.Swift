//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import ServiceStack

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

final class SerializeParentChildTests : @unchecked Sendable {

    @Test func Can_serialize_Empty_Parent() {
        let dto = Parent()

        let json = toJson(dto)
        print("json: " + json!)


        let obj = fromJson(Parent.self, json!)!
        #expect(obj.int == 1)
        #expect(obj.string == "A")
        #expect(obj.bool == true)
        #expect(obj.double == 1.0)

        #expect(obj.child.id == 1)

        #expect(obj.ints == [])
        #expect(obj.strings == [])
        #expect(obj.bools == [])
        #expect(obj.doubles == [])
    }

    func createChild(id: Int) -> Child {
        let to = Child()
        to.id = id
        to.name = "name" + String(id)
        return to
    }

    @Test func Can_serialize_full_Parent() {
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

        let obj = fromJson(Parent.self, json!)!
        #expect(obj.int == 1)
        #expect(obj.intOptional! == 2)
        #expect(obj.string == "A")
        #expect(obj.stringOptional! == "B")
        #expect(obj.bool == true)
        #expect(obj.boolOptional! == false)
        #expect(obj.double == 1.0)
        #expect(obj.doubleOptional! == 2.0)

        #expect(obj.child == Child())
        #expect(obj.childOptional! == createChild(id: 1))

        #expect(obj.ints == [1, 2, 3])
        #expect(obj.intsOptional! == [4, 5, 6])
        #expect(obj.strings == ["A", "B", "C"])
        #expect(obj.stringsOptional! == ["D", "E", "F"])
        #expect(obj.bools == [true, false])
        #expect(obj.boolsOptional! == [false, true])
        #expect(obj.doubles == [1.1, 2.2, 3.3])
        #expect(obj.doublesOptional! == [4.4, 5.5, 6.6])
    }

    @Test func Can_deserialize_full_Parent() {
        let json = "{\"int\":1,\"intOptional\":2,\"string\":\"A\",\"stringOptional\":\"B\",\"bool\":true,\"boolOptional\":false,\"double\":1.0,\"doubleOptional\":2.0,\"child\":{\"id\":1,\"name\":null},\"childOptional\":{\"id\":1,\"name\":\"name1\"},\"ints\":[1,2,3],\"intsOptional\":[4,5,6],\"strings\":[\"A\",\"B\",\"C\"],\"stringsOptional\":[\"D\",\"E\",\"F\"],\"bools\":[true,false],\"boolsOptional\":[false,true],\"doubles\":[1.1,2.2,3.3],\"doublesOptional\":[4.4,5.5,6.6],\"children\":[{\"id\":1,\"name\":\"name1\"},{\"id\":2,\"name\":\"name2\"}],\"childrenOptional\":[{\"id\":3,\"name\":\"name3\"},{\"id\":4,\"name\":\"name4\"}]}"

        let parent = fromJson(Parent.self, json)!

//        println("TO JSON:")
//        println(parent.toJson())

        #expect(parent.int == 1)
        #expect(parent.intOptional! == 2)
        #expect(parent.string == "A")
        #expect(parent.stringOptional! == "B")
        #expect(parent.bool == true)
        #expect(parent.boolOptional! == false)
        #expect(parent.double == 1.0)
        #expect(parent.doubleOptional! == 2.0)

        #expect(parent.child == Child())
        #expect(parent.childOptional! == createChild(id: 1))

        #expect(parent.ints == [1, 2, 3])
        #expect(parent.intsOptional! == [4, 5, 6])
        #expect(parent.strings == ["A", "B", "C"])
        #expect(parent.stringsOptional! == ["D", "E", "F"])
        #expect(parent.bools == [true, false])
        #expect(parent.boolsOptional! == [false, true])
        #expect(parent.doubles == [1.1, 2.2, 3.3])
        #expect(parent.doublesOptional! == [4.4, 5.5, 6.6])

        #expect(parent.children == [createChild(id: 1), createChild(id: 2)])
        #expect(parent.childrenOptional! == [createChild(id: 3), createChild(id: 4)])
    }
}

//
//  File.swift
//
//
//  Created by Demis Bellot on 2/19/21.
//

import Foundation

class EmptyUnkeyedDecodingContainer: UnkeyedDecodingContainer {
    var codingPath: [CodingKey] = []
    var count: Int? = 0
    var isAtEnd: Bool = true
    var currentIndex: Int = 0
    func decodeNil() throws -> Bool { return true }
    func decode(_: Bool.Type) throws -> Bool { return true }
    func decode(_: String.Type) throws -> String { return "" }
    func decode(_: Double.Type) throws -> Double { return 0 }
    func decode(_: Float.Type) throws -> Float { return 0 }
    func decode(_: Int.Type) throws -> Int { return 0 }
    func decode(_: Int8.Type) throws -> Int8 { return 0 }
    func decode(_: Int16.Type) throws -> Int16 { return 0 }
    func decode(_: Int32.Type) throws -> Int32 { return 0 }
    func decode(_: Int64.Type) throws -> Int64 { return 0 }
    func decode(_: UInt.Type) throws -> UInt { return 0 }
    func decode(_: UInt8.Type) throws -> UInt8 { return 0 }
    func decode(_: UInt16.Type) throws -> UInt16 { return 0 }
    func decode(_: UInt32.Type) throws -> UInt32 { return 0 }
    func decode(_: UInt64.Type) throws -> UInt64 { return 0 }
    func decode<T>(_: T.Type) throws -> T where T: Decodable { return Factory<T>.create() }
    func nestedContainer<NestedKey>(keyedBy _: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        return KeyedDecodingContainer<NestedKey>(EmptyKeyedDecodingContainerProtocol<NestedKey>())
    }
    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        return EmptyDecoder.instanceUnkeyedContainer
    }
    func superDecoder() throws -> Decoder { return EmptyDecoder.instance }
}

class EmptySingleValueDecodingContainer: SingleValueDecodingContainer {
    private(set) var codingPath: [CodingKey] = []
    func decodeNil() -> Bool { return true }
    func decode(_: Bool.Type) throws -> Bool { return true }
    func decode(_: String.Type) throws -> String { return "" }
    func decode(_: Double.Type) throws -> Double { return 0 }
    func decode(_: Float.Type) throws -> Float { return 0 }
    func decode(_: Int.Type) throws -> Int { return 0 }
    func decode(_: Int8.Type) throws -> Int8 { return 0 }
    func decode(_: Int16.Type) throws -> Int16 { return 0 }
    func decode(_: Int32.Type) throws -> Int32 { return 0 }
    func decode(_: Int64.Type) throws -> Int64 { return 0 }
    func decode(_: UInt.Type) throws -> UInt { return 0 }
    func decode(_: UInt8.Type) throws -> UInt8 { return 0 }
    func decode(_: UInt16.Type) throws -> UInt16 { return 0 }
    func decode(_: UInt32.Type) throws -> UInt32 { return 0 }
    func decode(_: UInt64.Type) throws -> UInt64 { return 0 }
    func decode<T>(_: T.Type) throws -> T where T: Decodable { return Factory<T>.create() }
}

class EmptyKeyedDecodingContainerProtocol<T: CodingKey>: KeyedDecodingContainerProtocol {
    typealias Key = T

    private(set) var codingPath: [CodingKey] = []
    private(set) var allKeys: [Key] = []

    func contains(_: Key) -> Bool { return false }
    func decodeNil(forKey _: Key) throws -> Bool { return false }
    func decode(_: Bool.Type, forKey _: Key) throws -> Bool { return false }
    func decode(_: String.Type, forKey _: Key) throws -> String { return "" }
    func decode(_: Double.Type, forKey _: Key) throws -> Double { return 0 }
    func decode(_: Float.Type, forKey _: Key) throws -> Float { return 0 }
    func decode(_: Int.Type, forKey _: Key) throws -> Int { return 0 }
    func decode(_: Int8.Type, forKey _: Key) throws -> Int8 { return 0 }
    func decode(_: Int16.Type, forKey _: Key) throws -> Int16 { return 0 }
    func decode(_: Int32.Type, forKey _: Key) throws -> Int32 { return 0 }
    func decode(_: Int64.Type, forKey _: Key) throws -> Int64 { return 0 }
    func decode(_: UInt.Type, forKey _: Key) throws -> UInt { return 0 }
    func decode(_: UInt8.Type, forKey _: Key) throws -> UInt8 { return 0 }
    func decode(_: UInt16.Type, forKey _: Key) throws -> UInt16 { return 0 }
    func decode(_: UInt32.Type, forKey _: Key) throws -> UInt32 { return 0 }
    func decode(_: UInt64.Type, forKey _: Key) throws -> UInt64 { return 0 }
    func decode<T>(_: T.Type, forKey _: Key) throws -> T where T: Decodable {
        return try T(from: EmptyDecoder.instance)
    }
    func decodeIfPresent(_: Bool.Type, forKey _: Key) throws -> Bool? { return nil }
    func decodeIfPresent(_: String.Type, forKey _: Key) throws -> String? { return nil }
    func decodeIfPresent(_: Double.Type, forKey _: Key) throws -> Double? { return nil }
    func decodeIfPresent(_: Float.Type, forKey _: Key) throws -> Float? { return nil }
    func decodeIfPresent(_: Int.Type, forKey _: Key) throws -> Int? { return nil }
    func decodeIfPresent(_: Int8.Type, forKey _: Key) throws -> Int8? { return nil }
    func decodeIfPresent(_: Int16.Type, forKey _: Key) throws -> Int16? { return nil }
    func decodeIfPresent(_: Int32.Type, forKey _: Key) throws -> Int32? { return nil }
    func decodeIfPresent(_: Int64.Type, forKey _: Key) throws -> Int64? { return nil }
    func decodeIfPresent(_: UInt.Type, forKey _: Key) throws -> UInt? { return nil }
    func decodeIfPresent(_: UInt8.Type, forKey _: Key) throws -> UInt8? { return nil }
    func decodeIfPresent(_: UInt16.Type, forKey _: Key) throws -> UInt16? { return nil }
    func decodeIfPresent(_: UInt32.Type, forKey _: Key) throws -> UInt32? { return nil }
    func decodeIfPresent(_: UInt64.Type, forKey _: Key) throws -> UInt64? { return nil }
    func decodeIfPresent<T>(_: T.Type, forKey _: Key) throws -> T? where T: Decodable { return nil }
    func nestedContainer<NestedKey>(keyedBy _: NestedKey.Type, forKey _: Key) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        return KeyedDecodingContainer<NestedKey>(EmptyKeyedDecodingContainerProtocol<NestedKey>())
    }
    func nestedUnkeyedContainer(forKey _: Key) throws -> UnkeyedDecodingContainer {
        return try EmptyDecoder.instance.unkeyedContainer()
    }
    func superDecoder() throws -> Decoder { return EmptyDecoder.instance }
    func superDecoder(forKey _: Key) throws -> Decoder { return EmptyDecoder.instance }
}

public class EmptyDecoder: Decoder {
    enum CodingKeys: String, CodingKey { case Empty }
    public static var instance: Decoder = EmptyDecoder()
    static var instanceUnkeyedContainer: UnkeyedDecodingContainer = EmptyUnkeyedDecodingContainer()
    static var instanceSingleValueContainer: SingleValueDecodingContainer = EmptySingleValueDecodingContainer()
    public var codingPath: [CodingKey] = []
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    public func container<Key>(keyedBy _: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        return KeyedDecodingContainer<Key>(EmptyKeyedDecodingContainerProtocol<Key>())
    }

    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return EmptyDecoder.instanceUnkeyedContainer
    }

    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return EmptyDecoder.instanceSingleValueContainer
    }
}

public class CaptureDecoder: Decoder {
    enum CodingKeys: String, CodingKey { case Empty }
    public var codingPath: [CodingKey] = []
    public var userInfo: [CodingUserInfoKey: Any] = [:]
    public var allKeys: [String] = []
    public func container<Key>(keyedBy _: Key.Type) throws -> KeyedDecodingContainer<Key> where Key: CodingKey {
        // Key.Type.self
        return KeyedDecodingContainer<Key>(EmptyKeyedDecodingContainerProtocol<Key>())
    }

    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return EmptyDecoder.instanceUnkeyedContainer
    }

    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return EmptyDecoder.instanceSingleValueContainer
    }
}

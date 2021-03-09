//
//  NativeExtensionsTests.swift
//  ServiceStackTests
//
//  Created by Demis Bellot on 1/30/15.
//  Copyright (c) 2021 ServiceStack, Inc. All rights reserved.
//

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import Foundation
import XCTest

 class NativeExtensionsTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_Can_combine_paths() {
        XCTAssertEqual("/a".combinePath("b"), "/a/b")
        XCTAssertEqual("/a/".combinePath("b"), "/a/b")
        XCTAssertEqual("/a/".combinePath("/b"), "/a/b")
    }
 }

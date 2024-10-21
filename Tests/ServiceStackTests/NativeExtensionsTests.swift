//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import ServiceStack

 class NativeExtensionsTests {

    @Test func Can_combine_paths() {
        #expect("/a".combinePath("b") == "/a/b")
        #expect("/a/".combinePath("b") == "/a/b")
        #expect("/a/".combinePath("/b") == "/a/b")
    }
 }

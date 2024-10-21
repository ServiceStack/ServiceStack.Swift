//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import ServiceStack

struct ServiceStack {
    var text = "Hello, World!"
}

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    #expect(ServiceStack().text == "Hello, World!")
}

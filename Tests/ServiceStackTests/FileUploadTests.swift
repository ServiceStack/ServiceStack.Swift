//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import ServiceStack

final class FileUploadTests : @unchecked Sendable {
    var client: JsonServiceClient!
    
    init() async throws {
        print("JsonServiceClientTests.init()")
        client = JsonServiceClient(baseUrl: "https://test.servicestack.net")
    }

    @Test func Can_Post_file_with_Request() throws {

        let request = SpeechToText()

        let files = [UploadFile(fileName: "test.txt", data:Data("Hello World".utf8))]
        
        let response: GenerationResponse = try client.postFilesWithRequest(request:request, files:files)

        Inspect.printDump(response)

        // XCTAssertEqual(response.fileName, "test.txt")
        // XCTAssertEqual(String(data: response.fileBytes!, encoding: .utf8), "Hello World")
    }
}
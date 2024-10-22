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

        do {
            let request = SpeechToText()
            request.tag = "ztag"
            request.refId = "zid"

            let files = [UploadFile(fileName: "test.txt", data:Data("Hello World".utf8), fieldName:"audio")]
            
            let response: GenerationResponse = try client.postFilesWithRequest(request:request, files:files)
            let r = response.textOutputs

            Inspect.printDump(response)
            
            #expect(r[0].text == "audio, Audio 11, test.txt, text/plain")
            #expect(r[1].text == "Tag ztag")
            #expect(r[2].text == "RefId zid")

        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Can_Post_file_with_Request_Async() async throws {

        do {
            let request = SpeechToText()
            request.tag = "ztag"
            request.refId = "zid"

            let files = [UploadFile(fileName: "test.txt", data:Data("Hello World".utf8), fieldName:"audio")]
            
            let response: GenerationResponse = try await client.postFilesWithRequestAsync(request:request, files:files)
            let r = response.textOutputs

            Inspect.printDump(response)
            
            #expect(r[0].text == "audio, Audio 11, test.txt, text/plain")
            #expect(r[1].text == "Tag ztag")
            #expect(r[2].text == "RefId zid")

        } catch {
            Issue.record("Error: \(error)")
        }
    }
    
    @Test func Can_Post_Multiple_files_with_Request() throws {

        do {
            let request = TestFileUploads()
            request.id = 1
            request.refId = "zid"

            let files = [
                UploadFile(fileName: "test.txt", data:Data("Hello World".utf8), fieldName:"audio"),
                UploadFile(fileName: "test.md", data:Data("## Heading".utf8), fieldName:"content"),
            ]
            
            let r: TestFileUploadsResponse = try client.postFilesWithRequest(request:request, files:files)
            Inspect.printDump(r)
            
            #expect(r.id == 1)
            #expect(r.refId == "zid")
            #expect(r.files.count == files.count)
            #expect(r.files[0].name == "audio")
            #expect(r.files[0].fileName == "test.txt")
            #expect(r.files[0].contentLength == "Hello World".count)
            #expect(r.files[0].contentType == "text/plain")
            #expect(r.files[1].name == "content")
            #expect(r.files[1].fileName == "test.md")
            #expect(r.files[1].contentLength == "## Heading".count)
            #expect(r.files[1].contentType == "text/markdown")
        } catch {
            Issue.record("Error: \(error)")
        }
    }
    
    @Test func Can_Post_Multiple_files_with_Request_Async() async throws {

        do {
            let request = TestFileUploads()
            request.id = 1
            request.refId = "zid"

            let files = [
                UploadFile(fileName: "test.txt", data:Data("Hello World".utf8), fieldName:"audio"),
                UploadFile(fileName: "test.md", data:Data("## Heading".utf8), fieldName:"content"),
            ]
            
            let r: TestFileUploadsResponse = try await client.postFilesWithRequestAsync(request:request, files:files)
            Inspect.printDump(r)
            
            #expect(r.id == 1)
            #expect(r.refId == "zid")
            #expect(r.files.count == files.count)
            #expect(r.files[0].name == "audio")
            #expect(r.files[0].fileName == "test.txt")
            #expect(r.files[0].contentLength == "Hello World".count)
            #expect(r.files[0].contentType == "text/plain")
            #expect(r.files[1].name == "content")
            #expect(r.files[1].fileName == "test.md")
            #expect(r.files[1].contentLength == "## Heading".count)
            #expect(r.files[1].contentType == "text/markdown")
        } catch {
            Issue.record("Error: \(error)")
        }
    }


}

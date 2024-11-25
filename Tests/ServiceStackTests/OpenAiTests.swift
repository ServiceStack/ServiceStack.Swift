
//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import ServiceStack

func createAiServerClient() -> JsonServiceClient {
    guard let apiKey = ProcessInfo.processInfo.environment["AI_SERVER_API_KEY"] else {
        Issue.record("Environment variables AI_SERVER_URL and AI_SERVER_API_KEY must be set")
        assert(false, "throw")
    }

    let client = JsonServiceClient(baseUrl: "https://openai.servicestack.net")
    client.bearerToken = apiKey
    return client
}

final class OpenAiTests : @unchecked Sendable {
    
    @Test func Can_call_AiServer_Chat() async throws {
        let client = createAiServerClient()
        let request = OpenAiChatCompletion()
        request.model = "llama3.1:8b"
        let msg =  OpenAiMessage()
        msg.role = "user"
        msg.content = "What's the capital of France?"
        request.messages = [msg]
        request.max_tokens = 50
 
        let result = try await client.sendAsync(request)

        #expect(result.choices.count == 1)
        #expect(result.choices[0].message?.content?.contains("Paris") == true)
    }

    @Test func Does_SpeechToText() async throws {
        let client = createAiServerClient()

        guard let audioURL = Bundle.module.url(forResource: "test_audio.wav",
                                             withExtension: nil) else {
            assert(false, "Unable to find test audio file in test bundle")
        }

        let request = SpeechToText()
        let audioData = try Data(contentsOf: audioURL)
        let file = UploadFile(fileName: "test_audio.wav", data:audioData, fieldName:"audio")
        
        let response: TextGenerationResponse = try await client.postFileWithRequestAsync(request:request, file:file)

        #expect(response.results![0].text!.contains("thermodynamics"))
    }

}

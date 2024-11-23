
//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import ServiceStack

final class OllamaTests : @unchecked Sendable {
    
    @Test func Can_call_AiServer_Chat() async throws {
        let client = JsonServiceClient(baseUrl: "https://openai.servicestack.net")
        client.bearerToken =  ProcessInfo.processInfo.environment["AI_SERVER_API_KEY"]
        let request = OpenAiChatCompletion()
        request.model = "llama3.1:8b"
        let msg =  OpenAiMessage()
        msg.role = "user"
        msg.content = "What's the capital of France?"
        request.messages = [msg]
        request.max_tokens = 50
 
        let result = try await client.sendAsync(request)

        #expect(result.choices!.count == 1)
        #expect(result.choices![0].message?.content?.contains("Paris") == true)
    }

    @Test func Can_call_Ollama_Chat() async throws {
        let client = JsonServiceClient(baseUrl: "https://supermicro.pvq.app")
        let request = OpenAiChatCompletion()
        // request.model = "mixtral:8x22b"
        request.model = "llama3.1:8b"
        let msg =  OpenAiMessage()
        msg.role = "user"
        msg.content = "What's the capital of France?"
        request.messages = [msg]
        request.max_tokens = 50
 
        let result:OpenAiChatResponse = try await client.postAsync(
            "/v1/chat/completions", request:request)

        #expect(result.choices!.count == 1)
        #expect(result.choices![0].message?.content?.contains("Paris") == true)
    }

}

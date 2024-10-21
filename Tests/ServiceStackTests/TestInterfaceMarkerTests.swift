//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import ServiceStack

class TestInterfaceMarkerTests : @unchecked Sendable {
    var client: JsonServiceClient!
    
    init() async throws {
        print("TestInterfaceMarkerTests.init()")
        client = JsonServiceClient(baseUrl: "https://test.servicestack.net")
    }

    @Test func Does_SendDefault_as_POST() {
        let request = SendDefault()
        request.id = 1

        do {
            let response = try client.send(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Post)
            #expect(response.pathInfo! == "/api/SendDefault")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Does_SendDefault_as_POST_Async() async {
        let request = SendDefault()
        request.id = 1

        do {
            let response = try await client.sendAsync(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Post)
            #expect(response.pathInfo! == "/api/SendDefault")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Does_SendRestGet_as_GET_using_Predefined_Route() {
        let request = SendRestGet()
        request.id = 1

        do {
            let response = try client.send(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Get)
            #expect(response.pathInfo! == "/api/SendRestGet")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Does_SendRestGet_as_GET_using_Predefined_Route_Async() async {
        let request = SendRestGet()
        request.id = 1

        do {
            let response = try await client.sendAsync(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Get)
            #expect(response.pathInfo! == "/api/SendRestGet")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Does_SendGet_as_GET() {
        let request = SendGet()
        request.id = 1

        do {
            let response = try client.send(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Get)
            #expect(response.pathInfo! == "/api/SendGet")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Does_SendGet_as_GET_Async() async {
        let request = SendGet()
        request.id = 1

        do {
            let response = try await client.sendAsync(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Get)
            #expect(response.pathInfo! == "/api/SendGet")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Does_SendPost_as_POST() {
        let request = SendPost()
        request.id = 1

        do {
            let response = try client.send(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Post)
            #expect(response.pathInfo! == "/api/SendPost")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Does_SendPost_as_POST_Async() async {
        let request = SendPost()
        request.id = 1

        do {
            let response = try await client.sendAsync(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Post)
            #expect(response.pathInfo! == "/api/SendPost")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Does_SendPut_as_PUT() {
        let request = SendPut()
        request.id = 1

        do {
            let response = try client.send(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Put)
            #expect(response.pathInfo! == "/api/SendPut")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Does_SendPut_as_PUT_Async() async {
        let request = SendPut()
        request.id = 1

        do {
            let response = try await client.sendAsync(request)
            #expect(response.id! == 1)
            #expect(response.requestMethod! == HttpMethods.Put)
            #expect(response.pathInfo! == "/api/SendPut")
        } catch {
            Issue.record("Error: \(error)")
        }
    }
}

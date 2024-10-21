//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import ServiceStack

final class BasicHttpTests : @unchecked Sendable {
    
    init() async throws {
        print("AsyncHttpTests.init()")
    }

    deinit {
        print("AsyncHttpTests.deinit")
    }

    func fetchData(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }

    @Test func testFetchDataSuccess() async throws {
        // Given
        let urlString = "https://jsonplaceholder.typicode.com/todos/1" // Example API that returns JSON

        let data = try await fetchData(from: urlString)
        #expect(data != nil)
        
        // Optional: Parse the JSON and make more specific assertions
        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            #expect(json["id"] != nil)
            #expect(json["title"] != nil)
        } else {
            Issue.record("JSON parsing failed")
        }
    }

    @Test func syncFetchData() throws {
        let urlString = "https://jsonplaceholder.typicode.com/todos/1"

        if let url = URL(string: urlString) {
            do {
                let contents = try String(contentsOf: url, encoding: .utf8)
                print(contents)
            } catch {
                print("*** Contents could not be loaded from" + urlString + ".")
            }
        } else {
            print("*** Bad URL:" + urlString + ".")
        }
    }
}

//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import ServiceStack

struct GitHubRepo : Codable {
  let name: String
  let description: String?
  let language: String?
  let watchers: Int
  let forks: Int
}

@Suite struct InspectSwiftTests {

    @Test func testInspect() async throws {
        let orgName = "ServiceStack"

        print("downloading orgRepos...")
        if let url = URL(string: "https://api.github.com/orgs/\(orgName)/repos") {
            let (data,_) = try await URLSession.shared.data(from: url)
            do {
                let orgRepos = try JSONDecoder().decode([GitHubRepo].self, from: data)
                    .sorted { $0.watchers > $1.watchers }

                print("Top 3 \(orgName) GitHub Repos:")
                Inspect.printDump(Array(orgRepos.prefix(3)))

                print("\nTop 10 \(orgName) GitHub Repos:")
                Inspect.printDumpTable(Array(orgRepos.prefix(10)), 
                    columns:["name","language","watchers","forks"])

                Inspect.vars(["orgRepos":orgRepos])

            } catch let error {
                print(error)
            }
        }
    }
}

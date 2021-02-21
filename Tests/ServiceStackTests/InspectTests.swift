import XCTest
import Foundation

@testable import ServiceStack

struct GitHubRepo : Codable {
  let name: String
  let description: String?
  let language: String?
  let watchers: Int
  let forks: Int
}

final class InspectSwiftTests: XCTestCase {

    func testInspect() {
        let asyncTest = expectation(description: "asyncTest")

        let orgName = "apple"

        print("downloading orgRepos...")
        if let url = URL(string: "https://api.github.com/orgs/\(orgName)/repos") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        defer { asyncTest.fulfill() }

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
            }.resume()
        }

        waitForExpectations(timeout: 5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

    static var allTests = [
        ("testInspect", testInspect),
    ]
}
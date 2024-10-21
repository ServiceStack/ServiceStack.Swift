//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import ServiceStack

final class ServiceClientTechStacksTests : @unchecked Sendable {
    var client: JsonServiceClient!
    
    init() async throws {
        print("JsonServiceClientTests.init()")
        client = JsonServiceClient(baseUrl: "https://techstacks.io")
    }

    @Test func Can_GET_TechStacks_Overview() {
        do {
            let response = try client.get(Overview())
            assertOverviewResponse(response)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Can_GET_TechStacks_Overview_Aync() async throws {
        do {
            let r:OverviewResponse = try await client.getAsync(Overview())
            assertOverviewResponse(r)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Can_GET_TechStacks_Overview_with_relative_url() {
        do {
            let response: OverviewResponse = try client.get("/overview")
            assertOverviewResponse(response)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Can_GET_TechStacks_Overview_with_absolute_url() {
        do {
            let response: OverviewResponse = try client.get("https://techstacks.io/overview")
            assertOverviewResponse(response)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Can_GET_GetTechnology_with_params() {
        do {
            let requestDto = GetTechnology()
            requestDto.slug = "servicestack"
            let response = try client.get(requestDto)
            assertGetTechnologyResponse(response)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Can_GET_GetTechnology_with_params_Async() async throws {
        let requestDto = GetTechnology()
        requestDto.slug = "servicestack"

        let r:GetTechnologyResponse = try await client.getAsync(requestDto)
        assertGetTechnologyResponse(r)
    }

    @Test func Can_GET_GetTechnology_with_url() {
        do {
            let response: GetTechnologyResponse = try client.get("/technology/servicestack")
            assertGetTechnologyResponse(response)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Can_call_FindTechnologies_AutoQuery_Service() throws {
        let request = FindTechnologies()
        request.name = "ServiceStack"

        let response = try client.get(request)

        #expect(response.results.count == 1)
    }

    @Test func Can_call_FindTechnologies_AutoQuery_Service_Async() async throws {
        let request = FindTechnologies()
        request.name = "ServiceStack"

        let r = try await client.getAsync(request)
        #expect(r.results.count == 1)
    }

    @Test func Can_call_FindTechnologies_AutoQuery_Implicit_Service() throws {
        let request = FindTechnologies()
        request.take = 5

        let response = try client.get(request, query: ["DescriptionContains": "framework"])

        #expect(response.results.count == 5)
    }

    /*
     * TEST HELPERS
     */

    func assertGetTechnologyResponse(_ r: GetTechnologyResponse) {
        #expect(r != nil)
        #expect(r.technology!.name! == "ServiceStack")
        #expect(r.technologyStacks.count > 0)
    }

    func assertOverviewResponse(_ r: OverviewResponse) {
        #expect(r != nil)
        #expect(r.topUsers.count > 0)
        #expect(r.topTechnologies.count > 0)
        #expect(r.latestTechStacks.count > 0)
        #expect(r.latestTechStacks[0].technologyChoices.count > 0)
        #expect(r.topTechnologiesByTier.count > 0)
    }
}

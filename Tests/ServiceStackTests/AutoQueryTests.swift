//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import ServiceStack

final class AutoQueryTests : @unchecked Sendable {
    var client: JsonServiceClient!
    
    init() async throws {
        client = JsonServiceClient(baseUrl: "https://techstacks.io")
        print("JsonServiceClient.init()")
    }

    @Test func Can_call_empty_FindTechnologies() {
        let request = FindTechnologies()

        do {
            let response = try client.get(request)

            #expect(response.total == 0)
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Can_call_query_FindTechnologies_VendorName() {
        let request = FindTechnologies()
        request.vendorName = "Google"
        request.take = 3
        request.orderByDesc = "ViewCount"
        request.fields = "Id,Name,VendorName,Tier,ProductUrl"

        do {
            let response = try client.get(request)
            
//            Inspect.printDump(response)
            #expect(response.total! >= 20 && response.total! < 30)
            #expect(response.results.count == 3)
            let names = response.results.map { $0.name! }.joined(separator: ",")
            #expect(names == "AngularJS,Go,Protocol Buffers")
            let ids = response.results.map { "\($0.id!)" }.joined(separator: ",")
            #expect(ids == "7,18,77")
            let tiers = response.results.map { "\($0.tier!)" }.joined(separator: ",")
            #expect(tiers == "Client,ProgrammingLanguage,Server")
        } catch {
            Issue.record("Error: \(error)")
        }
    }

    @Test func Can_call_FindTechnologies_ServiceStack() {
        let request = FindTechnologies()
        request.name = "ServiceStack"

        do {
            let response = try client.get(request)

            #expect(response.total == 1)
            let dto = response.results[0]
            #expect(dto.id == 1)
            #expect(dto.name == "ServiceStack")
            #expect(dto.slug == "servicestack")
            #expect(dto.logoApproved == true)
            #expect(dto.isLocked == false)
            #expect(dto.tier == TechnologyTier.Server)
        } catch {
            Issue.record("Error: \(error)")
        }
    }    
}

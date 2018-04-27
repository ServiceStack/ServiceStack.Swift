#if false
//
//  TestDtosJsonTests.swift
//  ServiceStackClientTests
//
//  Created by Demis Bellot on 1/28/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import XCTest
@testable import ServiceStackClient

class TechStacksDtosJsonTests: XCTestCase {
    
    func test_Can_serialize_Empty_Technology() {
        var dto = Technology()

        var json = dto.toJson()

        println(json)

        XCTAssertEqual(json,
            "{\"id\":null,\"name\":null,\"vendorName\":null,\"vendorUrl\":null,\"productUrl\":null,\"logoUrl\":null,\"description\":null,\"created\":null,\"createdBy\":null,\"lastModified\":null,\"lastModifiedBy\":null,\"ownerId\":null,\"slug\":null,\"logoApproved\":null,\"isLocked\":null,\"tier\":null,\"lastStatusUpdate\":null}")
    }

    func test_Can_serialize_Full_Technology() {
        var dto = Technology()
        dto.id = 1
        dto.name = "name"
        dto.vendorName = "vendorName"
        dto.vendorUrl = "vendorUrl"
        dto.productUrl = "productUrl"
        dto.logoUrl = "logoUrl"
        dto.description = "description"
        dto.created = "created"
        dto.createdBy = "createdBy"
        dto.lastModified = "lastModified"
        dto.lastModifiedBy = "lastModifiedBy"
        dto.ownerId = "ownerId"
        dto.slug = "slug"
        dto.logoApproved = true
        dto.isLocked = false
        dto.tier = TechnologyTier.ProgrammingLanguage
        dto.lastStatusUpdate = "lastStatusUpdate"


        var json = dto.toJson()

        println(json)

        XCTAssertEqual(json,
            "{\"id\":1,\"name\":\"name\",\"vendorName\":\"vendorName\",\"vendorUrl\":\"vendorUrl\",\"productUrl\":\"productUrl\",\"logoUrl\":\"logoUrl\",\"description\":\"description\",\"created\":\"created\",\"createdBy\":\"createdBy\",\"lastModified\":\"lastModified\",\"lastModifiedBy\":\"lastModifiedBy\",\"ownerId\":\"ownerId\",\"slug\":\"slug\",\"logoApproved\":true,\"isLocked\":false,\"tier\":\"ProgrammingLanguage\",\"lastStatusUpdate\":\"lastStatusUpdate\"}")
        
    }
}

#endif

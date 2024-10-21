//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
@testable import ServiceStack

class TechStacksDtosJsonTests {
    
    @Test func Can_serialize_Empty_Technology() {
        let dto = Technology()

        let json = toJson(dto)

        print(json!)

        #expect(json == "{}")
    }

    @Test func Can_serialize_Full_Technology() {
//        let date:Date = Date(year: 2001, month: 1, day: 1)
        let date:Date? = nil
        let dto = Technology()
        dto.id = 1
        dto.name = "name"
        dto.vendorName = "vendorName"
        dto.vendorUrl = "vendorUrl"
        dto.productUrl = "productUrl"
        dto.logoUrl = "logoUrl"
        dto.Description = "description"
        dto.created = date
        dto.createdBy = "createdBy"
        dto.lastModified = date
        dto.lastModifiedBy = "lastModifiedBy"
        dto.ownerId = "ownerId"
        dto.slug = "slug"
        dto.logoApproved = true
        dto.isLocked = false
        dto.tier = TechnologyTier.ProgrammingLanguage
        dto.lastStatusUpdate = date

        let json = toJson(dto)

        print(json!)

        let obj = fromJson(Technology.self, json!)!

        #expect(obj.id == dto.id)
        #expect(obj.name == dto.name)
        #expect(obj.vendorName == dto.vendorName)
        #expect(obj.vendorUrl == dto.vendorUrl)
        #expect(obj.productUrl == dto.productUrl)
        #expect(obj.logoUrl == dto.logoUrl)
        #expect(obj.Description == dto.Description)
        #expect(obj.created == dto.created)
        #expect(obj.createdBy == dto.createdBy)
        #expect(obj.lastModified == dto.lastModified)
        #expect(obj.lastModifiedBy == dto.lastModifiedBy)
        #expect(obj.ownerId == dto.ownerId)
        #expect(obj.slug == dto.slug)
        #expect(obj.logoApproved == dto.logoApproved)
        #expect(obj.isLocked == dto.isLocked)
        #expect(obj.tier == dto.tier)
        #expect(obj.lastStatusUpdate == dto.lastStatusUpdate)
    }
}

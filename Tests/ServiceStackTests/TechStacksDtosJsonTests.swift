@testable import ServiceStack
import XCTest

class TechStacksDtosJsonTests: XCTestCase {
    func test_Can_serialize_Empty_Technology() {
        let dto = Technology()

        let json = toJson(dto)

        print(json!)

        XCTAssertEqual(json,"{}")
    }

    func test_Can_serialize_Full_Technology() {
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

        XCTAssertEqual(json, "{\"id\":1,\"productUrl\":\"productUrl\",\"Description\":\"description\",\"logoApproved\":true,\"tier\":\"ProgrammingLanguage\",\"logoUrl\":\"logoUrl\",\"vendorName\":\"vendorName\",\"ownerId\":\"ownerId\",\"createdBy\":\"createdBy\",\"slug\":\"slug\",\"isLocked\":false,\"vendorUrl\":\"vendorUrl\",\"lastModifiedBy\":\"lastModifiedBy\",\"name\":\"name\"}")
    }
}

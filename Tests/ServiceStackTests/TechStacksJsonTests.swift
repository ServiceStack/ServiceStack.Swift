//  Copyright (c) 2013-present ServiceStack, Inc. All rights reserved.
//  Created by Demis Bellot

import Testing
import Foundation
#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif
import ServiceStack

final class TechStacksJsonTests : @unchecked Sendable {
    var client: JsonServiceClient!
    
    init() async throws {
        print("TechStacksJsonTests.init()")
        client = JsonServiceClient(baseUrl: "https://techstacks.io")
    }

    @Test func Can_serialize_Empty_Option() {
        let dto = Option()

        let json = toJson(dto)

        print(json!)

        #expect(json == "{}")
    }

    @Test func Can_deserialize_Empty_Option() {
        let json = "{\"name\":null,\"title\":null,\"value\":null}"

        let dto = fromJson(Option.self, json)!

        #expect(dto.name == nil)
        #expect(dto.title == nil)
        //        #expect(dto.name)
    }

    @Test func Can_deserialize_Full_Option() {
        let json = "{\"name\":\"name\",\"title\":\"title\",\"value\":\"ProgrammingLanguage\"}"

        let dto = fromJson(Option.self, json)!

        #expect(dto.name! == "name")
        #expect(dto.title! == "title")
    //        #expect(dto.value!, TechnologyTier.ProgrammingLanguage)
    }

    @Test func Can_serialize_Full_Option() {
        let dto = Option()
        dto.name = "name"
        dto.title = "title"
        dto.value = TechnologyTier.ProgrammingLanguage

        let json = toJson(dto)

        print(json!)

        let obj = fromJson(Option.self, json!)!

        #expect(obj.name == dto.name)
        #expect(obj.title == dto.title)
        #expect(obj.value == dto.value)
    }

    //    topTechnologiesByTier:[TechnologyTier:[TechnologyInfo]]

    @Test func Can_deserialize_Overview() {
        let bundle = Bundle(for: TechStacksJsonTests.self)
        let path = bundle.path(forResource: "overview", ofType: "json")
        if path == nil { return } // when run from `swift test`
        let bytes = NSData(contentsOfFile: path!)
        let json = NSString(data: bytes! as Data, encoding: String.Encoding.utf8.rawValue)

        let dto = fromJson(OverviewResponse.self, json! as String)!

        #expect(dto.topUsers.count == 6)
        #expect(dto.topUsers[0].userName! == "demisbellot")
        #expect(dto.topUsers[0].avatarUrl! == "http:\\/\\/pbs.twimg.com\\/profile_images\\/1765666853\\/image1326949938_normal.png")
        #expect(dto.topUsers[0].stacksCount! == 61)

        #expect(dto.topTechnologies.count == 20)
        #expect(dto.topTechnologies[0].tier! == TechnologyTier.Data)
        #expect(dto.topTechnologies[0].slug! == "redis")
        #expect(dto.topTechnologies[0].name! == "Redis")
        #expect(dto.topTechnologies[0].logoUrl! == "https://raw.githubusercontent.com/ServiceStack/Assets/master/img/livedemos/techstacks/redis-logo.png")
        #expect(dto.topTechnologies[0].stacksCount! == 35)

        let latestStacks = dto.latestTechStacks
        #expect(latestStacks.count == 20)

        let techstacks = latestStacks[0]
        #expect(techstacks.id! == 1)
        #expect(techstacks.name! == "TechStacks Website")
        #expect(techstacks.vendorName! == "ServiceStack")
        #expect(techstacks.Description!.hasPrefix("This Website! ") == true)
        #expect(techstacks.appUrl! == "http://techstacks.io")
        #expect(techstacks.screenshotUrl! == "https://raw.githubusercontent.com/ServiceStack/Assets/master/img/livedemos/techstacks/screenshots/techstacks.png")
        #expect(techstacks.created! == Date.fromIsoDateString("2015-01-01T17:33:58.9892560")!)
        #expect(techstacks.createdBy! == "layoric")
        #expect(techstacks.lastModified! == Date.fromIsoDateString("2015-01-12T23:34:12.4516410")!)
        #expect(techstacks.lastModifiedBy! == "layoric")
        #expect(techstacks.isLocked! == true)
        #expect(techstacks.ownerId! == "2")
        #expect(techstacks.slug! == "techstacks-website")
        #expect(techstacks.lastStatusUpdate! == Date.fromIsoDateString("2015-01-12T23:34:12.4516410")!)

        let techstackChoices = techstacks.technologyChoices
        #expect(techstackChoices.count == 10)
        #expect(techstackChoices[0].technologyId! == 1)
        #expect(techstackChoices[0].technologyStackId! == 1)
        #expect(techstackChoices[0].id! == 2)
        #expect(techstackChoices[0].name! == "ServiceStack")
        #expect(techstackChoices[0].vendorName! == "Service Stack")
        #expect(techstackChoices[0].vendorUrl! == "https://servicestack.net")
        #expect(techstackChoices[0].productUrl! == "https://servicestack.net")
        #expect(techstackChoices[0].logoUrl! == "https://raw.githubusercontent.com/ServiceStack/Assets/master/img/livedemos/techstacks/servicestack-logo.png")
        #expect(techstackChoices[0].created! == Date.fromIsoDateString("2014-12-28T08:49:20.9542550")!)
        #expect(techstackChoices[0].createdBy! == "demisbellot")
        #expect(techstackChoices[0].lastModified! == Date.fromIsoDateString("2014-12-28T08:49:20.9542550")!)
        #expect(techstackChoices[0].lastModifiedBy! == "demisbellot")
        #expect(techstackChoices[0].ownerId! == "1")
        #expect(techstackChoices[0].slug! == "servicestack")
        #expect(techstackChoices[0].logoApproved! == true)
        #expect(techstackChoices[0].isLocked! == false)
        #expect(techstackChoices[0].tier! == TechnologyTier.Server)

        #expect(dto.topTechnologiesByTier.count == 9)
        let langs = dto.topTechnologiesByTier["ProgrammingLanguage"]!
        #expect(langs.count == 3)
        #expect(langs[0].tier! == TechnologyTier.ProgrammingLanguage)
        #expect(langs[0].slug! == "python")
        #expect(langs[0].name! == "Python")
        #expect(langs[0].logoUrl! == "https://raw.githubusercontent.com/ServiceStack/Assets/master/img/livedemos/techstacks/python-logo.png")
        #expect(langs[0].stacksCount! == 25)

    //        let toJson = dto.toJson()
    //        println(toJson)
    }
}

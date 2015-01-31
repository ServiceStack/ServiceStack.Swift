 //
//  TechStacksJsonTests.swift
//  ServiceStackClientTests
//
//  Created by Demis Bellot on 1/26/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import XCTest


class TechStacksJsonTests: XCTestCase
{
    func test_Can_serialize_Empty_Option() {
        var dto = Option()
        
        var json = Option.reflect().toJson(dto)
        
        println(json)
        
        XCTAssertEqual(json,
            "{\"name\":null,\"title\":null,\"value\":null}")
    }
    
    func test_Can_deserialize_Empty_Option() {
        let json = "{\"name\":null,\"title\":null,\"value\":null}"
        
        var dto = Option.fromJson(json)!
        
        XCTAssertNil(dto.name)
        XCTAssertNil(dto.title)
        //        XCTAssertEqual(dto.name)
    }
    
    
    func test_Can_deserialize_Full_Option() {
        let json = "{\"name\":\"name\",\"title\":\"title\",\"value\":\"ProgrammingLanguage\"}"
        
        var dto = Option.fromJson(json)!
        
        XCTAssertEqual(dto.name!, "name")
        XCTAssertEqual(dto.title!, "title")
//        XCTAssertEqual(dto.value!, TechnologyTier.ProgrammingLanguage)
    }
    
    func test_Can_serialize_Full_Option() {
        var dto = Option()
        dto.name = "name"
        dto.title = "title"
        dto.value = TechnologyTier.ProgrammingLanguage
        
        var json = Option.reflect().toJson(dto)
        
        println(json)
        
        XCTAssertEqual(json,
            "{\"name\":\"name\",\"title\":\"title\",\"value\":\"ProgrammingLanguage\"}")
    }

//    topTechnologiesByTier:[TechnologyTier:[TechnologyInfo]]
    
    func test_Can_deserialize_Overview() {
        let bundle = NSBundle(forClass: TechStacksJsonTests.self)
        let path = bundle.pathForResource("overview", ofType: "json")
        let bytes = NSData(contentsOfFile: path!)
        let json = NSString(data: bytes!, encoding: NSUTF8StringEncoding)
        
        let dto = OverviewResponse.fromJson(json!)!
        
        XCTAssertEqual(dto.topUsers.count, 6)
        XCTAssertEqual(dto.topUsers[0].userName!, "demisbellot")
        XCTAssertEqual(dto.topUsers[0].avatarUrl!, "http:\\/\\/pbs.twimg.com\\/profile_images\\/1765666853\\/image1326949938_normal.png")
        XCTAssertEqual(dto.topUsers[0].stacksCount!, 61)
        
        
        XCTAssertEqual(dto.topTechnologies.count, 20)
        XCTAssertEqual(dto.topTechnologies[0].tier!, TechnologyTier.Data)
        XCTAssertEqual(dto.topTechnologies[0].slug!, "redis")
        XCTAssertEqual(dto.topTechnologies[0].name!, "Redis")
        XCTAssertEqual(dto.topTechnologies[0].logoUrl!, "https://raw.githubusercontent.com/ServiceStack/Assets/master/img/livedemos/techstacks/redis-logo.png")
        XCTAssertEqual(dto.topTechnologies[0].stacksCount!, 35)
        
        
        let latestStacks = dto.latestTechStacks
        XCTAssertEqual(latestStacks.count, 20)

        let techstacks = latestStacks[0]
        XCTAssertEqual(techstacks.id!, Int64(1))
        XCTAssertEqual(techstacks.name!, "TechStacks Website")
        XCTAssertEqual(techstacks.vendorName!, "ServiceStack")
        XCTAssertTrue(techstacks.description!.hasPrefix("This Website! "))
        XCTAssertEqual(techstacks.appUrl!, "http://techstacks.io")
        XCTAssertEqual(techstacks.screenshotUrl!, "https://raw.githubusercontent.com/ServiceStack/Assets/master/img/livedemos/techstacks/screenshots/techstacks.png")
        XCTAssertEqual(techstacks.created!, "2015-01-01T17:33:58.9892560")
        XCTAssertEqual(techstacks.createdBy!, "layoric")
        XCTAssertEqual(techstacks.lastModified!, "2015-01-12T23:34:12.4516410")
        XCTAssertEqual(techstacks.lastModifiedBy!, "layoric")
        XCTAssertEqual(techstacks.isLocked!, true)
        XCTAssertEqual(techstacks.ownerId!, "2")
        XCTAssertEqual(techstacks.slug!, "techstacks-website")
        XCTAssertEqual(techstacks.lastStatusUpdate!, "2015-01-12T23:34:12.4516410")

        let techstackChoices = techstacks.technologyChoices
        XCTAssertEqual(techstackChoices.count, 10)
        XCTAssertEqual(techstackChoices[0].technologyId!, Int64(1))
        XCTAssertEqual(techstackChoices[0].technologyStackId!, Int64(1))
        XCTAssertEqual(techstackChoices[0].id!, Int64(2))
        XCTAssertEqual(techstackChoices[0].name!, "ServiceStack")
        XCTAssertEqual(techstackChoices[0].vendorName!, "Service Stack")
        XCTAssertEqual(techstackChoices[0].vendorUrl!, "https://servicestack.net")
        XCTAssertEqual(techstackChoices[0].productUrl!, "https://servicestack.net")
        XCTAssertEqual(techstackChoices[0].logoUrl!, "https://raw.githubusercontent.com/ServiceStack/Assets/master/img/livedemos/techstacks/servicestack-logo.png")
        XCTAssertEqual(techstackChoices[0].created!, "2014-12-28T08:49:20.9542550")
        XCTAssertEqual(techstackChoices[0].createdBy!, "demisbellot")
        XCTAssertEqual(techstackChoices[0].lastModified!, "2014-12-28T08:49:20.9542550")
        XCTAssertEqual(techstackChoices[0].lastModifiedBy!, "demisbellot")
        XCTAssertEqual(techstackChoices[0].ownerId!, "1")
        XCTAssertEqual(techstackChoices[0].slug!, "servicestack")
        XCTAssertEqual(techstackChoices[0].logoApproved!, true)
        XCTAssertEqual(techstackChoices[0].isLocked!, false)
        XCTAssertEqual(techstackChoices[0].tier!, TechnologyTier.Server)
        
        
        XCTAssertEqual(dto.topTechnologiesByTier.count, 9)
        let langs = dto.topTechnologiesByTier[TechnologyTier.ProgrammingLanguage]!
        XCTAssertEqual(langs.count, 3)
        XCTAssertEqual(langs[0].tier!, TechnologyTier.ProgrammingLanguage)
        XCTAssertEqual(langs[0].slug!, "python")
        XCTAssertEqual(langs[0].name!, "Python")
        XCTAssertEqual(langs[0].logoUrl!, "https://raw.githubusercontent.com/ServiceStack/Assets/master/img/livedemos/techstacks/python-logo.png")
        XCTAssertEqual(langs[0].stacksCount!, 25)
        
        let toJson = dto.toJson()
        println(toJson)
    }
}

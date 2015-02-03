//
//  AppData.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/3/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import Foundation


public class AppData : NSObject
{
    var client = JsonServiceClient(baseUrl: "http://techstacks.io")
    
    struct Property {
        static let TopTechnologies = "topTechnologies"
        static let AllTiers = "allTiers"
        static let AllTechnologies = "allTechnologies"
    }
    
    public dynamic var allTiers:[Option] = []
    
    public dynamic var overview:OverviewResponse = OverviewResponse()
    public dynamic var topUsers:[UserInfo] = []
    public dynamic var topTechnologies:[TechnologyInfo] = []
    public dynamic var latestTechStacks:[TechStackDetails] = []
    public var topTechnologiesByTier:[TechnologyTier:[TechnologyInfo]] = [:]
    
    public dynamic var allTechnologies:[Technology] = [Technology]()
    
    override init(){
        super.init()
        self.loadConfig()
        self.loadOverview()
    }
    
    func loadConfig() -> Promise<GetConfigResponse> {
        return client.getAsync(GetConfig())
            .then(body:{(r:GetConfigResponse) -> GetConfigResponse in
                var option = Option()
                option.title = "[ Top 50 Technologies ]"
                r.allTiers.insert(option, atIndex: 0)
                self.allTiers = r.allTiers
                return r
            })
    }
    
    func loadOverview() -> Promise<OverviewResponse> {
        return client.getAsync(Overview())
            .then(body:{(r:OverviewResponse) -> OverviewResponse in
                self.overview = r
                self.topUsers = r.topUsers
                self.topTechnologies = r.topTechnologies
                self.latestTechStacks = r.latestTechStacks
                self.topTechnologiesByTier = r.topTechnologiesByTier
                return r
            })
    }
    
    func loadAllTechnologies() -> Promise<GetAllTechnologiesResponse> {
        return client.getAsync(GetAllTechnologies())
            .then(body:{(r:GetAllTechnologiesResponse) -> GetAllTechnologiesResponse in
                self.allTechnologies = r.results
                return r
            })
    }
    
    public func observe(observer: NSObject, property:String) {
        self.addObserver(observer, forKeyPath: property, options: .New | .Old, context: &client)
    }
    
    public func unobserve(observer: NSObject, property:String) {
        self.removeObserver(observer, forKeyPath: property, context: &client)
    }
}

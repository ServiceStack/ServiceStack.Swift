//
//  AppData.swift
//  TechStacksDesktop
//
//  Created by Demis Bellot on 2/9/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public class AppData : NSObject
{
    var client = JsonServiceClient(baseUrl: "http://techstacks.io")
    
    struct Property {
        static let FilteredTechStacks = "filteredTechStacks"
        static let FilteredTechnologies = "filteredTechnologies"
    }
    
    public dynamic var search:String?
    public dynamic var filteredTechStacks:[TechnologyStack] = []
    public dynamic var filteredTechnologies:[Technology] = []
    
    public var autoQueryOperands = [
        ("=",  "%"),
        (">=", ">%"),
        (">",  "%>"),
        ("<=", "%<"),
        ("<",  "<%"),
        ("In", "%In"),
        ("Between", "%Between"),
        ("Starts With", "%StartsWith"),
        ("Contains", "%Contains"),
        ("Ends With", "%EndsWith"),
    ]
    
    lazy public var autoQueryOperandsMap:[String:String] = {
        var map = [String:String]()
        self.autoQueryOperands.map { map[$0] = $1 }
        return map
    }()
    
    func createAutoQueryParam(field:String, _ operand:String) -> String {
        let template = autoQueryOperandsMap[operand]!
        let mergedField = template.replace("%", withString:field)
        return mergedField
    }
    
    func searchTechStacks(query:String, field:String? = nil, operand:String? = nil) -> Promise<QueryResponse<TechnologyStack>> {
        self.search = query
        
        let queryString = query.count > 0 && field != nil && operand != nil
            ? [createAutoQueryParam(field!, operand!): query]
            : ["NameContains":query, "DescriptionContains":query]
        
        let request = FindTechStacks<TechnologyStack>()
        return client.getAsync(request, query:queryString)
            .then(body:{(r:QueryResponse<TechnologyStack>) -> QueryResponse<TechnologyStack> in
                self.filteredTechStacks = r.results
                return r
            })
    }
    
    func searchTechnologies(query:String, field:String? = nil, operand:String? = nil) -> Promise<QueryResponse<Technology>> {
        self.search = query

        let queryString = query.count > 0 && field != nil && operand != nil
            ? [createAutoQueryParam(field!, operand!): query]
            : ["NameContains":query, "DescriptionContains":query]
        
        let request = FindTechnologies<Technology>()
        return client.getAsync(request, query:queryString)
            .then(body:{(r:QueryResponse<Technology>) -> QueryResponse<Technology> in
                self.filteredTechnologies = r.results
                return r
            })
    }

    var observedProperties = [NSObject:[String]]()
    var ctx:AnyObject = 1
    
    public func observe(observer: NSObject, properties:[String]) {
        for property in properties {
            self.observe(observer, property: property)
        }
    }
    
    public func observe(observer: NSObject, property:String) {
        self.addObserver(observer, forKeyPath: property, options: .New | .Old, context: &ctx)
        
        var properties = observedProperties[observer] ?? [String]()
        properties.append(property)
        observedProperties[observer] = properties
    }
    
    public func unobserve(observer: NSObject) {
        if let properties = observedProperties[observer] {
            for property in properties {
                self.removeObserver(observer, forKeyPath: property, context: &ctx)
            }
        }
    }
}
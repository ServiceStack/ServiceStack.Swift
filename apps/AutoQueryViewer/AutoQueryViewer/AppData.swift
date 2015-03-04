//
//  AppData.swift
//  AutoQueryViewer
//
//  Created by Demis Bellot on 2/16/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

public class AppData : NSObject
{
    var client = JsonServiceClient(baseUrl: "http://servicestack.net")
    
    var imageCache:[String:UIImage] = [:]
 
    override init(){
        super.init()
        self.loadDefaultImageCaches()
    }

    func loadDefaultImageCaches() {
        imageCache = [:]
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(858, 689), false, 0.0)
        imageCache["blankScreenshot"] = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(40, 40), false, 0.0)
        imageCache["clearIcon"] = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        imageCache["database"] = UIImage(named: "database")
        imageCache["bg-alpha"] = UIImage(named: "bg-alpha")
    }
    
    public func loadAllImagesAsync(urls:[String]) -> Promise<[String:UIImage?]> {
        var images = [String:UIImage?]()
        return Promise<[String:UIImage?]> { (complete, reject) in
            for url in urls {
                self.loadImageAsync(url)
                    .then(body: { (img:UIImage?) -> Void in
                        images[url] = img
                        if images.count == urls.count {
                            return complete(images)
                        }
                    })
            }
        }
    }
    
    public func loadImageAsync(url:String) -> Promise<UIImage?> {
        if let image = imageCache[url] {
            return Promise<UIImage?> { (complete, reject) in complete(image) }
        }
        
        return client.getDataAsync(url)
            .then(body: { (data:NSData) -> UIImage? in
                if let image = UIImage(data:data) {
                    self.imageCache[url] = image
                    return image
                }
                return nil
            })
    }
    
    /* KVO Observable helpers */
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
    
    func resetCache() {
        loadDefaultImageCaches()
    }
}

func saveDefaultSetting(key:String, value:String) {
    NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
}
func getDefaultSetting(key:String) -> String? {
    return NSUserDefaults.standardUserDefaults().stringForKey(key)
}




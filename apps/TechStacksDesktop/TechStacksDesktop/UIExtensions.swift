//
//  UIExtensions.swift
//  TechStacksDesktop
//
//  Created by Demis Bellot on 2/9/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import AppKit
import Foundation

extension NSView
{
    var appData:AppData {
        return (NSApplication.sharedApplication().delegate as AppDelegate).appData
    }
}

extension NSViewController
{
    var appData:AppData {
        return (NSApplication.sharedApplication().delegate as AppDelegate).appData
    }
}

extension NSTableView
{
    func addTableColumns(properties: [PropertyType]) {
        for property in properties {
            var column = NSTableColumn(identifier: property.name)
            
            self.addTableColumn(column)
        }
    }
}

extension String {
    var titleCase:String {
        return String(self[0]).uppercaseString + self[1..<self.count]
    }
}

extension NSError {
    var responseStatus:ResponseStatus {
        var status:ResponseStatus = self.convertUserInfo() ?? ResponseStatus()
        if status.errorCode == nil {
            status.errorCode = self.code.toString()
        }
        if status.message == nil {
            status.message = self.localizedDescription
        }
        return status
    }
}
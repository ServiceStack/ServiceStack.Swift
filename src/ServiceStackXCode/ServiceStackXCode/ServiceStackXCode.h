//
//  ServiceStackXCode.h
//  ServiceStackXCode
//
//  Created by Darren Reid on 29/01/2015.
//  Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface ServiceStackXCode : NSObject

+ (instancetype)sharedPlugin;

- (BOOL)validateUpdateRefMenuItem:(NSMenuItem *)menuItem;

@property(nonatomic, strong, readonly) NSBundle *bundle;
@end
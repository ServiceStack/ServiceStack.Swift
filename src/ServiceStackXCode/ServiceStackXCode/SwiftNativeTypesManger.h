//
// Created by Darren Reid on 12/02/15.
// Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SwiftNativeTypesManger : NSObject
+ (void)updateFileContents:(NSString *)fileName;

+ (NSString *)generateUrlFromDtoFile:(NSString *)dtoCode;

+ (NSString *)extractBaseUrlFromDtoFile:(NSArray *)dtoCodeLines;

+ (NSDictionary *)getOptionValues:(NSArray *)dtoCodeLines;
@end
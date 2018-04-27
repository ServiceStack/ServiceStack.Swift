//
// Created by Darren Reid on 12/02/15.
// Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SwiftNativeTypesManger : NSObject
+ (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

+ (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

+ (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

+ (void)connectionDidFinishLoading:(NSURLConnection *)connection;

+ (void)updateFileContents:(NSString *)fileName;

+ (NSString *)generateUrlFromDtoFile:(NSString *)dtoCode;

+ (NSString *)extractBaseUrlFromDtoFile:(NSArray *)dtoCodeLines;

+ (NSDictionary *)getOptionValues:(NSArray *)dtoCodeLines;
@end
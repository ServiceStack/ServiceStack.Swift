//
//  ExtendNSString.m
//  ServiceStackXCode
//
//  Created by Darren Reid on 7/02/2015.
//  Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExtendNSString.h"

@implementation NSString (util)

- (int)indexOf:(NSString *)text {
    NSRange range = [self rangeOfString:text];
    if (range.length > 0) {
        return range.location;
    } else {
        return -1;
    }
}

- (NSArray *)split:(NSString *)splitOn {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    if ([self indexOf:splitOn] == -1) {
        return result;
    }
    NSString *firstPart = [self substringToIndex:[self indexOf:splitOn]];
    NSString *secondPart = [self substringFromIndex:[self indexOf:splitOn]];
    [result addObject:firstPart];
    result[1] = secondPart;
    NSArray *resultArray = [NSArray arrayWithArray:result];

    return resultArray;
}

@end
//
// Created by Darren Reid on 12/02/15.
// Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import "NSDocument+SSXSAdditions.h"
#import <DTXcodeUtils/DTXcodeHeaders.h>
#import "SwiftNativeTypesManger.h"
#import "ExtendNSString.h"#import "DTXcodeHeaders.h"
#import "DTXcodeUtils.h"


@implementation SwiftNativeTypesManger {

}

+ (void)updateFileContents:(NSString *)fileName {
    NSString *content = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSString *fullUpdateUrl = [self generateUrlFromDtoFile:content];
    NSURL *url = [NSURL URLWithString:fullUpdateUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error == nil) {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        // This is a reference to the current source code editor.
        DVTSourceTextView *sourceTextView = [DTXcodeUtils currentSourceTextView];
        [sourceTextView selectAll:nil];
        NSRange selectedTextRange = [sourceTextView selectedRange];
        NSString *selectedString = [sourceTextView.textStorage.string substringWithRange:selectedTextRange];
        if (selectedString) {
            [sourceTextView replaceCharactersInRange:selectedTextRange withString:responseString];
        }
    } else {
        //Handle error
    }
}

+ (NSString *)generateUrlFromDtoFile:(NSString *)dtoCode {
    // first, separate by new line
    NSArray *allLinedStrings =
            [dtoCode componentsSeparatedByCharactersInSet:
                    [NSCharacterSet newlineCharacterSet]];
    NSString *baseUrl = [self extractBaseUrlFromDtoFile:allLinedStrings];
    NSDictionary *allOptions = [self getOptionValues:allLinedStrings];
    NSString *result = nil;
    if ([baseUrl indexOf:@"/types/swift"] == -1) {
        result = [baseUrl stringByAppendingString:@"types/swift"];
    } else {
        result = [baseUrl copy];
    }
    int count = 0;
    for (id key in allOptions) {
        if (count == 0) {
            result = [result stringByAppendingString:@"?"];
        } else {
            result = [result stringByAppendingString:@"&"];
        }

        result = [result stringByAppendingString:key];
        result = [result stringByAppendingString:@"="];
        result = [result stringByAppendingString:allOptions[key]];
        count++;
    }

    return result;
}

+ (NSString *)extractBaseUrlFromDtoFile:(NSArray *)dtoCodeLines {
    NSString *result = nil;
    for (NSUInteger i = 0; i < dtoCodeLines.count; i++) {
        NSString *dtoLine = dtoCodeLines[i];
        dtoLine = [dtoLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([dtoLine hasPrefix:@"BaseUrl"]) {
            result = [[dtoLine substringFromIndex:8] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            break;
        }
    }

    if (![result hasSuffix:@"/"]) {
        result = [result stringByAppendingString:@"/"];
    }
    return result;
}

+ (NSDictionary *)getOptionValues:(NSArray *)dtoCodeLines {
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    NSUInteger optionsStart = 0;
    for (NSUInteger i = 0; i < dtoCodeLines.count; i++) {
        NSString *dtoLine = dtoCodeLines[i];
        dtoLine = [dtoLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if (i > 0 && [dtoLine length] == 0 && [dtoCodeLines[i - 1] length] == 0) {
            optionsStart = i + 1;
            break;
        }
    }

    for (NSUInteger optionIndex = optionsStart; optionIndex < dtoCodeLines.count; optionIndex++) {
        NSString *currentOption = dtoCodeLines[optionIndex];
        if ([currentOption indexOf:@"*/"] != -1) {
            break;
        }

        if ([currentOption hasPrefix:@"//"] || [currentOption indexOf:@":"] == -1) {
            continue;
        }

        NSString *key = [currentOption split:@":"][0];
        NSString *val = [currentOption split:@":"][1];
        result[key] = val;
    }
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithDictionary:result];
    return resultDictionary;
}

@end
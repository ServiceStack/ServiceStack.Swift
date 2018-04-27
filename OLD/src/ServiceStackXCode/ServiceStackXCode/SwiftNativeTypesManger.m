//
// Created by Darren Reid on 12/02/15.
// Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import "NSDocument+SSXSAdditions.h"
#import <DTXcodeUtils/DTXcodeHeaders.h>
#import "SwiftNativeTypesManger.h"
#import "ExtendNSString.h"
#import "DTXcodeUtils.h"


@implementation SwiftNativeTypesManger {

}

NSMutableData *receivedData;
NSHTTPURLResponse *httpUrlResponse;
NSError *responseError;
NSString *errorMessage;
DVTSourceTextView *sourceTextView;

+(void) connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    httpUrlResponse = (NSHTTPURLResponse *) response;
    [receivedData setLength:0];
}

+(void) connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
    if(receivedData == nil) {
        receivedData = [NSMutableData alloc];
    }
    [receivedData appendData:data];
}

+(void) connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
    responseError = error;

}

+(void) connectionDidFinishLoading:(NSURLConnection*)connection {
    NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    if (httpUrlResponse == nil) {
        if (responseError != nil) {
            NSInteger errorCode = responseError.code;
            NSAlert *alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"OK"];
            [alert setMessageText:[NSString stringWithFormat:@"Error updating ServiceStack Reference - %ld", (long)errorCode]];
            [alert setAlertStyle:NSWarningAlertStyle];
            [alert runModal];
            return;
        }
        
        //Empty response 200
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Error updating ServiceStack Reference - Empty response"];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert runModal];
        return;
    }
    NSInteger responseCode = [httpUrlResponse statusCode];
    
    if(responseCode != 200) {
        NSInteger errorCode = responseCode;
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:[NSString stringWithFormat:@"Error updating ServiceStack Reference - %ld", (long)errorCode]];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert runModal];
        return;
    }
    
    if([responseString hasPrefix:@"<"]) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Error updating ServiceStack Reference."];
        [alert setInformativeText:@"Unexpected HTML response body returned from endpoint. Please check the BaseUrl."];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert runModal];
        return;
    }
    
    // This is a reference to the current source code editor.
    [sourceTextView selectAll:nil];
    NSRange selectedTextRange = [sourceTextView selectedRange];
    NSString *selectedString = [sourceTextView.textStorage.string substringWithRange:selectedTextRange];
    if (selectedString) {
        [sourceTextView replaceCharactersInRange:selectedTextRange withString:responseString];
        //This is done to avoid observed Xcode crashing
        NSUndoManager *undoManager = [sourceTextView undoManager];
        [undoManager removeAllActions];
    }
}

+ (void)updateFileContents:(NSString *)fileName {
    sourceTextView = [DTXcodeUtils currentSourceTextView];
    NSInteger insertionPoint = [[sourceTextView selectedRanges][0] rangeValue].location;
    [sourceTextView selectAll:self];
    NSRange selectedTextRange = [sourceTextView selectedRange];
    NSString *selectedString = [sourceTextView.textStorage.string substringWithRange:selectedTextRange];
    [sourceTextView setSelectedRange:NSMakeRange((NSUInteger) insertionPoint, 0)];
    NSString *content = selectedString;
    NSArray *allLinedStrings =
            [content componentsSeparatedByCharactersInSet:
                    [NSCharacterSet newlineCharacterSet]];

    NSString *fullUpdateUrl;
    if([fileName hasSuffix:@".dtos.swift"]) {
        fullUpdateUrl = [self generateUrlFromDtoFile:content];
        [self updateFile:fullUpdateUrl withFile:fileName];
        return;
    }

    if(allLinedStrings != nil && [allLinedStrings[0] indexOf:@"/* Url:"] != -1) {
        fullUpdateUrl = [self generateUrlFromFile:content];
        [self updateFile:fullUpdateUrl withFile:fileName];
        return;
    }
}

+ (void) updateFile:(NSString*)fullUpdateUrl withFile:(NSString*)fileName {
    NSURL *url = [NSURL URLWithString:fullUpdateUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *connection = [[NSURLConnection  alloc] initWithRequest:request delegate:self];
    [connection start];
}

+ (NSString *)generateUrlFromFile:(NSString *)code {

    NSArray *allLinedStrings =
            [code componentsSeparatedByCharactersInSet:
                    [NSCharacterSet newlineCharacterSet]];
    NSString *url = [self extractUrlFromCodeFile:allLinedStrings];
    return url;
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

+ (NSString *) extractUrlFromCodeFile:(NSArray *)codeLines {
    NSString *result = nil;
    if(codeLines.count > 0 && [codeLines[0] hasPrefix:@"/* Url"]) {
        NSString *codeLine = codeLines[0];
        result = [[[codeLine split:@":"][1] substringFromIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
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
        NSString *val = [[[currentOption split:@":"][1] substringFromIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        result[key] = val;
    }
    NSDictionary *resultDictionary = [NSDictionary dictionaryWithDictionary:result];
    return resultDictionary;
}

@end
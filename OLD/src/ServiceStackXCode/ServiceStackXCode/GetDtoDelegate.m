//
// Created by Darren Reid on 12/02/15.
// Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "GetDtoDelegate.h"
#import "XcodeProjectManipulation.h"

@interface GetDtoDelegate()

@property(strong) XcodeProjectManipulation *projectManipulation;

@end

@implementation GetDtoDelegate {

}

NSMutableData *receivedData;
NSHTTPURLResponse *httpUrlResponse;
NSError *responseError;
NSString *errorMessage;

- (void)setDelegate:(id)aDelegate {
    delegate = aDelegate;
}

-(void) connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse*)response {
    httpUrlResponse = (NSHTTPURLResponse *) response;
    [receivedData setLength:0];
}

-(void) connection:(NSURLConnection*)connection didReceiveData:(NSData*)data {
    if(receivedData == nil) {
        receivedData = [NSMutableData alloc];
    }
    [receivedData appendData:data];
}

-(void) connection:(NSURLConnection*)connection didFailWithError:(NSError*)error {
    responseError = error;
    [delegate handleGetDtoError:[responseError localizedDescription]];
}

-(void) connectionDidFinishLoading:(NSURLConnection*)connection {
    if (httpUrlResponse == nil) {
        if (responseError != nil) {
            //Handle errors
            errorMessage = [@"An error has occurred - " stringByAppendingString:[responseError localizedDescription]];
            [delegate handleGetDtoError:errorMessage];
            return;
        }
        errorMessage = @"Unknown error has occurred. Check URL.";
        [delegate handleGetDtoError:errorMessage];
        return;
    }

    if ([httpUrlResponse statusCode] != 200) {
        errorMessage = [NSString stringWithFormat:@"Failed getting Swift types - error %ld.", (long) [httpUrlResponse statusCode]];
        [delegate handleGetDtoError:errorMessage];
        return;
    }

    NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    [delegate handleGetDtoSuccess:responseString];
}

@end
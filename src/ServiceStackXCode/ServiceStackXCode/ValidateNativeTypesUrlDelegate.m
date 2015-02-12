//
// Created by Darren Reid on 12/02/15.
// Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import "ValidateNativeTypesUrlDelegate.h"

@interface ValidateNativeTypesUrlDelegate()

@property (readwrite) NSString *errorMessage;

@end

@implementation ValidateNativeTypesUrlDelegate {

}

@synthesize errorMessage;

NSMutableData *receivedData;
NSHTTPURLResponse *httpUrlResponse;
NSError *responseError;

- (void)setDelegate:(id)aDelegate {
    delegate = aDelegate;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    httpUrlResponse = (NSHTTPURLResponse *) response;
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(receivedData == nil) {
        receivedData = [NSMutableData alloc];
    }
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    responseError = error;
    errorMessage = [responseError localizedDescription];
    [delegate handleValidateNativeTypesResponse:false];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (httpUrlResponse == nil) {
        if (responseError != nil) {
            //Handle errors
            errorMessage = [@"An error has occurred - " stringByAppendingString:[responseError localizedDescription]];
            [delegate handleValidateNativeTypesResponse:false];
            return;
        }
        errorMessage = @"Unknown error has occurred. Check URL.";
        [delegate handleValidateNativeTypesResponse:false];
        return;
    }

    if ([httpUrlResponse statusCode] != 200) {
        errorMessage = [NSString stringWithFormat:@"Server responded with a %ld error.", (long) [httpUrlResponse statusCode]];
        [delegate handleValidateNativeTypesResponse:false];
        return;
    }
    NSError *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:&error];
    if(error != nil || json[@"Config"] == nil) {
        errorMessage = @"Invalid response from server.";
        [delegate handleValidateNativeTypesResponse:false];
        return;
    }

    [delegate handleValidateNativeTypesResponse:true];

}


@end
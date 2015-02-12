//
// Created by Darren Reid on 12/02/15.
// Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import "GetJsonServiceClientDelegate.h"


@implementation GetJsonServiceClientDelegate {

}

NSMutableData *receivedData;
NSHTTPURLResponse *httpUrlResponse;
NSError *responseError;
NSString *errorMessage;

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
    [delegate handleGetJsonServiceClientError:[responseError localizedDescription]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (httpUrlResponse == nil) {
        if (responseError != nil) {
            //Handle errors
            errorMessage = [@"Unable to retrieve JsonServiceClient - " stringByAppendingString:[responseError localizedDescription]];
            [delegate handleGetJsonServiceClientError:errorMessage];
            return;
        }
        errorMessage = @"Unknown error has occurred. Unable to retrieve JsonServiceClient.";
        [delegate handleGetJsonServiceClientError:errorMessage];
        return;
    }

    if ([httpUrlResponse statusCode] != 200) {
        errorMessage = [NSString stringWithFormat:@"Unable to retrieve JsonServiceClient - error %ld.", (long) [httpUrlResponse statusCode]];
        [delegate handleGetJsonServiceClientError:errorMessage];
        return;
    }

    NSString *responseString = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    [delegate handleGetJsonServiceClientSuccess:responseString];
}


@end
//
// Created by Darren Reid on 12/02/15.
// Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ValidateNativeTypesUrlDelegate : NSObject {
    id delegate;
    NSHTTPURLResponse *httpUrlResponse;
    NSError *responseError;
}

@property (readonly) NSString* errorMessage;

- (void)setDelegate:(id)delegate;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
@end

@interface NSObject(ValidateNativeTypesUrlDelegateMethods)

-(void) handleValidateNativeTypesResponse:(BOOL)validNativeTypes;

@end
//
// Created by Darren Reid on 12/02/15.
// Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GetJsonServiceClientDelegate : NSObject {
    id delegate;
}

-(void)setDelegate:(id)delegate;

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
@end


@interface NSObject(GetJsonServiceClientDelegateMethods)

-(void) handleGetJsonServiceClientError:(NSString*) errorMessage;
-(void) handleGetJsonServiceClientSuccess:(NSString*)responseText;

@end
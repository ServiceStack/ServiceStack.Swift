//
//  AddReference.m
//  ServiceStackXCode
//
//  Created by Darren Reid on 29/01/2015.
//  Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import "AddReference.h"
#import "XcodeProjectManipulation.h"
#import "GetDtoDelegate.h"
#import "ValidateNativeTypesUrlDelegate.h"
#import "GetJsonServiceClientDelegate.h"

@interface AddReference ()

@property(strong) XcodeProjectManipulation *projectManipulation;

@end

@implementation AddReference

@synthesize address;
@synthesize name;
@synthesize okButton;
@synthesize errorLabel;
@synthesize addressText;
@synthesize nameText;
@synthesize loadingIndicator;

NSString *jsonServiceClientUrl = @"https://servicestack.net/dist/JsonServiceClient.swift";
ValidateNativeTypesUrlDelegate *validateNativeTypesUrlDelegate;

NSString *finalJsonServiceClientCode;
NSString *finalDtoCode;

- (void)windowDidLoad {
    [super windowDidLoad];

    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    [okButton setEnabled:NO];
    [self clearErrorLabel];
}

-(void)formReady {
    [okButton setEnabled:YES];
    [loadingIndicator stopAnimation:self];
}

-(void)formBusy {
    [okButton setEnabled:NO];
    [self clearErrorLabel];
    [loadingIndicator startAnimation:self];
}

-(void)setError:(NSString*)errorText {
    [address selectText:self];
    errorLabel.stringValue = errorText;
}

- (void)addReference:(id)sender {
    [self formBusy];
    NSString* metadataUrl;
    if(![self createMetadataUrl:&metadataUrl]) {
        [self formReady];
        [self setError:@"Invalid url provided"];
        return;
    }
    [self startValidateUrlRequest:metadataUrl];
}

-(bool)createMetadataUrl:(NSString**) metadataUrl {
    NSString *urlFromTextBox = [address stringValue];
    if (![self validateUrl:urlFromTextBox]) {
        return false;
    }
    NSURL *validUrl = [[NSURL alloc] initWithString:urlFromTextBox];
    NSString *fromValidUrl = [validUrl absoluteString];
    if (![fromValidUrl hasSuffix:@"/"]) {
        fromValidUrl = [fromValidUrl stringByAppendingString:@"/"];
    }
    NSString *finalUrl;
    if ([fromValidUrl hasSuffix:@"types/swift"]) {
        finalUrl = [fromValidUrl stringByReplacingOccurrencesOfString:@"types/swift" withString:@"types/metadata?format=json"];
    } else {
        finalUrl = [fromValidUrl stringByAppendingString:@"types/metadata?format=json"];
    }
    *metadataUrl = finalUrl;
    return true;
}

-(bool)createNativeTypesUrl:(NSString**) url {
    NSString *urlFromTextBox = [address stringValue];
    if (![self validateUrl:urlFromTextBox]) {
        return false;
    }
    NSURL *validUrl = [[NSURL alloc] initWithString:urlFromTextBox];
    NSString *fromValidUrl = [validUrl absoluteString];
    if (![fromValidUrl hasSuffix:@"/"]) {
        fromValidUrl = [fromValidUrl stringByAppendingString:@"/"];
    }
    NSString *finalUrl;
    if ([fromValidUrl hasSuffix:@"types/swift"]) {
        finalUrl = fromValidUrl;
    } else {
        finalUrl = [fromValidUrl stringByAppendingString:@"types/swift"];
    }
    *url = finalUrl;
    return true;
}

-(void)handleGetJsonServiceClientSuccess:(NSString *)responseText {
    self.projectManipulation = [XcodeProjectManipulation new];
    finalJsonServiceClientCode = responseText;
    NSString *dtoUrl;
    [self createNativeTypesUrl:&dtoUrl];
    [self startDtoRequest:dtoUrl];
}

- (void)handleGetDtoError:(NSString *)errorMessage {
    [self setError:errorMessage];
    [self formReady];
}

-(void)handleGetDtoSuccess:(NSString *)responseText {
    self.projectManipulation = [XcodeProjectManipulation new];
    finalDtoCode = responseText;
    [self formReady];
    [self addFilesToProject];
}

-(void)handleValidateNativeTypesResponse:(bool)validNativeTypes {
    if(validNativeTypes) {
        [self startJsonServiceClientRequest:jsonServiceClientUrl];
    } else {
        [self formReady];
        [self setError:validateNativeTypesUrlDelegate.errorMessage];
    }
}

-(void)addFilesToProject {
    NSString *fileName = [name stringValue];
    [self createFileAndAddToProject:@"JsonServiceClient.swift" withContents:finalJsonServiceClientCode];
    [self createFileAndAddToProject:[fileName stringByAppendingString:@".dtos.swift"] withContents:finalDtoCode];
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseOK];
}

- (void)controlTextDidChange:(NSNotification *)aNotification {
    [okButton setEnabled:[[address stringValue] length] > 0 && [[name stringValue] length] > 0];
}

- (void)clearErrorLabel {
    errorLabel.stringValue = @"";
}

-(void)startValidateUrlRequest:(NSString*)url {
    NSURL *typesMetadataUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:typesMetadataUrl];
    validateNativeTypesUrlDelegate = [ValidateNativeTypesUrlDelegate alloc];
    [validateNativeTypesUrlDelegate setDelegate:self];
    NSURLConnection *connection = [[NSURLConnection  alloc] initWithRequest:request delegate:validateNativeTypesUrlDelegate];
    [connection start];
}

-(void)startDtoRequest:(NSString*)url {
    NSURL *dtoUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:dtoUrl];
    GetDtoDelegate *getDtoDelegate = [GetDtoDelegate alloc];
    [getDtoDelegate setDelegate:self];
    NSURLConnection *connection = [[NSURLConnection  alloc] initWithRequest:request delegate:getDtoDelegate];
    [connection start];
}

-(void)startJsonServiceClientRequest:(NSString*)url {
    NSURL *jsonServiceClientUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:jsonServiceClientUrl];
    GetJsonServiceClientDelegate *jsonServiceClientDelegate = [GetJsonServiceClientDelegate alloc];
    [jsonServiceClientDelegate setDelegate:self];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:jsonServiceClientDelegate];
    [connection start];
}

- (void) createFileAndAddToProject:(NSString*)fileName withContents:(NSString*)fileContents {
    NSString *projectName = [self.projectManipulation projectName];
    //https://gist.github.com/larryaasen/5035313
    NSString *currentWorkspacePath = [[self.projectManipulation workspacePath] stringByAppendingString:@"/"];
    NSString *defaultFolder = [[currentWorkspacePath stringByAppendingString:projectName] stringByAppendingString:@"/"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fullFilePath = nil;
    if ([fileManager fileExistsAtPath:defaultFolder]) {
        fullFilePath = [defaultFolder stringByAppendingString:fileName];
        NSString *path = [self createCodeFile:fullFilePath withCode:fileContents];
        id <PBXTarget> target = [self.projectManipulation targets][0];
        [self.projectManipulation addFileAtPath:path toTarget:target withGroup:projectName];
        return;
    }

    fullFilePath = [currentWorkspacePath stringByAppendingString:fileName];
    NSString *path = [self createCodeFile:fullFilePath withCode:fileContents];
    id <PBXTarget> target = [self.projectManipulation targets][0];
    [self.projectManipulation addFileAtPath:path toTarget:target];
}

- (void)cancelAddReference:(id)sender {
    [self.window.sheetParent endSheet:self.window returnCode:NSModalResponseCancel];
}


- (NSString *)createCodeFile:(NSString *)path withCode:(NSString *)code {
    NSString *outPath = [path stringByAppendingString:@""];
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
    [[NSFileManager defaultManager] createFileAtPath:outPath contents:data attributes:nil];
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:outPath];
    if (outFile == Nil) {
        NSLog(@"Failed.");
    }
    return path;
}

#pragma mark - Private


- (BOOL)validateUrl:(NSString *)candidate {
    NSString *urlRegEx =
            @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

@end

//
//  AddReference.m
//  ServiceStackXCode
//
//  Created by Darren Reid on 29/01/2015.
//  Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import "AddReference.h"
#import "XcodeIDE.h"
#import "XcodeProjectManipulation.h"

@interface AddReference ()

@property (strong) XcodeProjectManipulation* projectManipulation;

@end

@implementation AddReference

@synthesize address;
@synthesize name;

NSMutableData *_responseData;


- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    
}


- (void) addReference:(id)sender {
    NSString *urlFromTextBox = [address stringValue];
    NSString *fileName = [name stringValue];
    self.projectManipulation = [XcodeProjectManipulation new];
    if([self validateUrl:urlFromTextBox]) {
        NSURL *validUrl = [[NSURL alloc] initWithString: urlFromTextBox];
        NSString *fromValidUrl = [validUrl absoluteString];
        if(![fromValidUrl hasSuffix:@"/"]) {
            fromValidUrl = [fromValidUrl stringByAppendingString:@"/"];
        }
        NSString *finalUrl;
        if([fromValidUrl hasSuffix:@"types/swift/"]) {
            finalUrl = fromValidUrl;
        } else {
            finalUrl = [fromValidUrl stringByAppendingString:@"types/swift/"];
        }
        [self addFileFromUrl:[fileName stringByAppendingString:@".dtos.swift"] :finalUrl];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSString *currentWorkspacePath = [[self.projectManipulation workspacePath] stringByAppendingString:@"/"];
        NSString *pathForFile = [currentWorkspacePath stringByAppendingString:@"JsonServiceClient.swift"];
        
        if (![fileManager fileExistsAtPath:pathForFile]){
            [self addFileFromUrl:
              @"JsonServiceClient.swift":
             @"https://raw.githubusercontent.com/ServiceStack/ServiceStack.Swift/master/dist/JsonServiceClient.swift"];
        }
        
        [self.window close];
    }
}

-(void) addFileFromUrl:(NSString *) fileName :(NSString *) fileUrl {
    NSURL *url = [NSURL URLWithString:fileUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&error];
    if(error == nil) {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //https://gist.github.com/larryaasen/5035313
        NSString *currentWorkspacePath = [[self.projectManipulation workspacePath] stringByAppendingString:@"/"];
        NSString *fullFilePath = [currentWorkspacePath stringByAppendingString:fileName];
        NSString *path = [self createCodeFile:fullFilePath withCode:responseString];
        id<PBXTarget> target = [self.projectManipulation targets][0];
        [self.projectManipulation addFileAtPath:path toTarget:target];
    } else {
        //Handle error
    }
}

-(void) cancelAddReference:(id)sender {
    [self.window close];
}


- (NSString*) createCodeFile:(NSString*) path withCode:(NSString*)code {
    NSString *outPath = [path stringByAppendingString:@""];
    NSData* data = [code dataUsingEncoding:NSUTF8StringEncoding];
    [[NSFileManager defaultManager] createFileAtPath:outPath contents:data attributes:nil];
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:outPath];
    if (outFile == Nil) {
        NSLog(@"Failed.");
    }
    return path;
}



- (NSString *)currentWorkspaceDirectoryPath
{
    return [self directoryPathForWorkspace:[self workspaceForKeyWindow]];
}

- (NSString *)directoryPathForWorkspace:(id)workspace
{
    NSString *workspacePath = [[workspace valueForKey:@"representingFilePath"] valueForKey:@"_pathString"];
    return [workspacePath stringByDeletingLastPathComponent];
}

#pragma mark - Private

- (id)workspaceForKeyWindow
{
    return [self workspaceForWindow:[NSApp keyWindow]];
}

- (id)workspaceForWindow:(NSWindow *)window
{
    NSArray *workspaceWindowControllers = [NSClassFromString(@"IDEWorkspaceWindowController") valueForKey:@"workspaceWindowControllers"];
    
    for (IDEWorkspaceWindowController *controller in workspaceWindowControllers) {
        if ([[controller valueForKey:@"window"] isEqual:window]) {
            return [controller valueForKey:@"_workspace"];
        }
    }
    return nil;
}


- (NSString*) runCommand:(NSString*) commandToRun{
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/bin/sh"];
    
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-c" ,
                          [NSString stringWithFormat:@"%@", commandToRun],
                          nil];
    NSLog(@"run command: %@",commandToRun);
    [task setArguments: arguments];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *output;
    output = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
    return output;
}

- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

@end

//
//  ServiceStackXCode.m
//  ServiceStackXCode
//
//  Created by Darren Reid on 29/01/2015.
//  Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import "ServiceStackXCode.h"
#import "AddReference.h"
#import <DTXcodeUtils/DTXcodeHeaders.h>
#import <DTXcodeUtils/DTXcodeUtils.h>
#import <objc/runtime.h>
#import "ExtendNSString.h"
#import "SwiftNativeTypesManger.h"


static ServiceStackXCode *sharedPlugin;

@interface ServiceStackXCode ()

@property(strong) AddReference *controllerWindow;

@property(nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation ServiceStackXCode

NSString *const addRefMenuName = @"Add ServiceStack Reference...";
NSString *const updateRefMenuName = @"Update ServiceStack Reference";

+ (void)pluginDidLoad:(NSBundle *)plugin {
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin {
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin {
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;

        // Create menu items, initialize UI, etc.

        // Sample Menu Item:
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self setupMenu:[[NSApp mainMenu] itemWithTitle:@"File"]];
        }];
    }
    return self;
}

-(void)setupMenu: (NSMenuItem*)menuItem {
    if (menuItem) {
        NSMenuItem *addRefMenuItem = [[NSMenuItem alloc] initWithTitle:addRefMenuName action:@selector(addReference) keyEquivalent:@""];
        NSMenuItem *updateRefMenuItem = [[NSMenuItem alloc] initWithTitle:updateRefMenuName action:@selector(updateReference) keyEquivalent:@""];
        updateRefMenuItem.enabled = false;
        [addRefMenuItem setTarget:self];
        [updateRefMenuItem setTarget:self];
        updateRefMenuItem.enabled = false;
        SEL originalSelector = @selector(validateMenuItem:);
        SEL swizzledSelector = @selector(validateUpdateRefMenuItem:);

        Class class = [self class];

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        BOOL didAddMethod =
                class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        [[menuItem submenu] insertItem:addRefMenuItem atIndex:3];
        [[menuItem submenu] insertItem:updateRefMenuItem atIndex:4];
    }}

- (void)addReference {
    self.controllerWindow = [[AddReference alloc] initWithWindowNibName:@"AddReference"];
    NSWindow *mainWindow = [NSApp mainWindow];
    [mainWindow beginSheet:self.controllerWindow.window completionHandler:^(NSModalResponse returnCode) {

    }];
}

- (BOOL)validateUpdateRefMenuItem:(NSMenuItem *)menuItem {
    if ([menuItem.title isEqualToString:addRefMenuName]) {
        return true;
    }

    //Update reference
    IDESourceCodeDocument *sourceCodeDocument = [DTXcodeUtils currentSourceCodeDocument];
    NSURL *fileUrl = [sourceCodeDocument fileURL];
    NSString *absolutePath = [fileUrl absoluteString];
    BOOL isDtoFile = [absolutePath hasSuffix:@".dtos.swift"];
    return isDtoFile;
}

- (void)updateReference {
    IDESourceCodeDocument *sourceCodeDocument = [DTXcodeUtils currentSourceCodeDocument];
    NSURL *fileUrl = [sourceCodeDocument fileURL];
    NSString *absolutePath = fileUrl.path;
    BOOL isDtoFile = [absolutePath hasSuffix:@".dtos.swift"];
    if (isDtoFile) {
        [SwiftNativeTypesManger updateFileContents:absolutePath];
        @try {
            [self submitAnonStatsUpdateServiceStackRef];
        }
        @catch (NSException *exception) {
            //ignore
        }
    }
}

- (void)submitAnonStatsUpdateServiceStackRef {
    NSString* optoutValue = [[[NSProcessInfo processInfo]environment]objectForKey:@"SERVICESTACKXCODE_OPTOUT"];
    if(optoutValue == Nil) {
        NSURL *url = [NSURL URLWithString:@"https://servicestack.net/stats/updateref/record?Name=swift"];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             // noop, ignore errors
         }];
    }
}

@end

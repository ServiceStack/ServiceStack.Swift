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
#import <Foundation/NSObjCRuntime.h>
#import "ExtendNSString.h"


static ServiceStackXCode *sharedPlugin;

@interface ServiceStackXCode()

@property (strong) AddReference *controllerWindow;

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation ServiceStackXCode

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
        NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"File"];
        if (menuItem) {
            NSMenuItem *addRefMenuItem = [[NSMenuItem alloc] initWithTitle:@"Add ServiceStack Reference" action:@selector(addReference) keyEquivalent:@""];
            NSMenuItem *updateRefMenuItem = [[NSMenuItem alloc] initWithTitle:@"Update ServiceStack Reference" action:@selector(updateReference) keyEquivalent:@""];
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
            if(didAddMethod) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
            [[menuItem submenu] insertItem: addRefMenuItem atIndex:3];
            [[menuItem submenu] insertItem: updateRefMenuItem atIndex:4];
        }
    }
    return self;
}

- (void)addReference {
    self.controllerWindow = [[AddReference alloc] initWithWindowNibName:@"AddReference"];
    NSWindow* mainWindow = [NSApp mainWindow];
    [mainWindow beginSheet:self.controllerWindow.window completionHandler:^(NSModalResponse returnCode) {
        
    }];
}

- (BOOL)validateUpdateRefMenuItem:(NSMenuItem *)menuItem {
    if([menuItem.title isEqualToString:@"Add ServiceStack Reference"]) {
        return true;
    }
    
    //Update reference
    IDESourceCodeDocument *sourceCodeDocument = [DTXcodeUtils currentSourceCodeDocument];
    NSURL* fileUrl = [sourceCodeDocument fileURL];
    NSString *absolutePath = [fileUrl absoluteString];
    BOOL isDtoFile = [absolutePath hasSuffix:@".dtos.swift"];
    return isDtoFile;
}

- (void)updateReference {
    IDESourceCodeDocument *sourceCodeDocument = [DTXcodeUtils currentSourceCodeDocument];
    NSURL* fileUrl = [sourceCodeDocument fileURL];
    NSString *absolutePath = fileUrl.path;
    BOOL isDtoFile = [absolutePath hasSuffix:@".dtos.swift"];
    if(isDtoFile) {
        [self updateFileContents:absolutePath];
    }

    
}

- (void) updateFileContents:(NSString *) fileName {
    NSString *content = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSString *fullUpdateUrl = [self generateUrlFromDtoFile:content];
    NSURL *url = [NSURL URLWithString:fullUpdateUrl];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&error];
    if(error == nil) {
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

- (NSString*) generateUrlFromDtoFile: (NSString*) dtoCode {
    // first, separate by new line
    NSArray* allLinedStrings =
    [dtoCode componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    NSString* baseUrl = [self extractBaseUrlFromDtoFile:allLinedStrings];
    NSDictionary* allOptions = [self getOptionValues:allLinedStrings];
    NSString* result = nil;
    if([baseUrl indexOf:@"/types/swift"] == -1) {
        result = [baseUrl stringByAppendingString:@"types/swift"];
    } else {
        result = [baseUrl copy];
    }
    int count = 0;
    for(id key in allOptions) {
        if(count == 0) {
            result = [result stringByAppendingString:@"?"];
        } else {
            result = [result stringByAppendingString:@"&"];
        }
        
        result = [result stringByAppendingString:key];
        result = [result stringByAppendingString:@"="];
        result = [result stringByAppendingString:allOptions[key]];
    }
    
    return result;
}

- (NSString*) extractBaseUrlFromDtoFile: (NSArray*) dtoCodeLines {
    NSString* result = nil;
    for (int i = 0; i < dtoCodeLines.count; i++) {
        NSString* dtoLine = [dtoCodeLines objectAtIndex:i];
        dtoLine = [dtoLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([dtoLine hasPrefix:@"BaseUrl"]) {
            result = [[dtoLine substringFromIndex:8] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            break;
        }
    }
    
    if(![result hasSuffix:@"/"]) {
        result = [result stringByAppendingString:@"/"];
    }
    return result;
}

- (NSDictionary*) getOptionValues: (NSArray*)dtoCodeLines {
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    int optionsStart = 0;
    for (int i = 0; i < dtoCodeLines.count; i++) {
        NSString* dtoLine = [dtoCodeLines objectAtIndex:i];
        dtoLine = [dtoLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(i > 0 && [dtoLine length] == 0 && [[dtoCodeLines objectAtIndex:i - 1] length] == 0) {
            optionsStart = i + 1;
            break;
        }
    }
    
    for (int optionIndex = optionsStart; optionIndex < dtoCodeLines.count; optionIndex++) {
        NSString* currentOption = dtoCodeLines[optionIndex];
        if([currentOption indexOf:@"*/"] != -1) {
            break;
        }
        
        if([currentOption hasPrefix:@"//"] || [currentOption indexOf:@":"] == -1) {
            continue;
        }
        
        NSString* key = [currentOption split:@":"][0];
        NSString* val = [currentOption split:@":"][1];
        result[key] = val;
    }
    NSDictionary* resultDictionary = [NSDictionary dictionaryWithDictionary:result];
    return resultDictionary;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

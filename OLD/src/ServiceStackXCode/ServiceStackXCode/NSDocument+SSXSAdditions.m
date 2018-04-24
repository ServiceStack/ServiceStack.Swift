//
//  NSDocument+SSXSAdditions.m
//  ServiceStackXCode
//
//  Created by Darren Reid on 6/02/2015.
//  Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import "NSDocument+SSXSAdditions.h"
#import "ExtendNSString.h"
#import "SwiftNativeTypesManger.h"
#import <DTXcodeUtils/DTXcodeHeaders.h>
#import <DTXcodeUtils/DTXcodeUtils.h>
#import <objc/runtime.h>

@implementation NSDocument (SSXCAdditions)

+ (void)load {
//    Method original, swizzle;
//
//    original = class_getInstanceMethod(
//            self,
//            NSSelectorFromString(
//                    @"saveDocumentWithDelegate:didSaveSelector:contextInfo:"));
//    swizzle = class_getInstanceMethod(
//            self,
//            NSSelectorFromString(
//                    @"ssxc_documentWillSave:didSaveSelector:contextInfo:"));
//
//    method_exchangeImplementations(original, swizzle);

}


//- (void)ssxc_documentWillSave:(id)delegate
//              didSaveSelector:(SEL)didSaveSelector
//                  contextInfo:(void *)contextInfo {
//
//    IDESourceCodeDocument *sourceCodeDocument = [DTXcodeUtils currentSourceCodeDocument];
//    NSURL *fileUrl = [sourceCodeDocument fileURL];
//    NSString *absolutePath = fileUrl.path;
//    [SwiftNativeTypesManger updateFileContents:absolutePath];
//
//    [self ssxc_documentWillSave:delegate didSaveSelector:didSaveSelector contextInfo:contextInfo];
//}


@end
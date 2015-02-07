//
//  AddReference.h
//  ServiceStackXCode
//
//  Created by Darren Reid on 29/01/2015.
//  Copyright (c) 2015 ServiceStack. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AddReference : NSWindowController

- (IBAction)addReference:(id)sender;

- (IBAction)cancelAddReference:(id)sender;

@property (weak, nonatomic) IBOutlet NSTextField *address;

@property (weak, nonatomic) IBOutlet NSTextField *name;




@end

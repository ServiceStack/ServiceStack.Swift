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

- (void)controlTextDidChange:(NSNotification *)aNotification;

@property (weak, nonatomic) IBOutlet NSTextField *address;

@property (weak, nonatomic) IBOutlet NSTextField *name;

@property (weak, nonatomic) IBOutlet NSButton *okButton;

@property (weak, nonatomic) IBOutlet NSTextField *errorLabel;

@property (weak, nonatomic) NSString* addressText;

@property (weak, nonatomic) NSString* nameText;

@end

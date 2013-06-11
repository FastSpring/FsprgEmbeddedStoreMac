//
//  OrderViewController.m
//  TestApp
//
//  Created by Lars Steiger on 2/28/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "OrderViewController.h"


@implementation OrderViewController

- (NSString *)fileName
{
    return [[fileName retain] autorelease]; 
}

- (void)setFileName:(NSString *)aFileName
{
    if (fileName != aFileName) {
        [fileName release];
        fileName = [aFileName retain];
    }
}

- (void)savePanelDidEnd:(NSSavePanel *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    if (returnCode == NSOKButton) {
        [self setFileName:[[sheet URL] path]];
		
		NSError *error = nil;
		[[self representedObject] writeToFile:[self fileName] atomically:FALSE encoding:NSUTF8StringEncoding error:&error];
    }
}

- (IBAction)saveAs:(id)sender
{
    NSSavePanel* savePanel = [NSSavePanel savePanel];

	[savePanel setAllowedFileTypes:[NSArray arrayWithObject:@"plist"]];
#if defined(MAC_OS_X_VERSION_10_6) && MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_10_6
    [savePanel beginSheetModalForWindow:[[self view] window]
                      completionHandler:^(NSInteger result) {
                          [self savePanelDidEnd:savePanel returnCode:result contextInfo:nil];
                      }];
#else
	[savePanel beginSheetForDirectory:nil
								 file:[[self fileName] lastPathComponent]
					   modalForWindow:[[self view] window]
						modalDelegate:self
					   didEndSelector:@selector(savePanelDidEnd:returnCode:contextInfo:) 
						  contextInfo:nil];
#endif
}

- (void)dealloc
{
    [self setFileName:nil];
	
    [super dealloc];
}

@end

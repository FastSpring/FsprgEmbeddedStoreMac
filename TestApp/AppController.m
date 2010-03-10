//
//  AppController.m
//  TestApp
//
//  Created by Lars Steiger on 2/28/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "AppController.h"
#import "OrderViewController.h"

static NSString * const kParams = @"params";

@implementation AppController

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setStoreController:[[[FsprgEmbeddedStoreController alloc] init] autorelease]];

		NSDictionary *defaultParams = [[[NSUserDefaultsController sharedUserDefaultsController] defaults] dictionaryForKey:kParams];
		if(defaultParams == nil) {
			[self setParams:[FsprgStoreParameters parameters]];
			[[self params] setOrderProcessType:kFsprgOrderProcessDetail];
			[[self params] setMode:kFsprgModeTest];
		} else {
			[self setParams:[FsprgStoreParameters parametersWithRaw:(NSMutableDictionary *)defaultParams]];
		}
		
		[[self storeController] setDelegate:self];
	}
	return self;
}

- (FsprgEmbeddedStoreController *)storeController
{
    return [[storeController retain] autorelease]; 
}

- (void)setStoreController:(FsprgEmbeddedStoreController *)aStoreController
{
    if (storeController != aStoreController) {
        [storeController release];
        storeController = [aStoreController retain];
    }
}

- (FsprgStoreParameters *)params
{
    return [[params retain] autorelease]; 
}

- (void)setParams:(FsprgStoreParameters *)aParams
{
    if (params != aParams) {
        [params release];
        params = [aParams retain];
    }
}

- (void)awakeFromNib
{
	[[self storeController] setWebView:previewWebView];
	[[window toolbar] setSelectedItemIdentifier:@"settings"];
	[self switchToSettings:nil];
}

- (IBAction)switchToSettings:(id)sender
{
	[window setContentView:settingsView];
}

- (IBAction)switchToPreview:(id)sender
{
	[window setContentView:previewView];
	[self reloadPreview:sender];
}

- (IBAction)reloadPreview:(id)sender
{
	[previewWebView setHidden:TRUE];
	[[self storeController] loadWithParameters:[self params]];
}

// FsprgEmbeddedStoreDelegate

- (void)didLoadStore
{
	[previewWebView setHidden:FALSE];
}

- (void)didReceiveOrder:(FsprgOrder *)order
{
}

- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FsprgOrder *)order
{
	NSString *errorDesc = nil;
	NSData *data = [NSPropertyListSerialization dataFromPropertyList:[order raw] 
															  format:NSPropertyListXMLFormat_v1_0 
													errorDescription:&errorDesc];
	NSString *orderAsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

	OrderViewController *orderViewController = [[OrderViewController alloc] initWithNibName:@"OrderView" bundle:nil];
	[orderViewController setRepresentedObject:orderAsStr];

	[[[orderViewController view] window] setBackgroundColor:[NSColor blackColor]];
	[[orderViewController view] setFrame:frame];
	return [orderViewController view];
}

// NSApplicationDelegate

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
	NSUserDefaults *defaults = [[NSUserDefaultsController sharedUserDefaultsController] defaults];
	[defaults setObject:[[self params] raw] forKey:kParams];
}

- (void)dealloc
{
    [self setParams:nil];
    [self setStoreController:nil];
	
    [super dealloc];
}

@end

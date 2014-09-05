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

		[[[NSUserDefaultsController sharedUserDefaultsController] defaults] setBool:TRUE forKey:@"WebKitDeveloperExtras"];
		
		NSDictionary *defaultParams = [[[NSUserDefaultsController sharedUserDefaultsController] defaults] dictionaryForKey:kParams];
		if(defaultParams == nil) {
			[self setParams:[FsprgStoreParameters parameters]];
			[[self params] setOrderProcessType:kFsprgOrderProcessDetail];
			[[self params] setMode:kFsprgModeTest];
		} else {
			[self setParams:[FsprgStoreParameters parametersWithRaw:[[defaultParams mutableCopy] autorelease]]];
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
    
    NSToolbarItem *firstItem = [[[window toolbar] items] objectAtIndex:0];
	[[window toolbar] setSelectedItemIdentifier:[firstItem itemIdentifier]];
    [[firstItem target] performSelector:[firstItem action]];
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

- (void)didLoadStore:(NSURL *)url
{
	[previewURL setStringValue:[url absoluteString]];
	[previewPageType setStringValue:@"@FastSpring"];
	[previewPageType setHidden:FALSE];
	[previewWebView setHidden:FALSE];
}

- (void)didLoadPage:(NSURL *)url ofType:(FsprgPageType)pageType;
{
	[previewURL setStringValue:[url absoluteString]];
	switch (pageType) {
		case FsprgPageFS:
			[previewPageType setStringValue:@"@FastSpring"];
			break;
		case FsprgPagePayPal:
			[previewPageType setStringValue:@"@PayPal"];
			break;
		case FsprgPageUnknown:
		default:
			[previewPageType setStringValue:@"@Unknown"];
			break;
	}
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
	NSString *orderAsStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];

	OrderViewController *orderViewController = [[OrderViewController alloc] initWithNibName:@"OrderView" bundle:nil];
	[orderViewController setRepresentedObject:orderAsStr];

	[[[orderViewController view] window] setBackgroundColor:[NSColor blackColor]];
	[[orderViewController view] setFrame:frame];
	return [orderViewController view];
}

- (void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
    NSRunAlertPanel(@"Alert", @"%@", @"OK", nil, nil, [error localizedDescription]);
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
    NSRunAlertPanel(@"Alert", @"%@", @"OK", nil, nil, [error localizedDescription]);
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
	[[self storeController] setDelegate:nil];
    [self setStoreController:nil];
	
    [super dealloc];
}

@end

//
//  AppController.m
//  TestApp
//
//  Created by Lars Steiger on 2/28/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "AppController.h"
#import "OrderViewController.h"


@implementation AppController

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setStoreController:[[[FstSpgEmbeddedStoreController alloc] init] autorelease]];
		[self setParams:[FstSpgStoreParameters parameters]];
		[[self params] setStoreId:@"spootnik" withProductId:@"fsembeddedstore"];
		[[self params] setMode:kFstSpgModeTest];
		
		[[self storeController] setDelegate:self];
	}
	return self;
}

- (FstSpgEmbeddedStoreController *)storeController
{
    return [[storeController retain] autorelease]; 
}

- (void)setStoreController:(FstSpgEmbeddedStoreController *)aStoreController
{
    if (storeController != aStoreController) {
        [storeController release];
        storeController = [aStoreController retain];
    }
}

- (FstSpgStoreParameters *)params
{
    return [[params retain] autorelease]; 
}

- (void)setParams:(FstSpgStoreParameters *)aParams
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
	
	//NSData *data = [NSData dataWithContentsOfFile:@"/Users/lars/Desktop/test.plist"];
	//[[previewWebView mainFrame] loadData:data MIMEType:@"text/xml" textEncodingName:@"UTF-8" baseURL:nil];
}

// FstSpgEmbeddedStoreDelegate

- (void)didLoadStore
{
	[previewWebView setHidden:FALSE];
}

- (void)didReceiveOrder:(FstSpgOrder *)order
{
}

- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FstSpgOrder *)order
{
	NSString *errorDesc = nil;
	NSData *data = [NSPropertyListSerialization dataFromPropertyList:[order raw] 
															  format:NSPropertyListXMLFormat_v1_0 
													errorDescription:&errorDesc];
	NSString *orderAsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

	OrderViewController *orderViewController = [[OrderViewController alloc] initWithNibName:@"OrderView" bundle:nil];
	[orderViewController setRepresentedObject:orderAsStr];

	[[orderViewController view] setFrame:frame];
	return [orderViewController view];
}

- (void)dealloc
{
    [self setParams:nil];
    [self setStoreController:nil];
	
    [super dealloc];
}

@end

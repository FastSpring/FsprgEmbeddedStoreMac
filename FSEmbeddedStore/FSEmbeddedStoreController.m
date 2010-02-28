//
//  FSEmbeddedStoreController.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSEmbeddedStoreController.h"
#import "FSOrderView.h"
#import "FSOrderDocumentRepresentation.h"
#import <AddressBook/AddressBook.h>


@implementation FSEmbeddedStoreController

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setDelegate:nil];
	}
	return self;
}

- (id <FSEmbeddedStoreDelegate>)delegate
{
    return [[delegate retain] autorelease]; 
}

- (void)setDelegate:(id <FSEmbeddedStoreDelegate>)aDelegate
{
    if (delegate != aDelegate) {
        [delegate release];
        delegate = [aDelegate retain];
    }
}

- (IBAction)load:(id)sender
{
	[WebView registerViewClass:[FSOrderView class]
		   representationClass:[FSOrderDocumentRepresentation class]
				   forMIMEType:@"text/xml"];

	[self setLoading:TRUE];
	[webView setFrameLoadDelegate:self];
	[webView setUIDelegate:self];

	[webView setApplicationNameForUserAgent:@"FSEmbeddedStore/1.0"];
	
	FSStoreParameters *parameters = [FSStoreParameters parameters];
	[[self delegate] willLoadStoreWithParameters:parameters];
	[[webView mainFrame] loadRequest:[parameters toURLRequest]];
}

// WebFrameLoadDelegate

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
	[self setLoading:TRUE];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	[self setLoading:FALSE];
	[[self delegate] didLoadWebFrame:frame];
}

- (void)setLoading:(BOOL)aFlag
{
	loading = aFlag;
}

- (BOOL)loading
{
	return loading;
}

// WebUIDelegate

- (void)webView:(WebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame
{
	NSRunAlertPanel(@"Alert", message, @"OK", nil, nil);
}

- (WebView *)webView:(WebView *)sender createWebViewWithRequest:(NSURLRequest *)request
{
	NSWindow *window = [[NSWindow alloc] initWithContentRect:NSMakeRect(0,0,0,0)
										 styleMask:(NSClosableWindowMask|NSResizableWindowMask)
										 backing:NSBackingStoreBuffered
										 defer:NO];
	WebView *subWebView = [[[WebView alloc] initWithFrame:NSMakeRect(0,0,0,0) frameName:@"_blank" groupName:@"none"] autorelease];
	[window setReleasedWhenClosed:TRUE];
	[window setContentView:subWebView];
	[window makeKeyAndOrderFront:sender];
	
	return subWebView;
}

- (void)dealloc
{
    [self setDelegate:nil];
	
    [super dealloc];
}

@end

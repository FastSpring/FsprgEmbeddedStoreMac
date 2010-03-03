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


@implementation FSEmbeddedStoreController

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setWebView:nil];
		[self setDelegate:nil];
	}
	return self;
}

- (WebView *)webView
{
    return [[webView retain] autorelease]; 
}

- (void)setWebView:(WebView *)aWebView
{
    if (webView != aWebView) {
        [webView release];
        webView = [aWebView retain];
    }
}

- (id <FSEmbeddedStoreDelegate>)delegate
{
	if(delegate == nil) {
		NSLog(@"No delegate has been assigned to FSEmbeddedStoreController!");
	}
    return [[delegate retain] autorelease]; 
}

- (void)setDelegate:(id <FSEmbeddedStoreDelegate>)aDelegate
{
    if (delegate != aDelegate) {
        [delegate release];
        delegate = [aDelegate retain];
    }
}

- (void)load
{
	[WebView registerViewClass:[FSOrderView class]
		   representationClass:[FSOrderDocumentRepresentation class]
				   forMIMEType:@"text/xml"];

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
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
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
    [self setWebView:nil];
    [self setDelegate:nil];
	
    [super dealloc];
}

@end

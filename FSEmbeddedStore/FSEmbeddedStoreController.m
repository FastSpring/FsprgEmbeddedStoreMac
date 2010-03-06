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

+ (void)initialize
{
	[WebView registerViewClass:[FSOrderView class]
		   representationClass:[FSOrderDocumentRepresentation class]
				   forMIMEType:@"text/xml"];
}

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
		[webView setFrameLoadDelegate:nil];
		[webView setUIDelegate:nil];
		[webView setApplicationNameForUserAgent:nil];
		
        webView = [aWebView retain];
		[webView setFrameLoadDelegate:self];
		[webView setUIDelegate:self];
		[webView setApplicationNameForUserAgent:@"FSEmbeddedStore/1.0"];
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

- (void)loadWithParameters:(FSStoreParameters *)parameters
{

	[[webView mainFrame] loadRequest:[parameters toURLRequest]];
}

// WebFrameLoadDelegate

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	[[self delegate] didLoadStore];
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

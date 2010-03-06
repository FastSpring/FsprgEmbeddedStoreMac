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
		isInitialLoad = FALSE;
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
		[[NSNotificationCenter defaultCenter] removeObserver:self];
		
		
        webView = [aWebView retain];
		[webView setFrameLoadDelegate:self];
		[webView setUIDelegate:self];
		[webView setApplicationNameForUserAgent:@"FSEmbeddedStore/1.0"];
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(estimatedLoadingProgressChanged:) 
													 name:WebViewProgressStartedNotification 
												   object:webView];
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(estimatedLoadingProgressChanged:) 
													 name:WebViewProgressEstimateChangedNotification 
												   object:webView];
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

	isInitialLoad = TRUE;
	[[webView mainFrame] loadRequest:[parameters toURLRequest]];
}


- (BOOL)isLoading
{
	return [self estimatedLoadingProgress] < 100;
}
- (void)setIsLoading:(BOOL)aFlag
{
	// just triggering change observer
}
- (double)estimatedLoadingProgress
{
	return [webView estimatedProgress] * 100;
}
- (void)setEstimatedLoadingProgress:(double)aProgress
{
	// just triggering change observer
}
- (void)estimatedLoadingProgressChanged:(NSNotification *)aNotification
{
	[self setEstimatedLoadingProgress:-1];
	[self setIsLoading:TRUE];
}


// WebFrameLoadDelegate

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	if(isInitialLoad) {
		isInitialLoad = FALSE;
		[[self delegate] didLoadStore];
	}
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

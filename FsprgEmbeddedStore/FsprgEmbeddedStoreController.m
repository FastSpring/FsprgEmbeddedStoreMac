//
//  FsprgEmbeddedStoreController.m
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FsprgEmbeddedStoreController.h"
#import "FsprgOrderView.h"
#import "FsprgOrderDocumentRepresentation.h"


@implementation FsprgEmbeddedStoreController

+ (void)initialize
{
	[WebView registerViewClass:[FsprgOrderView class]
		   representationClass:[FsprgOrderDocumentRepresentation class]
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

- (id <FsprgEmbeddedStoreDelegate>)delegate
{
	if(delegate == nil) {
		NSLog(@"No delegate has been assigned to FsprgEmbeddedStoreController!");
	}
    return [[delegate retain] autorelease]; 
}

- (void)setDelegate:(id <FsprgEmbeddedStoreDelegate>)aDelegate
{
    if (delegate != aDelegate) {
        [delegate release];
        delegate = [aDelegate retain];
    }
}

- (void)loadWithParameters:(FsprgStoreParameters *)parameters
{
	NSURLRequest *urlRequest = [parameters toURLRequest];

	NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[urlRequest URL]];
	NSUInteger i, count = [cookies count];
	for (i = 0; i < count; i++) {
		NSHTTPCookie *cookie = [cookies objectAtIndex:i];
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
	}
	
	isInitialLoad = TRUE;
	[[webView mainFrame] loadRequest:urlRequest];
}

- (void)loadWithContentsOfFile:(NSString *)aPath
{
	NSString *mimeType = nil;
	if([[aPath pathExtension] isEqualTo:@"plist"]) {
		mimeType = @"text/xml";
	} else if([[aPath pathExtension] isEqualTo:@"html"]) {
		mimeType = @"text/html";
	}
	NSData *data = [NSData dataWithContentsOfFile:aPath];
	
	isInitialLoad = TRUE;
	[[webView mainFrame] loadData:data MIMEType:mimeType textEncodingName:@"UTF-8" baseURL:nil];
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
	WebView *subWebView = [[[WebView alloc] initWithFrame:NSMakeRect(0,0,0,0)] autorelease];
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

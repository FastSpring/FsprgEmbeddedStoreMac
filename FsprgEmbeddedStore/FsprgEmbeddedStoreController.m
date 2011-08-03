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


@interface FsprgEmbeddedStoreController (Private)
- (void)setIsLoading:(BOOL)aFlag;
- (void)setEstimatedLoadingProgress:(double)aProgress;
- (void)setIsSecure:(BOOL)aFlag;
- (void)setStoreHost:(NSString *)aHost;
- (void)resizeContentDivE;
- (void)webViewFrameChanged:(NSNotification *)aNotification;
@end

@implementation FsprgEmbeddedStoreController

+ (void)initialize
{
	[WebView registerViewClass:[FsprgOrderView class]
		   representationClass:[FsprgOrderDocumentRepresentation class]
				   forMIMEType:@"application/x-fsprgorder+xml"];
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setWebView:nil];
		[self setDelegate:nil];
		[self setStoreHost:nil];
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
		[webView setPostsFrameChangedNotifications:FALSE];
		[webView setFrameLoadDelegate:nil];
		[webView setUIDelegate:nil];
		[webView setApplicationNameForUserAgent:nil];
		[[NSNotificationCenter defaultCenter] removeObserver:self];
		
		[webView release];
        webView = [aWebView retain];
		
		if (webView) {
			[webView setPostsFrameChangedNotifications:TRUE];
			[webView setFrameLoadDelegate:self];
			[webView setUIDelegate:self];
			[webView setApplicationNameForUserAgent:@"FSEmbeddedStore/2.0"];
			[[NSNotificationCenter defaultCenter] addObserver:self 
													 selector:@selector(webViewFrameChanged:) 
														 name:NSViewFrameDidChangeNotification 
													   object:webView];
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
}

- (id <FsprgEmbeddedStoreDelegate>)delegate
{
	if(delegate == nil) {
		NSLog(@"No delegate has been assigned to FsprgEmbeddedStoreController!");
	}
	return delegate;
}

- (void)setDelegate:(id <FsprgEmbeddedStoreDelegate>)aDelegate
{
	// Keep a weak reference to delegates to prevent circular references
	// See https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmObjectOwnership.html#//apple_ref/doc/uid/20000043-1044135
	delegate = aDelegate;
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
	
	[self setStoreHost:nil];
	[[webView mainFrame] loadRequest:urlRequest];
}

- (void)loadWithContentsOfFile:(NSString *)aPath
{
	[self setStoreHost:nil];

	NSData *data = [NSData dataWithContentsOfFile:aPath];
	if(data == nil) {
		NSLog(@"File %@ not found.", aPath);
	} else {
		[[webView mainFrame] loadData:data MIMEType:@"application/x-fsprgorder+xml" textEncodingName:@"UTF-8" baseURL:nil];
	}
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
- (BOOL)isSecure
{
	WebDataSource *mainFrameDs = [[[self webView] mainFrame] dataSource];
	return [@"https" isEqualTo:[[[mainFrameDs request] URL] scheme]];
}
- (void)setIsSecure:(BOOL)aFlag
{
	// just triggering change observer
}

- (NSString *)storeHost
{
    return [[storeHost retain] autorelease]; 
}

- (void)setStoreHost:(NSString *)aHost
{
    if (storeHost != aHost) {
		[storeHost release];
        storeHost = [aHost retain];
    }
}

- (void)resizeContentDivE {
	DOMElement *resizableContentE = [[[[self webView] mainFrame] DOMDocument] getElementById:@"FsprgResizableContent"];
	if(resizableContentE == nil) {
		return;
	}
	
	float windowHeight = [[self webView] frame].size.height;
	float pageNavigationHeight = [[[[self webView] windowScriptObject] evaluateWebScript:@"document.getElementsByClassName('store-page-navigation')[0].clientHeight"] floatValue];
	
	DOMCSSStyleDeclaration *cssStyle = [[self webView] computedStyleForElement:resizableContentE pseudoElement:nil];	
	float paddingTop = [[[cssStyle paddingBottom] substringToIndex:[[cssStyle paddingTop] length]-2] floatValue];
	float paddingBottom = [[[cssStyle paddingBottom] substringToIndex:[[cssStyle paddingBottom] length]-2] floatValue];
	
	float newHeight = windowHeight - paddingTop - paddingBottom - pageNavigationHeight;
	[[resizableContentE style] setHeight:[NSString stringWithFormat:@"%fpx", newHeight]];
}

- (void)webViewFrameChanged:(NSNotification *)aNotification
{
	[self resizeContentDivE];
}


// WebFrameLoadDelegate

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	[self setIsSecure:TRUE]; // just triggering change observer

	[self resizeContentDivE];
	
	NSURL *newURL = [[[frame dataSource] request] URL];
	NSString *newStoreHost;
	if ([@"file" isEqualTo:[newURL scheme]]) {
		newStoreHost = @"file";
	} else {
		newStoreHost = [newURL host];
	}
	
	if([self storeHost] == nil) {
		[self setStoreHost:newStoreHost];
		[[self delegate] didLoadStore:newURL];
	} else {
		FsprgPageType newPageType;
		if([newStoreHost isEqualTo:[self storeHost]]) {
			newPageType = FsprgPageFS;
		} else if([newStoreHost hasSuffix:@"paypal.com"]) {
			newPageType = FsprgPagePayPal;
		} else {
			newPageType = FsprgPageUnknown;
		}
		[[self delegate] didLoadPage:newURL ofType:newPageType];
	}
}

- (void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
	[[self delegate] webView:sender didFailProvisionalLoadWithError:error forFrame:frame];
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
	[[self delegate] webView:sender didFailLoadWithError:error forFrame:frame];
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
	[self setStoreHost:nil];
	
    [super dealloc];
}

@end

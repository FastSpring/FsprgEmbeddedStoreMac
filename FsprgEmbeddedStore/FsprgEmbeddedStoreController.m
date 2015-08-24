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

// We don't retrieve SSL certificates below OSX 10.6
#define RETRIEVE_SSL_CERTIFICATES defined(MAC_OS_X_VERSION_10_6) && MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_6


@interface FsprgEmbeddedStoreController (Private)

- (void)setIsLoading:(BOOL)aFlag;
- (void)setEstimatedLoadingProgress:(double)aProgress;
- (void)setIsSecure:(BOOL)aFlag;
- (void)setStoreHost:(NSString *)aHost;
- (void)resizeContentDivE;
- (void)webViewFrameChanged:(NSNotification *)aNotification;
- (NSMutableDictionary *)hostCertificates;
- (void)setHostCertificates:(NSMutableDictionary *)aHostCertificates;

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
		[self setHostCertificates:[NSMutableDictionary dictionary]];
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
		[webView setResourceLoadDelegate:nil];
		[webView setApplicationNameForUserAgent:nil];
		[[NSNotificationCenter defaultCenter] removeObserver:self];
		
		[webView release];
		webView = [aWebView retain];
		
		if (webView) {
			[webView setPostsFrameChangedNotifications:TRUE];
			[webView setFrameLoadDelegate:self];
			[webView setUIDelegate:self];
			[webView setResourceLoadDelegate:self];
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
	if (urlRequest == nil) {
		return;
	}

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

- (NSArray *)securityCertificates
{
	if ([self isSecure] == NO) {
		return nil;
	}

	NSString *mainFrameURL = [[self webView] mainFrameURL];
	NSString *host = [[NSURL URLWithString:mainFrameURL] host];
	return [[self hostCertificates] objectForKey:host];
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

- (void)resizeContentDivE
{
	if ([[self delegate] respondsToSelector:@selector(shouldStoreControllerFixContentDivHeight:)]) {
		if ([[self delegate] shouldStoreControllerFixContentDivHeight:self] == NO) {
			return;
		}
	}
	
	DOMElement *resizableContentE = [[[[self webView] mainFrame] DOMDocument] getElementById:@"FsprgResizableContent"];
	if(resizableContentE == nil) {
		return;
	}

    CGFloat windowHeight = [[self webView] frame].size.height;
	id result = [[[self webView] windowScriptObject] evaluateWebScript:@"document.getElementsByClassName('store-page-navigation')[0].clientHeight"];
	if (result == [WebUndefined undefined]) {
		return;
	}
	float pageNavigationHeight = [(NSString *)result floatValue];
	
	DOMCSSStyleDeclaration *cssStyle = [[self webView] computedStyleForElement:resizableContentE pseudoElement:nil];	
	float paddingTop = [[[cssStyle paddingBottom] substringToIndex:[[cssStyle paddingTop] length]-2] floatValue];
	float paddingBottom = [[[cssStyle paddingBottom] substringToIndex:[[cssStyle paddingBottom] length]-2] floatValue];

    CGFloat newHeight = windowHeight - paddingTop - paddingBottom - pageNavigationHeight;
	[[resizableContentE style] setHeight:[NSString stringWithFormat:@"%fpx", newHeight]];
}

- (void)webViewFrameChanged:(NSNotification *)aNotification
{
	[self resizeContentDivE];
}

- (NSMutableDictionary *)hostCertificates
{
	return [[hostCertificates retain] autorelease];
}
- (void)setHostCertificates:(NSMutableDictionary *)anHostCertificates
{
	if (hostCertificates != anHostCertificates) {
		[anHostCertificates retain];
		[hostCertificates release];
		hostCertificates = anHostCertificates;
	}
}


#pragma mark - WebFrameLoadDelegate

- (void)webView:(WebView *)sender didStartProvisionalLoadForFrame:(WebFrame *)frame
{
    if ([[self delegate] respondsToSelector:@selector(webView:didStartProvisionalLoadForFrame:)]) {
        [[self delegate] webView:sender didStartProvisionalLoadForFrame:frame];
    }
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

#pragma mark - WebUIDelegate

- (void)webView:(WebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame
{
	NSString *title = [sender mainFrameTitle];
	NSAlert *alertPanel = [NSAlert alertWithMessageText:title defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@"%@", message];
	[alertPanel beginSheetModalForWindow:[sender window] modalDelegate:nil didEndSelector:NULL contextInfo:NULL];
}

- (NSUInteger)webView:(WebView *)sender dragDestinationActionMaskForDraggingInfo:(id <NSDraggingInfo>)draggingInfo
{
	return WebDragDestinationActionNone;
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

#pragma mark - WebResourceLoadDelegate

#if RETRIEVE_SSL_CERTIFICATES
- (BOOL)webView:(WebView *)sender resource:(id)identifier canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace forDataSource:(WebDataSource *)dataSource
{
    return TRUE;
}

- (void)webView:(WebView *)sender resource:(id)identifier didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge fromDataSource:(WebDataSource *)dataSource
{
    SecTrustRef trustRef = [[challenge protectionSpace] serverTrust];
    SecTrustResultType resultType;
    SecTrustEvaluate(trustRef, &resultType);
    NSUInteger count = (NSUInteger)SecTrustGetCertificateCount(trustRef);

    NSMutableArray *certificates = [NSMutableArray arrayWithCapacity:count];
    CFIndex idx;
    for (idx = 0; idx < (CFIndex)count; idx++) {
        SecCertificateRef certificateRef = SecTrustGetCertificateAtIndex(trustRef, idx);
        [certificates addObject:(id)certificateRef];
    }

    NSString *host = [[challenge protectionSpace] host];
    [[self hostCertificates] setObject:certificates forKey:host];

    [[challenge sender] useCredential:[NSURLCredential credentialForTrust:trustRef] forAuthenticationChallenge:challenge];
}
#endif


- (void)dealloc
{
	[self setWebView:nil];
	[self setDelegate:nil];
	[self setStoreHost:nil];
	[self setHostCertificates:nil];

	[super dealloc];
}

@end

//
//  FsprgEmbeddedStoreController.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "FsprgEmbeddedStoreDelegate.h"


@interface FsprgEmbeddedStoreController : NSObject {
	WebView* webView;
	id <FsprgEmbeddedStoreDelegate> delegate;
	BOOL isInitialLoad;
}

- (WebView *)webView;
- (void)setWebView:(WebView *)aWebView;
- (id <FsprgEmbeddedStoreDelegate>)delegate;
- (void)setDelegate:(id <FsprgEmbeddedStoreDelegate>)aDelegate;

- (void)loadWithParameters:(FsprgStoreParameters *)parameters;
- (void)loadWithContentsOfFile:(NSString *)aPath;
- (BOOL)isLoading;
- (double)estimatedLoadingProgress;

@end
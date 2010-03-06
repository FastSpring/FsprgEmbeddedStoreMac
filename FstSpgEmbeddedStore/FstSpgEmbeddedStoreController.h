//
//  FstSpgEmbeddedStoreController.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "FstSpgEmbeddedStoreDelegate.h"


@interface FstSpgEmbeddedStoreController : NSObject {
	WebView* webView;
	id <FstSpgEmbeddedStoreDelegate> delegate;
	BOOL isInitialLoad;
}

- (WebView *)webView;
- (void)setWebView:(WebView *)aWebView;
- (id <FstSpgEmbeddedStoreDelegate>)delegate;
- (void)setDelegate:(id <FstSpgEmbeddedStoreDelegate>)aDelegate;

- (void)loadWithParameters:(FstSpgStoreParameters *)parameters;
- (BOOL)isLoading;
- (double)estimatedLoadingProgress;

@end
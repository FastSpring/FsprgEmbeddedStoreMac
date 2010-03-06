//
//  FSEmbeddedStoreController.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "FSEmbeddedStoreDelegate.h"


@interface FSEmbeddedStoreController : NSObject {
	WebView* webView;
	id <FSEmbeddedStoreDelegate> delegate;
}

- (WebView *)webView;
- (void)setWebView:(WebView *)aWebView;
- (id <FSEmbeddedStoreDelegate>)delegate;
- (void)setDelegate:(id <FSEmbeddedStoreDelegate>)aDelegate;

- (void)load;

@end
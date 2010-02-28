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
	IBOutlet WebView* webView;
	BOOL loading;
	id <FSEmbeddedStoreDelegate> delegate;
}

- (id <FSEmbeddedStoreDelegate>)delegate;
- (void)setDelegate:(id <FSEmbeddedStoreDelegate>)aDelegate;

- (IBAction)load:(id)sender;

- (void)setLoading:(BOOL)aFlag;
- (BOOL)loading;

@end
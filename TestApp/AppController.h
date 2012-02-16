//
//  AppController.h
//  TestApp
//
//  Created by Lars Steiger on 2/28/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "FsprgEmbeddedStore.h"


@interface AppController : NSObject <FsprgEmbeddedStoreDelegate> {
	IBOutlet NSWindow *window;
	IBOutlet NSView* settingsView;
	IBOutlet NSView* previewView;
	IBOutlet NSTextField* previewURL;
	IBOutlet NSTextField* previewPageType;
	IBOutlet WebView* previewWebView;
	FsprgStoreParameters *params;
	FsprgEmbeddedStoreController *storeController;
}

- (FsprgStoreParameters *)params;
- (void)setParams:(FsprgStoreParameters *)aParams;
- (FsprgEmbeddedStoreController *)storeController;
- (void)setStoreController:(FsprgEmbeddedStoreController *)aStoreController;
- (IBAction)switchToSettings:(id)sender;
- (IBAction)switchToPreview:(id)sender;
- (IBAction)reloadPreview:(id)sender;

@end

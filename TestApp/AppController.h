//
//  AppController.h
//  TestApp
//
//  Created by Lars Steiger on 2/28/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <FstSpgEmbeddedStore/FstSpgEmbeddedStore.h>


@interface AppController : NSObject <FstSpgEmbeddedStoreDelegate> {
	IBOutlet NSWindow *window;
	IBOutlet NSView* settingsView;
	IBOutlet NSView* previewView;
	IBOutlet WebView* previewWebView;
	FstSpgStoreParameters *params;
	FstSpgEmbeddedStoreController *storeController;
}

- (FstSpgStoreParameters *)params;
- (void)setParams:(FstSpgStoreParameters *)aParams;
- (FstSpgEmbeddedStoreController *)storeController;
- (void)setStoreController:(FstSpgEmbeddedStoreController *)aStoreController;
- (IBAction)switchToSettings:(id)sender;
- (IBAction)switchToPreview:(id)sender;
- (IBAction)reloadPreview:(id)sender;

@end

//
//  AppController.h
//  Example1
//
//  Created by Lars Steiger on 2/28/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <FstSpgEmbeddedStore/FstSpgEmbeddedStore.h>


@interface AppController : NSObject <FstSpgEmbeddedStoreDelegate> {
	IBOutlet WebView* storeView;
	FstSpgEmbeddedStoreController *storeController;
}

- (FstSpgEmbeddedStoreController *)storeController;
- (void)setStoreController:(FstSpgEmbeddedStoreController *)aStoreController;

- (IBAction)load:(id)sender;

@end

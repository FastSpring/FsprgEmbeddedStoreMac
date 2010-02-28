//
//  AppController.h
//  Example1
//
//  Created by Lars Steiger on 2/28/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import <FSEmbeddedStore/FSEmbeddedStore.h>


@interface AppController : NSObject <FSEmbeddedStoreDelegate> {
	IBOutlet WebView* storeView;
	FSEmbeddedStoreController *storeController;
}

- (IBAction)load:(id)sender;

@end

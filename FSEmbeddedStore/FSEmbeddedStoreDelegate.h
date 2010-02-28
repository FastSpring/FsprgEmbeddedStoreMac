//
//  FSEmbeddedStoreDelegate.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/22/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "FSStoreParameters.h";
#import "WebFrame+FSDomAccessor.h"
#import "FSOrder.h";


@protocol FSEmbeddedStoreDelegate <NSObject>

- (void)willLoadStoreWithParameters:(FSStoreParameters *)parameters;
- (void)didLoadWebFrame:(WebFrame *)frame;
- (void)didReceiveOrder:(FSOrder *)order;
- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FSOrder *)order;

@end

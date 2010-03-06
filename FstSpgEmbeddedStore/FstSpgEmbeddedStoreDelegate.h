//
//  FstSpgEmbeddedStoreDelegate.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/22/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FstSpgStoreParameters.h";
#import "FstSpgOrder.h";


@protocol FstSpgEmbeddedStoreDelegate <NSObject>

- (void)didLoadStore;
- (void)didReceiveOrder:(FstSpgOrder *)order;
- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FstSpgOrder *)order;

@end

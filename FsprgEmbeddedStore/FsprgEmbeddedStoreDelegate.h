//
//  FsprgEmbeddedStoreDelegate.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/22/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FsprgStoreParameters.h";
#import "FsprgOrder.h";


@protocol FsprgEmbeddedStoreDelegate <NSObject>

- (void)didLoadStore;
- (void)didReceiveOrder:(FsprgOrder *)order;
- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FsprgOrder *)order;

@end

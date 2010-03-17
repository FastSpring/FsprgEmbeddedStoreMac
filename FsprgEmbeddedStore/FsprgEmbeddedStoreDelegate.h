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


/*!
 * Delegate protocol for FsprgEmbeddedStoreController.
 */
@protocol FsprgEmbeddedStoreDelegate <NSObject>

/*!
 * Gets called on initial load of the store.
 */
- (void)didLoadStore;

/*!
 * Gets called after finishing the order process.
 * @param order Order information
 */
- (void)didReceiveOrder:(FsprgOrder *)order;

/*!
 * Gets called to present the order confirmation.
 * @param frame The frame rectangle for the view object
 * @param order Order information
 * @result The view presenting the order confirmation
 */
- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FsprgOrder *)order;

@end

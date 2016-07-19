//
//  FsprgOrderView.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/18/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>


/*!
 * WebDocumentView implementation encapsulating the order
 * confirmation view of FsprgEmbeddedStoreDelegate.
 */
@interface FsprgOrderView : NSView <WebDocumentView> {
	WebDataSource *dataSource;
	BOOL needsLayout;
}

@property (NS_NONATOMIC_IOSONLY, assign) WebDataSource *dataSource;
@property (NS_NONATOMIC_IOSONLY) BOOL needsLayout;

@end

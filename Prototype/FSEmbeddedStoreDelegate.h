//
//  FSEmbeddedStoreDelegate.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/18/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FSStoreParameters.h";
#import "FSOrder.h";


@interface FSEmbeddedStoreDelegate : NSObject {

}

- (void)willLoadStoreWithParameters:(FSStoreParameters *)parameters;
- (void)didReceiveOrder:(FSOrder *)order;
- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FSOrder *)order;

@end

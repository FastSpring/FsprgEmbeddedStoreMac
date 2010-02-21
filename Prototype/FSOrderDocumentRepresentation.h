//
//  FSOrderDocumentRepresentation.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "FSOrder.h"


@interface FSOrderDocumentRepresentation : NSObject <WebDocumentRepresentation> {
	FSOrder *order;
}

- (FSOrder *)order;
- (void)setOrder:(FSOrder *)anOrder;

@end

//
//  FstSpgOrderDocumentRepresentation.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "FstSpgOrder.h"


@interface FstSpgOrderDocumentRepresentation : NSObject <WebDocumentRepresentation> {
	FstSpgOrder *order;
}

- (FstSpgOrder *)order;
- (void)setOrder:(FstSpgOrder *)anOrder;

@end

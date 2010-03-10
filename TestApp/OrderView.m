//
//  OrderView.m
//  TestApp
//
//  Created by Lars Steiger on 3/10/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "OrderView.h"


@implementation OrderView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	[[NSColor windowBackgroundColor] set];
	[NSBezierPath fillRect: [self bounds]];
}

@end

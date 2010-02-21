//
//  FSOrderView.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/18/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSOrderView.h"
#import "FSOrderDocumentRepresentation.h"
#import "FSOrder.h"


@implementation FSOrderView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setDataSource:nil];
        [self setNeedsLayout:FALSE];
    }
    return self;
}

- (WebDataSource *)dataSource
{
    return [[dataSource retain] autorelease]; 
}
- (void)setDataSource:(WebDataSource *)aDataSource
{
    if (dataSource != aDataSource) {
        [dataSource release];
        dataSource = [aDataSource retain];
    }
}
- (void)dataSourceUpdated:(WebDataSource *)aDataSource
{
	[self setDataSource:aDataSource];
}

- (BOOL)needsLayout
{
    return needsLayout;
}

- (void)setNeedsLayout:(BOOL)flag
{
    needsLayout = flag;
}

- (void)drawRect:(NSRect)aRect
{
	[self setFrame:[[[dataSource webFrame] frameView] frame]];
	
	NSUInteger i, count = [[self subviews] count];
	for (i = 0; i < count; i++) {
		NSView *subview = [[self subviews] objectAtIndex:i];
		[subview setFrame:[self frame]];
	}
	
	if([self needsLayout]) {
		[self setNeedsLayout:FALSE];
		[self layout];
	}
	[super drawRect:aRect];
}

- (void)layout
{
	if([[self subviews] count] == 0) {
		[self setFrame:[[[dataSource webFrame] frameView] frame]];
		
		FSOrderDocumentRepresentation *representation = [[self dataSource] representation];
		FSOrder *order = [representation order];

		id delegate = [[[[self dataSource] webFrame] webView] UIDelegate];
		NSView *newSubview = [delegate viewWithFrame:[self frame] forOrder:order];
		[self addSubview:newSubview];
	}
}

- (void)viewDidMoveToHostWindow
{
}
- (void)viewWillMoveToHostWindow:(NSWindow *)hostWindow
{
}

@end

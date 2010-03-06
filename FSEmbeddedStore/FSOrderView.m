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
#import "FSEmbeddedStoreController.h"


@implementation FSOrderView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setDataSource:nil];
        [self setNeedsLayout:FALSE];
		[self setAutoresizesSubviews:TRUE];
		[self setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
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
	if([self needsLayout]) {
		[self setNeedsLayout:FALSE];
		[self layout];
	}
	[super drawRect:aRect];
}

- (void)layout
{
	if([[self subviews] count] == 0) {
		[self setFrame:[[self superview] frame]];
		
		FSOrderDocumentRepresentation *representation = [[self dataSource] representation];
		FSOrder *order = [representation order];

		FSEmbeddedStoreController *delegate = [[[[self dataSource] webFrame] webView] UIDelegate];
		NSView *newSubview = [[delegate delegate] viewWithFrame:[self frame] forOrder:order];
		[self addSubview:newSubview];
	}
}

- (void)viewDidMoveToHostWindow
{
}
- (void)viewWillMoveToHostWindow:(NSWindow *)hostWindow
{
}

- (void)dealloc
{
    [self setDataSource:nil];
	
    [super dealloc];
}

@end

//
//  FsprgOrderView.m
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/18/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FsprgOrderView.h"
#import "FsprgOrderDocumentRepresentation.h"
#import "FsprgEmbeddedStoreController.h"


@implementation FsprgOrderView

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setDataSource:nil];
        [self setNeedsLayout:FALSE];
		[self setAutoresizesSubviews:TRUE];
		self.autoresizingMask = (NSViewWidthSizable | NSViewHeightSizable);
    }
    return self;
}

- (WebDataSource *)dataSource
{
    return dataSource; 
}
- (void)setDataSource:(WebDataSource *)aDataSource
{
    if (dataSource != aDataSource) {
        dataSource = aDataSource;
    }
}
- (void)dataSourceUpdated:(WebDataSource *)aDataSource
{
	self.dataSource = aDataSource;
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
	if(self.needsLayout) {
		[self setNeedsLayout:FALSE];
		[self layout];
	}
	[super drawRect:aRect];
}

- (void)layout
{
	if(self.subviews.count == 0) {
		self.frame = self.superview.frame;
		
		FsprgOrderDocumentRepresentation *representation = (FsprgOrderDocumentRepresentation *)self.dataSource.representation;
		FsprgOrder *order = representation.order;

		FsprgEmbeddedStoreController *delegate = self.dataSource.webFrame.webView.UIDelegate;
		NSView *newSubview = [delegate.delegate viewWithFrame:self.frame forOrder:order];
		[self addSubview:newSubview];
	}

	[super layout];
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
	
}

@end

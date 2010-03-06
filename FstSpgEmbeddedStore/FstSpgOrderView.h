//
//  FstSpgOrderView.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/18/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>


@interface FstSpgOrderView : NSView <WebDocumentView> {
	WebDataSource *dataSource;
	BOOL needsLayout;
}

- (WebDataSource *)dataSource;
- (void)setDataSource:(WebDataSource *)aDataSource;
- (BOOL)needsLayout;
- (void)setNeedsLayout:(BOOL)flag;

@end

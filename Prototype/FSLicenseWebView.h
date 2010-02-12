//
//  FSLicenseWebView.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>


@interface FSLicenseWebView : WebView {
	WebDataSource *dataSource;
}

- (void)setDataSource:(WebDataSource *)aDataSource;
- (void)dataSourceUpdated:(WebDataSource *)aDataSource;
- (void)setNeedsLayout:(BOOL)flag;
- (void)layout;

@end

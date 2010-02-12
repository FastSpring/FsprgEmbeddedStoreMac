//
//  FSLicenseWebView.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSLicenseWebView.h"
#import "FSLicenseDocumentRepresentation.h"


@implementation FSLicenseWebView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)setDataSource:(WebDataSource *)aDataSource {
	dataSource = [aDataSource retain];	
}

- (void)dataSourceUpdated:(WebDataSource *)aDataSource {
	dataSource = aDataSource;
}

- (void)setNeedsLayout:(BOOL)flag {
	[self setFrame:[[[dataSource webFrame] frameView] frame]];

	FSLicenseDocumentRepresentation *representation = [dataSource representation];
	
	NSString *name = [[representation license] valueForKey:@"Name"];
	NSString *email = [[representation license] valueForKey:@"Email"];
	NSString *htmlStr = [NSString stringWithFormat:@"<html><body><center><h1>Hi %@</h1><br/>Thanks for buying a license!<br/><br/>FSEmbeddedStore prototype is now registered for %@.</center></body></html>", name, email];
	[[self mainFrame] loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@""]];	
}

- (void)layout {
}


@end

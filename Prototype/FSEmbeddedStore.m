//
//  FSEmbeddedStore.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSEmbeddedStore.h"
#import "FSLicenseWebView.h"
#import "FSLicenseDocumentRepresentation.h"


@implementation FSEmbeddedStore

- (void)awakeFromNib {
	[WebView registerViewClass:[FSLicenseWebView class] representationClass:[FSLicenseDocumentRepresentation class] forMIMEType:@"text/plain"];
	[self open:nil];
}

- (IBAction)open:(id)sender {
	[self setLoading:TRUE];
	[webView setFrameLoadDelegate:self];

	NSString *path = [[NSBundle mainBundle] pathForResource:@"page1" ofType:@"html"];
	NSString *urlAsStr = [NSString stringWithFormat:@"file://%@", path];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlAsStr]];
	[[webView mainFrame] loadRequest:request];
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
	[self setLoading:FALSE];
}

- (void)setLoading:(BOOL)aFlag {
	loading = aFlag;
}

- (BOOL)loading {
	return loading;
}


@end

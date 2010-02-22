//
//  MyEmbeddedStoreController.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/22/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "MyEmbeddedStoreController.h"
#import "MyOrderViewController.h"
#import "FSStoreParameters.h"


@implementation MyEmbeddedStoreController

- (void)awakeFromNib
{
	[super setDelegate:self];
	[super load:nil];
}

- (void)willLoadStoreWithParameters:(FSStoreParameters *)parameters {
	[parameters setStoreId:@"" withProduct:@""];
	[parameters setCampaign:@""];
	[parameters setOption:@""];
	[parameters setMode:kFSModeTest];
	[parameters setReferrer:@""];
	[parameters setSource:@""];
}

- (void)didReceiveOrder:(FSOrder *)order
{
}

- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FSOrder *)order
{
	// using HTML to draw the view
	// see http://mattgemmell.com/2008/05/20/mgtemplateengine-templates-with-cocoa
	//WebView *webView = [[WebView alloc] initWithFrame:frame];
	//NSString *name = [order valueForKey:@"Name"];
	//NSString *email = [order valueForKey:@"Email"];
	//NSString *htmlStr = [NSString stringWithFormat:@"<html><body><center><h1>Hi %@</h1><br/>Thanks for buying a license!<br/><br/>FSEmbeddedStore prototype is now registered for %@.</center></body></html>", name, email];
	//[[webView mainFrame] loadHTMLString:htmlStr baseURL:[NSURL URLWithString:@""]];
	//return webView;
	
	// using a nib to draw the view
	// * create empty nib
	// * add CustomView
	// * set Class of File's Owner to NSViewController
	// * connect outlet view of File's Owner with CustomView
	// * add e.g. a Label to the CustomView
	// * bind Value to File's Owner representedObject.Name
	MyOrderViewController *controller = [[[MyOrderViewController alloc] initWithNibName:@"MyOrderView" bundle:nil] retain];
	[controller setRepresentedObject:order];
	return [controller view];
}

@end

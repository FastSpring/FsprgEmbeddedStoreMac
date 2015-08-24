//
//  AppController.m
//  Example1
//
//  Created by Lars Steiger on 2/28/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "AppController.h"
#import <AddressBook/AddressBook.h>
#import "OrderViewController.h"


@implementation AppController

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setStoreController:[[[FsprgEmbeddedStoreController alloc] init] autorelease]];
		[[self storeController] setDelegate:self];
	}
	return self;
}

- (void)awakeFromNib
{
	[[self storeController] setWebView:storeView];
	[self load:nil];
}

- (FsprgEmbeddedStoreController *)storeController
{
    return [[storeController retain] autorelease]; 
}

- (void)setStoreController:(FsprgEmbeddedStoreController *)aStoreController
{
    if (storeController != aStoreController) {
        [storeController release];
        storeController = [aStoreController retain];
    }
}

- (IBAction)load:(id)sender
{
	FsprgStoreParameters *parameters = [FsprgStoreParameters parameters];
	[parameters setOrderProcessType:kFsprgOrderProcessDetail];
	[parameters setStoreId:@"your_store" withProductId:@"your_product"];
	[parameters setMode:kFsprgModeTest];
	
	ABPerson *me = [[ABAddressBook sharedAddressBook] me];
	[parameters setContactFname:[me valueForProperty:kABFirstNameProperty]];
	[parameters setContactLname:[me valueForProperty:kABLastNameProperty]];
	[parameters setContactCompany:[me valueForProperty:kABOrganizationProperty]];
	
	ABMultiValue *allEmails = [me valueForProperty:kABEmailProperty];
	NSString *email = [allEmails valueAtIndex:[allEmails indexForIdentifier:[allEmails primaryIdentifier]]];
	[parameters setContactEmail:email];
	
	ABMultiValue *allPhones = [me valueForProperty:kABPhoneProperty];
	NSString *phone = [allPhones valueAtIndex:[allPhones indexForIdentifier:[allPhones primaryIdentifier]]];
	[parameters setContactPhone:phone];
	
	[[self storeController] loadWithParameters:parameters];
}

// FsprgEmbeddedStoreDelegate

- (void)didLoadStore:(NSURL *)url
{
}

- (void)didLoadPage:(NSURL *)url ofType:(FsprgPageType)pageType
{
}

- (void)didReceiveOrder:(FsprgOrder *)order
{
	NSLog(@"Order from %@ successfully received.", [order customerEmail]);
}

- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FsprgOrder *)order
{
	OrderViewController *orderViewController = [[OrderViewController alloc] initWithNibName:@"OrderView" bundle:nil];
	[orderViewController setRepresentedObject:order];

	[[orderViewController view] setFrame:frame];
	return [orderViewController view];
}

- (void)webView:(WebView *)sender didFailProvisionalLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
    NSRunAlertPanel(@"Alert", @"%@", @"OK", nil, nil, [error localizedDescription]);
}

- (void)webView:(WebView *)sender didFailLoadWithError:(NSError *)error forFrame:(WebFrame *)frame
{
    NSRunAlertPanel(@"Alert", @"%@", @"OK", nil, nil, [error localizedDescription]);
}

- (void)dealloc
{
	[[self storeController] setDelegate:nil];
    [self setStoreController:nil];
	
    [super dealloc];
}

@end

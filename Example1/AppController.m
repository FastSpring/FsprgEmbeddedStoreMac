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
		[self setStoreController:[[[FstSpgEmbeddedStoreController alloc] init] autorelease]];
		[[self storeController] setDelegate:self];
	}
	return self;
}

- (void)awakeFromNib
{
	[[self storeController] setWebView:storeView];
	[self load:nil];
}

- (FstSpgEmbeddedStoreController *)storeController
{
    return [[storeController retain] autorelease]; 
}

- (void)setStoreController:(FstSpgEmbeddedStoreController *)aStoreController
{
    if (storeController != aStoreController) {
        [storeController release];
        storeController = [aStoreController retain];
    }
}

- (IBAction)load:(id)sender
{
	FstSpgStoreParameters *parameters = [FstSpgStoreParameters parameters];
	[parameters setStoreId:@"spootnik" withProductId:@"fsembeddedstore"];
	[parameters setMode:kFstSpgModeTest];
	
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

// FstSpgEmbeddedStoreDelegate

- (void)didLoadStore
{
}

- (void)didReceiveOrder:(FstSpgOrder *)order
{
	NSLog(@"Order from %@ successfully received.", [order customerEmail]);
}

- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FstSpgOrder *)order
{
	OrderViewController *orderViewController = [[OrderViewController alloc] initWithNibName:@"OrderView" bundle:nil];
	[orderViewController setRepresentedObject:order];

	[[orderViewController view] setFrame:frame];
	return [orderViewController view];
}

- (void)dealloc
{
    [self setStoreController:nil];
	
    [super dealloc];
}

@end

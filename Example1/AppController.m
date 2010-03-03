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

- (void)awakeFromNib
{
	storeController = [[FSEmbeddedStoreController alloc] init];
	[storeController setWebView:storeView];
	[storeController setDelegate:self];
	[storeController load];
}

- (IBAction)load:(id)sender
{
	[storeController load];
}

// FSEmbeddedStoreDelegate

- (void)willLoadStoreWithParameters:(FSStoreParameters *)parameters
{
	[parameters setStoreId:@"spootnik" withProductId:@"fsembeddedstore"];
	[parameters setMode:kFSModeTest];

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
}

- (void)didReceiveOrder:(FSOrder *)order
{
	NSLog(@"Order from %@ successfully received.", [order customerEmail]);
}

- (NSView *)viewWithFrame:(NSRect)frame forOrder:(FSOrder *)order
{
	OrderViewController *orderViewController = [[OrderViewController alloc] initWithNibName:@"OrderView" bundle:nil];
	[orderViewController setRepresentedObject:order];
	return [orderViewController view];
}

@end

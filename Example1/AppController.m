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
}

- (void)didLoadWebFrame:(WebFrame *)frame
{
	if([frame fs_valueForId:kFSNameFieldId] != nil) {
		ABPerson *me = [[ABAddressBook sharedAddressBook] me];
		
		NSString *firstName = [me valueForProperty:kABFirstNameProperty];
		NSString *lastName = [me valueForProperty:kABLastNameProperty];
		[frame fs_setValue:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forId:kFSNameFieldId];
		[frame fs_setValue:[me valueForProperty:kABOrganizationProperty] forId:kFSCompanyFieldId];
		
		ABMultiValue *allPhones = [me valueForProperty:kABPhoneProperty];
		NSString *phone = [allPhones valueAtIndex:[allPhones indexForIdentifier:[allPhones primaryIdentifier]]];
		[frame fs_setValue:phone forId:kFSPhoneNumberFieldId];
		
		ABMultiValue *allEmails = [me valueForProperty:kABEmailProperty];
		NSString *email = [allEmails valueAtIndex:[allEmails indexForIdentifier:[allEmails primaryIdentifier]]];
		[frame fs_setValue:email forId:kFSEmailFieldId];
		
		ABMultiValue *allAddresses = [me valueForProperty:kABAddressProperty];
		NSDictionary *address = [allAddresses valueAtIndex:[allAddresses indexForIdentifier:[allAddresses primaryIdentifier]]];
		
		NSString *countryCode = [[address valueForKey:kABAddressCountryCodeKey] uppercaseString];
		[frame fs_setValue:countryCode forId:kFSCountryFieldId];
		[frame fs_setValue:[address valueForKey:kABAddressStreetKey] forId:kFSAddress1FieldId];
		[frame fs_setValue:@"" forId:kFSAddress2FieldId];
		[frame fs_setValue:[address valueForKey:kABAddressCityKey] forId:kFSCityFieldId];
		NSString *state = [address valueForKey:kABAddressStateKey];
		if(state != nil && ([countryCode isEqual:@"US"] || [countryCode isEqual:@"CA"] || [countryCode isEqual:@"AU"])) {
			NSString *region = [NSString stringWithFormat:@"%@-%@", countryCode, state];
			[frame fs_setValue:region forId:kFSRegionFieldId];
		} else {
			[frame fs_setValue:@"" forId:kFSRegionFieldId];
		}
		[frame fs_setValue:[address valueForKey:kABAddressZIPKey] forId:kFSPostalCodeFieldId];
	}
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

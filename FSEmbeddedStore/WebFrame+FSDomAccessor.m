//
//  WebFrame+FSDomAccessor.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/26/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "WebFrame+FSDomAccessor.h"

NSString * const kFSNameFieldId = @"user:name";
NSString * const kFSCompanyFieldId = @"user:company";
NSString * const kFSPhoneNumberFieldId = @"user:phone_number";
NSString * const kFSEmailFieldId = @"user:email";
NSString * const kFSCountryFieldId = @"user:country";
NSString * const kFSAddress1FieldId = @"user:address_1";
NSString * const kFSAddress2FieldId = @"user:address_2";
NSString * const kFSCityFieldId = @"user:city";
NSString * const kFSRegionFieldId = @"user:region";
NSString * const kFSPostalCodeFieldId = @"user:postal_code";

@implementation WebFrame (FSDomAccessor)

- (void)fs_setValue:(NSString *)aValue forId:(NSString *)anId;
{
	if(aValue == nil) {
		aValue = @"";
	}

	//NSString *script = [NSString stringWithFormat:@"document.getElementById('%@').value='%@'",anId, aValue];
	//[[self windowObject] evaluateWebScript:script];
	return [[[self DOMDocument] getElementById:anId] setValue:aValue];
}

- (NSString *)fs_valueForId:(NSString *)anId
{
	//NSString *script = [NSString stringWithFormat:@"document.getElementById('%@').value",anId];
	//return [[self windowObject] evaluateWebScript:script];
	return [[[self DOMDocument] getElementById:anId] value];
}

/**
 MOVE TO EXAMPLE
 
 - (IBAction)fillMeFromAddressBook:(id)sender
 {
 ABPerson *me = [[ABAddressBook sharedAddressBook] me];
 
 NSString *firstName = [me valueForProperty:kABFirstNameProperty];
 NSString *lastName = [me valueForProperty:kABLastNameProperty];
 [self fs_setValue:[NSString stringWithFormat:@"%@ %@", firstName, lastName] forId:kFSNameFieldId];
 [self fs_setValue:[me valueForProperty:kABOrganizationProperty] forId:kFSCompanyFieldId];
 
 ABMultiValue *allPhones = [me valueForProperty:kABPhoneProperty];
 NSString *phone = [allPhones valueAtIndex:[allPhones indexForIdentifier:[allPhones primaryIdentifier]]];
 [self fs_setValue:phone forId:kFSPhoneNumberFieldId];
 
 ABMultiValue *allEmails = [me valueForProperty:kABEmailProperty];
 NSString *email = [allEmails valueAtIndex:[allEmails indexForIdentifier:[allEmails primaryIdentifier]]];
 [self fs_setValue:email forId:kEmailFieldId];
 
 ABMultiValue *allAddresses = [me valueForProperty:kABAddressProperty];
 NSDictionary *address = [allAddresses valueAtIndex:[allAddresses indexForIdentifier:[allAddresses primaryIdentifier]]];
 
 NSString *countryCode = [[address valueForKey:kABAddressCountryCodeKey] uppercaseString];
 [self fs_setValue:countryCode forId:kCountryFieldId];
 [self fs_setValue:[address valueForKey:kABAddressStreetKey] forId:kAddress1FieldId];
 [self fs_setValue:@"" forId:kAddress2FieldId];
 [self fs_setValue:[address valueForKey:kABAddressCityKey] forId:kCityFieldId];
 NSString *state = [address valueForKey:kABAddressStateKey];
 if(state != nil && ([countryCode isEqual:@"US"] || [countryCode isEqual:@"CA"] || [countryCode isEqual:@"AU"])) {
 NSString *region = [NSString stringWithFormat:@"%@-%@", countryCode, state];
 [self fs_setValue:region forId:kFSRegionFieldId];
 } else {
 [self fs_setValue:@"" forId:kFSRegionFieldId];
 }
 [self fs_setValue:[address valueForKey:kABAddressZIPKey] forId:kFSPostalCodeFieldId];
 }
 */

@end

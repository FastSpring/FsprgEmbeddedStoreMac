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

	return [[[self DOMDocument] getElementById:anId] setValue:aValue];
}

- (NSString *)fs_valueForId:(NSString *)anId
{
	DOMElement *element = [[self DOMDocument] getElementById:anId];
	if(element == nil) {
		return nil;
	} else {
		return [element value];
	}
}

@end

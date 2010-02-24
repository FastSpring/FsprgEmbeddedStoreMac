//
//  FSFulfillment.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSFulfillment.h"
#import "FSLicense.h"
#import "FSFileDownload.h"


@implementation FSFulfillment

+ (FSFulfillment *)fulfillmentWithDictionary:(NSDictionary *)aDictionary
{
	return [[[FSFulfillment alloc] initWithDictionary:aDictionary] autorelease];
}

- (FSFulfillment *)initWithDictionary:(NSDictionary *)aDictionary
{
	self = [super init];
	if (self != nil) {
		[self setRaw:aDictionary];
	}
	return self;
}
- (NSDictionary *)raw
{
    return [[raw retain] autorelease]; 
}

- (void)setRaw:(NSDictionary *)aDictionary
{
    if (raw != aDictionary) {
        [raw release];
        raw = [aDictionary retain];
    }
}

- (id)valueForKey:(NSString *)aKey
{
	NSDictionary *anItem = [[self raw] valueForKey:aKey];
	
	if([[anItem valueForKey:@"FulfillmentType"] isEqual:@"License"]) {
		return [FSLicense licenseWithDictionary:anItem];
	}
	if([[anItem valueForKey:@"FulfillmentType"] isEqual:@"File"]) {
		return [FSFileDownload fileDownloadWithDictionary:anItem];
	}
	
	return anItem;
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
	// Don't need KVO as data won't change. Prevent having to keep (retain) instance variables.
	return FALSE;
}

- (void)dealloc
{
    [self setRaw:nil];
	
    [super dealloc];
}

@end

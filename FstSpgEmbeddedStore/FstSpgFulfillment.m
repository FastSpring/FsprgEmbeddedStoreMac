//
//  FstSpgFulfillment.m
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FstSpgFulfillment.h"
#import "FstSpgLicense.h"
#import "FstSpgFileDownload.h"


@implementation FstSpgFulfillment

+ (FstSpgFulfillment *)fulfillmentWithDictionary:(NSDictionary *)aDictionary
{
	return [[[FstSpgFulfillment alloc] initWithDictionary:aDictionary] autorelease];
}

- (FstSpgFulfillment *)initWithDictionary:(NSDictionary *)aDictionary
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
		return [FstSpgLicense licenseWithDictionary:anItem];
	}
	if([[anItem valueForKey:@"FulfillmentType"] isEqual:@"File"]) {
		return [FstSpgFileDownload fileDownloadWithDictionary:anItem];
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

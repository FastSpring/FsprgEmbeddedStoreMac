//
//  FstSpgOrderItem.m
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FstSpgOrderItem.h"


@implementation FstSpgOrderItem

+ (FstSpgOrderItem *)itemWithDictionary:(NSDictionary *)aDictionary
{
	return [[[FstSpgOrderItem alloc] initWithDictionary:aDictionary] autorelease];
}

- (FstSpgOrderItem *)initWithDictionary:(NSDictionary *)aDictionary
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

- (NSString *)productName
{
	return [[self raw] valueForKey:@"ProductName"];
}

- (NSString *)productDisplay
{
	return [[self raw] valueForKey:@"ProductDisplay"];
}

- (NSNumber *)quantity
{
	return [[self raw] valueForKey:@"Quantity"];
}

- (FstSpgFulfillment *)fulfillment
{
	return [FstSpgFulfillment fulfillmentWithDictionary:[[self raw] valueForKey:@"Fulfillment"]];
}

- (FstSpgLicense *)license
{
	return [[self fulfillment] valueForKey:@"license"];
}

- (FstSpgFileDownload *)download
{
	return [[self fulfillment] valueForKey:@"download"];
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

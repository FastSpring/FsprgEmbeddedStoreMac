//
//  FSOrderItem.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSOrderItem.h"


@implementation FSOrderItem

+ (FSOrderItem *)itemWithDictionary:(NSDictionary *)aDictionary
{
	return [[[FSOrderItem alloc] initWithDictionary:aDictionary] autorelease];
}

- (FSOrderItem *)initWithDictionary:(NSDictionary *)aDictionary
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

- (FSFulfillment *)fulfillment
{
	return [FSFulfillment fulfillmentWithDictionary:[[self raw] valueForKey:@"Fulfillment"]];
}

- (FSLicense *)license
{
	return [[self fulfillment] valueForKey:@"license"];
}

- (FSFileDownload *)download
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

//
//  FSOrder.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSOrder.h"


@implementation FSOrder

+ (FSOrder *)orderFromData:(NSData *)aData
{
	NSPropertyListFormat *format = nil;
	NSString *errorDesc = nil;
	
	NSDictionary *aDict = [NSPropertyListSerialization propertyListFromData:aData
													   mutabilityOption:NSPropertyListImmutable
													   format:format 
													   errorDescription:&errorDesc];
		
	
	return [[[FSOrder alloc] initWithDictionary:aDict] autorelease];
}

- (FSOrder *)initWithDictionary:(NSDictionary *)aDictionary
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

- (BOOL)orderIsTest
{
	return [[[self raw] valueForKey:@"OrderIsTest"] boolValue];
}

- (NSString *)orderReference
{
	return [[self raw] valueForKey:@"OrderReference"];
}

- (NSString *)orderLanguage
{
	return [[self raw] valueForKey:@"OrderLanguage"];
}

- (NSString *)orderCurrency
{
	return [[self raw] valueForKey:@"OrderCurrency"];
}

- (NSNumber *)orderTotal
{
	return [[self raw] valueForKey:@"OrderTotal"];
}

- (NSString *)customerFirstName
{
	return [[self raw] valueForKey:@"CustomerFirstName"];
}

- (NSString *)customerLastName
{
	return [[self raw] valueForKey:@"CustomerLastName"];
}

- (NSString *)customerCompany
{
	return [[self raw] valueForKey:@"CustomerCompany"];
}

- (NSString *)customerEmail
{
	return [[self raw] valueForKey:@"CustomerEmail"];
}

- (FSOrderItem *)firstOrderItem
{
	NSArray *items = [[self raw] valueForKey:@"OrderItems"];
	return [FSOrderItem itemWithDictionary:[items objectAtIndex:0]];
}

- (NSArray *)orderItems
{
	NSArray *items = [[self raw] valueForKey:@"OrderItems"];
	NSMutableArray *orderItems = [NSMutableArray arrayWithCapacity:[items count]];

	NSUInteger i, count = [items count];
	for (i = 0; i < count; i++) {
		NSDictionary *anItem = [items objectAtIndex:i];
		[orderItems addObject:[FSOrderItem itemWithDictionary:anItem]];
	}
	
	return orderItems;
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

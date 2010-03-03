//
//  FSStoreParameters.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSStoreParameters.h"


@implementation FSStoreParameters

+ (FSStoreParameters *)parameters
{
	return [[[FSStoreParameters alloc] init] autorelease];
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setOrderProcessType:kFSOrderProcessDetail];
		[self setRaw:[NSMutableDictionary dictionaryWithCapacity:5]];
	}
	return self;
}

- (NSMutableDictionary *)raw
{
    return [[raw retain] autorelease]; 
}

- (void)setRaw:(NSMutableDictionary *)aRaw
{
    if (raw != aRaw) {
        [raw release];
        raw = [aRaw retain];
    }
}

- (NSURLRequest *)toURLRequest
{
	NSString *storeIdEncoded = [[self storeId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *productIdEncoded = [[self productId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

	NSString *urlAsStr;
	switch([self orderProcessType]) {
		case kFSOrderProcessDetail: {
			NSString *protocol = @"http";
			if([self hasContactDefaults]) {
				protocol = @"https";
			}
			urlAsStr = [NSString stringWithFormat:@"%@://sites.fastspring.com/%@/product/%@", protocol, storeIdEncoded, productIdEncoded];
			break;
		}
		case kFSOrderProcessInstant: {
			urlAsStr = [NSString stringWithFormat:@"https://sites.fastspring.com/%@/instant/%@", storeIdEncoded, productIdEncoded];
			break;
		}
		default: {
			NSAssert1(FALSE, @"OrderProcess constant %i unknown.", [self orderProcessType]);
			break;
		}
	}
	
	NSString *queryStr = @"";
	NSArray *keys = [[self raw] allKeys];
	keys = [keys sortedArrayUsingSelector:@selector(compare:)];
	
	NSUInteger i, count = [keys count];
	for (i = 0; i < count; i++) {
		NSString *key = [keys objectAtIndex:i];
		NSString *value = [[self raw] valueForKey:key];
		if(value != nil) {
			queryStr = [queryStr stringByAppendingFormat:@"&%@=%@",
						key,
						[value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		}
	}
		
	if([queryStr length] > 0) {
		urlAsStr = [NSString stringWithFormat:@"%@?%@", urlAsStr, [queryStr substringFromIndex:1]];
	}
	
	return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlAsStr]];
}

- (int)orderProcessType
{
    return orderProcessType;
}
- (void)setOrderProcessType:(int)anOrderProcessType
{
    orderProcessType = anOrderProcessType;
}

- (NSString *)storeId
{
	return [[storeId retain] autorelease]; 
}
- (NSString *)productId
{
	return [[productId retain] autorelease]; 
}
- (void)setStoreId:(NSString *)aStoreId withProductId:(NSString *)aProductId
{
	if (storeId != aStoreId) {
		[storeId release];
		storeId = [aStoreId retain];
	}
	if (productId != aProductId) {
		[productId release];
		productId = [aProductId retain];
	}
}

- (void)setMode:(NSString *)aMode
{
	[[self raw] setObject:aMode forKey:@"mode"];
}

- (void)setCampaign:(NSString *)aCampaign
{
	[[self raw] setObject:aCampaign forKey:@"campaign"];
}

- (void)setOption:(NSString *)anOption
{
	[[self raw] setObject:anOption forKey:@"option"];
}

- (void)setReferrer:(NSString *)aReferrer
{
	[[self raw] setObject:aReferrer forKey:@"referrer"];
}

- (void)setSource:(NSString *)aSource
{
	[[self raw] setObject:aSource forKey:@"source"];
}

- (BOOL)hasContactDefaults
{
	return hasContactDefaults;
}
- (void)setHasContactDefaults:(BOOL)flag
{
	hasContactDefaults = flag;
}
		   
- (void)setContactFname:(NSString *)aContactFname
{
	[[self raw] setObject:aContactFname forKey:@"contact_fname"];
	[self setHasContactDefaults:TRUE];
}

- (void)setContactLname:(NSString *)aContactLname
{
	[[self raw] setObject:aContactLname forKey:@"contact_lname"];
	[self setHasContactDefaults:TRUE];
}

- (void)setContactEmail:(NSString *)aContactEmail
{
	[[self raw] setObject:aContactEmail forKey:@"contact_email"];
	[self setHasContactDefaults:TRUE];
}

- (void)setContactCompany:(NSString *)aContactCompany
{
	[[self raw] setObject:aContactCompany forKey:@"contact_company"];
	[self setHasContactDefaults:TRUE];
}

- (void)setContactPhone:(NSString *)aContactPhone
{
	[[self raw] setObject:aContactPhone forKey:@"contact_phone"];
	[self setHasContactDefaults:TRUE];
}

- (void)dealloc
{
	[self setStoreId:nil withProductId:nil];
    [self setRaw:nil];
	
    [super dealloc];
}

@end
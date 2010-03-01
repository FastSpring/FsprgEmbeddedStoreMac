//
//  FSStoreParameters.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSStoreParameters.h"


NSString * const kFSModeActive = @"active";
NSString * const kFSModeActiveTest = @"active.test";
NSString * const kFSModeTest = @"test";

@implementation FSStoreParameters

+ (FSStoreParameters *)parameters
{
	return [[[FSStoreParameters alloc] init] autorelease];
}

- (id) init
{
	self = [super init];
	if (self != nil) {
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
	NSString *urlAsStr = [NSString stringWithFormat:@"http://sites.fastspring.com/%@/product/%@",
						  [[self storeId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
						  [[self productId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
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

- (NSString *)mode
{
    return [[self raw] valueForKey:@"mode"];
}
- (void)setMode:(NSString *)aMode
{
	[[self raw] setObject:aMode forKey:@"mode"];
}

- (NSString *)campaign
{
    return [[self raw] valueForKey:@"campaign"];
}
- (void)setCampaign:(NSString *)aCampaign
{
	[[self raw] setObject:aCampaign forKey:@"campaign"];
}

- (NSString *)option
{
    return [[self raw] valueForKey:@"option"];
}
- (void)setOption:(NSString *)anOption
{
	[[self raw] setObject:anOption forKey:@"option"];
}

- (NSString *)referrer
{
    return [[self raw] valueForKey:@"referrer"];
}
- (void)setReferrer:(NSString *)aReferrer
{
	[[self raw] setObject:aReferrer forKey:@"referrer"];
}

- (NSString *)source
{
    return [[self raw] valueForKey:@"source"];
}
- (void)setSource:(NSString *)aSource
{
	[[self raw] setObject:aSource forKey:@"source"];
}

- (void)dealloc
{
	[self setStoreId:nil withProductId:nil];
    [self setRaw:nil];
	
    [super dealloc];
}

@end
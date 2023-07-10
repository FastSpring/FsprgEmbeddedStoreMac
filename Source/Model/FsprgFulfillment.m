//
//  FsprgFulfillment.m
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FsprgFulfillment.h"
#import "FsprgLicense.h"
#import "FsprgFileDownload.h"


@implementation FsprgFulfillment

+ (FsprgFulfillment *)fulfillmentWithDictionary:(NSDictionary *)aDictionary
{
	return [[FsprgFulfillment alloc] initWithDictionary:aDictionary];
}

- (instancetype)init
{
    return [self initWithDictionary:@{}];
}

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary
{
	self = [super init];
	if (self != nil) {
		self.raw = aDictionary;
	}
	return self;
}

- (NSDictionary *)raw
{
    return raw; 
}

- (void)setRaw:(NSDictionary *)aDictionary
{
    if (raw != aDictionary) {
        raw = aDictionary;
    }
}

- (id)valueForKey:(NSString *)aKey
{
	NSDictionary *anItem = [self.raw valueForKey:aKey];
	
	if([[anItem valueForKey:@"FulfillmentType"] isEqual:@"License"]) {
		return [FsprgLicense licenseWithDictionary:anItem];
	}
	if([[anItem valueForKey:@"FulfillmentType"] isEqual:@"File"]) {
		return [FsprgFileDownload fileDownloadWithDictionary:anItem];
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
	
}

@end

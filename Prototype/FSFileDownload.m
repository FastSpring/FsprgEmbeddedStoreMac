//
//  FSFileDownload.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSFileDownload.h"


@implementation FSFileDownload

+ (FSFileDownload *)fileDownloadWithDictionary:(NSDictionary *)aDictionary
{
	return [[[FSFileDownload alloc] initWithDictionary:aDictionary] autorelease];
}

- (FSFileDownload *)initWithDictionary:(NSDictionary *)aDictionary
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

- (NSURL *)fileURL
{
	return [NSURL URLWithString:[[self raw] valueForKey:@"FileURL"]];
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

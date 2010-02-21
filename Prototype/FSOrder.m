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
													   format:&format 
													   errorDescription:&errorDesc];
		
	
	FSOrder *order = [[FSOrder alloc] init];
	[order setDictionary:aDict];
	
	return [order autorelease];
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		[self setDictionary:nil];
	}
	return self;
}
										
- (NSDictionary *)dictionary
{
    return [[dictionary retain] autorelease]; 
}
- (void)setDictionary:(NSDictionary *)aDictionary
{
    if (dictionary != aDictionary) {
        [dictionary release];
        dictionary = [aDictionary retain];
    }
}

- (NSString *)valueForKey:(NSString *)aKey {
	return [[self dictionary] valueForKey:aKey];
}

@end

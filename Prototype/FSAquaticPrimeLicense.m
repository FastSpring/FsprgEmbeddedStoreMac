//
//  FSAquaticPrimeLicense.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSAquaticPrimeLicense.h"


@implementation FSAquaticPrimeLicense

+ (FSAquaticPrimeLicense *)licenseFromData:(NSData *)aData {
	NSPropertyListFormat *format = nil;
	NSString *errorDesc = nil;
	
	NSDictionary *aDict = [NSPropertyListSerialization propertyListFromData:aData
													   mutabilityOption:NSPropertyListImmutable
													   format:&format 
													   errorDescription:&errorDesc];
		
	
	return [[[FSAquaticPrimeLicense alloc] initWithDictionary:aDict] autorelease];
}

- (FSAquaticPrimeLicense *)initWithDictionary:(NSDictionary *)aDict {
	self = [super init];
	if (self != nil) {
		dict = [aDict retain];
	}
	return self;
}


- (NSString *)valueForKey:(NSString *)key {
	return [dict valueForKey:key];
}

- (NSString *)signature {
	return [self valueForKey:@"signature"];
}

@end

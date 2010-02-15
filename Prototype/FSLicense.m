//
//  FSLicense.m
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import "FSLicense.h"


@implementation FSLicense

+ (FSLicense *)licenseFromData:(NSData *)aData {
	NSPropertyListFormat *format = nil;
	NSString *errorDesc = nil;
	
	NSDictionary *aDict = [NSPropertyListSerialization propertyListFromData:aData
													   mutabilityOption:NSPropertyListImmutable
													   format:&format 
													   errorDescription:&errorDesc];
		
	
	return [[[FSLicense alloc] initWithDictionary:aDict] autorelease];
}

- (FSLicense *)initWithDictionary:(NSDictionary *)aDict {
	self = [super init];
	if (self != nil) {
		dict = [aDict retain];
	}
	return self;
}


- (NSString *)valueForKey:(NSString *)key {
	return [dict valueForKey:key];
}

@end

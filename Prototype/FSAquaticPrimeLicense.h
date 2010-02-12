//
//  FSAquaticPrimeLicense.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FSAquaticPrimeLicense : NSObject {
	NSDictionary *dict;
}

+ (FSAquaticPrimeLicense *)licenseFromData:(NSData *)aData;
	
- (FSAquaticPrimeLicense *)initWithDictionary:(NSDictionary *)aDict;
- (NSString *)valueForKey:(NSString *)key;
- (NSString *)signature;
	
@end

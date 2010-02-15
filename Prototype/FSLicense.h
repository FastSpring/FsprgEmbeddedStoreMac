//
//  FSLicense.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/12/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FSLicense : NSObject {
	NSDictionary *dict;
}

+ (FSLicense *)licenseFromData:(NSData *)aData;
	
- (FSLicense *)initWithDictionary:(NSDictionary *)aDict;
- (NSString *)valueForKey:(NSString *)key;
	
@end

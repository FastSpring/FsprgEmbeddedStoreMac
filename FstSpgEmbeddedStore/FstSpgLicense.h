//
//  FstSpgLicense.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface FstSpgLicense : NSObject {
	NSDictionary *raw;
}

+ (FstSpgLicense *)licenseWithDictionary:(NSDictionary *)aDictionary;

- (FstSpgLicense *)initWithDictionary:(NSDictionary *)aDictionary;
- (NSDictionary *)raw;
- (void)setRaw:(NSDictionary *)aDictionary;

- (NSString *)licenseName;
- (NSString *)licenseEmail;
- (NSString *)licenseCompany;
- (NSString *)firstLicenseCode;
- (NSArray *)licenseCodes;
- (NSDictionary *)licensePropertyList;
- (NSURL *)licenseURL;

@end

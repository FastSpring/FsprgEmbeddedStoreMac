//
//  FsprgLicense.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/24/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/*!
 * License information. FsprgLicense is backed by a NSMutableDictionary that
 * can be accessed and modified via the raw and setRaw: methods.
 */
@interface FsprgLicense : NSObject {
	NSDictionary *raw;
}

+ (FsprgLicense *)licenseWithDictionary:(NSDictionary *)aDictionary;

- (instancetype)initWithDictionary:(NSDictionary *)aDictionary NS_DESIGNATED_INITIALIZER;
@property (NS_NONATOMIC_IOSONLY, copy) NSDictionary *raw;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *licenseName;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *licenseEmail;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *licenseCompany;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *firstLicenseCode;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray *licenseCodes;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSDictionary *licensePropertyList;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSURL *licenseURL;

@end

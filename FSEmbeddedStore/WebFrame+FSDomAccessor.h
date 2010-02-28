//
//  WebFrame+FSDomAccessor.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/26/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

extern NSString * const kFSNameFieldId;
extern NSString * const kFSCompanyFieldId;
extern NSString * const kFSPhoneNumberFieldId;
extern NSString * const kFSEmailFieldId;
extern NSString * const kFSCountryFieldId;
extern NSString * const kFSAddress1FieldId;
extern NSString * const kFSAddress2FieldId;
extern NSString * const kFSCityFieldId;
extern NSString * const kFSRegionFieldId;
extern NSString * const kFSPostalCodeFieldId;

@interface WebFrame (FSDomAccessor)

- (void)fs_setValue:(NSString *)aValue forId:(NSString *)anId;
- (NSString *)fs_valueForId:(NSString *)anId;

@end

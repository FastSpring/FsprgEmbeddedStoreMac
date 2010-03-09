//
//  FstSpgStoreParameters.h
//  FstSpgEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const kFstSpgOrderProcessDetail;
extern NSString * const kFstSpgOrderProcessDetail;
extern NSString * const kFstSpgOrderProcessInstant;

extern NSString * const kFstSpgModeActive;
extern NSString * const kFstSpgModeActiveTest;
extern NSString * const kFstSpgModeTest;

@interface FstSpgStoreParameters : NSObject {
	BOOL hasContactDefaults;
	NSMutableDictionary *raw;
}

+ (FstSpgStoreParameters *)parameters;

- (NSURLRequest *)toURLRequest;
- (NSURL *)toURL;

- (NSMutableDictionary *)raw;
- (void)setRaw:(NSMutableDictionary *)aRaw;

- (NSString *)orderProcessType;
- (void)setOrderProcessType:(NSString *)anOrderProcessType;
- (void)setStoreId:(NSString *)aStoreId withProductId:(NSString *)aProductId;
- (NSString *)storeId;
- (void)setStoreId:(NSString *)aStoreId;
- (NSString *)productId;
- (void)setProductId:(NSString *)aProductId;
- (NSString *)mode;
- (void)setMode:(NSString *)aMode;
- (NSString *)campaign;
- (void)setCampaign:(NSString *)aCampaign;
- (NSString *)option;
- (void)setOption:(NSString *)anOption;
- (NSString *)referrer;
- (void)setReferrer:(NSString *)aReferrer;
- (NSString *)source;
- (void)setSource:(NSString *)aSource;

- (BOOL)hasContactDefaults;
- (NSString *)contactFname;
- (void)setContactFname:(NSString *)aContactFname;
- (NSString *)contactLname;
- (void)setContactLname:(NSString *)aContactLname;
- (NSString *)contactEmail;
- (void)setContactEmail:(NSString *)aContactEmail;
- (NSString *)contactCompany;
- (void)setContactCompany:(NSString *)aContactCompany;
- (NSString *)contactPhone;
- (void)setContactPhone:(NSString *)aContactPhone;

@end

//
//  FsprgStoreParameters.h
//  FsprgEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*! Constants for setOrderProcessType: */
extern NSString * const kFsprgOrderProcessDetail;
extern NSString * const kFsprgOrderProcessInstant;

/*! Constants for setMode: */
extern NSString * const kFsprgModeActive;
extern NSString * const kFsprgModeActiveTest;
extern NSString * const kFsprgModeTest;


/*!
 * FastSpring store parameters. FsprgStoreParameters is backed by a NSMutableDictionary that
 * can be accessed and modified via the raw and setRaw: methods.
 */
@interface FsprgStoreParameters : NSObject {
	BOOL hasContactDefaults;
	NSMutableDictionary *raw;
}

+ (FsprgStoreParameters *)parameters;
+ (FsprgStoreParameters *)parametersWithRaw:(NSMutableDictionary *)aRaw;

- (NSURLRequest *)toURLRequest;
- (NSURL *)toURL;

- (id)initWithRaw:(NSMutableDictionary *)aRaw;
- (NSMutableDictionary *)raw;
- (void)setRaw:(NSMutableDictionary *)aRaw;

- (NSString *)language;
- (void)setLanguage:(NSString *)aLanguage;
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

//
//  FSStoreParameters.h
//  FSEmbeddedStore
//
//  Created by Lars Steiger on 2/19/10.
//  Copyright 2010 FastSpring. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define kFSOrderProcessDetail	0
#define kFSOrderProcessInstant	1

#define kFSModeActive		@"active"
#define kFSModeActiveTest	@"active.test"
#define kFSModeTest			@"test"


@interface FSStoreParameters : NSObject {
	int orderProcessType;
	NSString *storeId;
	NSString *productId;
	BOOL hasContactDefaults;
	NSMutableDictionary *raw;
}

+ (FSStoreParameters *)parameters;

- (NSURLRequest *)toURLRequest;

- (NSMutableDictionary *)raw;
- (void)setRaw:(NSMutableDictionary *)aRaw;

- (int)orderProcessType;
- (void)setOrderProcessType:(int)anOrderProcessType;
- (NSString *)storeId;
- (NSString *)productId;
- (void)setStoreId:(NSString *)aStoreId withProductId:(NSString *)aProductId;
- (void)setMode:(NSString *)aMode;
- (void)setCampaign:(NSString *)aCampaign;
- (void)setOption:(NSString *)anOption;
- (void)setReferrer:(NSString *)aReferrer;
- (void)setSource:(NSString *)aSource;

- (BOOL)hasContactDefaults;
- (void)setContactFname:(NSString *)aContactFname;
- (void)setContactLname:(NSString *)aContactLname;
- (void)setContactEmail:(NSString *)aContactEmail;
- (void)setContactCompany:(NSString *)aContactCompany;
- (void)setContactPhone:(NSString *)aContactPhone;

@end
